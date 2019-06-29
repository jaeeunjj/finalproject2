package kr.or.ddit.mail;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MailController {
	
	//실행시 contextpaht를 (/)로 변경
	@RequestMapping("/")
	public String mailStart(){
		
		return "mail/mail";
	}
}
