package com.doraemon.comp.oo.repository;

import org.springframework.data.repository.CrudRepository;

import com.doraemon.comp.oo.model.User;

public interface RoleDao extends CrudRepository<User, Long> {

	User findRoleByUsername(String username);
   
	User findRoleByUsernameAndPassword(String username, String password);
}
