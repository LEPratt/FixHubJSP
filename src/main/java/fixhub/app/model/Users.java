package fixhub.app.model;

import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.*;

@Entity
@Table(name="users")
public class Users {
	
	//Assign variables
		@Id
		@GeneratedValue(strategy=GenerationType.AUTO)
		private Long id;	
		private String fName;		
		private String lName;		
		private String email;
		private String password;		
		@Transient
		private String password2;
		private String role;
		private String image;
		@Column(name="created_on")
		private Date createdon;
		@Transient
		private String tel;
		@Transient
		private String type;
		private String token;

		
		
		@OneToOne(mappedBy="user", cascade=CascadeType.ALL)
		private Addresses address;
		
		@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
		private Set<PhoneBook> phoneBook;		
		
		@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
		private List<Tools> tools;
		
		@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
		private List<Skills> skills;
		
		@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
		private List<ToolRequests> toolRequests;
		
		@OneToMany(mappedBy="user", cascade=CascadeType.ALL)
		private List<SkillRequests> skillRequests;
		
		
		public Users() {
			super();
		}
		
		
		public Long getId() {
			return id;
		}
		public void setId(Long id) {
			this.id = id;
		}

		public String getfName() {
			return fName;
		}
		public void setfName(String fName) {
			this.fName = fName;
		}

		public String getlName() {
			return lName;
		}
		public void setlName(String lName) {
			this.lName = lName;
		}

		public String getEmail() {
			return email;
		}
		public void setEmail(String email) {
			this.email = email;
		}

		
		public String getPassword() {
			return password;
		}
		public void setPassword(String password) {
			this.password = password;
		}

		public String getPassword2() {
			return password2;
		}
		public void setPassword2(String password2) {
			this.password2 = password2;
		}


		public String getRole() {return role;}


		public void setRole(String role) {this.role = role;}


		
		 public String getImage() { return image; }
		 
		 
		 public void setImage(String image) { this.image = image; }
		 
		 
		 public Addresses getAddress() { return address; }
		 
		 
		 public void setAddress(Addresses address) { this.address = address; }


		public Date getCreatedon() {
			return createdon;
		}


		public void setCreatedon(Date createdon) {
			this.createdon = createdon;
		}


		public Set<PhoneBook> getPhoneBook() {
			return phoneBook;
		}


		public void setPhoneBook(Set<PhoneBook> phoneBook) {
			this.phoneBook = phoneBook;
		}

		
		public String getTel() {
			return tel;
		}


		public String getToken() {
			return token;
		}


		public void setToken(String token) {
			this.token = token;
		}


		public void setTel(String tel) {
			this.tel = tel;
		}


		public String getType() {
			return type;
		}


		public void setType(String type) {
			this.type = type;
		}


		public List<Tools> getTools() {
			return tools;
		}


		public void setTools(List<Tools> tools) {
			this.tools = tools;
		}


		public List<Skills> getSkills() {
			return skills;
		}


		public void setSkills(List<Skills> skills) {
			this.skills = skills;
		}


		public List<ToolRequests> getToolRequests() {
			return toolRequests;
		}


		public void setToolRequests(List<ToolRequests> toolRequests) {
			this.toolRequests = toolRequests;
		}


		public List<SkillRequests> getSkillRequests() {
			return skillRequests;
		}


		public void setSkillRequests(List<SkillRequests> skillRequests) {
			this.skillRequests = skillRequests;
		}
		 


}
