<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member, mypage.model.vo.Review, mypage.model.vo.ReviewImage, java.util.ArrayList"%>
<%
	Member member = (Member)session.getAttribute("loginUser");
	ArrayList<Review> reviewPageList = (ArrayList<Review>)request.getAttribute("list");
	ArrayList<ReviewImage> reviewImagePageList = (ArrayList<ReviewImage>)request.getAttribute("reviewImagePageList");
	
	String nickname = (String)request.getAttribute("nickname");
	int listCount = ((Integer)request.getAttribute("listCount")).intValue(); 
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 
	int maxPage =((Integer)request.getAttribute("maxPage")).intValue(); 
	int startPage = ((Integer)request.getAttribute("startPage")).intValue(); 
	int endPage = ((Integer)request.getAttribute("endPage")).intValue(); 
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
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script> <!--dialog -->
<script type="text/javascript" src="/easyStudy/js/review.js"></script>

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
<script type="text/javascript">
$(document).ready(function(){    
    $("#mypage_myreviewModify").hide();
});
</script>
<script type="text/javascript">

function clickModify(listNo){
	$("#mypage_myreviewModify").show();

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

<!-- <div id="review_loginWrap">
			<div id="review_loginModal" class="review_loginPopup" style="display: none;">
				로그인 페이지
				<div id="">
					<img>
				
				</div>
			</div>
</div> -->



<div id="wrap">
	<!-- header 시작	-->
	<div id="header">
		<!-- navigation	-->
		<div id="nav_warp_shading"></div>
		<div id="nav_wrap" class="fixed">
			<div class="container_wrap">
				<div id="nav_container" class="">
					<div id="nav_shading" class="shading_bg" style="display: none;"></div>
					<!-- logo section -->
					<a id="nav_logo" href=""><img class="logo" src="images/logo.png"></a>

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
								<span id="nav_login">로그인</span>
								&nbsp;|&nbsp;
								<span id="nav_join">회원가입</span>
							</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- header 끝	-->
	
	
	<!--<div class="menu_wrap">
			<div id="nav_menu">
			</div>
	</div>-->
	
	
	<!-- container -->
	<div id="container">
	
		<!--배너 슬라이더 이미지 banner_warp-->
		<div id="banner_warp">
			<div class="trislider">
				<div></div>
			</div>
		</div>
		<!--배너 슬라이더 이미지 banner_warp-->
		
<!-- 	-------------------------------------------------------------------------------------------- -->
				
		<div id="content_wrap">
<!-- 			content			 -->
		<div id="content" class="detail review" >
				<div  id="mypage_myreviewModify"  >
				<form action="radd" method="post" enctype="multipart/form-data" style="margin:0;" >
			<div class="body first">
				<div class="title">
					리뷰 수정하기
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
				<button type="submit" id="myreviewModifyBtn" >
					리뷰 수정하기
				</button>
			</div>
			</form>
			</div>
			<div class="review_titleWrap">
				<div class="title" id="review_title">
								Review
				</div>
			</div>
			<%	if(reviewPageList == null){%>
					<br>
					<div id="mypage_noContents">
						작성하신 리뷰가 없습니다.<br> 이용하신후 리뷰를 작성해주세요
					</div>
					<div id="mypage_noContentsgomain">
						<a href="/easyStudy/main.jsp">장소 검색하러 가기.</a>
					</div>
					<% }else{ %>	
				
			<%	for(int i = 0; i < reviewPageList.size(); i++){ %>
			
			<div class="body review list ">
				<div class="review_detail">
					
					<i class="image border_radius circle" style="display: inline-block; background-image: url(&quot;http://c4.poing.co.kr/55ea410bd820b94b140000f7.jpg&quot;);"></i>
					</a>
					<div class="user">
						<div class="name " style="font-size: 20px;">
						<%= reviewPageList.get(i).getStoreName() %>				
						</div>
						
						<%
							if(reviewPageList.get(i).getScore() == 5){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(reviewPageList.get(i).getScore() == 4.5){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(reviewPageList.get(i).getScore() == 4){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(reviewPageList.get(i).getScore() == 3.5){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(reviewPageList.get(i).getScore() == 3){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(reviewPageList.get(i).getScore() == 2.5){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(reviewPageList.get(i).getScore() == 2){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(reviewPageList.get(i).getScore() == 1.5){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(reviewPageList.get(i).getScore() == 1){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(i).getScore() %> 점</span>
						</div>
						<%
							}
						%>
						
					</div>
				
				<!--리뷰 내용 리스트  -->
					<div class="review">
						<!-- <div class="time">하루 전<br><span>하루 전 수정됨</span></div> -->
						<div class="text">
						<pre><%= reviewPageList.get(i).getContents() %></pre>
						</div>
						
					<%	if(reviewImagePageList != null){ %>
					
					
						<%-- <%	for(int j = 0; j < listRImage.size(); j++){ %>
						<%	} %> --%>
						<ul class="photo_list">
							<li class="item">
								<a class="review_loginPopupBtn" href="#review_loginModal">
							<%if(reviewImagePageList != null){ %>
							
								<%if( reviewImagePageList.get(i).getRenamePhoto1()!=null){ %>
								<img src="uploadFiles/<%= reviewImagePageList.get(i).getRenamePhoto1() %>" width="84" height="84">
								<%}else{ %>
								<%} %>
								
								<%if( reviewImagePageList.get(i).getRenamePhoto2()!=null){ %>
								<img src="uploadFiles/<%= reviewImagePageList.get(i).getRenamePhoto2() %>" width="84" height="84">
								<%}else{ %>
								<%} %>
								
								<%if( reviewImagePageList.get(i).getRenamePhoto3()!=null){ %>
								<img src="uploadFiles/<%= reviewImagePageList.get(i).getRenamePhoto3() %>" width="84" height="84">
								<%}else{ %>
								<%} %>
								
								<%if( reviewImagePageList.get(i).getRenamePhoto4()!=null){ %>
								<img src="uploadFiles/<%= reviewImagePageList.get(i).getRenamePhoto4() %>" width="84" height="84">
								<%}else{ %>
								<%} %>
								
								<%if( reviewImagePageList.get(i).getRenamePhoto5()!=null){ %>
								<img src="uploadFiles/<%= reviewImagePageList.get(i).getRenamePhoto5() %>" width="84" height="84">
								<%}else{ %>
								<%} %>
								
							<%} %>
								
								<%-- <img src="uploadFiles/<%= listRImage.get(i+1).getRenamePhoto1() %>" width="84" height="84"> --%>
								<%-- <img src="uploadFiles/<%= listRImage.get(i+2).getRenamePhoto1() %>" width="84" height="84"> --%>
								<%-- <img src="uploadFiles/<%= listRImage.get(i+3).getRenamePhoto1() %>" width="84" height="84"> --%>
								<%-- <img src="uploadFiles/<%= listRImage.get(i+4).getRenamePhoto1() %>" width="84" height="84"> --%>
								</a>
							</li>
						</ul>
						
						
					<%	}else{ %>
						<div style="text-align: center"><br>사진 없음</div>
					<%	} %>
					
						<%	if(true){ %>
						<div id="mypage_modifyNdelbtns">
							<div>
							<a href="rdelete?listNo=<%= reviewPageList.get(i).getListNo()%>" class="func">
							<button class="mypage_btns">삭제하기</button>
							</a> 
							<a href="#" class="modify" id="review_updateBtn" onclick="clickModify(<%= reviewPageList.get(i).getListNo()%>);">
								<button class="mypage_btns">수정하기</button>
							</a>
							</div>
						</div>
						<%	} %>
						
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
			
			
				<%		} %>
				
				<%-- <%	if(list.size() > 5){ %>
				<div id="review_pagination">
					<div class="page-list">
						<ul class="pagination" onselectstart="return false;">
							<li class="prevAll">&lt;&lt;</li>
							<li class="prev">&lt;</li>
							<li class="page active" data-page="1">1</li>
							<li class="page" data-page="2">2</li>
							<li class="page" data-page="3">3</li>
							<li class="page" data-page="4">4</li>
							<li class="page" data-page="5">5</li>
							<li class="next">&gt;</li>
							<li class="nextAll">&gt;&gt;</li>
						</ul>
					</div>
				</div>
				<%	} %> --%>
				
				
				
				<div id="pager">
			    	<div class="page-list">
			    	 <ul class="pagination">
			    	
			    	<% if(currentPage <= 1){ %> 
			             <li>&lt;&lt;</li>
			            <%}else{ %> 
			           	<li><a href="/easyStudy/mreview?nickname=<%=nickname %>&page=<%= currentPage - 1 %>">&lt;&lt;</a></li>
			            <% } %> 
			          
			            
			            <% for(int p = startPage; p <= endPage; p++){ 
			                if(p == currentPage){ %> 
			                	<li class="active"><%= p %></li>
			                <%}else{ %> 
			               <li> <a href="/easyStudy/mreview?nickname=<%=nickname %>&page=<%= p %>"><%= p %></a></li>
			                <% } %> 
			            <% } %> 
			            
			 			
			            <% if(currentPage >= maxPage){ %> 
			            	<li>&gt;&gt;</li>
			            <%}else{ %> 
			            <li><a href="/easyStudy/mreview?nickname=<%=nickname %>&page=<%= currentPage + 1 %>">&gt;&gt;</a></li>
			            <% } %>
			            
			            </ul>
			    	</div>
			    </div>
				
				
				
				
				
				
				<%	} %>
				
				
				
				
				
				<!-- pagination 위치 -->
		</div>
			
			
			
			<!--  sidebar_wrap 		-->
			<!--  sidebar_wrap 끝	-->			
			
		</div>
		<!-- content_wrap 끝 	-->
<!-- 	-------------------------------------------------------------------------------------------- -->
	</div>
	<!-- container 끝   -->
	
	<!-- foot_wrap -->
	<!-- popup_wrap -->
	<!-- fb_root 	-->
	
</div>
<!-- 	wrap 끝	 -->




	
</body>
</html>