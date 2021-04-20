package com.springmvc.rentalcar.controller;

import com.springmvc.rentalcar.model.Category;
import com.springmvc.rentalcar.model.Vehicle;
import com.springmvc.rentalcar.service.CategoryService;
import com.springmvc.rentalcar.service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.validation.Valid;
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

        return "vehicle-form";
    }

    @RequestMapping(value = { "/editVehicle_{id}" }, method = RequestMethod.GET)
    public String showEditVehicleForm(@PathVariable int id,
                                      ModelMap model) {
        Vehicle vehicle = vehicleService.findById(id);
        List<Category> listCategories = categoryService.findAllCategories();
        model.addAttribute("vehicle", vehicle);
        model.addAttribute("listCategories", listCategories);

        return "vehicle-form";
    }

    @RequestMapping(value = { "/insertVehicle" }, method = RequestMethod.POST)
    public String insertVehicle(@Valid Vehicle vehicle,
                                BindingResult result) {
        if (result.hasErrors()) {
            return "redirect:/vehicle";
        }
        System.out.println(vehicle);

        vehicleService.saveVehicle(vehicle);

        return "redirect:/vehicle";
    }


}
