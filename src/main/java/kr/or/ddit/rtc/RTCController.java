package kr.or.ddit.rtc;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/rtcStart")
public class RTCController {
	@RequestMapping(method=RequestMethod.GET)
	public String rtcStart(){
		
		return "/rtcTest/rtcTest";
	}
	
	
}



