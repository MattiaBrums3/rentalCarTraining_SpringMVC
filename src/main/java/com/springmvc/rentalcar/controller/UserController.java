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
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.io.IOException;
import java.util.List;
import java.util.Locale;
import java.util.Map;

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
    public ModelAndView checkLogin(HttpServletRequest request,
                             HttpServletResponse response,
                             @RequestParam("username") String username,
                             @RequestParam("password") String password) throws IOException {
        String msg = "";
        HttpSession session = request.getSession();
        User user = userService.findByCredentials(username, password);

        if (user != null) {
            session.setAttribute("id", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("superUser", user.getSuperUser());

            return new ModelAndView("redirect:/user");
        } else {
            msg = "Username o password errati";
            session.setAttribute("msg", msg);

            return new ModelAndView("redirect:/");
        }
    }

    @RequestMapping(value={"/logout"}, method=RequestMethod.POST)
    public String logout(HttpServletRequest request) {
        request.getSession().removeAttribute("id");
        request.getSession().removeAttribute("username");
        request.getSession().removeAttribute("superUser");
        String msg = "A presto!";
        request.getSession().setAttribute("msg", msg);

        return "index";
    }

    @RequestMapping(value = {"/user" }, method = RequestMethod.GET)
    public String listUsers(ModelMap model) {
        List<User> users = userService.findAllUsers();
        model.addAttribute("listUsers", users);

        return "user-homepage";
    }

    @RequestMapping(value = { "/newUser" }, method = RequestMethod.GET)
    public String showNewUserForm() {
        return "user-form";
    }

    @RequestMapping(value = { "/editUser_{id}" }, method = RequestMethod.GET)
    public String showEditUserForm(@PathVariable int id,
                                   ModelMap model) {
        User user = userService.findById(id);
        model.addAttribute("user", user);

        return "user-form";
    }

    @RequestMapping(value = { "/insertUser" }, method = RequestMethod.POST)
    public String insertUser(@Valid User user,
                             BindingResult result) {
        if (result.hasErrors()){
            return "redirect:/user";
        }

        userService.saveUser(user);

        return "redirect:/user";
    }

    @RequestMapping(value = { "/updateUser" }, method = RequestMethod.POST)
    public String updateUser(@Valid User user,
                             BindingResult result) {
        if (result.hasErrors()){
            return "redirect:/user";
        }

        userService.updateUser(user);

        return "redirect:/user";
    }

    @RequestMapping(value = { "/deleteUser_{id}" }, method = RequestMethod.GET)
    public String deleteEmployee(HttpServletRequest request,
                                 @PathVariable int id) {
        HttpSession session = request.getSession();
        String msg = "";

        userService.deleteUser(id);
        msg = "Utente eliminato con successo";
        session.setAttribute("msg", msg);
        return "redirect:/user";
    }
}
