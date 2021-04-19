package com.springmvc.rentalcar.service;

import com.springmvc.rentalcar.model.Category;

import java.util.List;

public interface CategoryService {
    Category findById(int id);

    Category findByTypology(String typology);

    void saveCategory(Category category);

    void updateCategory(Category category);

    void deleteCategory(int id);

    List<Category> findAllCategories();
}
