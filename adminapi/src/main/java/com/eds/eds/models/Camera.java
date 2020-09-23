package com.eds.eds.models;



import org.springframework.data.annotation.Id;


public class Camera {

    @Id
    private String id;
    private String name;
    private String locationId;
    private String coordinates;

    public Camera() {
    }

    public Camera(String id, String name, String locationId, String coordinates) {
        this.id = id;
        this.name = name;
        this.locationId = locationId;
        this.coordinates = coordinates;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocationId() {
        return locationId;
    }

    public void setLocationId(String locationId) {
        this.locationId = locationId;
    }

    public String getCoordinates() {
        return coordinates;
    }

    public void setCoordinates(String coordinates) {
        this.coordinates = coordinates;
    }
}
