package com.jeevanspring.inventory.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jeevanspring.inventory.entity.Product;

public interface ProductRepo extends JpaRepository<Product, Integer>{

	Product findByName(String name);

}
