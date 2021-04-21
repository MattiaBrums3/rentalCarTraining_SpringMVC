package com.springmvc.rentalcar.controller;

import com.springmvc.rentalcar.model.Category;
import com.springmvc.rentalcar.model.Rental;
import com.springmvc.rentalcar.model.User;
import com.springmvc.rentalcar.model.Vehicle;
import com.springmvc.rentalcar.service.CategoryService;
import com.springmvc.rentalcar.service.RentalService;
import com.springmvc.rentalcar.service.UserService;
import com.springmvc.rentalcar.service.VehicleService;
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
public class VehicleController {
    @Autowired
    VehicleService vehicleService;

    @Autowired
    CategoryService categoryService;

    @Autowired
    UserService userService;

    @Autowired
    RentalService rentalService;

    @Autowired
    MessageSource messageSource;

    @RequestMapping(value = { "/vehicle" }, method = RequestMethod.GET)
    public String listVehicles(HttpServletRequest request,
                               ModelMap model) {
        HttpSession session = request.getSession();
        int idUser = (int)session.getAttribute("id");
        List<Vehicle> vehicles = vehicleService.findAllVehicles();
        User user = userService.findById(idUser);
        List<Rental> listRentals = rentalService.findAllRentals();
        model.addAttribute("listVehicles", vehicles);
        model.addAttribute("user", user);
        model.addAttribute("listRentals", listRentals);

        return "vehicles";
    }

    @RequestMapping(value = { "/newVehicle" }, method = RequestMethod.GET)
    public String showNewVehicleForm(ModelMap model) {
        Vehicle vehicle = new Vehicle();
        List<Category> categories = categoryService.findAllCategories();
        model.addAttribute("vehicle", vehicle);
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

    @RequestMapping(value = { "/insertUpdateVehicle" }, method = RequestMethod.POST)
    public String insertUpdateVehicle(@Valid Vehicle vehicle,
                                @Valid Category category,
                                BindingResult result) {
        if (result.hasErrors()) {
            return "redirect:/vehicle";
        }

        Category c = categoryService.findByTypology(category.getTypology());
        vehicle.setCategory(c);

        if (vehicle.getId() == 0) {
            vehicleService.saveVehicle(vehicle);
        } else {
            vehicleService.updateVehicle(vehicle);
        }


        return "redirect:/vehicle";
    }

    @RequestMapping(value = { "/deleteVehicle_{id}" }, method = RequestMethod.GET)
    public String deleteVehicle(HttpServletRequest request,
                                @PathVariable int id) {
        HttpSession session = request.getSession();
        String msg = "";

        vehicleService.deleteVehicle(id);
        msg = "Veicolo eliminato con successo";
        session.setAttribute("msg", msg);

        return "redirect:/vehicle";
    }
}
