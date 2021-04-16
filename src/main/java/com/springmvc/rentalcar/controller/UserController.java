package com.springmvc.rentalcar.controller;

import com.springmvc.rentalcar.model.User;
import com.springmvc.rentalcar.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.List;
import java.util.Locale;

@Controller
@RequestMapping("/")
public class UserController {
    @Autowired
    UserService userService;

    @Autowired
    MessageSource messageSource;

    @RequestMapping(value={"/"}, method=RequestMethod.GET)
    public String getHomepage() {
        return "index";
    }

    @RequestMapping(value={"/login"}, method=RequestMethod.POST)
    public String checkLogin(HttpServletRequest request,
                             @RequestParam("username") String username,
                             @RequestParam("password") String password) {
        String msg = "";
        User user = userService.findByCredentials(username, password);

        if (user != null) {
            request.getSession().setAttribute("id", user.getId());
            request.getSession().setAttribute("username", user.getUsername());
            request.getSession().setAttribute("superUser", user.getSuperUser());

            return "user-homepage";
        } else {
            msg = "Username o password errati";
            request.getSession().setAttribute("msg", msg);

            return "index";
        }
    }

    @RequestMapping(value = {"/list" }, method = RequestMethod.GET)
    public String listUsers(ModelMap model) {
        List<User> users = userService.findAllUsers();
        model.addAttribute("listUsers", users);

        return "user-list";
    }

    @RequestMapping(value = { "/new" }, method = RequestMethod.POST)
    public String saveUser(@Valid User user, BindingResult result,
                           ModelMap model) {
        if (result.hasErrors()) {
            return "registration";
        }

        userService.saveUser(user);

        model.addAttribute("success", "User " + user.getName() + " registered successfully");
        return "success";
    }

    @RequestMapping(value = { "/edit-{id}-user" }, method = RequestMethod.GET)
    public String editUser(@PathVariable int id, ModelMap model) {
        User user = userService.findById(id);
        model.addAttribute("user", user);
        model.addAttribute("edit", true);
        return "registration";
    }

    @RequestMapping(value = { "/edit-{id}-user" }, method = RequestMethod.POST)
    public String updateEmployee(@Valid User user, BindingResult result,
                                 ModelMap model, @PathVariable int id) {
        if (result.hasErrors()) {
            return "registration";
        }

        userService.updateUser(user);

        model.addAttribute("success", "User " + user.getName()  + " updated successfully");
        return "success";
    }

    @RequestMapping(value = { "/delete-{id}-employee" }, method = RequestMethod.GET)
    public String deleteEmployee(@PathVariable int id) {
        userService.deleteUser(id);
        return "redirect:/list";
    }
}
