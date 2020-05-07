package fixhub.app.model;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;



@Entity
@Table(name="addressBook")

public class Addresses {
	
	@Id
	private Long id;
	private String street;
	private String city;
	private String state;
	private String zip;
	

	@JsonIgnore
	@OneToOne
	@MapsId
	private Users user;

	public Addresses() {
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}
	
		
	public Users getUser() {
		return user;
	}

	public void setUser(Users user) {
		this.user = user;
	}

}
