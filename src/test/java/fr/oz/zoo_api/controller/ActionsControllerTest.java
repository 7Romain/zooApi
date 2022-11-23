package fr.oz.zoo_api.controller;

import fr.oz.zoo_api.repository.ActionsRepository;
import junit.framework.*;
import fr.oz.zoo_api.model.Actions;
import fr.oz.zoo_api.service.ActionsService;
import org.checkerframework.checker.units.qual.A;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
@ExtendWith(SpringExtension.class)
class ActionsServiceTest {

    @MockBean
    private ActionsRepository repo;

    @InjectMocks
    private ActionsService actionsService;


    @Test
    void shouldReturnListOfActionsByZone(){
        String zone = "montagne-europe";
        Actions action1 = new Actions("marmotte");
        Actions action2 = new Actions("marmotte");
        List<Actions> liste = new ArrayList<>();
        liste.add(action1);
        liste.add(action2);

        Mockito.when(repo.findActionsByZone(zone)).thenReturn(liste);
        List<Actions> result = actionsService.findActionsByZone(zone);

        System.out.println(actionsService.findActionsByZone(zone));
        assertTrue(result.size()>=2);
    }

}