<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="detail.model.vo.Store, java.util.* , member.model.vo.*" %>
<%
	Store s=(Store)request.getAttribute("store");
	System.out.println(s);
/* Image i=(Image)request.getAttribute("image"); */

%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css"
	href="/easyStudy/css/detail.css">
<script type="text/javascript"
	src="/easyStudy/js/jquery-3.1.0.min.js">
	
</script>
<title>Admin</title>
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
						<a id="nav_logo" href=""><img class="logo"
							src="images/logo.png"></a>

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
			</div>
		</div>

		<div id="container">
			<!--배너 슬라이더 이미지 banner_warp-->
			<div id="banner_warp">
				<div class="trislider">
					<div style="width: 850px; height: 420px; background: green;"></div>
				</div>
			</div>


			<div id="content_wrap">

				<div id="content" class="detail info">
					<ul class="tab">
						<li class="item selected"><a>관리자</a></li>
					</ul>
					<br>
					<br>
					<br>
					<br>
					
					
					<% if(s.getStoreId() != null){%>
					
					
					<form action="StoreUpdate?storeId=<%=s.getStoreId() %>" method="post" enctype="multipart/form-data">
						<table border="1" cellspacing="0" width="500">

						<tr>
						<th>이 름 :</th>
						<td><input type ="text" name="name" value="<%=s.getStoreName() %>"></td>
						</tr>
						<tr>
							<th>별 점 :</th>
							<td><input type ="text" name="star" value=""></td>
						</tr>
						<tr>
							<th>분 류 :</th>
							<td><input type ="text" name="group" value="<%=s.getCategoryId() %>"></td>
						</tr>
						<tr>
							<th>지 역 :</th>
							<td><input type ="text" name="local" value="<%=s.getLocalCode() %>"></td>
						</tr>
						<tr>
							<th>주 소 :</th>
							<td><input type ="text" name="address" value="<%=s.getAddress() %>"></td>
						</tr>
						<tr>
							<th>사 이 트 :</th>
							<td><input type ="text" name="site" value="<%=s.getHomepage() %>"></td>
						</tr>
						<tr>
							<th>평일 영업 :</th>
							<td><input type ="text" name="daytime" value="<%=s.getWeekDayTime() %>"></td>
						</tr>
						<tr>
							<th>주말 영업 :</th>
							<td><input type ="text" name="endtime" value="<%=s.getWeekEndTime() %>"></td>
						</tr>
						<tr>
							<th>가 격 :</th>
							<td><input type ="text" name="price" value="<%=s.getPrice() %>"></td>
						</tr>
						<tr>
							<th>전화번호 :</th>
							<td><input type ="text" name="tell" value="<%=s.getTell() %>"></td>
						</tr>
						<tr>
							<th>비 고 :</th>
							<td><input type ="text" name="etc" rows="5" cols="50" value="<%=s.getEtc() %>"></td>
						</tr>
											
							<tr>
								<th colspan="2"></th>
							</tr>

							<tr>
								<th>첨부파일</th>

								<td id="farea">&nbsp; &nbsp; &nbsp; &nbsp; <input
									type="button" id="fileadd" value="파일추가" >
								</td>

							</tr>


						</table>
						

						<input type="submit" value="수정하기"> &nbsp; &nbsp;
					</form>
					
					
					<%} else{%>

					<form action="../StoreAdd" method="post" enctype="multipart/form-data">
						<table border="1" cellspacing="0" width="500">

						<tr>
						<th>이 름 :</th>
						<td><input type ="text" name="name" value=""></td>
						</tr>
						
						<tr>
							<th>별 점 :</th>
							<td><input type ="text" name="star" value=""></td>
						</tr>
						<tr>
							<th>분 류 :</th>
							<td><input type ="text" name="group" value=""></td>
						</tr>
						<tr>
							<th>지 역 :</th>
							<td><input type ="text" name="local" value=""></td>
						</tr>
						<tr>
							<th>주 소 :</th>
							<td><input type ="text" name="address" value=""></td>
						</tr>
						<tr>
							<th>사 이 트 :</th>
							<td><input type ="text" name="site" value=""></td>
						</tr>
						<tr>
							<th>평일 영업 :</th>
							<td><input type ="text" name="daytime" value=""></td>
						</tr>
						<tr>
							<th>주말 영업 :</th>
							<td><input type ="text" name="endtime" value=""></td>
						</tr>
						<tr>
							<th>가 격 :</th>
							<td><input type ="text" name="price" value=""></td>
						</tr>
						<tr>
							<th>전화번호 :</th>
							<td><input type ="text" name="tell" value=""></td>
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
									type="button" id="fileadd" value="파일추가" >
								</td>

							</tr>


						</table>

						<input type="submit" value="등록하기"> &nbsp; &nbsp;
					</form>
					
<%} %>
				</div>
			</div>
		</div>
	</div>
</body>
</html>