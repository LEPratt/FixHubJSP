package fixhub.app.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import fixhub.app.model.Tools;

@Repository
public interface ToolsRepository extends JpaRepository<Tools, Long> { 
	
	Tools findById(String id);
		
	
	@Query("FROM Tools AS t INNER JOIN Users AS u ON t.user.id=u.id INNER JOIN Addresses AS a ON t.user.id=a.user.id WHERE tool LIKE %?1% ORDER BY city, tool")
	List<Tools> findTool(String keyword);

}
