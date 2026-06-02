package com.cariq.backend.model;

import java.util.List;
import java.util.Map;

import org.springframework.data.mongodb.core.mapping.Field;

import lombok.Data;

/**
 * Una generación de un vehículo. Subdocumento embebido dentro de Vehicle.
 *
 * Los bloques engine / consumption / body se modelan como Map<String, Object>
 * porque su estructura varía según el tipo de vehículo (combustión, eléctrico,
 * moto). De esta forma no se pierde ningún campo aunque difieran entre
 * documentos.
 */
@Data
public class Generation {

    private String name;

    @Field("year_start")
    private Integer yearStart;

    @Field("year_end")
    private Integer yearEnd;

    /**
     * Campos variables: combustión, eléctrico (battery_kwh, range_km), moto
     * (displacement_cc), etc.
     */
    private Map<String, Object> engine;

    private String transmission;

    private Map<String, Object> consumption;

    @Field("price_usd")
    private Double priceUsd;

    private Map<String, Object> body;

    private List<String> images;
}
