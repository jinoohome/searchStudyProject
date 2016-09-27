<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="detail.model.vo.Store,detail.model.vo.Image, java.util.* , member.model.vo.*"%>
<%
	Store s=(Store)request.getAttribute("store");
	Image i=(Image)request.getAttribute("image"); 
	Member member = (Member)session.getAttribute("member");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="js/jquery-3.1.0.min.js"> </script>
<script type="text/javascript" src="js/navigation.js"> </script>
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script> <!--dialog -->
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyA29xkBAMN_bvriR7uE8dSqVFFwjKXZjcw"></script>
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"></script>
<script src="//code.jquery.com/jquery-1.10.2.js"></script>

<link rel="stylesheet" href="/easyStudy/css/main.css" type="text/css"/>
<link rel="stylesheet"	href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">
<link rel="stylesheet"  href="/easyStudy/css/detail.css" type="text/css"/>

<title>DetailView</title>
<!-- GoogoleMap Asynchronously Loading the API ********************************************* -->
<script type="text/javascript">
    function initialize() {
        var mapOptions = {
                            zoom: 18, // 지도를 띄웠을 때의 줌 크기
                            mapTypeId: google.maps.MapTypeId.ROADMAP
                        };
         
        var map = new google.maps.Map(document.getElementById("map-canvas"), // div의 id과 값이 같아야 함. "map-canvas"
                                    mapOptions);
         
        var size_x = 40; // 마커로 사용할 이미지의 가로 크기
        var size_y = 40; // 마커로 사용할 이미지의 세로 크기
     
        // 마커로 사용할 이미지 주소
        var image = new google.maps.MarkerImage( '<%= s.getAddress() %>',
                                                    new google.maps.Size(size_x, size_y),
                                                    '',
                                                    '',
                                                    new google.maps.Size(size_x, size_y));
         
        // Geocoding *****************************************************
        var address = '<%= s.getAddress() %>'; // DB에서 주소 가져와서 검색하거나 왼쪽과 같이 주소를 바로 코딩.
        var marker = null;
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode( { 'address': address}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                marker = new google.maps.Marker({
                                map: map,
                                icon: image, // 마커로 사용할 이미지(변수)
                                title: '<%= s.getStoreName() %>', // 마커에 마우스 포인트를 갖다댔을 때 뜨는 타이틀
                                position: results[0].geometry.location
                            });
              
                // 마커를 클릭했을 때의 이벤트. 말풍선 뿅~
/*                  var infowindow = new google.maps.InfoWindow({ content: content});
                google.maps.event.addListener(marker, "click", function() {infowindow.open(map,marker);});  */
            } else {
                alert("Geocode was not successful for the following reason: " + status);
            }
        });
        // Geocoding // *****************************************************
         
    }
    google.maps.event.addDomListener(window, 'load', initialize);
</script>

<script>
$(function(){
	
	var x = document.getElementsByClassName("mySlides");
		
	x[0].style.display = "block";

});

	var slideIndex = 1;
	showDivs(slideIndex);

	function plusDivs(n) {
		showDivs(slideIndex += n);
	}

	
	function showDivs(n) {
		var i;
		var x = document.getElementsByClassName("mySlides");
		
		
		if (n > x.length) {
			slideIndex = 1
		}
		if (n < 1) {
			slideIndex = x.length
		}
		for (i = 0; i < x.length; i++) {
			x[i].style.display = "none";
		}
		x[slideIndex - 1].style.display = "block";
	}
	
/* 	function showTabMenu(n){
		var conId;

		for(i=1;i < 5; i++){
		conId = doc
		ument.getElementById("con"+i);	
		if(i==n){
		conId.style.display = "";
		}else{
		conId.style.display = "none";
		}
		}
		} */
</script>
<script>
$( document ).ready(function() {
	/*WebStorge 최근 저장된 로그인정보 가져오기 */
	if(!window.localStorage) { 
		alert('이 Browser 는 Local Storage 를 지원하지 않습니다.'); 
	}else { 
			var key = localStorage.key(0); 
			var value = localStorage[key];
			$('#main_loginUserId').val(key);
			$('#main_loginUserPwd').val(value);
	};
	/* localStorage.clear(); */
	
	/*로그인 패스워드 확인여부*/
	$("#main_loginBtn").click(function(){
			alert("");
		if ($("#main_login_chk").is(":checked")) {
			$.fnWebStorge();
		}
		var str = $("#loginForm").serialize();
		$.ajax({
			type:'POST',
			url:"/easyStudy/pwCheck",
			data: str,
			success: function(data) {
				if(data.result==0){
					$("#main_loginPwCheckArea").css('display','block');
					$("#main_loginPwCheckArea").css('background','#ffeeee');
					$("#main_loginPwCheckLabel").css('color','red');
					$("#main_loginPwCheckLabel").html("이메일 또는 비밀번호를 다시 확인해주세요");
				}else{
					$("#main_loginPwCheckArea").css('display','none');
					$("#loginForm").submit();
				}			
			},
			error: function(data) {
				alert("에러");
			}			
		});
	});

	/*회원가입 아이디 존재여부확인*/
	var joinIdCheck = false;
	$("#main_joinUserId").blur(function(){
		if($("#main_joinUserId").val().length != 0){
			var str = $("#joinForm").serialize();
			$.ajax({
				type:'POST',
				url:"/easyStudy/idCheck",
				data: str,
				success: function(data) {
					var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
					if (re.test($("#main_joinUserId").val())) {
						if(data.result>0){
							$("#main_joinIdCheckArea").css('display','block');
							$("#main_joinIdCheckArea").css('background','#ffeeee');
							$("#main_joinIdCheckLabel").css('color','red');
							$("#main_joinIdCheckLabel").html("이미 존재하는 이메일 입니다");
						}else{
							$("#main_joinIdCheckArea").css('display','block');
							$("#main_joinIdCheckArea").css('background','#def7de');
							$("#main_joinIdCheckLabel").css('color','green');
							$("#main_joinIdCheckLabel").html("사용가능한 이메일입니다");
							joinIdCheck = true;
						}	
					 
				   return false;
				 }else{
					 $("#main_joinIdCheckArea").css('display','block');
						$("#main_joinIdCheckArea").css('background','#ffeeee');
						$("#main_joinIdCheckLabel").css('color','red');
						$("#main_joinIdCheckLabel").html("올바른 이메일 형식이 아닙니다.");
				 }
				
				},
				error: function(data) {
					alert("에러");
				}			
			});
		}
		
	});
	
	/*회원가입 비밀번호 사용가능여부확인*/
	var joinPwdCheck= false;
	$("#main_joinUserPwd").blur(function(){
		var joinPassword = $("#main_joinUserPwd").val();
		if(joinPassword.length !=0){
			if(joinPassword.length > 0 && joinPassword.length < 8){
				$("#main_joinPwCheckArea").css('display','block');
				$("#main_joinPwCheckArea").css('background','#ffeeee');
				$("#main_joinPwCheckLabel").css('color','red');
				$("#main_joinPwCheckLabel").html("비밀번호는 8글자이상 입력하시기 바랍니다");
			}else{
				$("#main_joinPwCheckArea").css('display','block');
				$("#main_joinPwCheckArea").css('background','#def7de');
				$("#main_joinPwCheckLabel").css('color','green');
				$("#main_joinPwCheckLabel").html("사용가능한 비밀번호 입니다");
				joinPwdCheck = true;
			}
		}
	});
	
	
	/*회원가입 비밀번호 동일여부확인*/
	var joinPwdChkCheck = false;
	$("#main_joinUserPwdChk").blur(function(){
		var joinPassword = $("#main_joinUserPwd").val();
		var joinPasswordChk = $("#main_joinUserPwdChk").val();
		if(joinPasswordChk.length !=0){
			if(joinPassword != joinPasswordChk ){
				$("#main_joinPwCheckChkArea").css('display','block');
				$("#main_joinPwCheckChkArea").css('background','#ffeeee');
				$("#main_joinPwCheckChkLabel").css('color','red');
				$("#main_joinPwCheckChkLabel").html("비밀번호가 동일하지 않습니다");
			}else{
				$("#main_joinPwCheckChkArea").css('display','block');
				$("#main_joinPwCheckChkArea").css('background','#def7de');
				$("#main_joinPwCheckChkLabel").css('color','green');
				$("#main_joinPwCheckChkLabel").html("비밀번호가 동일합니다");
				joinPwdChkCheck = true;
			}
		}
	});
	
	/*회원가입 nickname 동일여부확인*/
	var joinNicknameCheck= false;
	$("#main_joinUserNickName").blur(function(){
		if($("#main_joinUserNickName").val().length != 0){
			var str = $("#joinForm").serialize();
			$.ajax({
				type:'POST',
				url:"/easyStudy/nickNameCheck",
				data: str,
				success: function(data) {
					if(data.result>0){
						$("#main_joinNickCheckArea").css('display','block');
						$("#main_joinNickCheckArea").css('background','#ffeeee');
						$("#main_joinNickCheckLabel").css('color','red');
						$("#main_joinNickCheckLabel").html("이미 존재하는 nickname 입니다");
					}else{
						$("#main_joinNickCheckArea").css('display','block');
						$("#main_joinNickCheckArea").css('background','#def7de');
						$("#main_joinNickCheckLabel").css('color','green');
						$("#main_joinNickCheckLabel").html("사용가능한 nickname");
						joinNicknameCheck =true;
					}	
				},
				error: function(data) {
					alert("에러");
				}			
			});
		}
	});
	/*회원가입 가능 여부 확인*/
	$("#main_joinBtn").click(function(){
		if(joinIdCheck == true && joinPwdCheck == true && 
				joinPwdChkCheck == true && joinNicknameCheck == true){
			$("#joinForm").submit();
		}
			
	});
	
	/*비밀번호 찾기 아이디 존재여부확인*/
	$("#main_sendEamilBtn").click(function(){
		if($("#main_pwSearchUser").val().length != 0){
			var str = $("#pwSearchForm").serialize();
			$.ajax({
				type:'POST',
				url:"/easyStudy/idCheck",
				data: str,
				success: function(data) {
					if(data.result>0){
						$("#main_pwSearchCheckArea").css('display','none');
						$("#pwSearchForm" ).submit();
					}else{
						$("#main_pwSearchCheckArea").css('display','block');
						$("#main_pwSearchCheckArea").css('background','#ffeeee');
						$("#main_pwSearchCheckLabel").css('color','red');
						$("#main_pwSearchCheckLabel").html("존재하지 않은 이메일 입니다. 다시 확인해주세요");
					}	
				},
				error: function(data) {
					alert("에러");
				}			
			});
		}
		
	});
	

		/*********팝업창 관련 jQeury**********/
		// 로그인 버튼 클릭시
		$(".main_loginPopupBtn").leanModal({
			top : 100,
			overlay : 0.6,
			closeButton : ".modal_close"
		});
		$(".main_loginPopupBtn").click(function() {
			$("#main_login").show();
			$("#main_join").hide();
			$("#main_pwSearch").hide();

			return false;
		});

		// 회원가입 버튼 클릭시
		$(".main_joinPopupBtn").leanModal({
			top : 100,
			overlay : 0.6,
			closeButton : ".modal_close"
		});

		$(".main_joinPopupBtn").click(function() {
			$("#main_join").show();
			$("#main_login").hide();
			$("#main_pwSearch").hide();

			return false;
		});
		
		// 비밀번호찾기 버튼 클릭시
		$(".main_pwSearchBtn").leanModal({
			top : 100,
			overlay : 0.6,
			closeButton : ".modal_close"
		});

		$(".main_pwSearchBtn").click(function() {
			$("#main_pwSearch").show();
			$("#main_login").hide();
			$("#main_join").hide();

			return false;
		});
		
		/* 주변 화면으로 팝업 종료 */
		$("#lean_overlay").click(function(){
			$("#main_loginWrap input[type=text]").val("");
			$("#main_loginWrap input[type=email]").val("");
			$("#main_loginWrap input[type=password]").val("");
			$("#main_loginWrap input[type=checkbox]").prop('checked', false);
			$(".main_labelRow").css("display","none");
		});
		
	});
</script>
<script>
  $(function() {
    $("#tabs").tabs();
  });
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
						<a id="nav_logo" href=""><img class="logo"
							src="images/logo.png"></a>

						<!-- area search section -->
						<div id="nav_area" class="search sel">
							<div class="input">
								<div class="selected">지역 선택</div>
							</div>
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
				</div>
			</div>
		</div>

		<!-- 상세페이지 내용  -->
		<div id="container">
			<!--배너 슬라이더 이미지 banner_warp-->
			<div id="banner_warp">
				<div id="banner">
					<div class="detail_imageArea">
						<img src="/easyStudy/images/<%=i.getPhoto1()%>" id="detail_titleImage">
					</div>
				</div>
			</div>
			<div class="nav">
				<i class="icon left"></i> <i class="icon right"></i>
			</div>

			<div id="tabs">
				<div id="content_wrap">
					<div id="content" class="detail info">
					<div id="detail_title"><%=s.getStoreName() %></div>
					<div><%=s.getLocalName() %> / <%=s.getCategoryName() %></div>
						<ul class="tab">
							<li class="item selected"><a href="#tabs-1">정보</a></li>
							<li class="item"><a href="#tabs-2">포토</a></li>
							<li class="item"><a href="#tabs-3">리뷰</a></li>
						</ul>
						
						<!-- 정보 탭 관련 정보  -->
						<div id="tabs-1">
							<form action="DView" method="post">
							
							
								<table border="1" width="1000" id="detail_table" style="">
									<tr>
										<th>이 름 </th>
										<td><%=s.getStoreName() %></td>
									</tr>
									<tr>
										<th> </th>
										<td></td>
									</tr>
									
									<tr>
										<th>주 소</th>
										<td><%=s.getAddress() %></td>
									</tr>
									<tr>
										<th>사 이 트</th>
										<td><%=s.getHomepage() %></td>
									</tr>
									<tr>
										<th>평일 영업 :</th>
										<td><%=s.getWeekDayTime() %></td>
									</tr>
									<th>주말 영업 :</th>
									<td><%=s.getWeekEndTime() %></td>
									</tr>
									<tr>
										<th>가 격 :</th>
										<td><%=s.getPrice() %></td>
									</tr>
									<tr>
										<th>전화번호 :</th>
										<td><%=s.getTell() %></td>
									</tr>
									<tr>
										<th>비 고 :</th>
										<td><%=s.getEtc() %></td>
									</tr>
									<tr>
										<th colspan="2"></th>
									</tr>
								</table>
							</form>
						</div>
						<form action="DMap" method="post">
							<div id="map-canvas" style="width: 100%; height: 340px"></div>
							<br>
							<%
								//String Admin = "Admin";
								Member loginUser = (Member)session.getAttribute("member");
								/* if(loginUser.getUserId().equals("Admin")){ */
								//로그인한 사용자와 공지글 작성자 아이디가 같을 경우
							%>
							<a href="/easyStudy/StoreUpdateView?storeId=<%= s.getStoreId() %>">
							<input type="button" value="수정하기"></a> &nbsp; &nbsp; 
							<a href="/easyStudy/StoreDelete?storeId=<%= s.getStoreId() %>">
							<input type="button" value="삭제하기"></a> &nbsp; &nbsp;
							<%/*  }  */%>
							<a href="/easyStudy/index.jsp"><input type="button" value="시작페이지로 가기"></a>
						</form>

						<div id="tabs-2">
							<form action="DPhoto" method="post">
								<div class="body first last">
									<div class="section">
										<div class="slider PoingSlider_wrap">
											<div style="width: 850px; height: 420px;">
												<img class="mySlides" src="" style="width: 100%"> <img
													class="mySlides" src="<%-- <%=i.getPhoto2() %> --%>"
													style="width: 100%"> <img class="mySlides"
													src="<%-- <%=i.getPhoto3() %> --%>" style="width: 100%">
												<img class="mySlides" src="<%-- <%=i.getPhoto4() %> --%>"
													style="width: 100%"> <img class="mySlides"
													src="<%-- <%=i.getPhoto5() %> --%>" style="width: 100%">
											</div>
											<div class="right shadow"></div>
											<div class="left shadow"></div>
											<div class="nav">
												<img class="left" alt="icon" src="../images/left.jpg"
													onclick="plusDivs(-1)" /> <img class="right" alt="icon"
													src="../images/right.jpg" onclick="plusDivs(1)" />
											</div>
										</div>
									</div>
								</div>
							</form>
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>