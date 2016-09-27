<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="detail.model.vo.Store, java.util.* , member.model.vo.*" %>
<%
	Store s=(Store)request.getAttribute("store");
	Member member = (Member)session.getAttribute("member");
/* Image i=(Image)request.getAttribute("image"); */

%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/easyStudy/css/main.css" type="text/css"/>
<link rel="stylesheet" href="/easyStudy/css/layout.css" type="text/css">  
<link rel="stylesheet" href="/easyStudy/css/function.css" type="text/css"> 
<link rel="stylesheet" type="text/css"	href="/easyStudy/css/detail.css">
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"> </script>
<script type="text/javascript" src="/easyStudy/js/navigation.js"> </script>
<title>Admin</title>

</head>
<body>
	<div id="wrap">
		<div id="header">


					<div id="content_wrap">

						<div id="content" class="detail info">
							<ul class="tab">
								<li class="item selected"><a>관리자</a></li>
							</ul>
							<br> <br> <br> <br>


							<%
								if (s.getStoreId() != null) {
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
										<td><input type="text" name="tell"
											value="<%=s.getTell()%>"></td>
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

							<%} %>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>