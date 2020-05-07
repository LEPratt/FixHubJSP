package fixhub.app.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import fixhub.app.model.Skills;

@Repository
public interface SkillsRepository extends JpaRepository<Skills, Long> {
	
	
	@Query("FROM Skills AS s INNER JOIN Users AS u ON s.user.id=u.id INNER JOIN Addresses AS a ON s.user.id=a.user.id WHERE skill LIKE %?1% ORDER BY city, skill")
	List<Skills> findSkill(String keyword);

}
