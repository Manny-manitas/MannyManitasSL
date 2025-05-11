package mannymanitas.Order;

import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@AllArgsConstructor
public class Order {

    private final int orderId;
    private LocalDateTime orderDate;
    private OrderStatus status;
    private int customerId;
}
