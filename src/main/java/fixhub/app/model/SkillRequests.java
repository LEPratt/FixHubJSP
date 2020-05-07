package fixhub.app.model;

import java.util.Date;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="skillRequests")

public class SkillRequests {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	private String skillRequested;
	private String typeOfHelp;
	private String dateRequested;
	
	@JsonIgnore
	@ManyToOne(cascade=CascadeType.DETACH)
	@JoinColumn(name="user_id")
	private Users user;


	public SkillRequests() {
		super();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getSkillRequested() {
		return skillRequested;
	}

	public void setSkillRequested(String skillRequested) {
		this.skillRequested = skillRequested;
	}
	public String getTypeOfHelp() {
		return typeOfHelp;
	}

	public void setTypeOfHelp(String typeOfHelp) {
		this.typeOfHelp = typeOfHelp;
	}

	
	public String getDateRequested() {
		return dateRequested;
	}

	public void setDateRequested(String dateRequested) {
		this.dateRequested = dateRequested;
	}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

}
