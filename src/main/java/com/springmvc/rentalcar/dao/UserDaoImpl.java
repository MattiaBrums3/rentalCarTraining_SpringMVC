package com.springmvc.rentalcar.dao;

import com.springmvc.rentalcar.model.User;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("userDao")
public class UserDaoImpl extends AbstractDao<Integer, User> implements UserDao {
    public User findById(int id) {
        return getByKey(id);
    }

    public User findByCredentials(String username, String password) {
        Criteria criteria = createEntityCriteria();
        criteria.add(Restrictions.eq("username", username));
        criteria.add(Restrictions.eq("password", password));
        return (User) criteria.uniqueResult();
    }

    public void saveUser(User user) {
        user.setSuperUser(false);
        persist(user);
    }

    public void deleteUser(int id) {
        Criteria c = createEntityCriteria();
        c.add(Restrictions.eq("id", id));
        User user = (User)c.uniqueResult();
        delete(user);
    }

    @SuppressWarnings("unchecked")
    public List<User> findAllUsers() {
        Criteria criteria = createEntityCriteria();
        return (List<User>) criteria.list();
    }
}
