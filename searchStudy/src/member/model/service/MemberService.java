package member.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import member.model.dao.MemberDao;
import member.model.vo.Member;

public class MemberService {

	public MemberService() {
	}

	public Member loginCheck(String userId, String userPwd) {
		Connection con = getConnection();
		Member member = new MemberDao().loginCheck(con, userId, userPwd);
		close(con);
		return member;
	}

	public int memberInsert(Member member) {
		Connection con = getConnection();
		int result = new MemberDao().memberInsert(con, member);
		close(con);
		return result;
	}

	public int idCheck(String userId) {
		Connection con = getConnection();
		int result = new MemberDao().idCheck(con, userId);
		close(con);
		return result;
	}

	public int pwCheck(String userId, String userPwd) {
		Connection con = getConnection();
		int result = new MemberDao().pwCheck(con, userId, userPwd);
		close(con);
		return result;
	}

	public int nickNameCheck(String userName) {
		Connection con = getConnection();
		int result = new MemberDao().nickNameCheck(con, userName);
		close(con);
		return result;
	}

	public Member selectRow(String userId) {
		Connection con = getConnection();
		Member member = new MemberDao().selectRow(con, userId);
		close(con);
		return member;
	}
	
	public int sendEmail(Member member) {
		int result = 0;
		Properties p = new Properties();
		p.put("mail.smtp.user", "jinoohom@gmail.com"); // Google계정@gmail.com으로 설정
		p.put("mail.smtp.host", "smtp.gmail.com");
		p.put("mail.smtp.port", "465");
		p.put("mail.smtp.starttls.enable","true");
		p.put("mail.smtp.auth", "true");
		p.put("mail.smtp.debug", "true");
		p.put("mail.smtp.socketFactory.port", "465"); 
		p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory"); 
		p.put("mail.smtp.socketFactory.fallback", "false");
		
		//Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
		
		try {
			Authenticator auth = new SMTPAuthenticator();
			Session session = Session.getInstance(p, auth);
			session.setDebug(true); // 메일을 전송할 때 상세한 상황을 콘솔에 출력한다.
			
			//session = Session.getDefaultInstance(p);
			MimeMessage msg = new MimeMessage(session);
			String message = member.getUserId()+"님의 고객의 비밀번호는 " + member.getUserPwd() + "입니다." ;
			msg.setSubject("비밀번호 확인 메일");
			Address fromAddr = new InternetAddress("jinoohom@gmail.com"); // 보내는 사람의 메일주소
			msg.setFrom(fromAddr);
			Address toAddr = new InternetAddress(member.getUserId()); // 받는 사람의 메일주소
			msg.addRecipient(Message.RecipientType.TO, toAddr); 
			msg.setContent(message, "text/plain;charset=UTF-8");
			System.out.println("Message: " + msg.getContent());
			Transport.send(msg);
			System.out.println("Gmail SMTP서버를 이용한 메일보내기 성공");
			result = 1;
		}
		catch (Exception mex) { 
			System.out.println("오류발생");
			mex.printStackTrace();
		} 
		return result;
	}

}

class SMTPAuthenticator extends javax.mail.Authenticator {

	public PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("jinoohom", "zxjyjtwexefbshuc");// Google id,
																	// pwd, 주의)
																	// @gmail.com
																	// 은 제외하세요
	}
}
