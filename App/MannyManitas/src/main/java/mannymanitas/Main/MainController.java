package mannymanitas.Main;

import javafx.fxml.FXML;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.layout.HBox;

import java.io.IOException;

public class MainController {

    @FXML
    private ComboBox<String> tablaComboBox;

    @FXML
    private Label seleccionLabel;

    @FXML
    private HBox imageContainer;

    @FXML
    public void initialize() {
        tablaComboBox.getItems().addAll("Customer", "Item", "Order", "OrderDetail");
        cargarImagen();
    }

    private void cargarImagen() {
        try {
            Image imagen = new Image(getClass().getResourceAsStream("/images/manny_manitas.png"));
            ImageView vistaImagen = new ImageView(imagen);
            imageContainer.getChildren().add(vistaImagen);
        } catch (Exception e) {
            System.err.println("Error al cargar la imagen: " + e.getMessage());
        }
    }

    @FXML
    public void irButtonClick() throws IOException {
        String elec = tablaComboBox.getSelectionModel().getSelectedItem();
        if (elec != null) {
            seleccionLabel.setVisible(false);
            switch (elec) {
                case "Customer":
                    MainApplication.setRoot("customer-view");
                    break;
                case "Item":
                    MainApplication.setRoot("item-view");
                    break;
                case "Order":
                    MainApplication.setRoot("order-view");
                    break;
                case "OrderDetail":
                    MainApplication.setRoot("order-detail-view");
                    break;
            }
        } else {
            seleccionLabel.setVisible(true);
        }
    }
}
