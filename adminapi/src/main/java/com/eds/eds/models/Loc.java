package com.eds.eds.models;

public class Loc {
    private double longi;
    private double lat;

    public Loc() {
    }

    public Loc(double longi, double lat) {
        this.longi = longi;
        this.lat = lat;
    }

    public static boolean calculateDistance(String coordinates, String location) {
        double[] c1 = getLatLong(coordinates);
        double[] c2 = getLatLong(location);

        double lat1 = c1[0];
        double lat2 = c2[0];
        double lon1 = c1[1];
        double lon2 = c2[1];

        if ((lat1 == lat2) && (lon1 == lon2)) {
            return false;
        }
        else {
            double theta = lon1 - lon2;
            double dist = Math.sin(Math.toRadians(lat1)) * Math.sin(Math.toRadians(lat2)) + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) * Math.cos(Math.toRadians(theta));
            dist = Math.acos(dist);
            dist = Math.toDegrees(dist);
            dist = dist * 60 * 1.1515;
            dist = dist * 1.609344;

            return dist <= 10;
        }
    }

    private static double[] getLatLong(String coordinates){
        String[] ray = coordinates.split(",");
        return new double[]{ Double.parseDouble(ray[0]), Double.parseDouble(ray[1]) };
    }

    public double getLongi() {
        return longi;
    }

    public void setLongi(double longi) {
        this.longi = longi;
    }

    public double getLat() {
        return lat;
    }

    public void setLat(double lat) {
        this.lat = lat;
    }
}
