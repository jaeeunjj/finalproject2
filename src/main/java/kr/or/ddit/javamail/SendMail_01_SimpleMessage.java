package kr.or.ddit.javamail;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail_01_SimpleMessage {
public static void main(String[] args) {
String to = "gusdndajtwu@gmail.com";
String from = "jaeeuntest@gmail.com";
final String username = "jaeeuntest@gmail.com";
final String password = "test1234!@";
final String host = "smtp.gmail.com";
Properties props = new Properties();
props.put("mail.smtp.auth", true);
props.put("mail.smtp.host", host);
props.put("mail.smtp.port", 587);
props.put("mail.smtp.starttls.enable", true);
// 1) 인증 정보 제공후 Session 객체 획득
Session session = Session.getDefaultInstance(props, new Authenticator()
{
@Override
protected PasswordAuthentication getPasswordAuthentication() {
return new PasswordAuthentication(username, password);
}
});
try {
// 2) 메시지 송/수신설정 및 메시지 구성
Message message = new MimeMessage(session);
message.setFrom(new InternetAddress(from));
message.setRecipients(RecipientType.TO, InternetAddress.parse(to));
message.setSubject("메일 전송 테스트");
message.setText("간단한 메시지 전송 테스트 내용.");
// 3) 메시지 전송
Transport.send(message);
System.out.println("전송 완료");
} catch (MessagingException e) {
e.printStackTrace();
}
}
}