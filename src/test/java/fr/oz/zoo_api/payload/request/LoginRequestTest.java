package fr.oz.zoo_api.payload.request;


import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;


class LoginRequestTest {
private LoginRequest loginRequest;

    @BeforeEach
    void setUp() {
        loginRequest = new LoginRequest("marion", "password");

    }

    @AfterEach
    void tearDown() {
        loginRequest = null;
    }

    @Test
    @DisplayName("Test que GetName fonctionne bien")
    void getUsername() {
        Assertions.assertThat(loginRequest.getUsername()).isEqualTo("marion");
    }

    @Test
    @DisplayName("Test si le nom a bien été set")
    void setUsername() {
        loginRequest.setUsername("louis");
        assertEquals("louis", loginRequest.getUsername() );
    }


}