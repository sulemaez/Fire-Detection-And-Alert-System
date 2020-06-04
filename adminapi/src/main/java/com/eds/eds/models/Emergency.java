package com.eds.eds.models;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
public class Emergency {

    @Id
    private String id;
    private String typeId;
    private String locationId;
    private LocalDateTime time;


}
