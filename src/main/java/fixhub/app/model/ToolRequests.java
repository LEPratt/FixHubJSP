package fixhub.app.model;

import java.util.Date;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Entity
@Table(name="toolRequsets")

public class ToolRequests {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Long id;
	private String toolRequested;
	private String pickUp;
	private String returnDate;
	
	@JsonIgnore
	@ManyToOne(cascade=CascadeType.DETACH)
	@JoinColumn(name="user_id")
	private Users user;

	public ToolRequests() {
		super();
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getToolRequested() {
		return toolRequested;
	}

	public void setToolRequested(String toolRequested) {
		this.toolRequested = toolRequested;
	}

	
	public String getPickUp() {
		return pickUp;
	}

	public void setPickUp(String pickUp) {
		this.pickUp = pickUp;
	}

	public String getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(String returnDate) {
		this.returnDate = returnDate;
	}

	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

}
