package com.springmvc.rentalcar.controller;

import com.springmvc.rentalcar.model.Category;
import com.springmvc.rentalcar.model.Vehicle;
import com.springmvc.rentalcar.service.CategoryService;
import com.springmvc.rentalcar.service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
@RequestMapping("/")
public class VehicleController {
    @Autowired
    VehicleService vehicleService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    MessageSource messageSource;

    @RequestMapping(value = { "/vehicle" }, method = RequestMethod.GET)
    public String listVehicles(ModelMap model) {
        List<Vehicle> vehicles = vehicleService.findAllVehicles();
        model.addAttribute("listVehicles", vehicles);

        return "vehicles";
    }

    @RequestMapping(value = { "/newVehicle" }, method = RequestMethod.GET)
    public String showNewVehicleForm(ModelMap model) {
        List<Category> categories = categoryService.findAllCategories();
        model.addAttribute("listCategories", categories);
        System.out.println(categories);
        return "vehicle-form";
    }
}
