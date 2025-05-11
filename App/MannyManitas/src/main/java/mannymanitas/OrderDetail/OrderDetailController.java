package mannymanitas.OrderDetail;

import javafx.beans.property.ReadOnlyObjectWrapper;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import mannymanitas.Customer.Customer;
import mannymanitas.Customer.MantenimientoCustomer;
import mannymanitas.Item.Item;
import mannymanitas.Order.MantenimientoOrder;
import mannymanitas.Item.MantenimientoItem;
import mannymanitas.Main.MainApplication;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import java.sql.Connection;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import static mannymanitas.Item.MantenimientoItem.obtenerPrecioPorItemId;
import static mannymanitas.Order.MantenimientoOrder.obtenerCustomerIdPorOrderId;

public class OrderDetailController {

    @FXML
    private TableView<OrderDetail> tablaOrderDetails;

    @FXML
    private TableColumn<OrderDetail, Integer> orderIdTableView;

    @FXML
    private TableColumn<OrderDetail, Integer> itemIdTableView;

    @FXML
    private TableColumn<OrderDetail, Integer> quantityTableView;

    @FXML
    private TableColumn<OrderDetail, Double> priceTableView;

    @FXML
    private TableColumn<OrderDetail, LocalDate> arrivalDateTableView;

    @FXML
    private TextField orderIdTextField;

    @FXML
    private TextField itemIdTextField;

    @FXML
    private TextField quantityTextField;

    @FXML
    private TextField priceTextField;

    @FXML
    private TextField arrivalDateTextField;

    @FXML
    private TextField filterTextField;

    @FXML
    private Button onAnyadirButtonClick;

    @FXML
    private Button guardarButton;

    @FXML
    private Label errorLabel;

    private ObservableList<OrderDetail> listaOrderDetails = FXCollections.observableArrayList();
    private FilteredList<OrderDetail> filtrarOrderDetails;
    Connection conexion;

    @FXML
    public void initialize() {
        conexion = MantenimientoOrderDetail.conectar();

        orderIdTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getOrderId()));
        itemIdTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getItemId()));
        quantityTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getCantidad()));
        priceTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getPresio()));
        priceTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getPresio()));
        priceTableView.setCellFactory(column -> new TableCell<OrderDetail, Double>() {
            @Override
            protected void updateItem(Double price, boolean empty) {
                super.updateItem(price, empty);
                if (empty || price == null) {
                    setText(null);
                } else {
                    setText(String.format("%.2f €", price));
                }
            }
        });
        arrivalDateTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getLlegadaDate()));

        priceTextField.setDisable(true);
        itemIdTextField.setOnKeyReleased(e -> {
            try {
                int itemId = Integer.parseInt(itemIdTextField.getText());
                if (MantenimientoItem.existeItemId(conexion, itemId)) {
                    double presio = obtenerPrecioPorItemId(conexion, itemId);
                    priceTextField.setText(String.valueOf(presio));
                } else {
                    priceTextField.clear();
                }
            } catch (NumberFormatException ex) {
                priceTextField.clear();
            }
        });

        listaOrderDetails = MantenimientoOrderDetail.consulta(conexion);
        filtrarOrderDetails = new FilteredList<>(listaOrderDetails, p -> true);
        tablaOrderDetails.setItems(filtrarOrderDetails);
    }

    @FXML
    public void filtrarButtonClick() {
        String filtrarText = filterTextField.getText().toLowerCase();
        filtrarOrderDetails.setPredicate(orderDetail -> {
            if (filtrarText.isEmpty()) {
                return true;
            }
            return String.valueOf(orderDetail.getOrderId()).contains(filtrarText) ||
                    String.valueOf(orderDetail.getItemId()).contains(filtrarText) ||
                    String.valueOf(orderDetail.getCantidad()).contains(filtrarText) ||
                    String.valueOf(orderDetail.getPresio()).contains(filtrarText);
        });
    }

    @FXML
    public void onAnyadirButton() {
        if (!validarCampos()) {
            return;
        }

        int orderId = Integer.parseInt(orderIdTextField.getText());
        int itemId = Integer.parseInt(itemIdTextField.getText());
        int cantidad = Integer.parseInt(quantityTextField.getText());
        double presio = Double.parseDouble(priceTextField.getText());
        LocalDate llegadaDate = LocalDate.parse(arrivalDateTextField.getText(), DateTimeFormatter.ISO_LOCAL_DATE);

        if (MantenimientoOrderDetail.existeOrderDetail(conexion, orderId, itemId)) {
            errorLabel.setText("Ya existe un detalle de pedido con este OrderID y ItemID.");
            return;
        }

        if (!MantenimientoOrder.existeOrderId(conexion, orderId)) {
            errorLabel.setText("El OrderID no existe en la base de datos.");
            return;
        }

        if (!MantenimientoItem.existeItemId(conexion, itemId)) {
            errorLabel.setText("El ItemID no existe en la base de datos.");
            return;
        }

        OrderDetail orderDetail = new OrderDetail(orderId, itemId, cantidad, presio, llegadaDate);
        MantenimientoOrderDetail.insertar(conexion, orderDetail);

        clearFields();
        listaOrderDetails = MantenimientoOrderDetail.consulta(conexion);
        filtrarOrderDetails = new FilteredList<>(listaOrderDetails, p -> true);
        tablaOrderDetails.setItems(filtrarOrderDetails);
    }


    @FXML
    public void editarButtonClick() {
        OrderDetail orderDetail = tablaOrderDetails.getSelectionModel().getSelectedItem();

        if (orderDetail != null) {
            orderIdTextField.setText(String.valueOf(orderDetail.getOrderId()));
            itemIdTextField.setText(String.valueOf(orderDetail.getItemId()));
            quantityTextField.setText(String.valueOf(orderDetail.getCantidad()));
            priceTextField.setText(String.valueOf(orderDetail.getPresio()));
            arrivalDateTextField.setText(orderDetail.getLlegadaDate().format(DateTimeFormatter.ISO_LOCAL_DATE));

            onAnyadirButtonClick.setDisable(true);
            guardarButton.setDisable(false);
        } else {
            errorLabel.setText("No hay ninguna fila seleccionada.");
        }
    }

    @FXML
    public void eliminarButtonClick() {
        OrderDetail orderDetail = tablaOrderDetails.getSelectionModel().getSelectedItem();

        if (orderDetail != null) {
            MantenimientoOrderDetail.borrar(conexion, orderDetail);
            listaOrderDetails = MantenimientoOrderDetail.consulta(conexion);
            filtrarOrderDetails = new FilteredList<>(listaOrderDetails, p -> true);
            tablaOrderDetails.setItems(filtrarOrderDetails);
        } else {
            errorLabel.setText("No hay ninguna fila seleccionada.");
        }
    }

    @FXML
    public void guardarButtonClick() {
        if (!validarCampos()) {
            return;
        }

        int orderId = Integer.parseInt(orderIdTextField.getText());
        int itemId = Integer.parseInt(itemIdTextField.getText());
        int cantidad = Integer.parseInt(quantityTextField.getText());
        double presio = Double.parseDouble(priceTextField.getText());
        LocalDate llegadaDate = LocalDate.parse(arrivalDateTextField.getText(), DateTimeFormatter.ISO_LOCAL_DATE);

        if (!MantenimientoOrder.existeOrderId(conexion, orderId)) {
            errorLabel.setText("El OrderID no existe en la base de datos.");
            return;
        }

        if (!MantenimientoItem.existeItemId(conexion, itemId)) {
            errorLabel.setText("El ItemID no existe en la base de datos.");
            return;
        }

        OrderDetail orderDetailSeleccionado = tablaOrderDetails.getSelectionModel().getSelectedItem();
        if (orderDetailSeleccionado != null) {
            int antiguoOrderId = orderDetailSeleccionado.getOrderId();
            int antiguoItemId = orderDetailSeleccionado.getItemId();

            if (orderId != antiguoOrderId || itemId != antiguoItemId) {
                if (MantenimientoOrderDetail.existeOrderDetail(conexion, orderId, itemId)) {
                    errorLabel.setText("Ya existe un detalle de pedido con este OrderID y ItemID.");
                    return;
                }
            }
        }

        OrderDetail orderDetail = new OrderDetail(orderId, itemId, cantidad, presio, llegadaDate);

        if (orderDetailSeleccionado != null) {
            int antiguoOrderId = orderDetailSeleccionado.getOrderId();
            int antiguoItemId = orderDetailSeleccionado.getItemId();
            orderDetail.setAnteriorOrderId(antiguoOrderId);
            orderDetail.setAnteriorItemId(antiguoItemId);
            MantenimientoOrderDetail.modificar(conexion, orderDetail);
        }

        clearFields();
        listaOrderDetails = MantenimientoOrderDetail.consulta(conexion);
        filtrarOrderDetails = new FilteredList<>(listaOrderDetails, p -> true);
        tablaOrderDetails.setItems(filtrarOrderDetails);

        guardarButton.setDisable(true);
        onAnyadirButtonClick.setDisable(false);
    }


    private boolean validarCampos() {
        if (orderIdTextField.getText().isEmpty() || itemIdTextField.getText().isEmpty() ||
                quantityTextField.getText().isEmpty() || priceTextField.getText().isEmpty() ||
                arrivalDateTextField.getText().isEmpty()) {
            errorLabel.setText("Por favor, rellene todos los campos.");
            return false;
        }

        try {
            Integer.parseInt(orderIdTextField.getText());
        } catch (NumberFormatException e) {
            errorLabel.setText("El OrderID debe ser un número válido.");
            return false;
        }

        try {
            Integer.parseInt(itemIdTextField.getText());
        } catch (NumberFormatException e) {
            errorLabel.setText("El ItemID debe ser un número válido.");
            return false;
        }

        try {
            Integer.parseInt(quantityTextField.getText());
        } catch (NumberFormatException e) {
            errorLabel.setText("La cantidad debe ser un número válido.");
            return false;
        }

        try {
            Double.parseDouble(priceTextField.getText());
        } catch (NumberFormatException e) {
            errorLabel.setText("El precio debe ser un número válido.");
            return false;
        }

        try {
            LocalDate.parse(arrivalDateTextField.getText(), DateTimeFormatter.ISO_LOCAL_DATE);
        } catch (Exception e) {
            errorLabel.setText("La fecha debe estar en formato ISO_LOCAL_DATE.");
            return false;
        }

        return true;
    }

    @FXML
    public void generarFacturaButtonClick() {
        OrderDetail orderDetail = tablaOrderDetails.getSelectionModel().getSelectedItem();

        if (orderDetail == null) {
            errorLabel.setText("No hay ninguna fila seleccionada.");
            return;
        }

        Item item = MantenimientoItem.obtenerItemPorId(conexion, orderDetail.getItemId());
        Customer customer = MantenimientoCustomer.obtenerCustomerPorId(conexion, obtenerCustomerIdPorOrderId(conexion, orderDetail.getOrderId()));
        LocalDateTime orderDate = MantenimientoOrder.obtenerOrderDatePorOrderId(conexion, orderDetail.getOrderId());

        File carpeta = new File("src/main/resources/facturas");
        if (!carpeta.exists()) {
            carpeta.mkdir();
        }

        File fichero = new File(carpeta, "factura_" + orderDetail.getOrderId() + ".txt");

        try (FileWriter editor = new FileWriter(fichero)) {
            editor.write("MannyManitas S.L. - ");
            editor.write("Factura\n");
            editor.write("\nOrder Date: " + orderDate + "\n");
            if (customer != null) {
                editor.write("\nCustomer Name: " + customer.getFirstName() + " " + customer.getLastName() + "\n");
                editor.write("Customer Address: " + customer.getAddress() + "\n");
                editor.write("Customer Email: " + customer.getEmail() + "\n");
            }
            editor.write("\nOrder ID: " + orderDetail.getOrderId() + "\n");
            if (item != null) {
                editor.write("Item Category: " + item.getCategoria() + "\n");
                editor.write("Item Name: " + item.getNameItem() + "\n");
                editor.write("Quantity: " + orderDetail.getCantidad() + "\n");
                editor.write("Item Price: " + item.getPresio() + "€\n");
            }
            editor.write("\nTotal Price: " + orderDetail.getPresio() * orderDetail.getCantidad() + "€ - ");
            editor.write("Arrival Date: " + orderDetail.getLlegadaDate() + "\n");

            errorLabel.setText("Factura generada correctamente en: " + fichero.getAbsolutePath());
        } catch (IOException e) {
            errorLabel.setText("Error al generar la factura: " + e.getMessage());
        }
    }


    private void clearFields() {
        orderIdTextField.clear();
        itemIdTextField.clear();
        quantityTextField.clear();
        priceTextField.clear();
        arrivalDateTextField.clear();
        errorLabel.setText("");
    }

    @FXML
    public void volverAPaginaPrincipal() throws IOException {
        MainApplication.setRoot("main-view");
    }
}
