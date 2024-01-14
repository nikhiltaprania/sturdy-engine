package com.bookmanagement.model;

public class Address {
    private int addressId;
    private String city;
    private String state;
    private int pinCode;

    public Address() {
    }

    public Address(String city, String state, int pinCode) {
        this.city = city;
        this.state = state;
        this.pinCode = pinCode;
    }

    public int getAddressId() {
        return addressId;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public int getPinCode() {
        return pinCode;
    }

    public void setPinCode(int pinCode) {
        this.pinCode = pinCode;
    }

    public String getFullAddress() {
        return String.format("[%s, %s, %d]", city, state, pinCode);
    }
}