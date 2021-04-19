package com.springmvc.rentalcar.controller;

import com.springmvc.rentalcar.model.Category;
import com.springmvc.rentalcar.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
@RequestMapping("/")
public class CategoryController {
    @Autowired
    CategoryService categoryService;

    @Autowired
    MessageSource messageSource;

    @RequestMapping(value={"/category"}, method= RequestMethod.GET)
    public String listCategories(ModelMap model) {
        List<Category> categories = categoryService.findAllCategories();
        model.addAttribute("listCategories", categories);
        return "categories";
    }

    @RequestMapping(value = { "/newCategory" }, method = RequestMethod.GET)
    public String showNewCategoryForm() {
        return "category-form";
    }

    @RequestMapping(value = { "/editCategory_{id}" }, method = RequestMethod.GET)
    public String showEditCategoryForm(@PathVariable int id,
                                   ModelMap model) {
        Category category = categoryService.findById(id);
        model.addAttribute("category", category);

        return "category-form";
    }
}
