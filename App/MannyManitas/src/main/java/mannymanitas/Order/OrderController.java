package mannymanitas.Order;

import javafx.beans.property.ReadOnlyObjectWrapper;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import mannymanitas.Customer.MantenimientoCustomer;
import mannymanitas.Main.MainApplication;

import java.io.IOException;
import java.sql.Connection;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Arrays;

public class OrderController {

    @FXML
    private TableView<Order> tablaOrders;

    @FXML
    private TableColumn<Order, Integer> orderIdTableView;

    @FXML
    private TableColumn<Order, LocalDateTime> orderDateTableView;

    @FXML
    private TableColumn<Order, OrderStatus> statusTableView;

    @FXML
    private TableColumn<Order, Integer> customerIdTableView;

    @FXML
    private TextField orderIdTextField;

    @FXML
    private TextField orderDateTextField;

    @FXML
    private TextField statusTextField;

    @FXML
    private TextField customerIdTextField;

    @FXML
    private TextField filtroTextField;

    @FXML
    private Button onAnyadirButtonClick;

    @FXML
    private Button guardarButton;

    @FXML
    private Label errorLabel;
    private ObservableList<Order> listaOrders = FXCollections.observableArrayList();
    private FilteredList<Order> filtrarOrders;
    Connection conexion;
    int orderIdAnterior;

    @FXML
    public void initialize() {
        conexion = MantenimientoOrder.conectar();

        orderIdTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getOrderId()));
        orderDateTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getOrderDate()));
        statusTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getStatus()));
        customerIdTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getCustomerId()));

        listaOrders = MantenimientoOrder.consulta(conexion);
        filtrarOrders = new FilteredList<>(listaOrders, p -> true);
        tablaOrders.setItems(filtrarOrders);
        orderIdTextField.setDisable(true);
        int siguienteID = MantenimientoOrder.siguienteOrderId(conexion);
        orderIdTextField.setText(String.valueOf(siguienteID));
    }

    @FXML
    public void filtrarButtonClick() {
        String filtrarText = filtroTextField.getText().toLowerCase();
        filtrarOrders.setPredicate(order -> {
            if (filtrarText.isEmpty()) {
                return true;
            }
            return order.getStatus().toString().toLowerCase().contains(filtrarText) ||
                    String.valueOf(order.getCustomerId()).contains(filtrarText);
        });
    }

    @FXML
    public void onAnyadirButton() {
        if (!validarCampos()) {
            return;
        }

        LocalDateTime orderDate = LocalDateTime.parse(orderDateTextField.getText(), DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        OrderStatus status = OrderStatus.valueOf(statusTextField.getText().toUpperCase());
        int customerId = Integer.parseInt(customerIdTextField.getText());

        if (!MantenimientoCustomer.existeCustomerId(conexion, customerId)) {
            errorLabel.setText("El CustomerID no existe en la base de datos.");
            return;
        }

        Order order = new Order(0, orderDate, status, customerId);
        MantenimientoOrder.insertar(conexion, order);

        clearFields();
        int siguienteID = MantenimientoOrder.siguienteOrderId(conexion);
        orderIdTextField.setText(String.valueOf(siguienteID));
        listaOrders = MantenimientoOrder.consulta(conexion);
        filtrarOrders = new FilteredList<>(listaOrders, p -> true);
        tablaOrders.setItems(filtrarOrders);
    }

    @FXML
    public void editarButtonClick() {
        Order order = tablaOrders.getSelectionModel().getSelectedItem();

        if (order != null) {
            orderIdAnterior = order.getOrderId();
            orderIdTextField.setText(String.valueOf(order.getOrderId()));
            orderDateTextField.setText(order.getOrderDate().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
            statusTextField.setText(order.getStatus().toString());
            customerIdTextField.setText(String.valueOf(order.getCustomerId()));

            onAnyadirButtonClick.setDisable(true);
            guardarButton.setDisable(false);
        } else {
            errorLabel.setText("No hay ninguna fila seleccionada.");
        }
    }

    @FXML
    public void eliminarButtonClick() {
        Order order = tablaOrders.getSelectionModel().getSelectedItem();

        if (order != null) {
            MantenimientoOrder.borrar(conexion, order);
            listaOrders = MantenimientoOrder.consulta(conexion);
            filtrarOrders = new FilteredList<>(listaOrders, p -> true);
            tablaOrders.setItems(filtrarOrders);
            int siguienteID = MantenimientoOrder.siguienteOrderId(conexion);
            orderIdTextField.setText(String.valueOf(siguienteID));
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

        int orderId = orderIdAnterior;
        LocalDateTime orderDate = LocalDateTime.parse(orderDateTextField.getText(), DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        OrderStatus status = OrderStatus.valueOf(statusTextField.getText().toUpperCase());
        int customerId = Integer.parseInt(customerIdTextField.getText());

        if (!MantenimientoCustomer.existeCustomerId(conexion, customerId)) {
            errorLabel.setText("El CustomerID no existe en la base de datos.");
            return;
        }

        Order order = new Order(orderId, orderDate, status, customerId);

        MantenimientoOrder.modificar(conexion, order, orderIdAnterior);

        clearFields();
        int siguienteID = MantenimientoOrder.siguienteOrderId(conexion);
        orderIdTextField.setText(String.valueOf(siguienteID));
        listaOrders = MantenimientoOrder.consulta(conexion);
        filtrarOrders = new FilteredList<>(listaOrders, p -> true);
        tablaOrders.setItems(filtrarOrders);
    }

    private boolean validarCampos() {
        if (orderDateTextField.getText().isEmpty() || statusTextField.getText().isEmpty() ||
                customerIdTextField.getText().isEmpty()) {
            errorLabel.setText("Por favor, rellene todos los campos.");
            return false;
        }

        try {
            LocalDateTime.parse(orderDateTextField.getText(), DateTimeFormatter.ISO_LOCAL_DATE_TIME);
        } catch (Exception e) {
            errorLabel.setText("La fecha debe estar en formato ISO_LOCAL_DATE_TIME.");
            return false;
        }

        try {
            OrderStatus.valueOf(statusTextField.getText().toUpperCase());
        } catch (IllegalArgumentException e) {
            errorLabel.setText("Estado no válido. Los estados válidos son: " + Arrays.toString(OrderStatus.values()));
            return false;
        }

        try {
            int customerId = Integer.parseInt(customerIdTextField.getText());
            if (!MantenimientoCustomer.existeCustomerId(conexion, customerId)) {
                errorLabel.setText("El CustomerID no existe en la base de datos.");
                return false;
            }
        } catch (NumberFormatException e) {
            errorLabel.setText("El CustomerID debe ser un número válido.");
            return false;
        }

        return true;
    }

    private void clearFields() {
        orderIdTextField.clear();
        orderDateTextField.clear();
        statusTextField.clear();
        customerIdTextField.clear();
        errorLabel.setText("");
    }

    @FXML
    public void volverAPaginaPrincipal() throws IOException {
        MainApplication.setRoot("main-view");
    }
}
