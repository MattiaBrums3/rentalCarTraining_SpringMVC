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
import java.util.Date;
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

    @RequestMapping(value = { "/newRental_{idVehicle}" }, method = RequestMethod.GET)
    public String showNewRentalForm(@PathVariable int idVehicle,
                                    ModelMap model) {
        Rental rental = new Rental();
        Vehicle vehicle = vehicleService.findById(idVehicle);
        rental.setVehicle(vehicle);
        model.addAttribute("rental", rental);

        return "rental-form";
    }

    @RequestMapping(value = { "/editRental_{id}" }, method = RequestMethod.GET)
    public String showEditRentalForm(@PathVariable int id,
                                     ModelMap model) {
        Rental rental = rentalService.findById(id);
        model.addAttribute("rental", rental);

        return "rental-form";
    }

    @RequestMapping(value = { "/insertUpdateRental" }, method = RequestMethod.POST)
    public String insertUpdateRental(@Valid Rental rental,
                                     BindingResult result,
                                     HttpServletRequest request) {

        if (result.hasErrors()) {
            return "redirect:/user";
        }

        HttpSession session = request.getSession();
        Date dateStart = rental.getDateOfStart();
        Date dateEnd = rental.getDateOfEnd();
        if(dateStart.getTime() > dateEnd.getTime()) {
            String msg = "Data di Inizio > Data di Fine";
            session.setAttribute("msg", msg);
            return "redirect:/user";
        }

        Vehicle v = vehicleService.findByModel(rental.getVehicle().getModel());
        User u = userService.findById((int)session.getAttribute("id"));
        rental.setUser(u);
        rental.setVehicle(v);

        if (rental.getId() == 0) {
            rental.setApproved(false);
            rentalService.saveRental(rental);
        } else {
            rental.setApproved(rental.getApproved());
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
