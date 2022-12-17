package fr.oz.zoo_api.controller;

//@SpringBootTest

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;

import static org.assertj.core.api.Assertions.assertThat;

import static org.junit.jupiter.api.Assertions.assertThrows;

import org.junit.jupiter.api.Test;

@SpringBootTest
class ActionsControllerTest {

    @Autowired
    ActionsController actionsController;

    // private final String zonUrl = "/api/actions/zones/montagne-europe";

    @Test
     void getMessageUnauthenticated() {
        // assertThatThrownBy(()->{actionsController.getActionsByZone("montagne-europe");}).isInstanceOf(AuthenticationCredentialsNotFoundException.class);
        assertThrows(AuthenticationCredentialsNotFoundException.class, () -> {
            actionsController.getActionsByZone("montagne-europe");
        });
    }

    @Test
    void contextLoads() {
        assertThat(actionsController).isNotNull();
    }



}
