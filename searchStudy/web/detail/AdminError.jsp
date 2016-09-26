<%@ page language="java" contentType="text/html; charset=EUC-KR"
  pageEncoding="UTF-8"%>
    <%  //자바 일반 로직 소스 작성 구역을 의미함 : 스크립트릿(scriptlet) 태그
	String code = (String)request.getAttribute("code");
	//int noticeNo = (Integer)request.getAttribute("noticeNo");
%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>에러 페이지</h1>

<%
	String message = null;
	switch(code){
	case "AInsert": message = "새 공지글 등록이 실패하였습니다."; break;

	default: message = "공지서비스에서 에러가 발생하였습니다."; break;
	}
%>

</body>
</html>