package com.springmvc.rentalcar.dao;

import com.springmvc.rentalcar.model.Rental;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.util.List;

@Repository("rentalDao")
public class RentalDaoImpl extends AbstractDao<Integer, Rental> implements RentalDao {
    public Rental findById(int id) {
        return getByKey(id);
    }

    public List<Rental> findByUserId(int id) {
        Criteria c = createEntityCriteria();
        c.add(Restrictions.eq("user.id", id));
        return (List<Rental>) c.list();
    }

    public void saveRental(Rental rental) {
        persist(rental);
    }

    public void deleteRental(int id) {
        Criteria c = createEntityCriteria();
        c.add(Restrictions.eq("id", id));
        Rental rental = (Rental)c.uniqueResult();
        delete(rental);
    }

    @SuppressWarnings("unchecked")
    @Transactional
    public List<Rental> findAllRentals() {
        Criteria c = createEntityCriteria();
        return (List<Rental>) c.list();
    }
}
