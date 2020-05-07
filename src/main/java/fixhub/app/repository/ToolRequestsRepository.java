package fixhub.app.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import fixhub.app.model.ToolRequests;

@Repository
public interface ToolRequestsRepository extends JpaRepository<ToolRequests, Long> {

}
