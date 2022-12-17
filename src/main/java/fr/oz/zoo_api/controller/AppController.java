package fr.oz.zoo_api.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AppController {

    @GetMapping("/api/login")
    // @PreAuthorize("permitAll()")
    public String loginIndex() {
        return "login";
    }

}
