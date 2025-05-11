package mannymanitas.Customer;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.*;

public class MantenimientoCustomer {

    public static Connection conectar() {
        Connection conexion;
        String host = "jdbc:mariadb://localhost:3307/";
        String usuario = "root";
        String psw = "";
        String bd = "mannymanitas";
        System.out.println("Conectando...");

        try {
            conexion = DriverManager.getConnection(host + bd, usuario, psw);
            System.out.println("Conexión realizada con éxito.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }

        return conexion;
    }

    public static ObservableList<Customer> consulta(Connection conexion) {
        ObservableList<Customer> listaCustomers = FXCollections.observableArrayList();
        String query = "SELECT * FROM customer";

        try (Statement stmt = conexion.createStatement();
             ResultSet resultado = stmt.executeQuery(query)) {

            while (resultado.next()) {
                int customerId = resultado.getInt("CustomerID");
                String address = resultado.getString("Address");
                String firstName = resultado.getString("FirstName");
                String lastName = resultado.getString("LastName");
                String email = resultado.getString("Email");
                listaCustomers.add(new Customer(customerId, address, firstName, lastName, email));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }

        return listaCustomers;
    }

    public static void insertar(Connection conexion, Customer customer) {
        int siguienteCustomerID = getNextCustomerId(conexion);
        String query = "INSERT INTO customer (CustomerID, Address, FirstName, LastName, Email) VALUES ("
                + siguienteCustomerID + ",'" + customer.getAddress() + "','" + customer.getFirstName() + "','"
                + customer.getLastName() + "','" + customer.getEmail() + "')";

        try (Statement stmt = conexion.createStatement()) {
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static int getNextCustomerId(Connection conexion) {
        String query = "SELECT MAX(CustomerID) FROM customer";
        try (Statement stmt = conexion.createStatement();
             ResultSet resultado = stmt.executeQuery(query)) {

            if (resultado.next()) {
                return resultado.getInt(1) + 1;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return 1;
    }

    public static void modificar(Connection conexion, Customer customer, int customerIdAnterior) {
        String query = "UPDATE customer SET Address = '"
                + customer.getAddress() + "', FirstName = '" + customer.getFirstName() + "', LastName = '"
                + customer.getLastName() + "', Email = '" + customer.getEmail() + "' WHERE CustomerID = " + customerIdAnterior;

        try (Statement stmt = conexion.createStatement()) {
            stmt.executeUpdate(query);
            System.out.println("Fila modificada.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static void borrar(Connection conexion, Customer customer) {
        String query = "DELETE FROM customer WHERE CustomerID = " + customer.getCustomerId();

        try (Statement stmt = conexion.createStatement()) {
            stmt.executeUpdate(query);
            System.out.println("Fila eliminada.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static boolean existeCustomerId(Connection conexion, int customerId) {
        String query = "SELECT COUNT(*) FROM customer WHERE CustomerID = " + customerId;
        try (Statement stmt = conexion.createStatement();
             ResultSet result = stmt.executeQuery(query)) {

            if (result.next()) {
                return result.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return false;
    }

    public static Customer obtenerCustomerPorId(Connection conexion, int customerId) {
        String query = "SELECT * FROM customer WHERE CustomerID = " + customerId;
        try (Statement stmt = conexion.createStatement();
             ResultSet resultado = stmt.executeQuery(query)) {

            if (resultado.next()) {
                String address = resultado.getString("Address");
                String firstName = resultado.getString("FirstName");
                String lastName = resultado.getString("LastName");
                String email = resultado.getString("Email");
                return new Customer(customerId, address, firstName, lastName, email);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return null;
    }


}
