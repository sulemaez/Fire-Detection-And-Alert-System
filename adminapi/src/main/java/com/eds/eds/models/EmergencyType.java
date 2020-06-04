package com.eds.eds.models;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

@Data
@NoArgsConstructor
public class EmergencyType {

    @Id
    private String id;
    private String name;
    private String description;


}
