package fr.oz.zoo_api;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.test.context.support.WithMockUser;
import org.springframework.test.context.ContextConfiguration;

import fr.oz.zoo_api.controller.EspecesController;
import fr.oz.zoo_api.repository.EspecesRepository;
import fr.oz.zoo_api.service.EspecesService;

@SpringBootTest
@ContextConfiguration
class ZooApiApplicationTests {

	@Autowired
	EspecesController especesController;
	@Autowired
	EspecesService especesService;
	@Autowired
	EspecesRepository especesRepository;



	/**
	 * *Test la connection à la base de données
	 * pas besoin d'être log
	 *
	 */
	@Test
	@DisplayName("Test la connection à la base de données")
	void testGetPersonnels() throws IOException {
		URL url = new URL("http://localhost:9003/api/personnels");
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-Type", "application/json");
		con.connect();
		int status = con.getResponseCode();
		System.out.println(status);
		int expected = 200;
		assertEquals(expected, status);
		con.disconnect();

	}

	@Test
	@DisplayName("Test le besoin d'être authentifié pour accèder à la ressource liste des espèces avec échec ")
	void testGetEspecesSansAuthentif() throws IOException {

		URL url = new URL("http://localhost:9003/api/especes");
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-Type", "application/json");
		con.connect();
		int status = con.getResponseCode();
		int expected = 401;
		assertEquals(expected, status);
		con.disconnect();

	}

	@Test
	@WithMockUser(authorities = "SOIGNEUR")
	@DisplayName("Test le besoin d'être authentifié pour accèder à la ressource liste des espèces ")
	void testGetEspecesAvecAuthentif() throws IOException {
		URL url = new URL("http://localhost:9003/api/especes");
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-Type", "application/json");
		con.connect();
		int status = con.getResponseCode();
		int expected = 401;
		assertEquals(expected, status);
		con.disconnect();

	}


}
