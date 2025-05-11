package mannymanitas.OrderDetail;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.*;
import java.time.LocalDate;

public class MantenimientoOrderDetail {

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

    public static ObservableList<OrderDetail> consulta(Connection conexion) {
        ObservableList<OrderDetail> listaOrderDetails = FXCollections.observableArrayList();
        String query = "SELECT * FROM order_details";

        try (Statement stmt = conexion.createStatement();
             ResultSet resultado = stmt.executeQuery(query)) {

            while (resultado.next()) {
                int orderId = resultado.getInt("OrderID");
                int itemId = resultado.getInt("ItemID");
                int cantidad = resultado.getInt("Quantity");
                double presio = resultado.getDouble("Price");
                LocalDate llegadaDate = resultado.getDate("ArrivalDate").toLocalDate();
                listaOrderDetails.add(new OrderDetail(orderId, itemId, cantidad, presio, llegadaDate));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }

        return listaOrderDetails;
    }

    public static void insertar(Connection conexion, OrderDetail orderDetail) {
        String query = "INSERT INTO order_details (OrderID, ItemID, Quantity, Price, ArrivalDate) VALUES ("
                + orderDetail.getOrderId() + ", " + orderDetail.getItemId() + ", " + orderDetail.getCantidad() + ", "
                + orderDetail.getPresio() + ", '" + orderDetail.getLlegadaDate() + "')";

        try (Statement stmt = conexion.createStatement()) {
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static void modificar(Connection conexion, OrderDetail orderDetail) {
        int antiguoOrderId = orderDetail.getAnteriorOrderId();
        int antiguoItemId = orderDetail.getAnteriorItemId();

        String query = "UPDATE order_details SET OrderID = " + orderDetail.getOrderId() + ", "
                + "ItemID = " + orderDetail.getItemId() + ", "
                + "Quantity = " + orderDetail.getCantidad() + ", "
                + "Price = " + orderDetail.getPresio() + ", "
                + "ArrivalDate = '" + orderDetail.getLlegadaDate() + "' "
                + "WHERE OrderID = " + antiguoOrderId + " AND ItemID = " + antiguoItemId;

        try (Statement stmt = conexion.createStatement()) {
            int columnas = stmt.executeUpdate(query);
            if (columnas > 0) {
                System.out.println("Fila modificada.");
            } else {
                System.out.println("No se modificó ninguna fila.");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static void borrar(Connection conexion, OrderDetail orderDetail) {
        String query = "DELETE FROM order_details WHERE OrderID = " + orderDetail.getOrderId() +
                " AND ItemID = " + orderDetail.getItemId();

        try (Statement stmt = conexion.createStatement()) {
            stmt.executeUpdate(query);
            System.out.println("Fila eliminada.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static boolean existeOrderDetail(Connection conexion, int orderId, int itemId) {
        String query = "SELECT COUNT(*) FROM order_details WHERE OrderID = " + orderId + " AND ItemID = " + itemId;
        try (Statement stmt = conexion.createStatement()) {
            ResultSet result = stmt.executeQuery(query);
            if (result.next()) {
                return result.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
