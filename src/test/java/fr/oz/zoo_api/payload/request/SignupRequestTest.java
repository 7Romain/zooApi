package fr.oz.zoo_api.payload.request;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static org.junit.jupiter.api.Assertions.*;

class SignupRequestTest {
    SignupRequest signupRequest;

    @BeforeEach
    void setUp() {
        signupRequest = new SignupRequest();

    }

    @AfterEach
    void tearDown() {
       signupRequest = null;
    }


    @Test
    @DisplayName("Test si as bien l'email invalide si on entr eun email qui ne match pas la regex")
    void setWrongEmail() {
        signupRequest.setEmail("string");
        assertEquals("invalide", signupRequest.getEmail());

    }

    @Test
    @DisplayName("Test si un email qui match la regex est bien set")
    void setEmail() {
        signupRequest.setEmail("string@test.fr");
        assertEquals("string@test.fr", signupRequest.getEmail());

    }

    @Test
    @DisplayName("Test si mon regex est bon")
     void testUsingRFC5322Regex() {
        String emailAddress = "username@domain.com";
        Pattern regexPattern = Pattern.compile("^[a-zA-Z0-9_!#$%&'*+/=?`{|}~^.-]+@[a-zA-Z0-9.-]+$");
        Matcher matcher = regexPattern.matcher(emailAddress);
        assertTrue(matcher.matches());

    }
}