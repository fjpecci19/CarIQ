package com.cariq.backend.model;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import lombok.Data;

/**
 * Marca de vehículos. Mapea la colección "brands".
 * Los nombres de campos en Mongo usan snake_case, por eso se mapean con @Field.
 */
@Data
@Document(collection = "brands")
public class Brand {

    @Id
    private String id;

    private String name;

    private String country;

    @Field("founded_year")
    private Integer foundedYear;

    private String founder;

    @Field("logo_url")
    private String logoUrl;

    private String history;

    @Field("vehicle_types")
    private List<String> vehicleTypes;

    private boolean active;
}
