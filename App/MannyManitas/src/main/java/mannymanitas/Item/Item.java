package mannymanitas.Item;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
public class Item {

    private final int itemId;
    private Category categoria;
    private String nameItem;
    private double presio;
}
