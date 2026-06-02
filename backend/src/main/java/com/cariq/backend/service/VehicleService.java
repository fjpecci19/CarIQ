package com.cariq.backend.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.cariq.backend.model.Vehicle;
import com.cariq.backend.repository.VehicleRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class VehicleService {

    private final VehicleRepository vehicleRepository;

    public List<Vehicle> findAll() {
        return vehicleRepository.findAll();
    }

    public Optional<Vehicle> findById(String id) {
        return vehicleRepository.findById(id);
    }
}
