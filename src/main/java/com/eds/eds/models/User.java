package com.eds.eds.models;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

@Data
@NoArgsConstructor
public class User {

    @Id
    private String id;
    private String name;
    private String phone;
    private String password;
    private String typeId;
    private boolean admin;

}
