package fixhub.app.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import fixhub.app.model.Users;

@Repository
public interface UserRepository extends JpaRepository<Users, Long> {
	
	Optional<Users> findById(Long id);
	
	void deleteById(Long id);

	Optional<Users> findByEmail(String email);
	
	@Query("FROM Users WHERE email=?1 AND password=?2")
	Optional<Users> logIn(String email, String password);

	@Query("FROM Users WHERE fName=?1 OR lName=?1 OR fName LIKE ?1% OR lName LIKE ?1%")
	List<Users> findByName(String keyword);
	
	

}
