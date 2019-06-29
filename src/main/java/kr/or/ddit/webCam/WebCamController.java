package kr.or.ddit.webCam;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/webcam")
public class WebCamController {

	@RequestMapping(method=RequestMethod.GET)
	public String webCamstart(){
		
		return "/webcam/webcam2";
		
	}
}
