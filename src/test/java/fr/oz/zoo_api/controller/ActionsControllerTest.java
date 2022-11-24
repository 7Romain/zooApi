package fr.oz.zoo_api.controller;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.client.TestRestTemplate;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.test.web.servlet.MockMvc;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;


@SpringBootTest


class ActionsControllerTest {
    @Autowired
    ActionsController actionsController;



    @Test
    void contextLoads() throws Exception{
        assertThat(actionsController).isNotNull();
    }

    @Test
    void TestgetActionsByZonel() {
        String zone = "montagne-europe";

        Assertions.assertThat(actionsController.getActionsByZone(zone).iterator().next().getIdAnimal()).isEqualTo("bobak");


    }



//    @Test
//    void givenIdZoneDoesNotExists_whenListeActionsParZoneDemande_then404Recu()throws ClientProtocolException, IOException{
//        String zone = "lune";
//        HttpUrlRequest request = new HttpGet( "https://api.github.com/users/" + name );
//    }

}