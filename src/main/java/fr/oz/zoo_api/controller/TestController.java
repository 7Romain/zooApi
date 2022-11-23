package fr.oz.zoo_api.controller;


import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/test")
public class TestController {
    @GetMapping("/all")
    public String allAccess() {
        return "Public Content.";
    }

    @GetMapping("/user")
    @PreAuthorize("hasRole('SOIGNEUR') or hasRole('RESPONSABLE') or hasRole('VETO')")
    public String userAccess() {
        return "Soigneur Content.";
    }

    @GetMapping("/mod")
    @PreAuthorize("hasRole('RESPONSABLE') or hasRole('VETO')")
    public String moderatorAccess() {
        return "Responsable Board.";
    }

    @GetMapping("/admin")
    @PreAuthorize("hasRole('VETO')")
    public String adminAccess() {
        return "Vétérinaire Board.";
    }
}