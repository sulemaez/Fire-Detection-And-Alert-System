package com.eds.eds.models;


import org.springframework.data.annotation.Id;


public class Location {

    @Id
    private String id;
    private String name;
    private String countyId;

    public Location(String id, String name, String countyId) {
        this.id = id;
        this.name = name;
        this.countyId = countyId;
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

    public String getCountyId() {
        return countyId;
    }

    public void setCountyId(String countyId) {
        this.countyId = countyId;
    }
}
