package com.cariq.backend.model;

import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import lombok.Data;

/**
 * Vehículo del catálogo. Mapea la colección "vehicles".
 * El array "generations" tiene estructura flexible (ver {@link Generation}).
 */
@Data
@Document(collection = "vehicles")
public class Vehicle {

    @Id
    private String id;

    /** Referencia (como String) al _id de una Brand. */
    @Field("brand_id")
    private String brandId;

    /** car | motorcycle | truck */
    private String type;

    private String model;

    private String category;

    private List<String> tags;

    private String history;

    private List<Generation> generations;
}
