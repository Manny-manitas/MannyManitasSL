package mannymanitas.Item;

import javafx.beans.property.ReadOnlyObjectWrapper;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import mannymanitas.Main.MainApplication;

import java.io.IOException;
import java.sql.Connection;
import java.util.Arrays;

public class ItemController {

    @FXML
    private TableView<Item> tablaItems;

    @FXML
    private TableColumn<Item, Integer> itemIdTableView;

    @FXML
    private TableColumn<Item, Category> categoriaTableView;

    @FXML
    private TableColumn<Item, String> nameItemTableView;

    @FXML
    private TableColumn<Item, Double> presioTableView;

    @FXML
    private TextField itemIdTextField;

    @FXML
    private TextField categoriaTextField;

    @FXML
    private TextField nameItemTextField;

    @FXML
    private TextField presioTextField;

    @FXML
    private TextField filtroTextField;

    @FXML
    private Button onAnyadirButtonClick;

    @FXML
    private Button guardarButton;

    @FXML
    private Label errorLabel;

    private ObservableList<Item> listaItems = FXCollections.observableArrayList();
    private FilteredList<Item> filtroItems;
    Connection conexion;
    int itemIdAnterior;

    @FXML
    public void initialize() {
        conexion = MantenimientoItem.conectar();

        itemIdTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getItemId()));
        categoriaTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getCategoria()));
        nameItemTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getNameItem()));
        presioTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getPresio()));
        presioTableView.setCellFactory(col -> {
            TableCell<Item, Double> celda = new TableCell<>() {
                @Override
                protected void updateItem(Double price, boolean empty) {
                    super.updateItem(price, empty);
                    if (empty || price == null) {
                        setText(null);
                    } else {
                        setText(String.format("%.2f €", price));
                    }
                }
            };
            return celda;
        });

        listaItems = MantenimientoItem.consulta(conexion);
        filtroItems = new FilteredList<>(listaItems, p -> true);
        tablaItems.setItems(filtroItems);
        itemIdTextField.setDisable(true);
        int siguienteId = MantenimientoItem.siguienteItemId(conexion);
        itemIdTextField.setText(String.valueOf(siguienteId));
    }

    @FXML
    public void filtrarButtonClick() {
        String filtroText = filtroTextField.getText().toLowerCase();
        filtroItems.setPredicate(item -> {
            if (filtroText.isEmpty()) {
                return true;
            }
            return item.getNameItem().toLowerCase().contains(filtroText) || item.getCategoria().toString().toLowerCase().contains(filtroText) || String.valueOf(item.getPresio()).contains(filtroText);
        });
    }

    @FXML
    public void onAnyadirButton() {
        if (!validarCampos()) {
            return;
        }

        Category categoria = Category.valueOf(categoriaTextField.getText().toUpperCase());
        String nameItem = nameItemTextField.getText();
        double presio = Double.parseDouble(presioTextField.getText());

        Item item = new Item(0, categoria, nameItem, presio);
        MantenimientoItem.insertar(conexion, item);

        clearFields();
        int siguienteId = MantenimientoItem.siguienteItemId(conexion);
        itemIdTextField.setText(String.valueOf(siguienteId));
        listaItems = MantenimientoItem.consulta(conexion);
        filtroItems = new FilteredList<>(listaItems, p -> true);
        tablaItems.setItems(filtroItems);
    }

    @FXML
    public void editarButtonClick() {
        Item item = tablaItems.getSelectionModel().getSelectedItem();

        if (item != null) {
            itemIdAnterior = item.getItemId();
            itemIdTextField.setText(String.valueOf(item.getItemId()));
            categoriaTextField.setText(item.getCategoria().toString());
            nameItemTextField.setText(item.getNameItem());
            presioTextField.setText(String.valueOf(item.getPresio()));

            if (validarCampos()) {
                onAnyadirButtonClick.setDisable(true);
                guardarButton.setDisable(false);
            } else {
                guardarButton.setDisable(true);
            }
        } else {
            errorLabel.setText("No hay ninguna fila seleccionada.");
            guardarButton.setDisable(true);
        }
    }

    @FXML
    public void eliminarButtonClick() {
        Item item = tablaItems.getSelectionModel().getSelectedItem();

        if (item != null) {
            MantenimientoItem.borrar(conexion, item);
            listaItems = MantenimientoItem.consulta(conexion);
            filtroItems = new FilteredList<>(listaItems, p -> true);
            tablaItems.setItems(filtroItems);
            int siguienteId = MantenimientoItem.siguienteItemId(conexion);
            itemIdTextField.setText(String.valueOf(siguienteId));
        } else {
            errorLabel.setText("No hay ninguna fila seleccionada.");
        }
    }

    @FXML
    public void guardarButtonClick() {
        if (!validarCampos()) {
            return;
        }

        onAnyadirButtonClick.setDisable(false);
        guardarButton.setDisable(true);

        int itemId = itemIdAnterior;
        Category category = Category.valueOf(categoriaTextField.getText().toUpperCase());
        String nameItem = nameItemTextField.getText();
        double price = Double.parseDouble(presioTextField.getText());

        Item item = new Item(itemId, category, nameItem, price);

        MantenimientoItem.modificar(conexion, item, itemIdAnterior);

        clearFields();
        int siguienteId = MantenimientoItem.siguienteItemId(conexion);
        itemIdTextField.setText(String.valueOf(siguienteId));
        listaItems = MantenimientoItem.consulta(conexion);
        filtroItems = new FilteredList<>(listaItems, p -> true);
        tablaItems.setItems(filtroItems);

    }

    private boolean validarCampos() {
        if (categoriaTextField.getText().isEmpty() || nameItemTextField.getText().isEmpty() || presioTextField.getText().isEmpty()) {
            errorLabel.setText("Por favor, rellene todos los campos.");
            return false;
        }

        try {
            Category.valueOf(categoriaTextField.getText().toUpperCase());
        } catch (IllegalArgumentException e) {
            errorLabel.setText("Categoría no válida. Las categorías válidas son: " + Arrays.toString(Category.values()));
            return false;
        }

        try {
            Double.parseDouble(presioTextField.getText());
        } catch (NumberFormatException e) {
            errorLabel.setText("El precio debe ser un número válido.");
            return false;
        }

        return true;
    }

    private void clearFields() {
        itemIdTextField.clear();
        categoriaTextField.clear();
        nameItemTextField.clear();
        presioTextField.clear();
        errorLabel.setText("");
    }

    @FXML
    public void volverAPaginaPrincipal() throws IOException {
        MainApplication.setRoot("main-view");
    }
}
