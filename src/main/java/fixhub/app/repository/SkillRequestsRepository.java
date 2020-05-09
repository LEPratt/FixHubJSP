package fixhub.app.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import fixhub.app.model.SkillRequests;

@Repository
public interface SkillRequestsRepository extends JpaRepository<SkillRequests, Long> {
	
	@Query("FROM SkillRequests AS s INNER JOIN Users AS u ON s.user.id=u.id INNER JOIN Addresses AS a ON s.user.id=a.user.id WHERE skill_requested LIKE %?1% ORDER BY city, skill_requested")
	List<SkillRequests> findRequests(String keyword);

}
