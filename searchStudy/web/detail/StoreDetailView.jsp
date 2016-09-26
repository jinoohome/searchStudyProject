<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="detail.model.vo.Store,detail.model.vo.Image, java.util.* , member.model.vo.*"%>
<%
	Store s=(Store)request.getAttribute("store");
	Image i=(Image)request.getAttribute("image"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/detail.css" />
<script type="text/javascript"
	src="http://maps.googleapis.com/maps/api/js?key=AIzaSyA29xkBAMN_bvriR7uE8dSqVFFwjKXZjcw"></script>
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"></script>
<link rel="stylesheet"	href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">
<script src="//code.jquery.com/jquery-1.10.2.js"></script>
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
								<span id="nav_login">로그인</span> &nbsp;|&nbsp; <span
									id="nav_join">회원가입</span>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div id="container">
			<!--배너 슬라이더 이미지 banner_warp-->
			<div id="banner_warp">
				<div class="trislider">
				
					<img src="/easyStudy/images/SC/<%=i.getPhoto1()%>">
					
					<%=i.getPhoto1()%>">.subStrig(1,<%=i.getPhoto1()%>.length -3);
				</div>
			</div>
			<div class="nav">
				<i class="icon left"></i> <i class="icon right"></i>
			</div>

			<div id="tabs">
				<div id="content_wrap">
					<div id="content" class="detail info">
						<ul class="tab">
							<li class="item selected"><a href="#tabs-1">정보</a></li>
							<li class="item"><a href="#tabs-2">포토</a></li>
							<li class="item"><a href="#tabs-3">리뷰</a></li>
						</ul>

						<!-- 정보 탭 관련 정보  -->
						<div id="tabs-1">
							<form action="DView" method="post">
								<table border="1" width="1000">
									<tr>
										<th>이 름 :</th>
										<td><%=s.getStoreName() %></td>
									</tr>
									<tr>
										<th>별 점 :</th>
										<td></td>
									</tr>
									<tr>
										<th>분 류 :</th>
										<td><%=s.getCategoryId() %></td>
									</tr>
									<th>지 역 :</th>
									
									<td><%=s.getLocalCode() %></td>
									</tr>
									<tr>
										<th>주 소 :</th>
										<td><%=s.getAddress() %></td>
									</tr>
									<tr>
										<th>사 이 트 :</th>
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