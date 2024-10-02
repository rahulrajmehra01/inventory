package com.jeevanspring.inventory.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jeevanspring.inventory.entity.Product;
import com.jeevanspring.inventory.service.ProductService;

@RestController
@RequestMapping("/prod")
public class ProductController {
	
	@Autowired
	private ProductService service;
	
	@PostMapping("/addProduct")
	public Product addProduct(@RequestBody Product prod) {
		return service.saveProduct(prod);
	}
	
	@PostMapping("/addProducts")
	public List<Product> addProducts(@RequestBody List<Product> prod) {
		return service.saveProducts(prod);
	}
	
	@PostMapping("/getProduct")
	public List<Product> getProduct() {
		return service.getProducts();
	}
	
	@PostMapping("/getProdByName")
	public Product getProductByName(@RequestBody Product prod){
		return service.getProductByName(prod);
	}
	
//	@PostMapping("getById/{Id}")
//	public Optional<Product> getProductById(@PathVariable int Id){
//		return service.fetchProduct(Id);
//	}
//	
	
	@PostMapping("getById")
	public Optional<Product> getProductById(@RequestBody Product prod){
		return service.fetchProduct(prod);
	}
	
	@PostMapping("/deleteProduct")
	public String deleteProductById(@RequestBody Product prod) {
		return service.deleteProductById(prod);
	}
	
	@PostMapping("/updateProduct")
	public Product updateProduct(@RequestBody Product prod) {
		return service.updateProduct(prod);
	}
	
}
