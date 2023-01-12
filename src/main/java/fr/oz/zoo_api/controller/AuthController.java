package fr.oz.zoo_api.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

import javax.validation.Valid;

import fr.oz.zoo_api.model.ERole;
import fr.oz.zoo_api.model.Role;
import fr.oz.zoo_api.model.User;
import fr.oz.zoo_api.payload.request.LoginRequest;
import fr.oz.zoo_api.payload.request.SignupRequest;
import fr.oz.zoo_api.payload.response.MessageResponse;
import fr.oz.zoo_api.payload.response.UserInfoResponse;
import fr.oz.zoo_api.repository.RoleRepository;
import fr.oz.zoo_api.repository.UserRepository;
import fr.oz.zoo_api.security.jwt.JwtUtils;
import fr.oz.zoo_api.service.UserDetailsImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;



//@CrossOrigin(origins = "http://localhost:4200", maxAge = 3600)
//@CrossOrigin(originPatterns = "http://localhost:4200")
@RestController
@RequestMapping("/api/auth")
@Validated
public class AuthController {
    private static final String ERREUR_MESSAGE = "Erreur, rôle introuvable.";
    @Autowired
    AuthenticationManager authenticationManager;

    @Autowired
    UserRepository userRepository;

    @Autowired
    RoleRepository roleRepository;

    @Autowired
    PasswordEncoder encoder;

    @Autowired
    JwtUtils jwtUtils;
    @CrossOrigin(origins = "http://localhost:4200")
    @PostMapping("/signin")
    public ResponseEntity<?> authenticateUser(@Valid @RequestBody LoginRequest loginRequest) {

        Authentication authentication = authenticationManager
                .authenticate(new UsernamePasswordAuthenticationToken(loginRequest.getUsername(), loginRequest.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(authentication);

        UserDetailsImpl userDetails = (UserDetailsImpl) authentication.getPrincipal();

        ResponseCookie jwtCookie = jwtUtils.generateJwtCookie(userDetails);

        List<String> roles = userDetails.getAuthorities().stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());

        return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, jwtCookie.toString())
                .body(new UserInfoResponse(userDetails.getId(),
                        userDetails.getUsername(),
                        userDetails.getEmail(),
                        roles) );
    }
    @PreAuthorize("hasRole('VETO')")
    @PostMapping("/signup")
    public ResponseEntity<?> registerUser(@Valid @RequestBody SignupRequest signUpRequest) {
        if (userRepository.existsByUsername(signUpRequest.getUsername())) {
            return ResponseEntity.badRequest().body(new MessageResponse("Erreur : le nom d'utilisateur est déjà utilisé !"));
        }

        if (userRepository.existsByEmail(signUpRequest.getEmail())) {
            return ResponseEntity.badRequest().body(new MessageResponse("Erreur: l' email est dégà utilisé !"));
        }

        // Create new user's account
        User user = new User(signUpRequest.getUsername(),
                signUpRequest.getEmail(),
                encoder.encode(signUpRequest.getPassword()));

        Set<String> strRoles = signUpRequest.getRole();
        Set<Role> roles = new HashSet<>();

        if (strRoles == null) {
            Role userRole = roleRepository.findByName(ERole.ROLE_SOIGNEUR)
                    .orElseThrow(() -> new RuntimeException(ERREUR_MESSAGE));
            roles.add(userRole);
        } else {
            strRoles.forEach(role -> {
                switch (role) {
                    case "veto" -> {
                        Role adminRole = roleRepository.findByName(ERole.ROLE_VETO)
                                .orElseThrow(() -> new RuntimeException(ERREUR_MESSAGE));
                        roles.add(adminRole);
                    }
                    case "responsable" -> {
                        Role modRole = roleRepository.findByName(ERole.ROLE_RESPONSABLE)
                                .orElseThrow(() -> new RuntimeException(ERREUR_MESSAGE));
                        roles.add(modRole);
                    }
                    default -> {
                        Role userRole = roleRepository.findByName(ERole.ROLE_SOIGNEUR)
                                .orElseThrow(() -> new RuntimeException(ERREUR_MESSAGE));
                        roles.add(userRole);
                    }
                }
            });
        }

        user.setRoles(roles);
        userRepository.save(user);

        return ResponseEntity.ok(new MessageResponse("User registered successfully!"));
    }

    @PostMapping("/signout")
    public ResponseEntity<?> logoutUser() {
        ResponseCookie cookie = jwtUtils.getCleanJwtCookie();
        return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, cookie.toString())
                .body(new MessageResponse("Vous vous êtes déconnecté !"));
    }
}