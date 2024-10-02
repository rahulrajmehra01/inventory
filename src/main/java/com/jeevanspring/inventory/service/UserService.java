package com.jeevanspring.inventory.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jeevanspring.inventory.repo.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepo;
}
