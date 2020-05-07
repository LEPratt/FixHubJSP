package fixhub.app.model;	

	import javax.persistence.*;

	import com.fasterxml.jackson.annotation.JsonIgnore;

	@Entity
	@Table(name="skills")

	public class Skills {
		
		@Id
		@GeneratedValue(strategy=GenerationType.AUTO)
		private Long id;
		private String skill;
		private String type;
		
		
		@JsonIgnore
		@ManyToOne(cascade=CascadeType.DETACH)
		@JoinColumn(name="users_id")
		private Users user;


		public Skills() {
			super();
		}


		public Long getId() {
			return id;
		}


		public void setId(Long id) {
			this.id = id;
		}


		public String getSkill() {
			return skill;
		}


		public void setSkill(String skill) {
			this.skill = skill;
		}


		

		public String getType() {
			return type;
		}


		public void setType(String type) {
			this.type = type;
		}


		public Users getUser() {
			return user;
		}


		public void setUser(Users user) {
			this.user = user;
		}

	}



