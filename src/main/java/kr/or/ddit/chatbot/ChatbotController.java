package kr.or.ddit.chatbot;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/chatbot")
public class ChatbotController {

	@RequestMapping(method=RequestMethod.GET)
	public String chatbotStart(){
		
		return "/chatbot/chatbot2";
	}
	
	
}
