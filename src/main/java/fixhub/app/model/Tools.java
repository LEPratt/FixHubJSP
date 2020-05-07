package fixhub.app.model;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="tools")

public class Tools {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	private String tool;
	private String type;
	private String status;
	
	@JsonIgnore
	@ManyToOne(cascade=CascadeType.DETACH)
	@JoinColumn(name="user_id")
	private Users user;


	public Tools() {
		super();
	}


	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getTool() {
		return tool;
	}


	public void setTool(String tool) {
		this.tool = tool;
	}


	public String getType() {
		return type;
	}


	public void setType(String type) {
		this.type = type;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public Users getUser() {
		return user;
	}


	public void setUser(Users user) {
		this.user = user;
	}

}
