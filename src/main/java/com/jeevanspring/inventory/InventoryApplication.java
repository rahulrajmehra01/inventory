package com.jeevanspring.inventory;

import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import ch.qos.logback.classic.Logger;

@SpringBootApplication
public class InventoryApplication {
	
	private static final Logger log = (Logger) LoggerFactory.getLogger(InventoryApplication.class);

	public static void main(String[] args) {
		SpringApplication.run(InventoryApplication.class, args);
		log.info("Application is Running log by Logger 1");
	}

}
