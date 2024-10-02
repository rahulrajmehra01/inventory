package com.jeevanspring.inventory.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home() {
        return "home"; // This will resolve to /WEB-INF/views/home.jsp
    }
}