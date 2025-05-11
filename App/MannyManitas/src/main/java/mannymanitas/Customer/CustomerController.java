package mannymanitas.Customer;

import javafx.beans.property.ReadOnlyObjectWrapper;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import mannymanitas.Main.MainApplication;

import java.io.IOException;
import java.sql.Connection;

public class CustomerController {

    @FXML
    private TableView<Customer> tablaCustomers;

    @FXML
    private TableColumn<Customer, Integer> customerIdTableView;

    @FXML
    private TableColumn<Customer, String> addressTableView;

    @FXML
    private TableColumn<Customer, String> firstNameTableView;

    @FXML
    private TableColumn<Customer, String> lastNameTableView;

    @FXML
    private TableColumn<Customer, String> emailTableView;

    @FXML
    private TextField customerIdTextField;

    @FXML
    private TextField addressTextField;

    @FXML
    private TextField firstNameTextField;

    @FXML
    private TextField lastNameTextField;

    @FXML
    private TextField emailTextField;

    @FXML
    private TextField filterTextField;

    @FXML
    private Button onAnyadirButtonClick;

    @FXML
    private Button guardarButton;

    @FXML
    private Label errorLabel;

    private ObservableList<Customer> listaCustomers = FXCollections.observableArrayList();
    private FilteredList<Customer> filtradoCustomers;
    Connection conexion;
    int customerIdAnterior;

    @FXML
    public void initialize() {
        conexion = MantenimientoCustomer.conectar();

        customerIdTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getCustomerId()));
        addressTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getAddress()));
        firstNameTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getFirstName()));
        lastNameTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getLastName()));
        emailTableView.setCellValueFactory(data -> new ReadOnlyObjectWrapper<>(data.getValue().getEmail()));

        listaCustomers = MantenimientoCustomer.consulta(conexion);
        filtradoCustomers = new FilteredList<>(listaCustomers, p -> true);
        tablaCustomers.setItems(filtradoCustomers);
        customerIdTextField.setDisable(true);
        int siguienteID = MantenimientoCustomer.getNextCustomerId(conexion);
        customerIdTextField.setText(String.valueOf(siguienteID));
    }

    @FXML
    public void filtrarButtonClick() {
        String filtrarText = filterTextField.getText().toLowerCase();
        filtradoCustomers.setPredicate(customer -> {
            if (filtrarText.isEmpty()) {
                return true;
            }
            return customer.getFirstName().toLowerCase().contains(filtrarText) ||
                    customer.getLastName().toLowerCase().contains(filtrarText) ||
                    customer.getEmail().toLowerCase().contains(filtrarText) ||
                    customer.getAddress().toLowerCase().contains(filtrarText);
        });
    }

    @FXML
    public void onAnyadirButton() {
        if (!validarCampos()) {
            return;
        }

        String address = addressTextField.getText();
        String firstName = firstNameTextField.getText();
        String lastName = lastNameTextField.getText();
        String email = emailTextField.getText();

        Customer customer = new Customer(0, address, firstName, lastName, email);
        MantenimientoCustomer.insertar(conexion, customer);

        clearFields();
        int siguienteID = MantenimientoCustomer.getNextCustomerId(conexion);
        customerIdTextField.setText(String.valueOf(siguienteID));
        listaCustomers = MantenimientoCustomer.consulta(conexion);
        filtradoCustomers = new FilteredList<>(listaCustomers, p -> true);
        tablaCustomers.setItems(filtradoCustomers);
    }

    @FXML
    public void editarButtonClick() {
        Customer customer = tablaCustomers.getSelectionModel().getSelectedItem();

        if (customer != null) {
            customerIdAnterior = customer.getCustomerId();
            customerIdTextField.setText(String.valueOf(customer.getCustomerId()));
            addressTextField.setText(customer.getAddress());
            firstNameTextField.setText(customer.getFirstName());
            lastNameTextField.setText(customer.getLastName());
            emailTextField.setText(customer.getEmail());

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
        Customer customer = tablaCustomers.getSelectionModel().getSelectedItem();

        if (customer != null) {
            MantenimientoCustomer.borrar(conexion, customer);
            listaCustomers = MantenimientoCustomer.consulta(conexion);
            filtradoCustomers = new FilteredList<>(listaCustomers, p -> true);
            tablaCustomers.setItems(filtradoCustomers);
            int siguienteID = MantenimientoCustomer.getNextCustomerId(conexion);
            customerIdTextField.setText(String.valueOf(siguienteID));
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

        int customerId = customerIdAnterior;
        String address = addressTextField.getText();
        String firstName = firstNameTextField.getText();
        String lastName = lastNameTextField.getText();
        String email = emailTextField.getText();

        Customer customer = new Customer(customerId, address, firstName, lastName, email);

        MantenimientoCustomer.modificar(conexion, customer, customerIdAnterior);

        clearFields();
        int siguienteID = MantenimientoCustomer.getNextCustomerId(conexion);
        customerIdTextField.setText(String.valueOf(siguienteID));
        listaCustomers = MantenimientoCustomer.consulta(conexion);
        filtradoCustomers = new FilteredList<>(listaCustomers, p -> true);
        tablaCustomers.setItems(filtradoCustomers);
    }

    private boolean validarCampos() {
        String firstName = firstNameTextField.getText();
        String lastName = lastNameTextField.getText();
        String email = emailTextField.getText();

        if (addressTextField.getText().isEmpty() || firstName.isEmpty() || lastName.isEmpty() || email.isEmpty()) {
            errorLabel.setText("Rellena todos los campos por favor.");
            return false;
        }

        if (!firstName.matches("[\\p{L}]+") || !lastName.matches("[\\p{L}]+")) {
            errorLabel.setText("El nombre y apellido solo pueden contener letras.");
            return false;
        }

        if (!email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            errorLabel.setText("El email debe estar en formato __@__.__");
            return false;
        }

        return true;
    }

    private void clearFields() {
        customerIdTextField.clear();
        addressTextField.clear();
        firstNameTextField.clear();
        lastNameTextField.clear();
        emailTextField.clear();
        errorLabel.setText("");
    }

    @FXML
    public void volverAPaginaPrincipal() throws IOException {
        MainApplication.setRoot("main-view");
    }
}
