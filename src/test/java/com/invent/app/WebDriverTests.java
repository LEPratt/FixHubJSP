package com.invent.app;

import java.util.concurrent.TimeUnit;
import org.junit.AfterClass;
import org.junit.BeforeClass;
import org.junit.Ignore;
import org.junit.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.interactions.Actions;

import io.github.bonigarcia.wdm.WebDriverManager;

public class WebDriverTests {

static WebDriver driver;

static String url ="http://localhost:2500/capstone";

static String co_link ="COMPANY";

    @BeforeClass
public static void openBrowser() {  
    //System.setProperty("webdriver.ie.driver", "C:\\ws\\drivers\\IEDriverServer.exe");
        //driver=new InternetExplorerDriver();   
WebDriverManager.chromedriver().setup();
    //System.setProperty("webdriver.chrome.driver", "C:\\ws\\drivers\\chromedriver.exe");
        
driver = new ChromeDriver();  
        driver.manage().window().maximize();
        driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
        
    }
    


public void login(String email, String password) throws InterruptedException {
	driver.get(url);
	Thread.sleep(1000);
	driver.findElement(By.name("email")).sendKeys(email);
	Thread.sleep(1000);
	driver.findElement(By.name("password")).sendKeys(password);
	driver.findElement(By.id("submit")).click();
	Thread.sleep(1000);
    
}

public void logout() throws InterruptedException {
	driver.findElement(By.linkText("Logout")).click();
	Thread.sleep(3000);
}
    

@Test
//@Ignore
public void loginTests() throws InterruptedException {
	//testheader();
	login("me@email.com","1");
	testheader();
	logout();
	login("john@email.com","1");
	testheader();
	logout();

}

@Test
@Ignore
public void google() throws InterruptedException {
driver.get("https://www.google.com/");
Thread.sleep(300);
}

@Test
@Ignore
public void testheader() throws InterruptedException {
testlink("");
Thread.sleep(30);
testlink("about");
Thread.sleep(30);
testlink("contact");
Thread.sleep(30);
testlink("error");
Thread.sleep(30);
testlink("register");
Thread.sleep(30);
testlink("profile");
Thread.sleep(30);
testlink("allusers");

}

public synchronized void testlink(String page) throws InterruptedException {
	driver.get("http://localhost:2500/capstone/"+page+"");
	driver.findElement(By.linkText("HOME")).click(); 
    Thread.sleep(1000);
	driver.findElement(By.linkText("PROFILE")).click(); 
    Thread.sleep(1000);
    driver.findElement(By.linkText("ABOUT US")).click();  
    Thread.sleep(1000);
    driver.findElement(By.linkText("CONTACT US")).click(); 
    Thread.sleep(1000);
    //driver.findElement(By.linkText("REGISTER")).click();
    //Thread.sleep(1000);
    driver.findElement(By.linkText("SHOW ALL USERS")).click();
    Thread.sleep(1000);
    driver.get("http://localhost:2500/capstone");

    Thread.sleep(1000);

}

@Test
@Ignore
public void testEmail() {
driver.get(url+"/contact");
driver.findElement(By.name("name")).sendKeys("George Omollo");
driver.findElement(By.name("email")).sendKeys("xx@gmail.com");
driver.findElement(By.name("subject")).sendKeys("WebDriver Test Email");
driver.findElement(By.name("message")).sendKeys("This is a test email from Claim tutorials for Web Driver");
driver.findElement(By.id("contact-submit")).click(); 

}

public void hover(String link) {
Actions builder = new Actions(driver);
WebElement element = driver.findElement(By.linkText(link));
builder.moveToElement(element).build().perform();
}


@AfterClass
public static void closeBrowser() {
driver.quit();
}



}