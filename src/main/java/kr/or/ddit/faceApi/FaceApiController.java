package kr.or.ddit.faceApi;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/faceApi")
public class FaceApiController {
	
	@RequestMapping(method=RequestMethod.GET)
	public String faceApiStart(){
		
		return "/webcam/webcam2";
		
	}
}
