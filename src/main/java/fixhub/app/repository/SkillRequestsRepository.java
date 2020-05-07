package fixhub.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import fixhub.app.model.SkillRequests;

@Repository
public interface SkillRequestsRepository extends JpaRepository<SkillRequests, Long> {

}
