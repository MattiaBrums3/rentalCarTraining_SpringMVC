package com.springmvc.rentalcar.controller;

import com.springmvc.rentalcar.model.Category;
import com.springmvc.rentalcar.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
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
    public String showNewCategoryForm(ModelMap model) {
        Category category = new Category();
        System.out.println(category);
        model.addAttribute("category", category);

        return "category-form";
    }

    @RequestMapping(value = { "/editCategory_{id}" }, method = RequestMethod.GET)
    public String showEditCategoryForm(@PathVariable int id,
                                   ModelMap model) {
        Category category = categoryService.findById(id);
        model.addAttribute("category", category);

        return "category-form";
    }

    @RequestMapping(value = { "/insertCategory" }, method = RequestMethod.POST)
    public String insertCategory(@Valid Category category,
                                 BindingResult result) {
        if (result.hasErrors()) {
            return "redirect:/category";
        }

        categoryService.saveCategory(category);

        return "redirect:/category";
    }

    @RequestMapping(value = { "/updateCategory" }, method = RequestMethod.POST)
    public String updateCategory(@Valid Category category,
                                 BindingResult result) {
        if (result.hasErrors()) {
            return "redirect:/category";
        }

        categoryService.updateCategory(category);

        return "redirect:/category";
    }

    @RequestMapping(value = { "/deleteCategory_{id}" }, method = RequestMethod.GET)
    public String deleteCategory(HttpServletRequest request,
                                 @PathVariable int id) {
        HttpSession session = request.getSession();
        String msg = "";

        categoryService.deleteCategory(id);
        msg = "Categoria eliminata con successo";
        session.setAttribute("msg", msg);

        return "redirect:/category";

    }
}
