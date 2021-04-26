package com.springmvc.rentalcar.controller;

import com.springmvc.rentalcar.model.Rental;
import com.springmvc.rentalcar.model.User;
import com.springmvc.rentalcar.service.RentalService;
import com.springmvc.rentalcar.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.AuthenticationTrustResolver;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.rememberme.PersistentTokenBasedRememberMeServices;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.IOException;
import java.util.Collection;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Controller
@RequestMapping("/")
@SessionAttributes("roles")
public class UserController {
    @Autowired
    UserService userService;

    @Autowired
    RentalService rentalService;

    @Autowired
    MessageSource messageSource;

    @Autowired
    PersistentTokenBasedRememberMeServices persistentTokenBasedRememberMeServices;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Autowired
    AuthenticationTrustResolver authenticationTrustResolver;

    @RequestMapping(value={"/"}, method=RequestMethod.GET)
    public String getHomepage(ModelMap model) {
        return "index";
    }

    @RequestMapping(value={"/login"}, method=RequestMethod.GET)
    public String checkLogin() {
        if (isCurrentAuthenticationAnonymous()) {
            return "redirect:/";
        } else {
            return "redirect:/user";
        }
    }

    @RequestMapping(value={"/logout"}, method=RequestMethod.GET)
    public String logout(HttpServletRequest request,
                         HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        if (auth != null) {
            persistentTokenBasedRememberMeServices.logout(request, response, auth);
            SecurityContextHolder.getContext().setAuthentication(null);
        }

        return "redirect:/login?logout";
    }

    @RequestMapping(value = {"/user" }, method = RequestMethod.GET)
    public String listUsers(ModelMap model) {

        List<User> users = userService.findAllUsers();
        model.addAttribute("listUsers", users);
        model.addAttribute("loggedinuser", getPrincipal());

        return "user-homepage";
    }

    @RequestMapping(value = { "/newUser" }, method = RequestMethod.GET)
    public String showNewUserForm(ModelMap model) {
        User user = new User();
        model.addAttribute("user", user);
        model.addAttribute("loggedinuser", getPrincipal());

        return "user-form";
    }

    @RequestMapping(value = { "/editUser_{id}" }, method = RequestMethod.GET)
    public String showEditUserForm(@PathVariable int id,
                                   ModelMap model) {
        User user = userService.findById(id);
        user.setPassword("");
        model.addAttribute("user", user);
        model.addAttribute("loggedinuser", getPrincipal());

        return "user-form";
    }

    @RequestMapping(value= { "/editUser" }, method = RequestMethod.GET)
    public String showMyProfile(ModelMap model) {
        User user = userService.findByUsername(getPrincipal());
        user.setPassword("");
        model.addAttribute("user", user);
        model.addAttribute("loggedinuser", getPrincipal());

        return "user-form";
    }

    @RequestMapping(value = { "/insertUpdateUser" }, method = RequestMethod.POST)
    public String insertUpdateUser(@Valid User user,
                             BindingResult result) {
        if (result.hasErrors()){
            return "redirect:/user";
        }

        passwordEncoder = new BCryptPasswordEncoder();

        if (user.getId() == 0) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            userService.saveUser(user);
        } else {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
            userService.updateUser(user);
        }

        return "redirect:/user";
    }

    @RequestMapping(value = { "/deleteUser_{id}" }, method = RequestMethod.GET)
    public String deleteUser(HttpServletRequest request,
                             @PathVariable int id) {
        HttpSession session = request.getSession();
        String msg = "";

        User user = userService.findById(id);

        if (user.getRentals().isEmpty()) {
            userService.deleteUser(id);
            msg = "Utente eliminato con successo";
        } else {
            msg = "Impossibile eliminare. L'utente ha prenotato veicoli.";
        }

        session.setAttribute("msg", msg);

        return "redirect:/user";
    }

    @ModelAttribute("roles")
    public List<User> initializeUsers() { return userService.findAllUsers(); }

    @RequestMapping(value = { "/accessDenied" }, method = RequestMethod.GET)
    public String accessDenied(ModelMap model) {
        model.addAttribute("loggedinuser", getPrincipal());

        return "access-denied";
    }

    private String getPrincipal() {
        String userName = null;
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        if (principal instanceof UserDetails) {
            userName = ((UserDetails)principal).getUsername();
        } else {
            userName = principal.toString();
        }

        return userName;
    }

    private Boolean isCurrentAuthenticationAnonymous() {
        final Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        return authenticationTrustResolver.isAnonymous(authentication);
    }
}
