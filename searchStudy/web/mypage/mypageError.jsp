<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String code = (String)request.getAttribute("code");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/main.css" />
<link rel="stylesheet" type="text/css" href="/easyStudy/css/layout.css" >
<script type="text/javascript" src="js/jquery-3.1.0.min.js">
	
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
					<div id="nav_container" class="">
						<div id="nav_shading" class="shading_bg" style="display: none;"></div>
						<!-- logo section -->
						<a id="nav_logo" href="/easyStudy/main.jsp"><img class="logo"
							src="/easyStudy/images/logo.png"></a>

						<!--<div id="nav_city">
						<span>서울</span>
						<i class="icon"></i>	
				</div>  -->

						<!-- area search section -->
						<div id="nav_area" class="search sel">
							<div class="input">
								<div class="selected">지역 선택</div>
							</div>
							<!-- <div class="box">
						<ul class="district">
							<li data-dist="c1038633da6870c2a84a6b58a82283a6" class="selected">강남<span>&gt;</span></li>
							<li data-dist="1aac31587cc4cfffdaf450724a554aaa">종로<span>&gt;</span></li>
							<li data-dist="4431507c0830b8cd256dca4762f83c9c">신촌<span>&gt;</span></li>
						</ul>
						

						<button class="confirm red_fill border_radius soft" type="button" tabindex="-1">확인</button>
					</div>-->
						</div>
						<!-- genre search section -->
						<div id="nav_genre" class="search sel">
							<div class="input">
								<div class="selected">카테코리 선택</div>
							</div>

						</div>

						<button type="button" id="nav_btn" class="search" tabindex="-1">검색</button>

						<!-- account section -->
						<div id="nav_account">
							<div id="nav_guest">
								<span id="nav_login">로그인</span> &nbsp;|&nbsp; <span
									id="nav_join">회원가입</span>
							</div>
						</div>
					</div>
				</div>
				<div id="mymenu">
					<!--마이페이지 메뉴 -->
					<div id="mymenu_in">
						<%
							
						%>
						<a href="/easyStudy/mypage/myBookmark.jsp">즐겨찾기</a> &nbsp; &nbsp;
						&nbsp; &nbsp; &nbsp; &nbsp; <a
							href="/easyStudy/mypage/myReview.jsp">내가 쓴 리뷰</a> &nbsp; &nbsp;
						&nbsp; &nbsp; &nbsp; &nbsp; <a href="/easyStudy/mypage/myinfo.jsp">내
							정보 변경</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<%
							//관리자 모드
						%>
						<a href="/easyStudy/mmanagement">회원 관리</a> &nbsp;
						&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; <a href="#">글쓰기</a>
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