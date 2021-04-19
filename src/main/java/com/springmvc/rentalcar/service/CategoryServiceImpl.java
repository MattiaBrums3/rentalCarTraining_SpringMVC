package com.springmvc.rentalcar.service;

import com.springmvc.rentalcar.dao.CategoryDao;
import com.springmvc.rentalcar.model.Category;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.List;

@Service("categoryService")
@Transactional
public class CategoryServiceImpl implements CategoryService {
    @Autowired
    private CategoryDao dao;

    public Category findById(int id) {
        return dao.findById(id);
    }

    public Category findByTypology(String typology) {
        return dao.findByTypology(typology);
    }

    public void saveCategory(Category category) {
        dao.saveCategory(category);
    }

    public void updateCategory(Category category) {
        Category entity = dao.findById(category.getId());
        if (entity != null) {
            entity.setTypology(category.getTypology());
        }
    }

    public void deleteCategory(int id) {
        dao.deleteCategory(id);
    }

    public List<Category> findAllCategories() {
        return dao.findAllCategories();
    }
}
