package fixhub.app.service;

import java.util.List;
import java.util.Optional;

import fixhub.app.model.Users;

public interface UserService {
	Optional<Users> findByEmail(String email);
	Optional<Users> findById(Long id);
	void deleteById(Long id);
	Optional<Users> logIn(String email, String password);
	List<Users> findByName(String keyword);
	List<Users> findAll();
	void updateUser(Users user);
	void setRole(String role, Long id);
	void resetPassword(String password, Long id);
	void save(Users user);
	

}
