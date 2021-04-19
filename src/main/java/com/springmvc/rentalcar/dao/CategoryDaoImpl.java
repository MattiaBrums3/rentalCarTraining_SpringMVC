package com.springmvc.rentalcar.dao;

import com.springmvc.rentalcar.model.Category;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository("categoryDao")
public class CategoryDaoImpl extends AbstractDao<Integer, Category> implements CategoryDao{
    public Category findById(int id) {
        return getByKey(id);
    }

    public Category findByTypology(String typology) {
        Criteria criteria = createEntityCriteria();
        criteria.add(Restrictions.eq("typology", typology));
        return (Category) criteria.uniqueResult();
    }

    public void saveCategory(Category category) {
        persist(category);
    }

    public void deleteCategory(int id) {
        Criteria c = createEntityCriteria();
        c.add(Restrictions.eq("id", id));
        Category category = (Category)c.uniqueResult();
        delete(category);
    }

    public List<Category> findAllCategories() {
        Criteria criteria = createEntityCriteria();
        return (List<Category>) criteria.list();
    }
}
