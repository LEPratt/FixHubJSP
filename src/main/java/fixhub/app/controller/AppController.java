package fixhub.app.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import fixhub.app.model.Addresses;
import fixhub.app.model.PhoneBook;
import fixhub.app.model.SkillRequests;
import fixhub.app.model.Skills;
import fixhub.app.model.States;
import fixhub.app.model.ToolRequests;
import fixhub.app.model.Tools;
import fixhub.app.model.Users;
import fixhub.app.repository.AddressRepository;
import fixhub.app.repository.PhoneBookRepository;
import fixhub.app.repository.SkillRequestsRepository;
import fixhub.app.repository.SkillsRepository;
import fixhub.app.repository.ToolRequestsRepository;
import fixhub.app.repository.ToolsRepository;
import fixhub.app.service.UserService;
import fixhub.app.utils.DataValidation;
import fixhub.app.utils.WebUtils;

@Controller
@SessionAttributes({ "loggedInID", "loggedInRole" })

public class AppController {

	@Autowired
	private UserService userService;

	@Autowired
	private AddressRepository addressRepository;

	@Autowired
	private PhoneBookRepository phoneBookRepository;

	@Autowired
	private ToolsRepository toolsRepository;

	@Autowired
	private SkillsRepository skillsRepository;

	@Autowired
	private ToolRequestsRepository toolRequestsRepository;

	@Autowired
	private SkillRequestsRepository skillRequestsRepository;

	@Autowired
	private DataValidation dataValidation;

	@Autowired
	private WebUtils webUtils;

	@GetMapping({ "index", "/" })
	String index(Model model) {
		model.addAttribute("page", "Home");
		model.addAttribute("msgt", "Welcome to FixHub!");
		model.addAttribute("msgs", "Fixing Cars and Connecting People");
		return "index";
	}

	@GetMapping("register")
	String register(Model model) {

		model.addAttribute("page", "Register");
		model.addAttribute("user", new Users());
		return "register";
	}

	@PostMapping("register")
	String register(@ModelAttribute("user") Users user, BindingResult result, RedirectAttributes redirect,
			Model model) {

		try {
			dataValidation.validate(user, result);
			if (result.hasErrors()) {
				return "register";
			}

			user.setRole("USER");
			user.setCreatedon(new java.util.Date());
			userService.save(user);
			PhoneBook book = new PhoneBook();

			book.setUser(user);
			book.setTel(user.getTel());
			book.setType(user.getType());
			phoneBookRepository.save(book);

			redirect.addFlashAttribute("success",
					"Successful Login, Thank You " + user.getfName() + " " + user.getlName() + "!");
			model.addAttribute("loggedInID", user.getId());
			model.addAttribute("loggedInRole", user.getRole());
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:/profile";

	}

	@PostMapping("login")
	String login(@RequestParam String email, @RequestParam String password, Model model, RedirectAttributes redirect) {
		Optional<Users> loggedIn = userService.logIn(email, password);
		if (loggedIn.isPresent()) {

			redirect.addFlashAttribute("success",
					"Successful Login, Thank You " + loggedIn.get().getfName() + " " + loggedIn.get().getlName() + "!");
			model.addAttribute("loggedInID", loggedIn.get().getId());
			model.addAttribute("loggedInRole", loggedIn.get().getRole());

		} else {
			redirect.addFlashAttribute("error", "Invalid Credentials Please try again. ");
			return "redirect:/register";
		}
		return "redirect:/profile";

	}

	@GetMapping("logout")
	String logout(HttpSession session, SessionStatus status, Model model, RedirectAttributes redirect) {
		session.removeAttribute("loggedInID");
		session.invalidate();
		model.addAttribute("loggedInID", "");
		model.addAttribute("loggedInRole", "");
		redirect.addFlashAttribute("page", "Register");
		redirect.addFlashAttribute("msg", "Thank You for using FixHub!");
		return "redirect:/register";
	}

	@GetMapping("expired")
	String exp(Model model, SessionStatus status) {
		status.setComplete();
		model.addAttribute("user", new Users());
		model.addAttribute("loggedInID", "");
		model.addAttribute("loggedInRole", "");
		model.addAttribute("expired", "You have been logged out due to inactivity");

		return "register";

	}

	@GetMapping("profile")
	String profile(@SessionAttribute("loggedInID") Long Id, Model model, RedirectAttributes redirect) {

		if (null == Id) {
			redirect.addFlashAttribute("page", "Registration");
			redirect.addFlashAttribute("msg", "Please Login!");
			redirect.addFlashAttribute("error", "Invalid Credentials Please Login or Try Again. ");
			return "redirect:/register";
		}
		model.addAttribute("user_account", userService.findById(Id).get());
		DateFormat df = new SimpleDateFormat("MM/dd/yyyy");
		model.addAttribute("createdOn", df.format(userService.findById(Id).get().getCreatedon()));
		model.addAttribute("page", "Profile");

		return "profile";
	}

	@GetMapping("about")
	String about(Model model) {
		model.addAttribute("page", "About Us");
		model.addAttribute("msg", "This is the about page.");
		return "about";
	}

	@GetMapping("contact")
	String contact(Model model) {
		model.addAttribute("page", "Contact Us");
		return "contact";
	}

	@GetMapping("tools")
	String tools(@SessionAttribute(value = "loggedInID", required = false) Long Id, Model model, @RequestParam(required = false) String tool) {
		model.addAttribute("page", "Tools");
		model.addAttribute("requestList", toolRequestsRepository.findAll());
		if (Id != null) {
			model.addAttribute("user_account", userService.findById(Id).get());
		}
		if (tool != null) {
			model.addAttribute("results", toolsRepository.findTool(tool));
			model.addAttribute("active", "tab2");
		} else {
			model.addAttribute("active", "tab1");
		}
		return "tools";
	}

	@GetMapping("skills")
	String skills(@SessionAttribute(value = "loggedInID", required = false) Long Id, Model model, @RequestParam(required = false) String skill) {
		model.addAttribute("page", "Skills");
		model.addAttribute("requestList", skillRequestsRepository.findAll());
		if (Id != null) {
			model.addAttribute("user_account", userService.findById(Id).get());
		}
		if (skill != null) {
			model.addAttribute("results", skillsRepository.findSkill(skill));
			model.addAttribute("active", "tab2");
		} else {
			model.addAttribute("active", "tab1");
		}
		return "skills";
	}

	@GetMapping("allusers")
	String allUsers(@SessionAttribute("loggedInRole") String Role, Model model, RedirectAttributes redirect) {
		if (Role.equals("ADMIN")) {
			model.addAttribute("list", userService.findAll());
			return "allusers";
		} else {
			redirect.addFlashAttribute("page", "Login");
			redirect.addFlashAttribute("msg", "Please Login!");
			redirect.addFlashAttribute("error", "Access Denied. Admin Access Required. ");
			return "redirect:/register";
		}
	}

	@GetMapping("delete")
	String delete(@RequestParam Long id, RedirectAttributes model) {
		userService.deleteById(id);
		model.addFlashAttribute("success", "User Deleted");
		return "redirect:/allusers";
	}

	@PostMapping("editrole")
	String editrole(@RequestParam String role, @RequestParam Long id, RedirectAttributes redirect) {

		try {
			userService.setRole(role, id);
			redirect.addFlashAttribute("success", "Update success");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:allusers";
	}

	@PostMapping("updateuser")
	String updateuser(@ModelAttribute Users update, RedirectAttributes redirect) {
		try {
			userService.findById(update.getId()).ifPresent(user -> {

				user.setlName(update.getlName());
				user.setfName(update.getfName());
				user.setEmail(update.getEmail());
				user.setPassword(update.getPassword());
				userService.save(user);
			});
			redirect.addFlashAttribute("list", userService.findAll());
			redirect.addFlashAttribute("success", "Update success");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:allusers";
	}

	@PostMapping("searchUser")
	String searchUser(@RequestParam String keyword, Model model) {

		try {
			model.addAttribute("list", userService.findByName(keyword));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "allusers";

	}

	@ModelAttribute("address")
	Addresses address() {
		return new Addresses();
	}

	@ModelAttribute("user")
	Users user() {
		return new Users();
	}

	@PostMapping("updateContact")
	String update(@ModelAttribute Addresses addresses, RedirectAttributes redirect) {

		try {
			Users user = userService.findById(addresses.getId()).get();
			addresses.setUser(user);
			addressRepository.save(addresses);
			redirect.addFlashAttribute("msg", "Update success");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:profile";
	}

	@ModelAttribute("states")
	public List<States> populateStates() {
		return Arrays.asList(States.values());
	}

	@PostMapping("sendemail")
	String sendemail(Model model, @RequestParam String to, @RequestParam String from, @RequestParam String message,
			@RequestParam String name, @RequestParam String subject, @RequestParam String page) {

		try {
			webUtils.sendMail(to.trim(), from.trim(), message + "\n From " + name, subject);
			model.addAttribute("msg", "Thank you " + name + ". Email sent :) ");
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (page.equalsIgnoreCase("skills")) {
			return "skills";
		} else if (page.equalsIgnoreCase("tools")) {
			return "tools";
		} else {
			return "contact";
		}

	}

	@ModelAttribute("tool")
	Tools tool() {
		return new Tools();
	}

	@PostMapping("addTool")
	String addTool(@ModelAttribute Tools tool, RedirectAttributes redirect) {

		try {
			Users user = userService.findById(tool.getId()).get();
			tool.setUser(user);
			toolsRepository.save(tool);
			redirect.addFlashAttribute("msg", "Tool Added");

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:profile";
	}

	@PostMapping("editToolType")
	String editToolType(@RequestParam String type, @RequestParam Long id, RedirectAttributes redirect) {

		try {
			toolsRepository.findById(id).ifPresent(a -> {
				a.setType(type);
				redirect.addFlashAttribute("msg", "Tool Updated");

			});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/profile";
	}

	@PostMapping("editToolStatus")
	String editToolStatus(@RequestParam String status, @RequestParam Long id, RedirectAttributes redirect) {

		try {
			toolsRepository.findById(id).ifPresent(a -> {
				a.setStatus(status);
				redirect.addFlashAttribute("msg", "Tool Updated");

			});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/profile";
	}

	@GetMapping("deleteTool")
	String deleteTool(@RequestParam Long id, RedirectAttributes redirect) {
		toolsRepository.deleteById(id);
		redirect.addFlashAttribute("msg", "Tool Deleted");

		return "redirect:profile";
	}

	@ModelAttribute("toolRequest")
	ToolRequests toolRequest() {
		return new ToolRequests();
	}

	@PostMapping("addToolRequest")
	String addToolRequest(@ModelAttribute ToolRequests toolRequest, RedirectAttributes redirect) {
		try {
			Users user = userService.findById(toolRequest.getId()).get();
			toolRequest.setUser(user);
			toolRequestsRepository.save(toolRequest);
			redirect.addFlashAttribute("msg", "Tool Request Added");
			redirect.addFlashAttribute("active", "tab3");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:tools";
	}

	@GetMapping("deleteToolRequest")
	String deleteToolRequest(@RequestParam Long id, RedirectAttributes redirect) {
		toolRequestsRepository.deleteById(id);
		redirect.addFlashAttribute("msg", "Tool Request Deleted");

		return "redirect:tools";
	}

	@ModelAttribute("skill")
	Skills skill() {
		return new Skills();
	}

	@PostMapping("addSkill")
	String addSkill(@ModelAttribute Skills skill, RedirectAttributes redirect) {

		try {
			Users user = userService.findById(skill.getId()).get();
			skill.setUser(user);
			skillsRepository.save(skill);
			redirect.addFlashAttribute("msg", "Skill Added");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:profile";

	}

	@GetMapping("deleteSkill")
	String deleteSkill(@RequestParam Long id, RedirectAttributes redirect) {
		skillsRepository.deleteById(id);
		redirect.addFlashAttribute("msg", "Skill Request Deleted");

		return "redirect:profile";
	}
	
	
	@ModelAttribute("skillRequest")
	SkillRequests skillRequest() {
		return new SkillRequests();
	}

	@PostMapping("addSkillRequest")
	String addSkillRequest(@ModelAttribute SkillRequests skillRequest, RedirectAttributes redirect) {
		try {
			Users user = userService.findById(skillRequest.getId()).get();
			skillRequest.setUser(user);
			skillRequestsRepository.save(skillRequest);
			redirect.addFlashAttribute("msg", "Request for Help Added");
			redirect.addFlashAttribute("active", "tab3");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:skills";
	}

	@GetMapping("deleteSkillRequest")
	String deleteSkillRequest(@RequestParam Long id, RedirectAttributes redirect) {
		skillRequestsRepository.deleteById(id);
		redirect.addFlashAttribute("msg", "Request for Help Deleted");

		return "redirect:skills";
	}


	@GetMapping("deletephone")
	String deletephone(@RequestParam Long id, RedirectAttributes redirect) {
		phoneBookRepository.deleteById(id);
		redirect.addFlashAttribute("msg", "Phone Number Deleted");

		return "redirect:profile";
	}

	@PostMapping("addphone")
	String addphone(@RequestParam Long id, @RequestParam String type, @RequestParam String tel, RedirectAttributes redirect) {

		try {
			PhoneBook book = new PhoneBook();
			Users user = userService.findById(id).get();
			book.setUser(user);
			book.setTel(tel);
			book.setType(type);
			phoneBookRepository.save(book);
			redirect.addFlashAttribute("msg", "Phone Number Added");

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:profile";

	}

	@PostMapping("/addimages")
	public String addprofileImg(@RequestParam("file") MultipartFile file, @RequestParam Long id, RedirectAttributes redirect) {

		Pattern ext = Pattern.compile("([^\\s]+(\\.(?i)(png|jpg))$)");
		try {

			if (file != null && file.isEmpty()) {
				redirect.addFlashAttribute("error", "Error No file Selected ");
				return "redirect:profile";
			}
			if (file.getSize() > 1073741824) {
				redirect.addFlashAttribute("error",
						"File size " + file.getSize() + "KB excceds max allowed, try another photo ");
				return "redirect:profile";
			}
			Matcher mtch = ext.matcher(file.getOriginalFilename());

			if (!mtch.matches()) {
				redirect.addFlashAttribute("error", "Invalid Image type ");
				return "redirect:profile";
			}
			// save image
			webUtils.addProfilePhoto(file, id, "users");
			redirect.addFlashAttribute("msg", "Upload success " + file.getSize() + " KB");

		} catch (Exception e) {
			// e.printStackTrace);
		}

		return "redirect:profile";
	}

	@PostMapping("passwordReset")
	String resetpass(Model model, @RequestParam String from, String to) {
		try {
			Optional<Users> findUser = userService.findByEmail(from);
			if (findUser.isPresent()) {
				Users usr = findUser.get();
				Random random = new Random();
				String token = String.format("%04d", random.nextInt(10000));
				usr.setToken(token);

				model.addAttribute("email", from);
				webUtils.sendMail(to, from, "Please use this token to reset your password " + token, "Password Reset");
			} else {
				model.addAttribute("error", "No user account found with " + from);
				return "login";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "resetpassword";
	}

	@PostMapping("resetpassword")
	String resetpassword(RedirectAttributes redirect, Model model, @RequestParam String to, @RequestParam String from,
			@RequestParam String token, @RequestParam String password) {
		try {
			String passwordRegex = "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&+=])(?=\\S+$).{8,}$";

			if (!password.matches(passwordRegex)) {
				model.addAttribute("error",
						"Password should be at least 8 characters, lower case, upper case and a special character.");
				model.addAttribute("email", from);
				return "resetpassword";
			}
			Optional<Users> findUser = userService.findByEmail(from);
			if (findUser.isPresent() && token.equals(findUser.get().getToken())) {
				Users usr = findUser.get();
				usr.setToken("");
				usr.setPassword(password);

				model.addAttribute("role", usr.getRole());
				model.addAttribute("loggedInuser", usr.getEmail());
				redirect.addFlashAttribute("success",
						"Password reset success thanks, please contact admin if you did not perform this change");
				webUtils.sendMail(to, from,
						"Password reset success thanks, please contact admin if you did not perform this change",
						"Password Reset");
				return "redirect:profile";
			} else {
				model.addAttribute("error", "Invalid token");
				model.addAttribute("email", from);

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "resetpassword";
	}

}
