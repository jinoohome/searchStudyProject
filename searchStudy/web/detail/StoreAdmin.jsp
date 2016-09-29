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
 <link rel="stylesheet" href="css/main.css" type="text/css"/>
 <link rel="stylesheet" href="css/layout.css" type="text/css">  
 <link rel="stylesheet" href="css/function.css" type="text/css"> 
 <script type="text/javascript" src="js/jquery-3.1.0.min.js"> </script>
 <script type="text/javascript" src="js/navigation.js"> </script>
 <script type="text/javascript" src="js/jquery.leanModal.min.js"></script> <!--dialog -->
<script type="text/javascript" src="/easyStudy/js/navigation.js">
	
</script>
<title>Admin</title>

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
							<a id="nav_logo" href="index.jsp"><img class="logo"	src="images/logo.png"></a>

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
									<img src="images/down_arrow.png" class="searchbox arrow">
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
									<img src="images/down_arrow.png" class="searchbox arrow">
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

				<div id="banner">
					<div class="trislider">
						<div class="pieces" data-index="0" data-max="5"
							style="left: -1700px; display: block;">
							<a href="" class="piece"
								style="background-image: url(images/main1.jpg);"></a> <a href=""
								class="piece" style="background-image: url(images/main2.jpg)"></a>
							<a href="" class="piece"
								style="background-image: url(images/main3.jpg)"></a> <a href=""
								class="piece" style="background-image: url(images/main4.jpg)"></a>
							<a href="" class="piece"
								style="background-image: url(images/main5.jpg)"></a>

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
							<img class="left" alt="icon" src="images/left_arrow.png" /> <img
								class="right" alt="icon" src="images/right_arrow.png" />
						</div>
					</div>
				</div>
			</div>
			<!--배너 슬라이더 이미지 banner_warp-->

			<div id="content_wrap">

				<div id="content" class="detail info">
					<ul class="tab">
						<li class="item selected"><a>관리자</a></li>
					</ul>
					<br> <br> <br> <br>


					<%
						if (s != null) {
					%>


					<form action="StoreUpdate?storeId=<%=s.getStoreId()%>"
						method="post" enctype="multipart/form-data">
						<table border="1" cellspacing="0" width="500">

							<tr>
								<th>이 름 :</th>
								<td><input type="text" name="name"
									value="<%=s.getStoreName()%>"></td>
							</tr>
							<tr>
								<th>별 점 :</th>
								<td><input type="text" name="star" value=""></td>
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
								<th colspan="2"></th>
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

					<form action="../StoreAdd" method="post"
						enctype="multipart/form-data">
						<table border="1" cellspacing="0" width="500">

							<tr>
								<th>이 름 :</th>
								<td><input type="text" name="name" value=""></td>
							</tr>

							<tr>
								<th>별 점 :</th>
								<td><input type="text" name="star" value=""></td>
							</tr>
							<tr>
								<th>분 류 :</th>
								<td><input type="text" name="group" value=""></td>
							</tr>
							<tr>
								<th>지 역 :</th>
								<td><input type="text" name="local" value=""></td>
							</tr>
							<tr>
								<th>주 소 :</th>
								<td><input type="text" name="address" value=""></td>
							</tr>
							<tr>
								<th>사 이 트 :</th>
								<td><input type="text" name="site" value=""></td>
							</tr>
							<tr>
								<th>평일 영업 :</th>
								<td><input type="text" name="daytime" value=""></td>
							</tr>
							<tr>
								<th>주말 영업 :</th>
								<td><input type="text" name="endtime" value=""></td>
							</tr>
							<tr>
								<th>가 격 :</th>
								<td><input type="text" name="price" value=""></td>
							</tr>
							<tr>
								<th>전화번호 :</th>
								<td><input type="text" name="tell" value=""></td>
							</tr>
							<tr>
								<th>비 고 :</th>
								<td><textarea name="etc" rows="5" cols="50"></textarea></td>
							</tr>

							<tr>
								<th colspan="2"></th>
							</tr>

							<tr>
								<th>첨부파일</th>

								<td id="farea">&nbsp; &nbsp; &nbsp; &nbsp; <input
									type="button" id="fileadd" value="파일추가">
								</td>

							</tr>


						</table>

						<input type="submit" value="등록하기"> &nbsp; &nbsp;
					</form>

					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>

</body>
</html>