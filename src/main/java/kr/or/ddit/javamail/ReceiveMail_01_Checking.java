package kr.or.ddit.javamail;

import java.util.Date;
import java.util.Properties;

import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Store;
import javax.mail.internet.InternetAddress;

/**
 * 메일 checking 은 특정 폴더의 메시지 헤더들만 읽어오는 과정을 의미하며, 송/수신자나 메일 제목등의 정보는 읽어오지만,
 * 내용(content)는 읽지 않는다. * 1) Session 객체의 생성 2) pop3/imap Store 객체를 생성하고 연결 3)
 * 메일함에 포함된 특정 folder 객체 생성 후 개방 4) 메시지 접근 5) Store와 folder객체 종료
 */
public class ReceiveMail_01_Checking {
	public static void main(String[] args) {
		String username = "jaeeuntest@gmail.com";
		String password = "test1234!@";
		String host = "imap.gmail.com";
		int port = 993;
		Properties props = new Properties();
		props.put("mail.imaps.host", host);
		props.put("mail.imaps.port", port);
		props.put("mail.imaps.starttls.enable", true); // 1)세션 객체 생성
		Session session = Session.getDefaultInstance(props);
		try {
// 2) 프로토콜에 해당하는 Store 객체 생성 및 연결 
			Store store = session.getStore("imaps");
			store.connect(host, username, password); // 3) 메시지 폴더 객체 생성
			Folder folder = store.getFolder("INBOX");
// 읽기 전용으로 폴더 개방
			folder.open(Folder.READ_ONLY);
// 4) 메시지 접근, 최근 메시지 순으로 확인하기 위해 전체 메시지 건수 조회 
			int totalCount = folder.getMessageCount();
// 전체 메시지 건수를 기준으로 페이징
			Message[] messages = folder.getMessages(totalCount - 9, totalCount);
			String format = "%s\t%s\t%s\t%s\n";
			System.out.printf(format, "메일번호", "날짜", "제목", "발신자");
			for (Message msg : messages) {
				System.out.println("============================================");
				int num = msg.getMessageNumber();
				Date sentDate = msg.getSentDate();
				String subject = msg.getSubject();
// RFC822 규약에 따른 발신자 정보 파싱
				String from = ((InternetAddress) msg.getFrom()[0]).toUnicodeString();
				System.out.printf(format, num + "", sentDate, subject, from);
			}
// 5) folder 폐쇄전 수정가능 모드에서 삭제된 메시지가 있다면 삭제 반영여부를 결정
			folder.close(false);
			store.close();
		} catch (Exception e) {

			e.printStackTrace();

		}
	}
}