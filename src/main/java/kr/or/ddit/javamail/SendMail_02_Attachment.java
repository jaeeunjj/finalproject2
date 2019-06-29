package kr.or.ddit.javamail;

import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.activation.URLDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Message.RecipientType;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class SendMail_02_Attachment {
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
      
      Session session = Session.getDefaultInstance(props, new Authenticator() {
         @Override
         protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(username, password);
         }
      });
      // session 객체 생성 단계는 앞 예제와 동일함.
      try {
         // 2) MimeMessage 생성 및 기본 정보 설정
         Message message = new MimeMessage(session);
         message.setFrom(new InternetAddress(from));
         message.setRecipients(RecipientType.TO, InternetAddress.parse(to));
         message.setSubject("첨부 메일 전송 테스트");
         // 3) Multipart를 구성할 BodyPart 객체로 실제 내용을 작성
         BodyPart textBodyPart = new MimeBodyPart();
         textBodyPart.setText("첨부파일 메시지 전송 테스트의 내용");
         // 4) Multipart 객체를 생성하고, BodyPart를 실제 파트 요소로 설정
         Multipart multipart = new MimeMultipart();
         multipart.addBodyPart(textBodyPart);
         // 5) 첨부파일이 있는 경우, 해당 파일에 대해 BodyPart 객체 생성
         BodyPart fileBodyPart = new MimeBodyPart();
         String filePath = "D:\\DHRDF\\akdhkd.jpg";
         // 파일을 읽어들이기 위한 DataSource 객체
         // 생성(FileDataSource/URLDataSource)
         DataSource dataSource = new FileDataSource(filePath);
         // DataSource로 부터 전송 데이터를 조작하기 위한 DataHandler 객체 설정
         DataHandler handler = new DataHandler(dataSource);
         fileBodyPart.setDataHandler(handler);
         // BodyPart 의 filename 헤더의 값 설정
         fileBodyPart.setFileName(handler.getName());
         // multipart 객체에 BodyPart 추가
         multipart.addBodyPart(fileBodyPart);
         // 6) 메시지 Content 설정
         message.setContent(multipart);
         // 7) 메시지 전송
         Transport.send(message);
         System.out.println("전송 완료");
      } catch (MessagingException e) {
         e.printStackTrace();
      }
   }
}