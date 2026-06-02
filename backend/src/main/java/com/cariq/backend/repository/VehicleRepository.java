package com.cariq.backend.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.cariq.backend.model.Vehicle;

@Repository
public interface VehicleRepository extends MongoRepository<Vehicle, String> {
}
