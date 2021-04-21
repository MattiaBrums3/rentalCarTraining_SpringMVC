package com.springmvc.rentalcar.controller;

import com.springmvc.rentalcar.model.Rental;
import com.springmvc.rentalcar.model.User;
import com.springmvc.rentalcar.model.Vehicle;
import com.springmvc.rentalcar.service.RentalService;
import com.springmvc.rentalcar.service.UserService;
import com.springmvc.rentalcar.service.VehicleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;

@Controller
@RequestMapping("/")
public class RentalController {
    @Autowired
    RentalService rentalService;

    @Autowired
    UserService userService;

    @Autowired
    VehicleService vehicleService;

    @Autowired
    MessageSource messageSource;

    @RequestMapping(value = { "/rentals_{id}" }, method = RequestMethod.GET)
    public String getUserRentals(@PathVariable int id,
                                 ModelMap model) {
        List<Rental> listRentals = rentalService.findByUserId(id);
        model.addAttribute("listRentals", listRentals);

        return "rental-list";
    }

    @RequestMapping(value = { "/approveRental_{approved}_{id}" }, method = RequestMethod.GET)
    public String approveRental(HttpServletRequest request,
                                @PathVariable Boolean approved,
                                @PathVariable int id) {
        HttpSession session = request.getSession();
        Rental rental = rentalService.findById(id);

        if (approved == true) {
            rental.setApproved(true);
            rentalService.updateRental(rental);
        } else {
            rentalService.deleteRental(id);
        }

        return "redirect:/user";
    }

    @RequestMapping(value = { "/newRental" }, method = RequestMethod.GET)
    public String showNewRentalForm(ModelMap model) {
        Rental rental = new Rental();
        model.addAttribute("rental", rental);

        return "rental-form";
    }

    @RequestMapping(value = { "/editRental_{id}" }, method = RequestMethod.GET)
    public String showEditRentalForm(@PathVariable int id,
                                     ModelMap model) {
        Rental rental = rentalService.findById(id);
        Vehicle vehicle = rental.getVehicle();
        model.addAttribute("rental", rental);
        model.addAttribute("vehicle", vehicle);

        return "rental-form";
    }

    @RequestMapping(value = { "/insertUpdateRental" }, method = RequestMethod.POST)
    public String insertUpdateRental(@ModelAttribute(value="rental") @Valid Rental rental,
                                     BindingResult rental_result) {
        System.out.println(rental);
        if (rental_result.hasErrors()) {
            System.out.println("errore");
            return "redirect:/user";
        }

        if (rental.getId() == 0) {
            rentalService.saveRental(rental);
        } else {
            rentalService.updateRental(rental);
        }

        return "redirect:/user";
    }

    @RequestMapping(value = { "/deleteRental_{id}" }, method = RequestMethod.GET)
    public String deleteRental(HttpServletRequest request,
                                @PathVariable int id) {
        HttpSession session = request.getSession();
        String msg = "";

        rentalService.deleteRental(id);
        msg = "Prenotazione eliminata con successo.";
        session.setAttribute("msg", msg);

        return "redirect:/user";
    }
}
