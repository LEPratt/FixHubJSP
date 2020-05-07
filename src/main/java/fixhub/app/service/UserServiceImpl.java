package fixhub.app.service;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import fixhub.app.model.Users;
import fixhub.app.repository.UserRepository;

@Service
@Transactional
public class UserServiceImpl implements UserService {
	
	
	private UserRepository userRepository;
	
	@Autowired
	public UserServiceImpl(UserRepository userRepository) {
		super();
		this.userRepository = userRepository;
	}

	@Override
	public Optional<Users> findByEmail(String email) {
		return userRepository.findByEmail(email);
	}

	@Override
	public Optional<Users> findById(Long id) {
		return userRepository.findById(id);
	}

	@Override
	public void deleteById(Long id) {
	}

	@Override
	public Optional<Users> logIn(String email, String password) {
		return userRepository.logIn(email, password);
	}

	@Override
	public List<Users> findByName(String keyword) {
		return userRepository.findByName(keyword);
	}

	@Override
	public void updateUser(Users user) {
		
	}

	@Override
	public void setRole(String role, Long id) {
		userRepository.findById(id).ifPresent(a->{a.setRole(role);});
	}
	

	@Override
	public void resetPassword(String password, Long id) {
		userRepository.findById(id).ifPresent(a->{a.setPassword(password);});
	}

	@Override
	public void save(Users user) {
		userRepository.save(user);
		
	}

	@Override
	public List<Users> findAll() {
		return userRepository.findAll();
	}

}
