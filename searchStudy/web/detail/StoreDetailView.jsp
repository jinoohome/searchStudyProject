<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="review.model.vo.Review, review.model.vo.ReviewImage" %>
<%@ page
	import="detail.model.vo.Store,detail.model.vo.Image, java.util.* , member.model.vo.*"%>
<%
	Store s=(Store)request.getAttribute("store");
	Image i=(Image)request.getAttribute("image"); 
	Member member = (Member)session.getAttribute("member");
	ArrayList<Review> list = (ArrayList<Review>)request.getAttribute("list");
	ArrayList<ReviewImage> listRImage = (ArrayList<ReviewImage>)request.getAttribute("listRImage");
	
	int score = (Integer)request.getAttribute("score");
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();	//현재 페이지
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int listRCount = ((Integer)request.getAttribute("listRCount")).intValue(); //해당하는 storeId에 대한 총 리뷰 수
	ArrayList<Review> reviewPageList = (ArrayList<Review>)request.getAttribute("reviewPageList");
	ArrayList<ReviewImage> reviewImagePageList = (ArrayList<ReviewImage>)request.getAttribute("reviewImagePageList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/main.css" >
<link rel="stylesheet" type="text/css" href="/easyStudy/css/review.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/star.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/detail.css" > 
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"> </script>
<script type="text/javascript" src="/easyStudy/js/navigation.js"> </script>
<script type="text/javascript" src="/easyStudy/js/jquery.leanModal.min.js"></script> <!--dialog -->
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyA29xkBAMN_bvriR7uE8dSqVFFwjKXZjcw"></script>
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script type="text/javascript" src="/easyStudy/js/review.js"></script>


<title>DetailView</title>
<!-- GoogoleMap Asynchronously Loading the API ********************************************* -->
<script type="text/javascript">
/*WebStorge 로그인 상태저장 */
<%-- $.fnWebStorge = function() {
		var storeId = <%=s.getStoreId()%>;
		var StoreMainImg = <%=i.getPhoto1()%>;
		if(id.length != 0 && password !=0){
			localStorage.setItem(storeId, StoreMainImg);
		}

}
 --%>
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
  $(function() {
    /* $("#tabs").tabs(); */
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
function update(listNo){
	alert("sssss : " + listNo );
	//alert("dddd : " + contents );
	
	/* $("#upBtn").hide();
	$("#modiBtn").show(); */
	$.ajax({
		url : "rupdate",
		data : {listNo : listNo},
		type : "post",
		dataType : "json", //명시해줘야 data를 json 타입으로 받아준다.
		success : function(data){
			alert(data.listNo + ", " + data.score + ", " + data.contents);
			
			//
			$("#itemPhoto").hide();
			
			//내용			
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
			
			
			//console.log("ffffffffffffffff : " + data.renamePhoto1);
			//readURL("E:\server workspace\easyStudy-1\web\uploadFiles" + data.renamePhoto1);
			
			/*
			if(data.renamePhoto1 != null){
				
				//$("#AA").append($("<input type='file' multiple name='reviewPhoto1' id='upBtn1_1' class='' value= '" + data.renamePhoto1 + "'/>"));
				//$("#upBtn1_1").attr('files', data.renamePhoto1);
				
				/* var fName = "E:\\server workspace\\easyStudy-1\\web\\uploadFiles\\" + data.renamePhoto1;
				var ext = data.renamePhoto1.split(".").pop();
				console.log(ext);
				
				ext.toLowerCase();
				
				if(ext.length > 0){
					//if($.inArray(ext, ["gif","png","jpg","jpeg"]) == -1) { 
					if($.inArray(ext,['gif','png','jpg','jpeg']) == -1) { 
						alert("gif,png,jpg 파일만 업로드 할수 있습니다.");
						this.value = "";
						return;  
					} else {
						readURL(fName);	
					}	
				}
			}
			*/

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
			//if($.inArray(ext, ["gif","png","jpg","jpeg"]) == -1) { 
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
					<div><%=s.getLocalName() %> / <%=s.getCategoryName() %></div>
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
						    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto1() %>);"></a>
						    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto2() %>)"></a>
						    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto3() %>)"></a>
						    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto4() %>)"></a>
						    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto5() %>)"></a>
										    		    		
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
							<form action="radd?storeId=<%=s.getStoreId() %>" method="post" enctype="multipart/form-data" style="margin:0;" >
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
											<div class="name">
												자세하게 써주세요
											</div>
											<div class="detail">
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
					
								<div class="body review write">
									<button type="submit" class="border_radius soft" id="AA">
										리뷰 올리기
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
							<a class="i_wrap" href="/timeline/50b6dc12d20c781e6700004b">
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
								<%if(member !=null){ %>
									<%	if(member.getNickName().equals(reviewPageList.get(z).getNickName())){ %>
									<div class="action">
										<a href="rdelete?listNo=<%= reviewPageList.get(z).getListNo()%>&storeId=<%= s.getStoreId() %>" class="func">
											삭제하기
										</a>
										<a href="#" class="modify" id="review_updateBtn" onclick="update(<%= reviewPageList.get(z).getListNo()%>);">
															
											수정하기  
										</a>
									</div>
								<%		} 
									}
								%>
								
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
				           	<li><a href="/easyStudy-1/rlist?page=<%= currentPage - 1 %>&storeId=<%= s.getStoreId() %>">&lt;&lt;</a></li>
				            <% } %> 
				          
				            
				            <% for(int p = startPage; p <= endPage; p++){ 
				                if(p == currentPage){ %> 
				                	<li class="active"><%= p %></li>
				                <%}else{ %> 
				               <li> <a href="/easyStudy-1/rlist?page=<%= p %>&storeId=<%= s.getStoreId() %>"><%= p %></a></li>
				                <% } %> 
				            <% } %> 
				            
				 			
				            <% if(currentPage >= maxPage){ %> 
				            	<li>&gt;&gt;</li>
				            <%}else{ %> 
				            <li><a href="/easyStudy-1/rlist?page=<%= currentPage + 1 %>&storeId=<%= s.getStoreId() %>">&gt;&gt;</a></li>
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
</div>

	<!-- 리뷰페이지 사진 클릭시 다이얼로그  -->
	<div id="review_loginWrap">
		<div id="review_loginModal" class="review_loginPopup" style="display: none;">
			로그인 페이지
			<div id="review_model">
				<img>
			</div>
		</div>
	</div>
</body>
</html>