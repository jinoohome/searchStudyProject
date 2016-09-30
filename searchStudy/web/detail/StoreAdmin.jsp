<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="detail.model.vo.Store, java.util.* , member.model.vo.*"%>
<%
	Store s = (Store) request.getAttribute("store");
	Member member = (Member) session.getAttribute("member");
	/* Image i=(Image)request.getAttribute("image"); */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/layout.css" > 
<link rel="stylesheet" type="text/css" href="/easyStudy/css/detail.css" > 
<link rel="stylesheet" type="text/css" href="/easyStudy/css/review.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/main.css" >
<link rel="stylesheet" type="text/css" href="/easyStudy/css/function.css" >

<script src="//ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script src="//d1p7wdleee1q2z.cloudfront.net/post/search.min.js"></script>
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyA29xkBAMN_bvriR7uE8dSqVFFwjKXZjcw"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript" src="/easyStudy/js/navigation.js"> </script>
<script type="text/javascript" src="/easyStudy/js/review.js"></script>
<script type="text/javascript" src="/easyStudy/js/jquery.leanModal.min.js"></script> <!--dialog -->

<title>Admin</title>
<script>
$( document ).ready(function() {
	   $("button").attr("tabindex", "-1");
	   $("body").on("click", " button", function(e)
	   {
	      var type = $(this).data("type");

	      if(type != null)
	      {
	         $(this).blur();
	         $.proxy(eval(type), this)();
	      }
	   });
	   $("#banner").on("selectstart", function()
	         {
	             return false;
	         });
	$("#banner").on("selectstart", function()
	      {
	          return false;
	      });
	      function TriSlider(options) {
	          var slider = $(options.selector);
	          var pieces = slider.children(".pieces");
	          var max = pieces.data('max');
	          var fake_pieces = options.fake_pieces? options.fake_pieces:2;
	          var width = 850;
	          var start_point = -width * (fake_pieces-1);
	          var start_index = options.start_index? options.start_index:0;
	          var isSliding = false;

	          (function() {
	              pieces.data('index', start_index);
	              pieces.css('left', (-width*(start_index+1) + start_point)+'px');
	          
	              slider.find(".index>li").removeClass('current');
	              slider.find(".index>li[data-id="+start_index+"]").addClass('current');

	              pieces.show();
	          })();

	          var piece = slider.find(".piece"),
	              first   = piece.filter(':first'),
	              last    = piece.filter(':last');

	          // 슬라이더가 0개임
	          if(piece.length == 0) 
	              return false;

	          // 가짜 페이지들을 만들 때, 설정한 갯수가 진짜 페이지의 최대 갯수보다 많을 경우
	          var rest = fake_pieces % piece.length;
	          if(rest > 0) {
	              first.before( piece.slice(-1 * rest).clone(true) );
	              last.after( piece.slice(0, rest).clone(true) );
	          }

	          for(var i=0, len = Math.floor(fake_pieces / piece.length); i<len; ++i) {
	              first.before( piece.clone(true) );
	              last.after( piece.clone(true) );
	          }

	          var slide = function(add) {
	              isSliding = true;
	              var index = pieces.data('index');

	              index += add;
	              pieces.data('index', index);
	              pieces.animate({left : (-width*(index+1) + start_point)+'px'}, 
	                  {'duration':300,
	                   'complete':function() {
	                      if(index == -1) { // attach to left
	                          index = max - 1;
	                          pieces.data('index', index);
	                          pieces.css('left', (-width*(index+1) + start_point)+'px');
	                      } else if(index == max) { // attach to right
	                          index = 0;
	                          pieces.data('index', index);
	                          pieces.css('left', (-width*(index+1) + start_point)+'px');
	                      }
	                      slider.find(".index>li").removeClass('current');
	                      slider.find(".index>li[data-id="+index+"]").addClass('current');

	                      if( options.complete )
	                          options.complete( pieces.children(".piece").get(index+fake_pieces) );

	                      isSliding = false;
	                  }
	              });
	          }

	          this.prev = function() {
	              if(isSliding === false)
	                  slide(-1);
	          };

	          this.next = function() {
	              if(isSliding === false)
	                  slide(1);
	          };
	          
	          slider.find(".nav>.left").click(this.prev);
	          slider.find(".nav>.right").click(this.next);

	          if(options.duration > 0)
	              setInterval(this.next, options.duration);
	      };
	      var TriSlider = new TriSlider({'selector':'#banner>.trislider'});
	});

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
			top : 50,
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
<!-- "검색" 단추를 누르면 팝업 레이어가 열리도록 설정한다 -->
<script> 
$("#postcodify_search_button").click(function(){
	alert();
});
$(function() { 
	$("#postcodify_search_button").postcodifyPopUp(); 
}); 
</script>

<script type="text/javascript">
// 사진파일 다중 업로드
$(document).ready(function() {
	 var num = 1;
	 
	$(".file_input_hidden").change(function() {
		console.log("변화된 n값 : " + n);
		
		var ext = $("#upBtn"+n).val().split(".").pop();
		console.log($("#upBtn"+n).val().split(".").pop());
		ext.toLowerCase();
		
		if(ext.length > 0){
			if($.inArray(ext,['gif','png','jpg','jpeg']) == -1) { 
				alert("gif,png,jpg 파일만 업로드 할수 있습니다.");
				this.value = "";
				return;  
			} else {
				readURL(this);	
				if(num != 6){	
					$(this).hide();	
				}
		 		$("input[name='reviewPhoto"+(num+1)+"']").show();              
			}
		}
		n++;
		
	 });
	function readURL(input) {
		if (input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				var thumnailId = "thumnail"+ num;
				$('#'+thumnailId).css("width","74px");
				$('#'+thumnailId).css("height","74px");
				$('#'+thumnailId).attr('src', e.target.result);
				num++;
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
});
// 리뷰쓰기 사진 올리기 버튼
var n = 1;
$(function(){          
	console.log("ok");
	console.log(n);
	$('#review_photo_upload').click(function(e){
		e.preventDefault();
		
		if(n < 6){
			$("#upBtn" + n).click();         
			$("input:file").val().toLowerCase();
		}else{
			alert("사진은 최대 5장까지만 업로드할 수 있습니다.")
		}
	});       
	
			
});
</script>
<script type="text/javascript">

//[] <--문자 범위 [^] <--부정 [0-9] <-- 숫자  
//[0-9] => \d , [^0-9] => \D
var rgx1 = /\D/g;  // /[^0-9]/g 와 같은 표현
var rgx2 = /(\d+)(\d{3})/; 

function getNumber(obj){
	
     var num01;
     var num02;
     num01 = obj.value;
     num02 = num01.replace(rgx1,"");
     num01 = setComma(num02);
     obj.value =  num01;

}

function setComma(inNum){
     
     var outNum;
     outNum = inNum; 
     while (rgx2.test(outNum)) {
          outNum = outNum.replace(rgx2, '$1' + ',' + '$2');
      }
     return outNum;

}

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
							<a id="nav_logo" href="/easyStudy/index.jsp"><img class="logo"	src="/easyStudy/images/logo.png"></a>

							<!-- area search section -->
							<%
								if (member != null) {
							%>
							<input type="hidden" name="userid"
								value="<%=member.getUserId()%>">
							<%
								}
							%>
							<div id="nav_area" class="search sel">
								<div class="input">
									<div class="selected">지역 선택</div>
									<img src="/easyStudy/images/down_arrow.png" class="searchbox arrow">
								</div>
								<div class="box" id="box1">
									<ul class="district content">
										<li><input type="checkbox" name="area" id="GN" value="GN">
											<label for="GN">강남</label></li>
										<li><input type="checkbox" name="area" id="JL" value="JL">
											<label for="JL">종로</label></li>
										<li><input type="checkbox" name="area" id="SC" value="SC">
											<label for="SC">신촌</label></li>
									</ul>
									<!--<button type="button" id="off" class="confirm red_fill border_radius soft">확인</button>-->
									<button class="confirm red_fill border_radius soft"
										type="button">확인</button>
								</div>
							</div>
							<!-- genre search section -->
							<div id="nav_genre" class="search sel">
								<div class="input">
									<div class="selected">카테고리 선택</div>
									<img src="/easyStudy/images/down_arrow.png" class="searchbox arrow">
								</div>
								<div class="box" id="box2">
									<ul class="search_category content">
										<li><input type="checkbox" name="category" id="S10"
											value="S10"> <label for="S10">도서관/독서실</label></li>
										<li><input type="checkbox" name="category" id="S20"
											value="S20"> <label for="S20">스터디룸</label></li>
										<li><input type="checkbox" name="category" id="S30"
											value="S30"> <label for="S30">스터디카페</label></li>
										<!--  <li><input type="checkbox" name="category" id="S40" value="S40">
							<label for="S40">스터디룸/스터디카페</label></li>-->
									</ul>
									<button class="confirm red_fill border_radius soft"
										type="button">확인</button>
								</div>

							</div>
							<button type="submit" id="nav_btn" class="search">검색</button>

							<!-- account section -->
							<div id="nav_account">
								<div id="nav_guest">
									<%
										if (member != null) {
									%>
									<span id="nav_login"><a class="main_loginPopupBtn"
										href="/easyStudy/logout">로그아웃</a></span> &nbsp;|&nbsp; <span
										id="nav_join"><a> <%=member.getNickName()%></a></span>
									<%
										} else {
									%>
									<span id="nav_login"><a class="main_loginPopupBtn"
										href="#main_loginModal">로그인</a></span> &nbsp;|&nbsp; <span
										id="nav_join"><a class="main_joinPopupBtn"
										href="#main_joinModal">회원가입</a></span>
									<%
										}
									%>
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

						<%
							if (member != null) {
								if ("admin".equals(member.getUserId())) {
						%>
						<a href="/easyStudy/mmanagement?page=1"
							style="margin-left: 300px;">회원 관리</a> <a
							href="/easyStudy/detail/StoreAdmin.jsp"
							style="margin-left: 100px;">글쓰기</a>
						<%
							} else {
						%>
						<a href="/easyStudy/mbookmark?userid=<%=member.getUserId()%>"
							style="margin-left: 300px;">즐겨찾기</a> <a
							href="/easyStudy/mreview?page=1&nickname=<%=member.getNickName()%>"
							style="margin-left: 50px;">내가 쓴 리뷰</a> <a
							href="/easyStudy/mypage/myinfo.jsp" style="margin-left: 40px;">내
							정보 변경</a>
						<%
							}
							} else {
							}
						%>

					</div>
				</div>
			</div>
		</div>
		<!--<div class="menu_wrap">
				<div id="nav_menu">
				</div>
		</div>-->
		<div id="container">
			<!--배너 슬라이더 이미지 banner_warp-->
			<div id="banner_wrap">

				<div id="banner" class="storeAdd_banner" style="opacity:1;">
					<div class="trislider">
						<div class="pieces" data-index="0" data-max="5"
							style="left: -1700px; display: block;">
							<a href="" class="piece" style="background-image:url(/easyStudy/images/content_04.jpg);"></a>
		                    <a href="" class="piece" style="background-image:url(/easyStudy/images/content_02.jpg)"></a>
		                    <a href="" class="piece" style="background-image:url(/easyStudy/images/content_03.jpg)"></a>
		                    <a href="" class="piece" style="background-image:url(/easyStudy/images/content_06.jpg)"></a>
		                    <a href="" class="piece" style="background-image:url(/easyStudy/images/content_05.jpg)"></a>

						</div>
						<div class="left shadow"></div>
						<div class="right shadow"></div>

						<ul class="index">
							<li data-id="0" class="current">●</li>
							<li data-id="1" class="">●</li>
							<li data-id="2" class="">●</li>
							<li data-id="3" class="">●</li>
							<li data-id="4" class="">●</li>
						</ul>
						<div class="nav">
							<img class="left" alt="icon" src="/easyStudy/images/left_arrow.png" /> <img
								class="right" alt="icon" src="/easyStudy/images/right_arrow.png" />
						</div>
					</div>
				</div>
			</div>
			<!--배너 슬라이더 이미지 banner_warp-->
		
		<!--************content 작업 부분****************-->
			<div id="content_wrap">

				<div id="content" class="detail info">
					<ul class="tab">
						<li class="item selected"><a>상점 등록 </a></li>
					</ul>
					<%
						if (s != null) {
					%>

					<form action="StoreUpdate?storeId=<%=s.getStoreId()%>"
						method="post" enctype="multipart/form-data">
						<table border="1" id="detail_table">

							<tr>
								<th>이 름 :</th>
								<td><input type="text" name="name"
									value="<%=s.getStoreName()%>"></td>
							</tr>
							<tr>
								<th>분 류 :</th>
								<td><input type="text" name="group"
									value="<%=s.getCategoryId()%>"></td>
							</tr>
							<tr>
								<th>지 역 :</th>
								<td><input type="text" name="local"
									value="<%=s.getLocalCode()%>"></td>
							</tr>
							<tr>
								<th>주 소 :</th>
								<td><input type="text" name="address"
									value="<%=s.getAddress()%>"></td>
							</tr>
							<tr>
								<th>사 이 트 :</th>
								<td><input type="text" name="site"
									value="<%=s.getHomepage()%>"></td>
							</tr>
							<tr>
								<th>평일 영업 :</th>
								<td><input type="text" name="daytime"
									value="<%=s.getWeekDayTime()%>"></td>
							</tr>
							<tr>
								<th>주말 영업 :</th>
								<td><input type="text" name="endtime"
									value="<%=s.getWeekEndTime()%>"></td>
							</tr>
							<tr>
								<th>가 격 :</th>
								<td><input type="text" name="price"
									value="<%=s.getPrice()%>"></td>
							</tr>
							<tr>
								<th>전화번호 :</th>
								<td><input type="text" name="tell" value="<%=s.getTell()%>"></td>
							</tr>
							<tr>
								<th>비 고 :</th>
								<td><input type="text" name="etc" rows="5" cols="50"
									value="<%=s.getEtc()%>"></td>
							</tr>


							<tr>
								<th>첨부파일</th>
								<td id="farea">&nbsp; &nbsp; &nbsp; &nbsp; <input
									type="button" id="fileadd" value="파일추가">
								</td>

							</tr>


						</table>


						<input type="submit" value="수정하기"> &nbsp; &nbsp;
					</form>


					<%
						} else {
					%>

					<div id="storeAdd_area">
					<form action="/easyStudy/storeAdd" method="post" enctype="multipart/form-data">
						<table border="1" id="detail_table">
							<tr>
								<th><p>상 점 명</p></th>
								<td>
									<div class="inputBox3Wrap" id="">
										<input type="text" placeholder="" id="" name="storeName" class="inputBox3">
									</div>
								</td>
							</tr>

							<tr>
								<th><p>분 류</p></th>
								<td>
									<div class="" id="storeAdd_cate">
										<li><input type="radio" name="categoryId" id="storeAdd_S10" value="S10"> <label for="storeAdd_S10">도서관/독서실</label></li>
										<li><input type="radio" name="categoryId" id="storeAdd_S20" value="S20"> <label for="storeAdd_S20">스터디룸</label></li>
										<li><input type="radio" name="categoryId" id="storeAdd_S30" value="S30"> <label for="storeAdd_S30">스터디카페</label></li>
									</div>
								</td>
							</tr>
							<tr>
								<th><p>지 역</p></th>
								<td>
									<div class="" id="storeAdd_loca">
										<li><input type="radio" name="localCode" id="storeAdd_GN" value="GN"><label for="storeAdd_GN">강남</label></li>
										<li><input type="radio" name="localCode" id="storeAdd_SC" value="SC"><label for="storeAdd_SC">신촌</label></li>   
										<li><input type="radio" name="localCode" id="storeAdd_JL" value="JL"><label for="storeAdd_JL">종로</label></li>  
									</div>
								</td>
							</tr>
							<tr>
								<th><p>주 소</p></th>
								<td>
								<div class="inputBox3Wrap" id="">
									<input type="text" name="address" class="postcodify_postcode5 inputBox3" value="" />
								</div>
								</td>
							</tr>
							<tr>
								<th><p>사 이 트</p></th>
								<td>
									<div class="inputBox3Wrap" id="">
										<input type="text" placeholder=" http://www.searchStudy.com " id="" name="homepage" class="inputBox3">
									</div>
								</td>
							</tr>
							<tr>
								<th><p>평일 영업</p></th>
								<td>
									<div id="storeAdd_weekDayWrap" class="storeAdd_time" >
										<input type="time" placeholder="" id="storeAdd_weekDay" name="weekDayTime" class="inputBox3">
									</div>
								</td>
							</tr>
							<tr>
								<th><p>주말 영업</p></th>
								<td>
									<div id="storeAdd_weekEndWrap" class="storeAdd_time" >
										<input type="time" placeholder="" id="storeAdd_weekEnd" name="weekEndTime" class="inputBox3">
									</div>
								</td>
							</tr>
							<tr>
								<th><p>전화번호</p></th>
								<td>
									<div class="inputBox3Wrap" id="">
										<input type="tel" placeholder=" '-'를 뺀 번호를 입력해주세요" id="" name="tell" class="inputBox3">
									</div>
								</td>
							</tr>
							<tr>
								<th><p>가 격</p></th>
								<td>
									<div class="inputBox1Wrap" id="">
										<input name="price" placeholder="숫자만 사용 가능합니다" id="storeAdd_price" type="text" onchange="getNumber(this);" onkeyup="getNumber(this);" class="inputBox3">
									</div>
								</td>
							</tr>
							<tr>
								<th><p>서비스</p></th>
								<td>
									<div class="" id="storeAdd_servie">
									<li><input type="checkbox" name="storeAdd_servie" id="storeAdd_laptop" value="laptop"><label for="storeAdd_laptop">노트북</label></li>
									<li><input type="checkbox" name="storeAdd_servie" id="storeAdd_beam" value="beam"><label for="storeAdd_beam">빔 프로젝트</label></li>   
									<li><input type="checkbox" name="storeAdd_servie" id="storeAdd_wifi" value="wifi"><label for="storeAdd_wifi">와이파이</label></li>  
									<li><input type="checkbox" name="storeAdd_servie" id="storeAdd_board" value="board"><label for="storeAdd_board">화이트보드</label></li>  
									</div>
								</td>
							</tr>
							
							<tr>
								<th><p class="textarea_text">비 고</p></th>
								<td>
									<div class="textareaBoxWrap" id="">
										<textarea placeholder="" id="" name="etc" class="textareaBox" style="background:aliceblue;"></textarea>
										<div id="review_text_state" class="border_radius soft">
													특이 사항이 있으면 적어주세요!
										</div>
									</div>
									
									
								</td>
							</tr>

	
							<tr>
								<th>첨부파일</th>

								<td id="farea">
									<div id="itemPhoto" class="item photo">
											<div class="detail">
												<button type="button" id="review_photo_upload" class="border_radius medium" tabindex="-1">
													+
												</button>
												<input type="file" multiple name="reviewPhoto1" id="upBtn1" class="file_input_hidden" /> 
												<input type="file" multiple name="reviewPhoto2" id="upBtn2" class="file_input_hidden" style="display:none" /> 
												<input type="file" multiple name="reviewPhoto3" id="upBtn3" class="file_input_hidden" style="display:none" />
												<input type="file" multiple name="reviewPhoto4" id="upBtn4" class="file_input_hidden" style="display:none" />
												<input type="file" multiple name="reviewPhoto5" id="upBtn5" class="file_input_hidden" style="display:none" />
											    <div id="thumnailArea">
											       <img id="thumnail1" name="thumanail" />
											       <img id="thumnail2" name="thumanail" />
											       <img id="thumnail3" name="thumanail" />
											       <img id="thumnail4" name="thumanail" />
											       <img id="thumnail5" name="thumanail" />
											    </div>
												<!-- <ul id="review_photo_list">
												</ul> -->
											</div>
										</div>

								</td>

							</tr>


						</table>
						<div id="storeAdd_enrollBtnWrap">
							<input type="submit" value="등록하기" id="storeAdd_enrollBtn">
						</div>
					</form>
					</div>

					<%
						}
					%>
				</div>
			</div>
		</div>
		
		<div id="footer_wrap">
	      <div id="footer" style="width:970px; height:208px;">
	         <img class="logo" src="/easyStudy/images/logo.png" style="width:100px; height:auto;">
	         <div class="slogan">특별한 공간에서 공부하는 방법.<br>즐거운 공부 하세요.<br>성공 할 수 있습니다.</div>
	         <div class="author">(주)이지스터디  만든이들 : 최진형, 유의현, 하지수, 박유화, 양명준&nbsp;&nbsp;|&nbsp;&nbsp;HK정보교육원&nbsp;&nbsp;|&nbsp;&nbsp;등록번호 :778484758&nbsp;&nbsp;|&nbsp;&nbsp;1F 서울시 강남구 역삼동 152309 </div>
	      </div>
   		</div>
	</div>
	<div id="main_loginWrap">
		<div id="main_loginModal" class="main_loginPopup" style="display: none;">
			<!-- 로그인 페이지-->
			<div id="main_login">
				<div id="main_loginHeader">
					<h1>SEARCH STUDY</h1>
				</div>
				
				<div class="sel">
					<form action="login" method="post" id="loginForm">
						<div class="main_inputRow" id="main_loginIdArea">
							<input type="email" placeholder="이메일" id="main_loginUserId" name="main_loginUserId" class="inputBox1">
						</div>
						<div class="main_labelRow"  id="main_loginIdCheckArea" style="display:none">
							<label class="main_loginCheck" id="main_loginIdCheckLabel"> </label>							
						</div>
						<div class="main_inputRow" id="main_passwordArea">
							<input type="password" placeholder="비밀번호" id="main_loginUserPwd" name="main_loginUserPwd" class="inputBox1">
						</div>
						<div class="main_labelRow"  id="main_loginPwCheckArea" style="display:none">
							<label class="main_loginCheck" id="main_loginPwCheckLabel"> 패스워드를 다시 확인해주세요</label>							
						</div>
						<div id="main_loginBtn_area">
							<input type="button" value="로그인" id="main_loginBtn">
						</div>
						<div id="main_sendLoginBtn" class="box">
							<ul class="content">
								<li>
									<input type="checkbox" id="main_login_chk" value="off" >
									<label for="main_login_chk">로그인 상태 저장</label>
								</li>
							</ul>
						</div>
					</form>
				</div>

				<div id="main_find_info">
					<div>
						<!-- <a href="#"> 아이디 찾기</a> <span>|</span> -->
						<a href="#main_pwSearchModal" class="main_pwSearchBtn"> 비밀번호 찾기</a> <span>|</span>
						<a href="#main_joinModal" class="main_joinPopupBtn"> 회원가입</a>
					</div>
				</div>

			</div>
		</div>
		
		<div id="main_joinModal" class="main_joinPopup" style="display: none;">
			<!-- 회원가입 페이지-->
			<div id="main_join" >
				<div id="main_joinHeader">
					<h1>SEARCH STUDY</h1>
				</div>

				<div>
					<form action="mjoin" method="post" id="joinForm">
						<div id="main_joinIdArea" class="divBox1">
							<input type="email" placeholder="이메일" class="inputBox1" name="main_joinUserId" id="main_joinUserId">
						</div>
						<div class="main_labelRow"  id="main_joinIdCheckArea" style="display:none">
							<label class="main_loginCheck" id="main_joinIdCheckLabel"> </label>							
						</div>
						<div id="main_joinPwArea" class="divBox1">
							<input type="password" placeholder="비밀번호" class="inputBox1" name="main_joinUserPwd" id="main_joinUserPwd">
						</div>
						<div class="main_labelRow"  id="main_joinPwCheckArea" style="display:none">
							<label class="main_loginCheck" id="main_joinPwCheckLabel"> </label>							
						</div>
						<div id="main_joinPwcheckArea" class="divBox1">
							<input type="password" placeholder="비밀번호확인" class="inputBox1" name="main_joinUserPwdChk" id="main_joinUserPwdChk">
						</div>
						<div class="main_labelRow"  id="main_joinPwCheckChkArea" style="display:none">
							<label class="main_loginCheck" id="main_joinPwCheckChkLabel"> </label>							
						</div>
						<div id="main_joinNickArea" class="divBox1">
							<input type="text" placeholder="닉네임" class="inputBox1" name="main_joinUserNickName" id="main_joinUserNickName">
						</div>
						<div class="main_labelRow"  id="main_joinNickCheckArea" style="display:none">
							<label class="main_loginCheck" id="main_joinNickCheckLabel"> </label>							
						</div>
						<div id="main_sendInfoBtn">
							<input type="button" value="가입하기" id="main_joinBtn">
						</div>
					</form>
				</div>
				<div id="main_backArea">
					<a href="#main_loginModal" class="main_loginPopupBtn"> 로그인</a>
				</div>
			</div>
		</div>
		
		<div id="main_pwSearchModal" class="main_pwSearchPopup" style="display: none;">
			<!-- 비밀번호찾기 페이지-->
			<div id="main_pwSearch" >
				<div id="main_pwSearchHeader">
					<h1>SEARCH STUDY</h1>
				</div>

				<div>
					<form action="sendEmail" method="post" id="pwSearchForm">
						<div id="main_pwSearchArea" class="divBox1">
							<input type="text" placeholder="이메일" class="inputBox1" name="main_pwSearchUser" id="main_pwSearchUser">
						</div>
						<div class="main_labelRow"  id="main_pwSearchCheckArea" style="display:none">
							<label class="main_loginCheck" id="main_pwSearchCheckLabel"> </label>							
						</div>
						<div id="main_sendEamilBtn">
							<input type="button" value="이메일로 보내기">
						</div>
					</form>
				</div>
				<div id="main_backArea">
					<a href="#main_loginModal" class="main_loginPopupBtn"> 로그인</a>
				</div>
			</div>
		</div>
		
	</div>
</body>
</html>