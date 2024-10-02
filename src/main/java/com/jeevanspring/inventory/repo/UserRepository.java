package com.jeevanspring.inventory.repo;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.jeevanspring.inventory.entity.User;

public interface UserRepository extends JpaRepository<User , Long>{
	

	Optional<User> findByUserName(String userNm);
}
