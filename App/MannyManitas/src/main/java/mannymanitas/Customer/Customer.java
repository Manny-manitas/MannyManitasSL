package mannymanitas.Customer;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
public class Customer {

    private final int customerId;
    private String address;
    private String firstName;
    private String lastName;
    private String email;

}