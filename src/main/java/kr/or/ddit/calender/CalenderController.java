package kr.or.ddit.calender;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.vo.CalenderVO;

@Controller
@RequestMapping("/calender") 
public class CalenderController {
	
	@RequestMapping(method=RequestMethod.GET) 
	public String calenderstart(){ 
		
		return "/calender/calender";
	}
	
	//VO에 일정을 담아 json 형식의  List 형태로반환한다.
	@RequestMapping(method=RequestMethod.GET, produces="application/json;charset=UTF-8")
	@ResponseBody
	public List<CalenderVO> getCalender(){
		CalenderVO calender = new CalenderVO(); 
		calender.setTitle("테스트 일정1");
		calender.setStart("2019-05-02");
		calender.setEnd("2019-05-07");
		List<CalenderVO> cList = new ArrayList<>();
		cList.add(calender);
		CalenderVO calender2 = new CalenderVO(); 
		calender2.setTitle("테스트 일정2");
		calender2.setStart("2019-05-03");
		calender2.setEnd("2019-05-04");
		cList.add(calender2);
		CalenderVO calender3 = new CalenderVO(); 
		calender3.setTitle("테스트 일정3");
		calender3.setStart("2019-05-02");
		calender3.setEnd("2019-05-08");
		cList.add(calender3);
		CalenderVO calender4 = new CalenderVO(); 
		calender4.setTitle("테스트 일정4");
		calender4.setStart("2019-05-02");
		calender4.setEnd("2019-05-08");
		cList.add(calender4);
		CalenderVO calender5 = new CalenderVO(); 
		calender5.setTitle("테스트 일정5");
		calender5.setStart("2019-05-02");
		calender5.setEnd("2019-05-08");
		cList.add(calender5);
		return cList;
	}

}
