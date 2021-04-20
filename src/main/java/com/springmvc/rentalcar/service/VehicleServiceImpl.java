package com.springmvc.rentalcar.service;

import com.springmvc.rentalcar.dao.VehicleDao;
import com.springmvc.rentalcar.model.Vehicle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service("vehicleService")
@Transactional
public class VehicleServiceImpl implements VehicleService {
    @Autowired
    private VehicleDao dao;

    public Vehicle findById(int id) {
        return dao.findById(id);
    }

    public Vehicle findByModel(String model) {
        return dao.findByModel(model);
    }

    public void saveVehicle(Vehicle vehicle) {

        dao.saveVehicle(vehicle);
    }

    public void updateVehicle(Vehicle vehicle) {
        Vehicle entity = dao.findById(vehicle.getId());

        if(entity != null) {
            entity.setModel(vehicle.getModel());
            entity.setManufacturer(vehicle.getManufacturer());
            entity.setLicensePlate(vehicle.getLicensePlate());
            entity.setYearOfRegistration(vehicle.getYearOfRegistration());
            entity.setCategory(vehicle.getCategory());
        }
    }

    public void deleteVehicle(int id) {
        dao.deleteVehicle(id);
    }

    public List<Vehicle> findAllVehicles() {
        return dao.findAllVehicles();
    }
}
