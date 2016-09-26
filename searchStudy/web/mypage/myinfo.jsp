<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member"%>
<%
	Member member = (Member) session.getAttribute("member");
	System.out.println(member);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/easyStudy/css/main.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/layout.css" >


<script type="text/javascript">
	$(document).ready(function() {
		//비밀번호 확인
		var exPwdChkCheck = false;
		$("#mypage_loginUserPwd").blur(function() {
			var loginPassword = "<%=member.getUserPwd()%>";
			var loginPasswordChk = $("#mypage_loginUserPwd").val();			
			console.log(loginPassword + ", " + loginPasswordChk);
			if (loginPasswordChk.length != 0) {
				console.log("asdfeeeee");
				if (loginPassword != loginPasswordChk) {
					console.log("adsf");
					$("#mypage_loginPwCheckArea").css('display', 'block');
					$("#mypage_loginPwCheckArea").css('background', '#ffeeee');
					$("#mypage_loginPwCheckLabel").css('color', 'red');
					$("#mypage_loginPwCheckLabel").html("비밀번호가 동일하지 않습니다");
				} else if(loginPassword == loginPasswordChk){
					console.log("assssss");
					$("#mypage_loginPwCheckArea").css('display', 'block');
					$("#mypage_loginPwCheckArea").css('background', '#def7de');
					$("#mypage_loginPwCheckLabel").css('color', 'green');
					$("#mypage_loginPwCheckLabel").html("비밀번호가 동일합니다");
					exPwdChkCheck = true;
				}
			}
		});
		
		//비밀번호 조건
		var myPwdCheck= false;
		$("#mypage_infoUserPwd").blur(function(){
			var myPassword = $("#mypage_infoUserPwd").val();
			if(myPassword.length !=0){
				if(myPassword.length > 0 && myPassword.length < 8){
					$("#mypage_infoPwCheckArea").css('display','block');
					$("#mypage_infoPwCheckArea").css('background','#ffeeee');
					$("#mypage_infoPwCheckLabel").css('color','red');
					$("#mypage_infoPwCheckLabel").html("비밀번호는 8글자이상 입력하시기 바랍니다");
				}else{
					$("#mypage_infoPwCheckArea").css('display','block');
					$("#mypage_infoPwCheckArea").css('background','#def7de');
					$("#mypage_infoPwCheckLabel").css('color','green');
					$("#mypage_infoPwCheckLabel").html("사용가능한 비밀번호 입니다");
					myPwdCheck = true;
				}
			}
		});
		
		//비밀번호 재확인
		var myPwdChkCheck = false;
		$("#mypage_infoUserPwdChk").blur(function() {
			var myPassword = $("#mypage_infoUserPwd").val();
			var myPasswordChk = $("#mypage_infoUserPwdChk").val();
			if (myPasswordChk.length != 0) {
				if (myPassword != myPasswordChk) {
					$("#mypage_infoPwCheckChkArea").css('display', 'block');
					$("#mypage_infoPwCheckChkArea").css('background', '#ffeeee');
					$("#mypage_infoPwCheckChkLabel").css('color', 'red');
					$("#mypage_infoPwCheckChkLabel").html("비밀번호가 동일하지 않습니다");
				} else {
					$("#mypage_infoPwCheckChkArea").css('display', 'block');
					$("#mypage_infoPwCheckChkArea").css('background', '#def7de');
					$("#mypage_infoPwCheckChkLabel").css('color', 'green');
					$("#mypage_infoPwCheckChkLabel").html("비밀번호가 동일합니다");
					myPwdChkCheck = true;
				}
			}
		});

	});
	
	//submit 실행전 조건 확인
	function checkDelPwd() {
		if (mypage_modifypwd_form.mypage_loginUserPwd.value != "<%=member.getUserPwd() %>") {
			alert("비밀 번호가 일치하지 않습니다.");
			mypage_modifypwd_form.mypage_loginUserPwd.focus();
		} else if(mypage_modifypwd_form.mypage_infoUserPwd.value.length < 8){
			alert("새로운 비밀번호를 8글자 이상 입력해주세요.");
			mypage_modifypwd_form.mypage_infoUserPwd.focus();
		} else if(mypage_modifypwd_form.mypage_infoUserPwd.value != mypage_modifypwd_form.mypage_infoUserPwdChk.value){
			alert("새로운 비밀번호가 일치하지 않습니다.");
			mypage_modifypwd_form.mypage_infoUserPwdChk.focus();
		} else
			mypage_modifypwd_form.submit();
	}
	
	//탈퇴시 조건 확인
	function checkPWD() {
		if (mypage_modifypwd_form.mypage_loginUserPwd.value != "<%=member.getUserPwd() %>") {
			alert("비밀 번호가 일치하지 않습니다.");
			mypage_modifypwd_form.mypage_loginUserPwd.focus();
		} else{
			if(confirm("작성한 리뷰는 자동 삭제되지 않습니다. 정말 탈퇴하시겠습니까?")){
				location.href="/easyStudy/mdel?userid=<%=member.getUserId() %>,user";
			}else{
				return false;
			}
		}
	}
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
							//일반회원모드
						%>
						<a href="/easyStudy/mypage/myBookmark.jsp">즐겨찾기</a> &nbsp; &nbsp;
						&nbsp; &nbsp; &nbsp; &nbsp; <a
							href="/easyStudy/mypage/myReview.jsp">내가 쓴 리뷰</a> &nbsp; &nbsp;
						&nbsp; &nbsp; &nbsp; &nbsp; <a href="/easyStudy/mypage/myinfo.jsp">내
							정보 변경</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<%
							//관리자 모드
						%>
						<a href="/easyStudy/mmanagement">회원 관리</a> &nbsp; &nbsp; &nbsp;
						&nbsp; &nbsp; &nbsp; <a href="#">글쓰기</a>
					</div>
				</div>
			</div>
		</div>
		<div id="container">
			<div id="mypages">
				<div id="mypage_informodify_detail">
					보다 안전한 <apan class="mypage_sitename">search study</apan> 이용을 위해 <br>
					6개월마다 비밀번호 변경을 권장하고 있습니다. <br>
					<ul class="mypage_pwdGuide">
						<li>다른 사이트에서 사용한 적 없는 비밀번호나</li>
						<li>이전에 사용한 적 없는 비밀번호가 안전합니다.</li>
					</ul>
				</div>
				
				<div id="mypage_info_pwd">

						<form id="mypage_modifypwd_form" action="/easyStudy/myinfo" method="post" >
							<!-- 변경을 위한 userID -->
							<input type="text" style="display:none" name="userid" value="<%=member.getUserId() %>">
							
							<!-- 실제 보이는 부분 -->
							<div id="mypage_infoPwArea" >
								<input type="password" placeholder="기존 비밀번호" class="inputBox" id="mypage_loginUserPwd" required >
							</div>
							<div class="labelRow" id="mypage_loginPwCheckArea" style="display: none">
								<label class="loginCheck" id="mypage_loginPwCheckLabel">	</label>
							</div>


							<div id="mypage_infoPwArea" >
								<input type="password" placeholder="새로운 비밀번호" class="inputBox"  name="mypage_infoUserPwd" 	id="mypage_infoUserPwd">
							</div>
							<div class="labelRow" id="mypage_infoPwCheckArea" style="display: none">
								<label class="loginCheck" id="mypage_infoPwCheckLabel"></label>
							</div>


							<div id="mypage_infoPwcheckArea" >
								<input type="password" placeholder="새로운 비밀번호 확인" class="inputBox" id="mypage_infoUserPwdChk">
							</div>
							<div class="labelRow" id="mypage_infoPwCheckChkArea" style="display: none">
								<label class="oginCheck" id="mypage_infoPwCheckChkLabel">
								</label>
							</div>

							<div id="mypage_infoBtn">
								<input type="button" value="변경하기"  onclick="checkDelPwd()"> &nbsp; &nbsp; 
							
									<a href="#" onclick="checkPWD()"><input type="button" value="탈퇴하기" ></a>
							</div>
						</form>
				</div>
			</div>

		</div>
</body>
</html>