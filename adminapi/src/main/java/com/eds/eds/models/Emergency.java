package com.eds.eds.models;


import org.springframework.data.annotation.Id;
import java.time.LocalDateTime;


public class Emergency {

    @Id
    private String id;
    private String typeId;
    private String locationId;
    private LocalDateTime time;

    public Emergency() {
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTypeId() {
        return typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public String getLocationId() {
        return locationId;
    }

    public void setLocationId(String locationId) {
        this.locationId = locationId;
    }

    public LocalDateTime getTime() {
        return time;
    }

    public void setTime(LocalDateTime time) {
        this.time = time;
    }
}
