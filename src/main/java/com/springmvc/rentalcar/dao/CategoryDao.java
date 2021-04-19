package com.springmvc.rentalcar.dao;

import com.springmvc.rentalcar.model.Category;

import java.util.List;

public interface CategoryDao {
    Category findById(int id);

    Category findByTypology(String typology);

    void saveCategory(Category category);

    void deleteCategory(int id);

    List<Category> findAllCategories();
}
