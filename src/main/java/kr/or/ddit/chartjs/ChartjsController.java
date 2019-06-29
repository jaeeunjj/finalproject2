package kr.or.ddit.chartjs;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/chartjs")
public class ChartjsController {
	
	@RequestMapping(method=RequestMethod.GET)
	public String chartjsStart(){
		
		return "/chartjs/chart";
	}
}
