package com.springmvc.rentalcar.service;

import com.springmvc.rentalcar.dao.RentalDao;
import com.springmvc.rentalcar.model.Rental;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service("rentalService")
@Transactional
public class RentalServiceImpl implements RentalService {
    @Autowired
    private RentalDao dao;

    public Rental findById(int id) {
        return dao.findById(id);
    }

    public List<Rental> findByUserId(int id) {
        return dao.findByUserId(id);
    }

    public void saveRental(Rental rental) {
        dao.saveRental(rental);
    }

    public void updateRental(Rental rental) {
        Rental entity = dao.findById(rental.getId());

        if (entity != null) {
            entity.setUser(rental.getUser());
            entity.setVehicle(rental.getVehicle());
            entity.setDateOfStart(rental.getDateOfStart());
            entity.setDateOfEnd(rental.getDateOfEnd());
            entity.setApproved(rental.getApproved());
        }
    }

    public void deleteRental(int id) {
        dao.deleteRental(id);
    }

    public List<Rental> findAllRentals() {
        return dao.findAllRentals();
    }
}
