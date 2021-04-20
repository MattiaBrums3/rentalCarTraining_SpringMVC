package com.springmvc.rentalcar.service;

import com.springmvc.rentalcar.model.Vehicle;

import java.util.List;

public interface VehicleService {
    Vehicle findById(int id);

    Vehicle findByModel(String model);

    void saveVehicle(Vehicle vehicle);

    void updateVehicle(Vehicle vehicle);

    void deleteVehicle(int id);

    List<Vehicle> findAllVehicles();
}
