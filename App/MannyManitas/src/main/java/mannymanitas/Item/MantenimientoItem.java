package mannymanitas.Item;

import javafx.collections.FXCollections;
import javafx.collections.ObservableList;

import java.sql.*;

public class MantenimientoItem {

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

    public static ObservableList<Item> consulta(Connection conexion) {
        ObservableList<Item> listaItems = FXCollections.observableArrayList();
        String query = "SELECT * FROM item";

        try (Statement stmt = conexion.createStatement();
             ResultSet resultado = stmt.executeQuery(query)) {

            while (resultado.next()) {
                int itemId = resultado.getInt("ItemID");
                String categoriaStr = resultado.getString("Category");
                Category categoria;
                try {
                    categoria = Category.valueOf(categoriaStr.toUpperCase());
                } catch (IllegalArgumentException e) {
                    System.out.println("Categoría no válida en la base de datos: " + categoriaStr);
                    continue;
                }
                String nameItem = resultado.getString("NameItem");
                double price = resultado.getDouble("Price");
                listaItems.add(new Item(itemId, categoria, nameItem, price));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }

        return listaItems;
    }

    public static void insertar(Connection conexion, Item item) {
        int siguienteItemId = siguienteItemId(conexion);
        String query = "INSERT INTO item (ItemID, Category, NameItem, Price) VALUES ("
                + siguienteItemId + ",'" + item.getCategoria() + "','" + item.getNameItem() + "'," + item.getPresio() + ")";

        try (Statement stmt = conexion.createStatement()) {
            stmt.executeUpdate(query);
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static int siguienteItemId(Connection conexion) {
        String query = "SELECT MAX(ItemID) FROM item";
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

    public static void modificar(Connection conexion, Item item, int itemIdAnterior) {
        String query = "UPDATE item SET Category = '"
                + item.getCategoria() + "', NameItem = '" + item.getNameItem() + "', Price = " + item.getPresio()
                + " WHERE ItemID = " + itemIdAnterior;

        try (Statement stmt = conexion.createStatement()) {
            stmt.executeUpdate(query);
            System.out.println("Fila modificada.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static void borrar(Connection conexion, Item item) {
        String query = "DELETE FROM item WHERE ItemID = " + item.getItemId();

        try (Statement stmt = conexion.createStatement()) {
            stmt.executeUpdate(query);
            System.out.println("Fila eliminada.");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
    }

    public static boolean existeItemId(Connection conexion, int itemId) {
        String query = "SELECT COUNT(*) FROM item WHERE ItemID = " + itemId;
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

    public static double obtenerPrecioPorItemId(Connection conexion, int itemId) {
        double precio = 0.0;
        String sql = "SELECT price FROM ITEM WHERE ItemID = " + itemId;

        try (Statement stmt = conexion.createStatement()) {
            ResultSet rs = stmt.executeQuery(sql);
            if (rs.next()) {
                precio = rs.getDouble("price");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return precio;
    }

    public static Item obtenerItemPorId(Connection conexion, int itemId) {
        String query = "SELECT * FROM item WHERE ItemID = " + itemId;
        try (Statement stmt = conexion.createStatement();
             ResultSet resultado = stmt.executeQuery(query)) {

            if (resultado.next()) {
                String categoriaStr = resultado.getString("Category");
                Category categoria = Category.valueOf(categoriaStr.toUpperCase());
                String nameItem = resultado.getString("NameItem");
                double price = resultado.getDouble("Price");
                return new Item(itemId, categoria, nameItem, price);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            throw new RuntimeException(e);
        }
        return null;
    }

}