package fr.oz.zoo_api;

import com.fasterxml.jackson.core.JsonParser;
import fr.oz.zoo_api.model.Personnels;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.json.JSONObject;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import org.springframework.boot.test.context.SpringBootTest;


import java.io.IOException;

import java.net.HttpURLConnection;
import java.net.URL;

import static org.junit.jupiter.api.Assertions.assertEquals;


@SpringBootTest
class ZooApiApplicationTests {

	@Test
	void contextLoads() {
	}

	/**
	 * *Test si la connection à la base fonctionne
	 * pas besoin d'être log
	 * @throws IOException
	 */
	@Test
	@DisplayName("Test la connection à la base de données")
	void testGetPersonnels() throws IOException {

		URL url = new URL ("http://localhost:9003/api/personnels");
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-Type", "application/json");
		con.connect();
		int status = con.getResponseCode();
		System.out.println(status);
		int expected = 200;
		assertEquals(expected,status);
		con.disconnect();

	}
	@Test
	@DisplayName("Test le besoin d'être authentifié pour accèder à la ressource liste des espèces ")
 void testGetEspecesSansAuthentif() throws IOException {

		URL url = new URL ("http://localhost:9003/api/especes");
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		con.setRequestProperty("Content-Type", "application/json");
		con.connect();
		int status = con.getResponseCode();
		System.out.println(status);
		int expected = 401;
		assertEquals(expected,status);
		con.disconnect();

	}
//	@Test
// void testAuthentifSoigneur() throws IOException {
//
//		URL url = new URL ("http://localhost:9003/api/auth/signin");
//		HttpURLConnection con = (HttpURLConnection) url.openConnection();
//		con.setRequestMethod("POST");
//		con.setRequestProperty("Content-Type", "application/json");
//		con.connect();
//		int status = con.getResponseCode();
//		System.out.println(status);
//		int expected = 401;
//		assertEquals(expected,status);
//		con.disconnect();
//
//	}




}
