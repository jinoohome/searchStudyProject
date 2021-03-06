<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="review.model.vo.Review, review.model.vo.ReviewImage" %>
<%@ page

	import="detail.model.vo.Store,detail.model.vo.Image, java.util.* , member.model.vo.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	Store s=(Store)request.getAttribute("store");
	Image i=(Image)request.getAttribute("image"); 
	Member member = (Member)session.getAttribute("member");
	ArrayList<Review> list = (ArrayList<Review>)request.getAttribute("list");
	ArrayList<ReviewImage> listRImage = (ArrayList<ReviewImage>)request.getAttribute("listRImage");
	
	Double score = (Double)request.getAttribute("score");
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();	//현재 페이지
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int listRCount = ((Integer)request.getAttribute("listRCount")).intValue(); //해당하는 storeId에 대한 총 리뷰 수
	ArrayList<Review> reviewPageList = (ArrayList<Review>)request.getAttribute("reviewPageList");
	ArrayList<ReviewImage> reviewImagePageList = (ArrayList<ReviewImage>)request.getAttribute("reviewImagePageList");
	String nickname = "GUEST";
	if(member !=null){
		nickname = member.getNickName();
	}
	
	//String storeName = java.net.URLEncoder.encode(s.getStoreName());
	String detail = s.getStoreName()+","+i.getPhoto1()+","+score;
	//상품정보 쿠기 저장
	
	Cookie cook = new Cookie(s.getStoreId(), java.net.URLEncoder.encode(detail,"utf-8"));
	cook.setMaxAge(5*60);//초단위  
	cook.setPath("/");
	
	response.addCookie(cook);
	
	System.out.print("detail storeName:"+cook.getName()+"\n");
	System.out.print("detail storeImg:"+cook.getValue()+"\n");
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/review.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/detail.css" > 
<link rel="stylesheet" type="text/css" href="/easyStudy/css/main.css" >
<link rel="stylesheet" type="text/css" href="/easyStudy/css/layout.css" > 
<link rel="stylesheet" type="text/css" href="/easyStudy/css/function.css" > 
<link rel="stylesheet" type="text/css" href="/easyStudy/css/star.css">

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyA29xkBAMN_bvriR7uE8dSqVFFwjKXZjcw"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript" src="/easyStudy/js/navigation.js"> </script>
<script type="text/javascript" src="/easyStudy/js/review.js"></script>
<script type="text/javascript" src="/easyStudy/js/jquery.leanModal.min.js"></script> <!--dialog -->


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
  <style>
body{
	width:100%;
	margin:0;
}
a {
    text-decoration: none;
}
ol, ul {
    list-style: none;
}
#bannerSlider{
	position: relative;
    overflow: hidden; 
    width: 100%;
    height: 420px;
 	background-size: cover; 
    background-position: center center;
}
.trislider{
	width: 850px;
    height: 100%;
    position: relative;
    margin: 0 auto;
}
.pieces{
    width: 30000px;
    height: 100%;
    position: relative; 
    left: -730px;
    overflow: hidden; 
 	display: none; 
}
.pieces .piece{
    float: left;
    height: 100%;
    width: 730px;
    background-size: cover;
    background-position: center center;
    background-repeat: no-repeat;
}
.nav{
    position: absolute;
    top: 10%;
    width: 730px;
    margin: -25px auto 0 -130px;
   }
.nav i {
    position: absolute;
    width: 51px;
    height: 51px;
    cursor: pointer;
   /*  background-image: url(../image/recent_sheet.png);  */
}
.left{
		position: absolute;
 	 	 background-image: url(/easyStudy/images/detail_leftArrow.png);
    	width: 730px;
    	margin-left:155px;
}
.right{
     background-image: url(/easyStudy/images/detail_rightArrow.png);
     background-repeat: no-repeat;
    
}
.shadow{
	height: 100%;
    width: 30000px;
    position: absolute;
    top: 0;
    /* background-image: url(../image/mask.png); */
    background: white;
}
.left.shadow{
    right: 0;
    margin-right: 730px;
}
.right.shadow{
    left: 0;
    margin-left: 730px;
}
.index {
    position: absolute;
    left: 0;
    width: 100%;
    top: 22px;
    text-align: center;
    color: #fff;
}
.index li{
    display: inline-block;
    font-size: 11px;
    letter-spacing: 1px;
}
.index li.current {
    color: #c91b3c;
}
</style>
<style type="text/css">
   #thumnailArea{
      width: 450px;
      height: 74px;
      /* background: aliceblue; */
      background: white;
   }
   #thumnailArea img{
		margin: 2px;
		margin-top: 0px;
		-webkit-border-radius: 5px;
		-moz-border-radius: 5px;
		border-radius: 5px;
   }
   
   
   
	#file { width:0; height:0; }               
	
	/* 사진 올리기 input type=file 태그 안보이게하기  */
	.file_input_hidden{
		/* font-size: 45px; */
		/* right: 0px; */
		/* position: absolute; */
		top: 0px;
		opacity: 0; 
		z-index: -100;
    	width: 0px;
    	height: 0px;
	
		filter: alpha(opacity=0);
		-ms-filter: "alpha(opacity=0)";
		-khtml-opacity: 0;
		-moz-opacity: 0;
	}
	
	/* 뒷화면 어둡게 하기*/
	#lean_overlay {
		position: fixed;
		z-index: 100;
		top: 0px;
		left: 0px;
		height: 100%;
		width: 100%;
		background: #000;
		display: none;
	}
	/*로그인 팝업창*/
	.review_loginPopup {
		position: absolute;
		width: 600px;
		height: 500px;
		left: 45%;
		top: 60px;
		background: #FFF;
		z-index: 20000;
	}
</style>
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
	$("#bannerSlider").on("selectstart", function()
			{
			    return false;
			});
$("#bannerSlider").on("selectstart", function()
		{
		    return false;
		});
		function TriSlider(options) {
		    var slider = $(options.selector);
		    var pieces = slider.children(".pieces");
		    var max = pieces.data('max');
		    var fake_pieces = options.fake_pieces? options.fake_pieces:2;
		    var width = 730;
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
		var TriSlider = new TriSlider({'selector':'#bannerSlider>.trislider'});
});
</script>
<script type="text/javascript">
//시작하자마자 수정버튼 숨기기
$( document ).ready(function() {
	
	$('#review_modify').hide();	
	
	//수정버튼 클릭
	$('#modifyGo').click(function(){
		
		var contents = $("#review_text").val();
		var listno = $('#hiddenlistno').val();
		var score = 0;
		if($("#p10").is(":checked")){
			score = 5.0;
		}
		if($("#p9").is(":checked")){
			score = 4.5;
		}
		if($("#p8").is(":checked")){
			score = 4.0;
		}
		if($("#p7").is(":checked")){
			score = 3.5;
		}
		if($("#p6").is(":checked")){
			score = 3.0;
		}
		if($("#p5").is(":checked")){
			score = 2.5;
		}
		if($("#p4").is(":checked")){
			score = 2.0;
		}
		if($("#p3").is(":checked")){
			score = 1.5;
		}
		if($("#p2").is(":checked")){
			score = 1.0;
		}
		if($("#p1").is(":checked")){
			score = 0.5;
		}
		location.href = "/easyStudy/updateQ?listno=" + listno + "&updatescore=" + score + "&contents=" + contents + "&storeId=<%=s.getStoreId() %>&score=<%=score %>";
		
		
		
	});
});
function update(listNo){
	
	$.ajax({
		url : "rupdate",
		data : {listNo : listNo},
		type : "post",
		dataType : "json", //명시해줘야 data를 json 타입으로 받아준다.
		success : function(data){
			
			//
			$("#itemPhoto").hide();
			$('#review_add').hide();
			$('#review_modify').show();
			
			//내용			
			$("#hiddenlistno").val(data.listNo);
			$("#review_text").text($("#review_text").text() + data.contents);
			 
			//별점
			var score = data.score;
			
			if(score == 5){
				$("#p10").attr("checked", true);
				$("output>b").text($("#p10").next().text());
			}
			if(score == 4.5){
				$("#p9").attr("checked", true);
				$("output>b").text($("#p9").next().text());
			}
			if(score == 4){
				$("#p8").attr("checked", true);
				$("output>b").text($("#p8").next().text());
			}
			if(score == 3.5){
				$("#p7").attr("checked", true);
				$("output>b").text($("#p7").next().text());
			}
			if(score == 3){
				$("#p6").attr("checked", true);
				$("output>b").text($("#p6").next().text());
			}
			if(score == 2.5){
				$("#p5").attr("checked", true);
				$("output>b").text($("#p5").next().text());
			}
			if(score == 2){
				$("#p4").attr("checked", true);
				$("output>b").text($("#p4").next().text());
			}
			if(score == 1.5){
				$("#p3").attr("checked", true);
				$("output>b").text($("#p3").next().text());
			}
			if(score == 1){
				$("#p2").attr("checked", true);
				$("output>b").text($("#p2").next().text());
			}
			if(score == 0.5){
				$("#p1").attr("checked", true);
				$("output>b").text($("#p1").next().text());
			}
			
			
			var num = 1;
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
			
			
		},
		error : function(){
			alert("error!!");
		}
	});
	
}
$(document).ready(function() {
	// 로그인 버튼 클릭시
	$(".review_loginPopupBtn").leanModal({
		top : 100,
		overlay : 0.6,
		closeButton : ".modal_close"
	});
});	
	
	
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
		console.log("222222 : " + n);
		
		if(n < 6){
			$("#upBtn" + n).click();         
			//var ext = $("input[name=reviewPhoto"+n+"]").val().split(".").pop();
			console.log("123123123123123");
			console.log("n값이다111111111111111: " + n);
			
			//if("#upBtn" + n)
			/* var ext = $("#upBtn"+(n-1)).val().split(".").pop();
			console.log($("#upBtn"+n).val().split(".").pop());
			ext.toLowerCase();
			if(ext.length > 0){
				//if($.inArray(ext, ["gif","png","jpg","jpeg"]) == -1) { 
				if($.inArray(['gif','png','jpg','jpeg'], ext) == -1) { 
					alert("gif,png,jpg 파일만 업로드 할수 있습니다.");
					return false;  
				}                  
			} */
			$("input:file").val().toLowerCase();
		}else{
			alert("사진은 최대 5장까지만 업로드할 수 있습니다.")
		}
		
	});       
	
	
	/* $("input[type=file]").each(function(index){
		$("upBtn" + index).change(function(){
			n++;
			console.log("변화된 n값 : " + n)
		});
	});  */
	
	/* $("input[type=file]").on("change", function(){
			$("#upBtn" + index).change(function(index){
				n++;
				console.log("변화된 n값 : " + n)
			});
	}); */
	
	/* $("#upBtn" + 1).change(function(){
		n++;
		console.log("변화된 n값 : " + n);
	});
	$("#upBtn" + 2).change(function(){
		n++;
		console.log("변화된 n값 : " + n);
	});
	$("#upBtn" + 3).change(function(){
		n++;
		console.log("변화된 n값 : " + n);
	});
	$("#upBtn" + 4).change(function(){
		n++;
		console.log("변화된 n값 : " + n);
	});
	$("#upBtn" + 5).change(function(){
		n++;
		console.log("변화된 n값 : " + n);
	}); */
	
	
	
	/* $(".upBtn").change(function(){
		console.log("변화된 n값 : " + n);
		
		var ext = $("#upBtn"+(n)).val().split(".").pop();
		console.log($("#upBtn"+n).val().split(".").pop());
		ext.toLowerCase();
		if(ext.length > 0){
			//if($.inArray(ext, ["gif","png","jpg","jpeg"]) == -1) { 
			if($.inArray(['gif','png','jpg','jpeg'], ext) == -1) { 
				alert("gif,png,jpg 파일만 업로드 할수 있습니다.");
				this.value = "";
				return;  
			}                  
		}
		n++;
	}); */
			
});
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
							&nbsp;|&nbsp;
							<span id="nav_join" style="color:#fff"><%=member.getNickName() %></span>
						<%}else{ %>
							<span id="nav_login" ><a class="main_loginPopupBtn" href="#main_loginModal">로그인</a></span>
							
							<span id="nav_join"><a class="main_joinPopupBtn" href="#main_joinModal">회원가입</a></span>
						<%} %>	
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
							<a href="/easyStudy/mmanagement?page=1" style="margin-left:300px;">회원 관리</a> 
						    <a href="/easyStudy/detail/StoreAdmin.jsp" style="margin-left:100px;">글쓰기</a>
						<%}else{ %>		
							<a href="/easyStudy/mbookmark?userid=<%=member.getUserId() %>" style="margin-left:300px;">즐겨찾기</a> 
							<a href="/easyStudy/mreview?page=1&nickname=<%=member.getNickName() %>" style="margin-left:50px;">내가 쓴 리뷰</a> 
							<a href="/easyStudy/mypage/myinfo.jsp" style="margin-left:40px;">내 정보 변경</a> 		
						<%}
					}else{} %>
				
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
						<%if(i !=null){ %>
						<img src="/easyStudy/images/<%=i.getPhoto1()%>" id="detail_titleImage">
						<%} %>
					</div>
				</div>
			</div>

			<div id="tabs">
				<div id="content_wrap">
					<div id="content" class="detail info">
					<%if(s !=null){ %>
					<div id="detail_title"><%=s.getStoreName() %></div>
					<div id="detail_explain"><%=s.getLocalName() %> / <%=s.getCategoryName() %></div>
					<%} %>
						<!-- <ul class="tab">
							<li class="item "><a href="">정보</a></li>
							<li class="item"><a href="">포토</a></li>
							<li class="item"><a href="">리뷰</a></li>
						</ul> -->
						
						<!-- 정보 탭 관련 정보  -->
						<div id="tabs-1">
							<form action="DView" method="post">
								<div id="detail_firstImageWrap">
									<%if (i !=null){  %> 
									<div id="banner_wrap">
										<div id="bannerSlider">
										    <div class="trislider">
										    	<div class="pieces" data-index="0" data-max="5" style="left: -1700px; display: block;">
						    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto1() %>);" onclick="return false"></a>
						    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto2() %>);" onclick="return false"></a>
						    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto3() %>);" onclick="return false"></a>
						    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto4() %>);" onclick="return false"></a>
						    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto5() %>);" onclick="return false"></a>
										    		    		
										    		    	</div>
										   		<div class="left shadow"></div>
										        <div class="right shadow"></div>
										        <ul class="index">
										        	        	<!-- 	<li data-id="0" class="current">●</li>
										        	        		<li data-id="1" class="">●</li>
										        	        		<li data-id="2" class="">●</li>
										        	        		<li data-id="3" class="">●</li>
										        	        		<li data-id="4" class="">●</li> -->
										        	        </ul> 
										        <div class="nav">
										        	<i class="icon left"></i>
										        	<i class="icon right"></i>
										        </div>
										    </div>
										</div></div>
									
									
								</div>
									<% } %>
								<p class="detail_h">공간소개</p>
								<table border="1" id="detail_table" style="">
									<tr>
										<th>상점명</th>
										<td><%=s.getStoreName() %></td>
									</tr>
									<tr>
										<th>평가</th>
										<td>
											 <div class="rating" id="detail_score">
	                                             <%
													if(score <= 0.5){
												%>
												<div class="stars">
													<span class="star odd active"></span>
													<span class="star even active"></span>
													<span class="star odd"></span>
													<span class="star even"></span>
													<span class="star odd"></span>
													<span class="star even"></span>
													<span class="star odd"></span>
													<span class="star even"></span>
													<span class="star odd"></span>
													<span class="star even"></span>
												</div>
												<%
													}else if(score <= 1){
												%>
												<div class="stars">
													<span class="star odd active"></span>
			                                        <span class="star even active"></span>
			                                        <span class="star odd"></span>
			                                        <span class="star even"></span>
			                                        <span class="star odd"></span>
			                                        <span class="star even"></span>
			                                        <span class="star odd"></span>
			                                        <span class="star even"></span>
			                                        <span class="star odd"></span>
			                                        <span class="star even"></span>
												</div>
												<%
													}else if(score<= 1.5){
												%>
												<div class="stars">
													<span class="star odd active"></span>
	                                      			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even"></span>
	                                      			<span class="star odd"></span>
	                                       			<span class="star even"></span>
	                                      			<span class="star odd"></span>
	                                       			<span class="star even"></span>
	                                      			<span class="star odd"></span>
	                                       			<span class="star even"></span>
												</div>
												<%
													}else if(score<= 2){
												%>
												<div class="stars">
													<span class="star odd active"></span>
	                                      			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd"></span>
	                                       			<span class="star even"></span>
	                                      			<span class="star odd"></span>
	                                       			<span class="star even"></span>
	                                      			<span class="star odd"></span>
	                                       			<span class="star even"></span>
												</div>
												<%
													}else if(score<= 2.5){
												%>
												<div class="stars">
													<span class="star odd active"></span>
	                                      			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even"></span>
	                                      			<span class="star odd"></span>
	                                       			<span class="star even"></span>
	                                      			<span class="star odd"></span>
	                                       			<span class="star even"></span>
												</div>
												<%
													}else if(score<= 3){
												%>
												<div class="stars">
													<span class="star odd active"></span>
	                                      			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd"></span>
	                                       			<span class="star even"></span>
	                                      			<span class="star odd"></span>
	                                       			<span class="star even"></span>
												</div>
												<%
													}else if(score<= 3.5){
												%>
												<div class="stars">
													<span class="star odd active"></span>
	                                      			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even"></span>
	                                      			<span class="star odd"></span>
	                                       			<span class="star even"></span>
												</div>
												<%
													}else if(score<= 4){
												%>
												<div class="stars">
													<span class="star odd active"></span>
	                                      			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd"></span>
	                                       			<span class="star even"></span>
												</div>
												<%	}else if(score<= 4.5){
												%>
												<div class="stars">
													<span class="star odd active"></span>
	                                      			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even"></span>
												</div>
												<%	
													}else if(score<= 5){
												%>
												<div class="stars">
													<span class="star odd active"></span>
	                                      			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
	                                      			<span class="star odd active"></span>
	                                       			<span class="star even active"></span>
												</div>
												<%
													}
												%>
			                              </div>
										</td>
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
										<th>평일 영업</th>
										<td><%=s.getWeekDayTime() %></td>
									</tr>
									<tr>
									<th>주말 영업</th>
									<td><%=s.getWeekEndTime() %></td>
									</tr>
									<tr>
										<th>가 격</th>
										<td><%=s.getPrice() %></td>
									</tr>
									<tr>
										<th>전화번호</th>
										<td><%=s.getTell() %></td>
									</tr>
									<tr>
										<th>비 고</th>
										<td><%=s.getEtc() %></td>
									</tr>
									
								</table>
							</form>
						
								<form action="DMap" method="post">
								<p class="detail_h">지도</p>
									<div id="map-canvas" style="width: 730px; height: 500px"></div>
									<br>
									
								</form>
						</div>
						<!--reivew area  -->
						<div id="tabs-2">
						<div id="content" class="detail review">
					<!-- 	<ul class="tab">
							<li class="item "><a href="">정보</a></li>
							<li class="item"><a href="">포토</a></li>
							<li class="item"><a href="">리뷰</a></li>
						</ul> -->
							<form action="radd?storeId=<%=s.getStoreId()%>&nickname=<%= nickname %>" method="post" enctype="multipart/form-data" style="margin:0;" >
								<div class="body first">
									<div class="title">
										리뷰 쓰기
									</div>
									<ul class="list">
										<li class="item grade">
											<div class="name">
												전체적인 평점
											</div>
											<div class="detail">
												<span class="star-input">
							  					<span class="input" style="display:inline-block;vertical-align:super;">
							    				<input type="radio" name="star-input" id="p1" value="0.5"><label for="p1">0.5</label>
							    				<input type="radio" name="star-input" id="p2" value="1"><label for="p2">1</label>
							    				<input type="radio" name="star-input" id="p3" value="1.5"><label for="p3">1.5</label>
							    				<input type="radio" name="star-input" id="p4" value="2"><label for="p4">2</label>
							    				<input type="radio" name="star-input" id="p5" value="2.5"><label for="p5">2.5</label>
							    				<input type="radio" name="star-input" id="p6" value="3"><label for="p6">3</label>
							    				<input type="radio" name="star-input" id="p7" value="3.5"><label for="p7">3.5</label>
							    				<input type="radio" name="star-input" id="p8" value="4"><label for="p8">4</label>
							    				<input type="radio" name="star-input" id="p9" value="4.5"><label for="p9">4.5</label>
							    				<input type="radio" name="star-input" id="p10" value="5"><label for="p10">5</label>
							  					</span>
							  					<span class="lastspan" style="display:inline-block;vertical-align:super;"><output for="star-input" ><b>0</b>점</output></span>
												</span>				
											</div>
										</li>
										<li class="item text">
											<div class="name" id="detail_text">
												자세하게 써주세요
											</div>
											<div class="detail">
												<input type="hidden" id="hiddenlistno" >
												<textarea id="review_text" name="review_text" class="border_radius soft"></textarea>
												<div id="review_text_state" class="border_radius soft">
													평점을 매겨주세요!
												</div>
											</div>
											<script>
											if($("input[name=star-input]").is(":checked")){
												$("#review_text_state").css("background", "green");
											}
											</script>
										</li>
										<li id="itemPhoto" class="item photo">
											<div class="name">
												사진 올리기
											</div>
											<div class="detail">
												<button id="review_photo_upload" class="border_radius medium" tabindex="-1">
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
										</li>
									</ul>
									
									
								</div>
					
								<div class="body review write" id="review_add">
									<button type="submit" class="border_radius soft" id="AA">
										리뷰 올리기
									</button>
								</div>
								<div class="body review write" id="review_modify">
									<button type="button" class="border_radius soft" id="modifyGo">
										리뷰 수정하기
									</button>
								</div>
								</form>
						<div class="review_titleWrap">
						<div class="title" id="review_title">
								Review
						</div>
					</div>
					<!-- reviewPageList != null -->
					<%	if(reviewPageList != null){%>
					<%	for(int z = 0; z < reviewPageList.size(); z++){ %>
			
					<div class="body review list ">
						<div class="review_detail">
							<i class="image border_radius circle" style="display: inline-block; background-image: url(&quot;http://c4.poing.co.kr/55ea410bd820b94b140000f7.jpg&quot;);"></i>
							</a>
							<div class="user">
								<div class="name ">
								<a href="#"><%= reviewPageList.get(z).getNickName() %></a>									
								</div>
								
								
								
								<%
									if(reviewPageList.get(z).getScore() == 5){
								%>
								<div class="grade">
									<i class="icon star medium odd active" data-index="0" style=""></i>
									<i class="icon star medium even active" data-index="1" style=""></i>
									<i class="icon star medium odd active" data-index="2" style=""></i>
									<i class="icon star medium even active" data-index="3" style=""></i>
									<i class="icon star medium odd active" data-index="4" style=""></i>
									<i class="icon star medium even active" data-index="5" style=""></i>
									<i class="icon star medium odd active" data-index="6" style=""></i>
									<i class="icon star medium even active" data-index="7" style=""></i>
									<i class="icon star medium odd active" data-index="8" style=""></i>
									<i class="icon star medium even active" data-index="9" style=""></i>
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 4.5){
								%>
								<div class="grade">
									<i class="icon star medium odd active" data-index="0" style=""></i>
									<i class="icon star medium even active" data-index="1" style=""></i>
									<i class="icon star medium odd active" data-index="2" style=""></i>
									<i class="icon star medium even active" data-index="3" style=""></i>
									<i class="icon star medium odd active" data-index="4" style=""></i>
									<i class="icon star medium even active" data-index="5" style=""></i>
									<i class="icon star medium odd active" data-index="6" style=""></i>
									<i class="icon star medium even active" data-index="7" style=""></i>
									<i class="icon star medium odd active" data-index="8" style=""></i>
									<i class="icon star medium even" data-index="9" style=""></i>
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 4){
								%>
								<div class="grade">
									<i class="icon star medium odd active" data-index="0" style=""></i>
									<i class="icon star medium even active" data-index="1" style=""></i>
									<i class="icon star medium odd active" data-index="2" style=""></i>
									<i class="icon star medium even active" data-index="3" style=""></i>
									<i class="icon star medium odd active" data-index="4" style=""></i>
									<i class="icon star medium even active" data-index="5" style=""></i>
									<i class="icon star medium odd active" data-index="6" style=""></i>
									<i class="icon star medium even active" data-index="7" style=""></i>
									<i class="icon star medium odd" data-index="8" style=""></i>
									<i class="icon star medium even" data-index="9" style=""></i>
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 3.5){
								%>
								<div class="grade">
									<i class="icon star medium odd active" data-index="0" style=""></i>
									<i class="icon star medium even active" data-index="1" style=""></i>
									<i class="icon star medium odd active" data-index="2" style=""></i>
									<i class="icon star medium even active" data-index="3" style=""></i>
									<i class="icon star medium odd active" data-index="4" style=""></i>
									<i class="icon star medium even active" data-index="5" style=""></i>
									<i class="icon star medium odd active" data-index="6" style=""></i>
									<i class="icon star medium even" data-index="7" style=""></i>
									<i class="icon star medium odd" data-index="8" style=""></i>
									<i class="icon star medium even" data-index="9" style=""></i>
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 3){
								%>
								<div class="grade">
									<i class="icon star medium odd active" data-index="0" style=""></i>
									<i class="icon star medium even active" data-index="1" style=""></i>
									<i class="icon star medium odd active" data-index="2" style=""></i>
									<i class="icon star medium even active" data-index="3" style=""></i>
									<i class="icon star medium odd active" data-index="4" style=""></i>
									<i class="icon star medium even active" data-index="5" style=""></i>
									<i class="icon star medium odd" data-index="6" style=""></i>
									<i class="icon star medium even" data-index="7" style=""></i>
									<i class="icon star medium odd" data-index="8" style=""></i>
									<i class="icon star medium even" data-index="9" style=""></i>
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 2.5){
								%>
								<div class="grade">
									<i class="icon star medium odd active" data-index="0" style=""></i>
									<i class="icon star medium even active" data-index="1" style=""></i>
									<i class="icon star medium odd active" data-index="2" style=""></i>
									<i class="icon star medium even active" data-index="3" style=""></i>
									<i class="icon star medium odd active" data-index="4" style=""></i>
									<i class="icon star medium even" data-index="5" style=""></i>
									<i class="icon star medium odd" data-index="6" style=""></i>
									<i class="icon star medium even" data-index="7" style=""></i>
									<i class="icon star medium odd" data-index="8" style=""></i>
									<i class="icon star medium even" data-index="9" style=""></i>
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 2){
								%>
								<div class="grade">
									<i class="icon star medium odd active" data-index="0" style=""></i>
									<i class="icon star medium even active" data-index="1" style=""></i>
									<i class="icon star medium odd active" data-index="2" style=""></i>
									<i class="icon star medium even active" data-index="3" style=""></i>
									<i class="icon star medium odd" data-index="4" style=""></i>
									<i class="icon star medium even" data-index="5" style=""></i>
									<i class="icon star medium odd" data-index="6" style=""></i>
									<i class="icon star medium even" data-index="7" style=""></i>
									<i class="icon star medium odd" data-index="8" style=""></i>
									<i class="icon star medium even" data-index="9" style=""></i>
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 1.5){
								%>
								<div class="grade">
									<i class="icon star medium odd active" data-index="0" style=""></i>
									<i class="icon star medium even active" data-index="1" style=""></i>
									<i class="icon star medium odd active" data-index="2" style=""></i>
									<i class="icon star medium even" data-index="3" style=""></i>
									<i class="icon star medium odd" data-index="4" style=""></i>
									<i class="icon star medium even" data-index="5" style=""></i>
									<i class="icon star medium odd" data-index="6" style=""></i>
									<i class="icon star medium even" data-index="7" style=""></i>
									<i class="icon star medium odd" data-index="8" style=""></i>
									<i class="icon star medium even" data-index="9" style=""></i>
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 1){
								%>
								<div class="grade">
									<i class="icon star medium odd active" data-index="0" style=""></i>
									<i class="icon star medium even" data-index="1" style=""></i>
									<i class="icon star medium odd" data-index="2" style=""></i>
									<i class="icon star medium even" data-index="3" style=""></i>
									<i class="icon star medium odd" data-index="4" style=""></i>
									<i class="icon star medium even" data-index="5" style=""></i>
									<i class="icon star medium odd" data-index="6" style=""></i>
									<i class="icon star medium even" data-index="7" style=""></i>
									<i class="icon star medium odd" data-index="8" style=""></i>
									<i class="icon star medium even" data-index="9" style=""></i>
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}
								%>
								
							</div>
						
						<!--리뷰 내용 리스트  -->
							<div class="review">
								<!-- <div class="time">하루 전<br><span>하루 전 수정됨</span></div> -->
								<div class="text">
								<pre><%= reviewPageList.get(z).getContents() %></pre>
								</div>
							<%	if(reviewImagePageList != null){ %>
											
								<ul class="photo_list">
									<li class="item">
										<a class="review_loginPopupBtn" href="#review_loginModal">
									
										<%if( reviewImagePageList.get(z).getRenamePhoto1()!=null){ %>
										<img src="uploadFiles/<%= reviewImagePageList.get(z).getRenamePhoto1() %>" width="84" height="84">
										<%}else{ %>
										<%} %>
										
										<%if( reviewImagePageList.get(z).getRenamePhoto2()!=null){ %>
										<img src="uploadFiles/<%= reviewImagePageList.get(z).getRenamePhoto2() %>" width="84" height="84">
										<%}else{ %>
										<%} %>
										
										<%if( reviewImagePageList.get(z).getRenamePhoto3()!=null){ %>
										<img src="uploadFiles/<%= reviewImagePageList.get(z).getRenamePhoto3() %>" width="84" height="84">
										<%}else{ %>
										<%} %>
										
										<%if( reviewImagePageList.get(z).getRenamePhoto4()!=null){ %>
										<img src="uploadFiles/<%= reviewImagePageList.get(z).getRenamePhoto4() %>" width="84" height="84">
										<%}else{ %>
										<%} %>
										
										<%if( reviewImagePageList.get(z).getRenamePhoto5()!=null){ %>
										<img src="uploadFiles/<%= reviewImagePageList.get(z).getRenamePhoto5() %>" width="84" height="84">
										<%}else{ %>
										<%} %>
										
										</a>
									</li>
								</ul>
								
								
							<%	}else{ %>
								<div style="text-align: center">사진 없음</div>
							<%	} %>
									<div class="action">
								<%if(member !=null){ %>
									<%	if(member.getNickName().equals(reviewPageList.get(z).getNickName())){ %>
										<a href="#" id="review_updateBtn" onclick="update(<%= reviewPageList.get(z).getListNo()%>);" class="func">
											수정하기  
										</a>
										<a href="rdelete?listNo=<%= reviewPageList.get(z).getListNo()%>&storeId=<%= s.getStoreId() %>&score=<%=score %>" class="func">
											삭제하기
										</a>
										<%		
												}
											if(member.getUserId().equals("admin")){
										%>
											<a href="rdelete?listNo=<%= reviewPageList.get(z).getListNo()%>&storeId=<%= s.getStoreId() %>&score=<%=score %>" class="func">
											삭제하기
										</a>
										
										<%
												}
											}
										%>
									</div>
								</div>
							</div>
						</div>
					<%} %>
					<div id="pager">
				    	<div class="page-list">
				    	 <ul class="pagination">
				    	
				    	<% if(currentPage <= 1){ %> 
				             <li>&lt;&lt;</li>
				            <%}else{ %> 
				           	<li><a href="/easyStudy/DView?page=<%= currentPage - 1 %>&storeId=<%= s.getStoreId() %>&score=<%=score %>">&lt;&lt;</a></li>
				            <% } %> 
				          
				            
				            <% for(int p = startPage; p <= endPage; p++){ 
				                if(p == currentPage){ %> 
				                	<li class="active"><%= p %></li>
				                <%}else{ %> 
				               <li> <a href="/easyStudy/DView?page=<%= p %>&storeId=<%= s.getStoreId() %>&score=<%=score %>"><%= p %></a></li>
				                <% } %> 
				         <% } %> 
				            
				           <% if(currentPage >= maxPage){ %> 
				            	<li>&gt;&gt;</li>
				            <%}else{ %> 
				            <li><a href="/easyStudy/DView?page=<%= currentPage + 1 %>&storeId=<%= s.getStoreId() %>&score=<%=score %>">&gt;&gt;</a></li>
				            <% } %>
				            
				            </ul>
				    	</div>
				    </div>
							
					<!--reviewPageList ==null  -->		
					<% }else{ %>	
						<br>
						<div style="text-align:center">리뷰가 없습니다.</div>
							
					<%	} %>	
						</div><!-- class= review  -->
					</div><!--tab2  -->
					<!--reviewPageList ==null 끝 -->			
					<%
						if(member !=null){
							if(member.getUserId().equals("admin")){
					%>
						<div id="detail_btnAera">
						<a href="/easyStudy/StoreUpdateView?storeId=<%= s.getStoreId() %>">
						<input type="button" value="수정하기" id="detail_updateBtn"></a> &nbsp; &nbsp; 
						<a href="/easyStudy/StoreDelete?storeId=<%= s.getStoreId() %>" >
						<input type="button" value="삭제하기" id="detail_deleteBtn"></a> &nbsp; &nbsp;
						</div>
					<% 		
							} 
						}		
					%>
				</div>
			</div>
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