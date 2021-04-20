package com.springmvc.rentalcar.dao;

import com.springmvc.rentalcar.model.Vehicle;

import java.util.List;

public interface VehicleDao {
    Vehicle findById(int id);

    Vehicle findByModel(String model);

    void saveVehicle(Vehicle vehicle);

    void deleteVehicle(int id);

    List<Vehicle> findAllVehicles();
}
