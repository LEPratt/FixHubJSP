package fixhub.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import fixhub.app.model.Addresses;

public interface AddressRepository extends JpaRepository<Addresses, Long>{
	
	
	Addresses findById(String id);
	
	
}
