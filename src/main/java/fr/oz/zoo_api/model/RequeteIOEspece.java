package fr.oz.zoo_api.model;
import lombok.Data;
import java.util.List;

@Data
public class RequeteIOEspece {

    String idEspece;
    List<String> idAnimaux;
    String username;
    String  observations;
}
