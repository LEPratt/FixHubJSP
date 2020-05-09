package fixhub.app.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import fixhub.app.model.ToolRequests;

@Repository
public interface ToolRequestsRepository extends JpaRepository<ToolRequests, Long> {
	
	ToolRequests findById(String Id);
	
	@Query("FROM ToolRequests AS t INNER JOIN Users AS u ON t.user.id=u.id INNER JOIN Addresses AS a ON t.user.id=a.user.id WHERE tool_requested LIKE %?1% ORDER BY city, tool_requested")
	List<ToolRequests> findRequests(String keyword);
}
