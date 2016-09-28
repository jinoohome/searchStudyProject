<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member"%>
<%
	Member member = (Member) session.getAttribute("member");
	String code = (String)request.getAttribute("code");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/main.css"/>
<link rel="stylesheet" type="text/css" href="/easyStudy/css/layout.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/function.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/review.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/star.css">
 <script type="text/javascript" src="js/jquery-3.1.0.min.js"> </script>
 <script type="text/javascript" src="js/navigation.js"> </script>
 <script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
	
</script>
<title>main</title>
<script>
	
</script>

</head>
<body>
<div id="wrap">
	<div id="header">
		<div id="nav_warp_shading"></div>
		<div id="nav_wrap" class="fixed">
	<div class="container_wrap">
	<form action="/easyStudy/search.store" method="get">
		<div id="nav_container" class="">
			<div id="nav_shading" class="shading_bg" style="display: none;"></div>
				<!-- logo section -->
			<a id="nav_logo" href="index.jsp"><img class="logo" src="images/logo.png"></a>

			<!-- area search section -->
			<%if(member != null){ %>
			<input type="hidden" name="userid" value="<%=member.getUserId() %>" >
			<%} %>
			<div id="nav_area" class="search sel">
				<div class="input">
					<div class="selected">지역 선택 </div>
					<img src="images/down_arrow.png" class="searchbox arrow">
				</div>
				<div class="box" id="box1">
					<ul class="district content">
						<li>
						<input type="checkbox" name="area" id="GN" value="GN">
						<label for="GN">강남</label>
    					</li>
						<li><input type="checkbox" name="area" id="JL" value="JL">
							<label for="JL">종로</label></li>
						<li><input type="checkbox" name="area" id="SC" value="SC">
							<label for="SC">신촌</label></li>
					</ul>
					<!--<button type="button" id="off" class="confirm red_fill border_radius soft">확인</button>-->
					<button class="confirm red_fill border_radius soft" type="button">확인</button>
				</div>
			</div>
				<!-- genre search section -->
			<div id="nav_genre" class="search sel">
				<div class="input">
					<div class="selected">카테고리 선택</div>
					<img src="images/down_arrow.png" class="searchbox arrow">
				</div>
				<div class="box" id="box2">
					<ul class="search_category content">
						<li>
						<input type="checkbox" name="category" id="S10" value="S10">
						<label for="S10">도서관/독서실</label>
    					</li>
						<li><input type="checkbox" name="category" id="S20" value="S20">
						<label for="S20">스터디룸</label></li>
						<li><input type="checkbox" name="category" id="S30" value="S30">
						<label for="S30">스터디카페</label></li>
						<!--  <li><input type="checkbox" name="category" id="S40" value="S40">
						<label for="S40">스터디룸/스터디카페</label></li>-->
					</ul>
					<button class="confirm red_fill border_radius soft" type="button">확인</button>
				</div>
					
			</div>
			<button type="submit" id="nav_btn" class="search">검색</button>
			
				<!-- account section -->
				<div id="nav_account">
						<div id="nav_guest">
						<%if(member !=null){ %>
							<span id="nav_login" ><a class="main_loginPopupBtn" href="/easyStudy/logout">로그아웃</a></span>
						<%}else{ %>
							<span id="nav_login" ><a class="main_loginPopupBtn" href="#main_loginModal">로그인</a></span>
							&nbsp;|&nbsp;
						<%} %>	
							<span id="nav_join"><a class="main_joinPopupBtn" href="#main_joinModal">회원가입</a></span>
						</div>
				</div>
		</div>
		</form>
		
	</div>
		<div class="menu_wrap">
			<div id="nav_menu">
			<!-- 	 <a href="#" class="underline ">메뉴</a>
				<a href="#" class="underline ">메뉴</a>
				<a href="#" class="underline ">메뉴</a>
				<a href="#" class="underline ">메뉴<i class="text new"></i></a> -->	
			
				<% if(member != null){
					if("admin".equals(member.getUserId())) { %>	
						<%=member.getNickName() %>님  &nbsp; &nbsp; &nbsp;
						<a href="/easyStudy/mmanagement?page=1">회원 관리</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<a href="#">글쓰기</a>		
					<%}else{ %>		
						<%=member.getNickName() %>님  &nbsp; &nbsp; &nbsp;
						<a href="/easyStudy/mbookmark?userid=<%=member.getUserId() %>">즐겨찾기</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<a href="/easyStudy/mreview?page=1&nickname=<%=member.getNickName() %>">내가 쓴 리뷰</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<a href="/easyStudy/mypage/myinfo.jsp">내 정보 변경</a> 		
					<%}
				}else{} %>
			
			</div>
		</div>
	</div>
	</div>
	<!--<div class="menu_wrap">
			<div id="nav_menu">
			</div>
	</div>-->
		<div id="container">
			<div id="mypages">
		<div id="message">
				<h1>회원 관련 서비스 에러 페이지</h1>
	<%
		String message = null;
	
		switch(code){
		case "mdel" : message = "회원 탈퇴 서비스가 실패하였습니다."; break;
		case "usersManagement": message = "유저 조회 서비스가 실패하였습니다.."; break;
		case "searchEnroll_date": message = "가입날짜 검색 서비스가 실패하였습니다."; break;
		case "searchnickname": message = "닉네임 검색 서비스가 실패하였습니다.";
					break;
		case "searchuserid": message = "유저 아이디 검색 서비스가 실패하였습니다.";
					break;
		case "myinfo": message = "비밀번호 변경 서비스가 실패하였습니다."; break;
		default: message = "알 수 없는 에러가 발생하였습니다."; break;
		}
	%>
	에러 : <%= message %> <br>
	<a href="/easyStudy/main.jsp">시작페이지로 이동</a>
		</div>

		</div>
	</div>



</body>
</html>