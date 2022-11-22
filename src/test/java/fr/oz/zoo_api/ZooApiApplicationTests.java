package fr.oz.zoo_api;

import com.fasterxml.jackson.core.JsonParser;
import fr.oz.zoo_api.model.Personnels;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.json.JSONObject;
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
	 * @throws IOException
	 */
	@Test
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



}
