package mannymanitas.OrderDetail;

import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@AllArgsConstructor
public class OrderDetail {

    private final int orderId;
    private final int itemId;
    private int cantidad;
    private double presio;
    private LocalDate llegadaDate;

    private int anteriorOrderId;
    private int anteriorItemId;

    public OrderDetail(int orderId, int itemId, int cantidad, double presio, LocalDate llegadaDate) {
        this.orderId = orderId;
        this.itemId = itemId;
        this.cantidad = cantidad;
        this.presio = presio;
        this.llegadaDate = llegadaDate;
    }

}
