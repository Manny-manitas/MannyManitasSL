package mannymanitas.Order;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.*;
import java.time.LocalDateTime;

public class MantenimientoOrder {

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

    public static ObservableList<Order> consulta(Connection conexion) {
        ObservableList<Order> listaOrders = FXCollections.observableArrayList();
        String query = "SELECT * FROM orders";

        try (Statement stmt = conexion.createStatement();
             ResultSet resultado = stmt.executeQuery(query)) {

            while (resultado.next()) {
                int orderId = resultado.getInt("OrderID");
                LocalDateTime orderDate = resultado.getTimestamp("OrderDate").toLocalDateTime();
                OrderStatus status = OrderStatus.valueOf(resultado.getString("Status").toUpperCase());
                int customerId = resultado.getInt("CustomerID");
                listaOrders.add(new Order(orderId, orderDate, status, customerId));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }

        return listaOrders;
    }

    public static void insertar(Connection conexion, Order order) {
        int siguienteOrderId = siguienteOrderId(conexion);
        String query = "INSERT INTO orders (OrderID, OrderDate, Status, CustomerID) VALUES ("
                + siguienteOrderId + ",'" + order.getOrderDate() + "','" + order.getStatus() + "'," + order.getCustomerId() + ")";

        try (Statement stmt = conexion.createStatement()) {
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static int siguienteOrderId(Connection conexion) {
        String query = "SELECT MAX(OrderID) FROM orders";
        try (Statement stmt = conexion.createStatement();
             ResultSet result = stmt.executeQuery(query)) {

            if (result.next()) {
                return result.getInt(1) + 1;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return 1;
    }

    public static void modificar(Connection conexion, Order order, int orderIdAnterior) {
        String query = "UPDATE orders SET OrderDate = '"
                + order.getOrderDate() + "', Status = '" + order.getStatus() + "', CustomerID = " + order.getCustomerId()
                + " WHERE OrderID = " + orderIdAnterior;

        try (Statement stmt = conexion.createStatement()) {
            stmt.executeUpdate(query);
            System.out.println("Fila modificada.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static void borrar(Connection conexion, Order order) {
        String query = "DELETE FROM orders WHERE OrderID = " + order.getOrderId();

        try (Statement stmt = conexion.createStatement()) {
            stmt.executeUpdate(query);
            System.out.println("Fila eliminada.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static boolean existeOrderId(Connection conexion, int orderId) {
        String query = "SELECT COUNT(*) FROM orders WHERE OrderID = " + orderId;
        try (Statement stmt = conexion.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return false;
    }

    public static int obtenerCustomerIdPorOrderId(Connection conexion, int orderId) {
        String query = "SELECT CustomerID FROM orders WHERE OrderID = " + orderId;
        try (Statement stmt = conexion.createStatement();
             ResultSet resultado = stmt.executeQuery(query)) {

            if (resultado.next()) {
                return resultado.getInt("CustomerID");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return -1;
    }

    public static LocalDateTime obtenerOrderDatePorOrderId(Connection conexion, int orderId) {
        String query = "SELECT OrderDate FROM orders WHERE OrderID = " + orderId;
        try (Statement stmt = conexion.createStatement();
             ResultSet resultado = stmt.executeQuery(query)) {

            if (resultado.next()) {
                return resultado.getTimestamp("OrderDate").toLocalDateTime();
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return null;
    }


}
