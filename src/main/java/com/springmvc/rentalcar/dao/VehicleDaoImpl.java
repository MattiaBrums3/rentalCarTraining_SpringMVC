package com.springmvc.rentalcar.dao;

import com.springmvc.rentalcar.model.Vehicle;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository("vehicleDao")
public class VehicleDaoImpl extends AbstractDao<Integer, Vehicle> implements VehicleDao {
    public Vehicle findById(int id) {
        return getByKey(id);
    }

    public Vehicle findByModel(String model) {
        Criteria c = createEntityCriteria();
        c.add(Restrictions.eq("model", model));
        return (Vehicle) c.uniqueResult();
    }

    public void saveVehicle(Vehicle vehicle) {
        persist(vehicle);
    }

    public void deleteVehicle(int id) {
        Criteria c = createEntityCriteria();
        c.add(Restrictions.eq("id", id));
        Vehicle vehicle = (Vehicle)c.uniqueResult();
        delete(vehicle);
    }

    @SuppressWarnings("unchecked")
    @Transactional
    public List<Vehicle> findAllVehicles() {
        Criteria c = createEntityCriteria().setResultTransformer(Criteria.DISTINCT_ROOT_ENTITY);;
        return (List<Vehicle>) c.list();
    }
}
