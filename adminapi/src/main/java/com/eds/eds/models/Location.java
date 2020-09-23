package com.eds.eds.models;


import org.springframework.data.annotation.Id;


public class Location {

    @Id
    private String id;
    private String name;
    private String mainLocationId;

    public Location(String id, String name, String mainLocationId) {
        this.id = id;
        this.name = name;
        this.mainLocationId = mainLocationId;
    }

    public Location() {
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

    public String getMainLocationId() {
        return mainLocationId;
    }

    public void setMainLocationId(String mainLocationId) {
        this.mainLocationId = mainLocationId;
    }
}
