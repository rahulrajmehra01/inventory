package com.jeevanspring.inventory.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jeevanspring.inventory.entity.Product;
import com.jeevanspring.inventory.repo.ProductRepo;

@Service
public class ProductService {

	@Autowired
	private ProductRepo repo;
	
	public Product saveProduct(Product product) {
	     return repo.save(product);	
	}
	
	public List<Product> saveProducts(List<Product> products){
		return repo.saveAll(products);
	}
	
	public List<Product> getProducts(){
		return repo.findAll();
	}
	
	public Optional<Product> fetchProduct(Product prod) {
		Optional<Product> isPresent = repo.findById(prod.getId());
		if(isPresent.isPresent()) {
			return repo.findById(prod.getId());
		}else {
			return null;
		}
		
	}
	
	public Product getProductByName(Product prod) {
		Product isPresent = repo.findByName(prod.getName());
		if(isPresent != null) {
			return isPresent;
		}else {
			return null;
		}
		
	}
	
	public String deleteProductById(Product prod) {
		Optional<Product> isPresentProd = repo.findById(prod.getId());
		if(isPresentProd.isPresent()) {
		    
			repo.deleteById(prod.getId());
			return "Product is Deleted - " +prod.getId();
		}else {
			return "Product is not Present In The DataBase";
		}
		
	}
	
	public Product updateProduct(Product product) {
		Optional<Product> OptionalProd = repo.findById(product.getId());
		if(OptionalProd.isPresent()){
			Product existingProd = OptionalProd.get();
			existingProd.setName(product.getName());
			existingProd.setPrice(product.getPrice());
			existingProd.setQuantity(product.getQuantity());
			
			return repo.save(existingProd);
		}else {
			return null;
		}
		
	}
//	public Product fetchProduct(int id) {
//		return repo.findById(id).orElse(null);
//	}
}
