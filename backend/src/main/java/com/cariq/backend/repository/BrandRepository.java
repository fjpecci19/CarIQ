package com.cariq.backend.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.cariq.backend.model.Brand;

@Repository
public interface BrandRepository extends MongoRepository<Brand, String> {
}
