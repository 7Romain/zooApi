package fr.oz.zoo_api.controller;


import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.assertj.core.api.Assertions.assertThat;


@SpringBootTest
@RestController
@RequestMapping("/api/test")
class TestController {


    @GetMapping("/admin")

    public String adminAccess() {
        return "Vétérinaire Board.";
    }

    @Test
    void adminAccessTest(){ assertThat(adminAccess()).isEqualTo("Vétérinaire Board.");}
}