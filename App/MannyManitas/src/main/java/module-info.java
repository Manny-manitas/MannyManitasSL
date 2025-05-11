module project.mannymanitas {
    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.web;

    requires org.controlsfx.controls;
    requires com.dlsc.formsfx;
    requires net.synedra.validatorfx;
    requires org.kordamp.ikonli.javafx;
    requires org.kordamp.bootstrapfx.core;
    requires eu.hansolo.tilesfx;
    requires com.almasb.fxgl.all;
    requires java.sql;
    requires static lombok;

    opens mannymanitas.Main to javafx.fxml;
    exports mannymanitas.Main;
    opens mannymanitas.Customer to javafx.fxml;
    exports mannymanitas.Customer;
    opens mannymanitas.Item to javafx.fxml;
    exports mannymanitas.Item;
    opens mannymanitas.Order to javafx.fxml;
    exports mannymanitas.Order;
    opens mannymanitas.OrderDetail to javafx.fxml;
    exports mannymanitas.OrderDetail;
}
