package com.cariq.backend.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.cariq.backend.model.Brand;
import com.cariq.backend.repository.BrandRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BrandService {

    private final BrandRepository brandRepository;

    public List<Brand> findAll() {
        return brandRepository.findAll();
    }

    public Optional<Brand> findById(String id) {
        return brandRepository.findById(id);
    }
}
