<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member, mypage.model.vo.Review, mypage.model.vo.ReviewImage, java.util.ArrayList"%>
<%
	Member member = (Member)session.getAttribute("loginUser");
	ArrayList<Review> list = (ArrayList<Review>)request.getAttribute("list");
	ArrayList<ReviewImage> reviewImagePageList = (ArrayList<ReviewImage>)request.getAttribute("reviewImagePageList");
	
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
<link rel="stylesheet" type="text/css" href="/easyStudy/css/layout.css" >
<link rel="stylesheet" type="text/css" href="/easyStudy/css/star.css" >
<link rel="stylesheet" type="text/css" href="/easyStudy/css/review.css" >
 <script type="text/javascript" src="js/jquery-3.1.0.min.js"> </script>
<title>main</title>
<script>

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
					<ul class="search_catagory content">
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
						<%}else{ %>
							<span id="nav_login" ><a class="main_loginPopupBtn" href="#main_loginModal">로그인</a></span>
							&nbsp;|&nbsp;
						<%} %>	
							<span id="nav_join"><a class="main_joinPopupBtn" href="#main_joinModal">회원가입</a></span>
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
						<%=member.getNickName() %>님  &nbsp; &nbsp; &nbsp;
						<a href="/easyStudy/mmanagement?page=1">회원 관리</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<a href="#">글쓰기</a>		
					<%}else{ %>		
						<%=member.getNickName() %>님  &nbsp; &nbsp; &nbsp;
						<a href="/easyStudy/mbookmark?userid=<%=member.getUserId() %>">즐겨찾기</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<a href="/easyStudy/mreview?page=1&nickname=<%=member.getNickName() %>">내가 쓴 리뷰</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<a href="/easyStudy/mypage/myinfo.jsp">내 정보 변경</a> 		
					<%}
				}else{} %>
			
			</div>
		</div>
	</div>
	</div>
	<!--<div class="menu_wrap">
			<div id="nav_menu">
			</div>
	</div>-->
		<div id="container">
				<div id="mypage_myreview">
						<div id="content_wrap">
<!-- 			content			 -->
		<div id="content" class="detail review">
		<%	if(list == null){%>
					<br>
					<div id="mypage_noContents"> 작성하신 리뷰가 없습니다.<br>
						이용하신후 리뷰를 작성해주세요</div>
					<div id="mypage_noContentsgomain">
   			  	<a href="/easyStudy/main.jsp">장소 검색하러 가기.</a>
   			  </div>
					
			<% }else{ %>	
				
			<div class="review_titleWrap">
			
				<div class="title" id="review_title">
								MY Review
				</div>
			</div>
			
			<%	for(int i = 0; i < list.size(); i++){ %>
			
			<div class="body review list ">
				<div class="review_detail">
				
					<div class="user">
						<div class="mypage_myriewStore">
						</div>
						<div class="name ">
						<a href="#"><%= list.get(i).getNickName() %></a>									
						</div>
						
						
						
						<%
							if(list.get(i).getScore() == 5){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= list.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(list.get(i).getScore() == 4.5){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= list.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(list.get(i).getScore() == 4){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= list.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(list.get(i).getScore() == 3.5){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= list.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(list.get(i).getScore() == 3){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= list.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(list.get(i).getScore() == 2.5){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= list.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(list.get(i).getScore() == 2){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= list.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(list.get(i).getScore() == 1.5){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= list.get(i).getScore() %> 점</span>
						</div>
						<%
							}else if(list.get(i).getScore() == 1){
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
							<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= list.get(i).getScore() %> 점</span>
						</div>
						<%
							}
						%>
						
					</div>
				
				<!--리뷰 내용 리스트  -->
								<div class="review">
									<div class="text">
										<pre><%= list.get(i).getContents() %></pre>
									</div>

									<%	if(reviewImagePageList != null){ %>


									<%-- <%	for(int j = 0; j < listRImage.size(); j++){ %>
						<%	} %> --%>
									<ul class="photo_list">
										<li class="item"><a class="review_loginPopupBtn"
											href="#review_loginModal"> <%if(reviewImagePageList != null){ %>

												<%if( reviewImagePageList.get(i).getRenamePhoto1()!=null){ %>
												<img
												src="uploadFiles/<%= reviewImagePageList.get(i).getRenamePhoto1() %>"
												width="84" height="84"> <%}else{ %> <%} %> <%if( reviewImagePageList.get(i).getRenamePhoto2()!=null){ %>
												<img
												src="uploadFiles/<%= reviewImagePageList.get(i).getRenamePhoto2() %>"
												width="84" height="84"> <%}else{ %> <%} %> <%if( reviewImagePageList.get(i).getRenamePhoto3()!=null){ %>
												<img
												src="uploadFiles/<%= reviewImagePageList.get(i).getRenamePhoto3() %>"
												width="84" height="84"> <%}else{ %> <%} %> <%if( reviewImagePageList.get(i).getRenamePhoto4()!=null){ %>
												<img
												src="uploadFiles/<%= reviewImagePageList.get(i).getRenamePhoto4() %>"
												width="84" height="84"> <%}else{ %> <%} %> <%if( reviewImagePageList.get(i).getRenamePhoto5()!=null){ %>
												<img
												src="uploadFiles/<%= reviewImagePageList.get(i).getRenamePhoto5() %>"
												width="84" height="84"> <%}else{ %> <%} %> <%} %> <%-- <img src="uploadFiles/<%= listRImage.get(i+1).getRenamePhoto1() %>" width="84" height="84"> --%>
												<%-- <img src="uploadFiles/<%= listRImage.get(i+2).getRenamePhoto1() %>" width="84" height="84"> --%>
												<%-- <img src="uploadFiles/<%= listRImage.get(i+3).getRenamePhoto1() %>" width="84" height="84"> --%>
												<%-- <img src="uploadFiles/<%= listRImage.get(i+4).getRenamePhoto1() %>" width="84" height="84"> --%>
										</a></li>
									</ul>


									<%	}else{ %>
									<div style="text-align: center">사진 없음</div>
									<%	} %>
									<br>
									<br>
									<div id="mypage_reviewButtonDiv">
										<div  id="mypage_reviewButton">
											<a	href="rdelete?listNo=<%=list.get(i).getListNo()%>&storeId=<%=list.get(i).getStoreId()%>" class="func"> 
												<input type="button" class="reviewBtn"
												value="삭제하기">
											</a> 
											<a href="rupdate?listNo=<%=list.get(i).getListNo()%>&storeId=<%=list.get(i).getStoreId()%>" class="func"> 
												<input type="button" class="reviewBtn" value="수정하기">
											</a>
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
			
			
				<%		} %>
				
				<%	if(list.size() > 5){ %>
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
				<%	} %> 
				
					<div id="pager">
			    	<div class="page-list">
			    	 <ul class="pagination">
			    	
			    	<% if(currentPage <= 1){ %> 
			             <li>&lt;&lt;</li>
			            <%}else{ %> 
			           	<li><a href="/easyStudy/mreview?page=<%= currentPage - 1 %>&nickname=<%=member.getNickName() %>">&lt;&lt;</a></li> 
			            <% } %> 
			            <% for(int p = startPage; p <= endPage; p++){ 
			                if(p == currentPage){ %> 
			                	<li class="active"><%= p %></li>
			                <%}else{ %> 
			             <li> <a href="/easyStudy/mreview?page=<%= p %>&nickname=<%=member.getNickName() %>"><%= p %></a></li> 
			                <% } %> 
			            <% } %> 
			            <% if(currentPage >= maxPage){ %> 
			            	<li>&gt;&gt;</li>
			            <%}else{ %> 
			            <li><a href="/easyStudy/mreview?page=<%=currentPage + 1 %>&nickname=<%=member.getNickName() %>">&gt;&gt;</a></li> 
			            <% } %>
			            
			            </ul>
			    	</div>
			    </div>
				
				<%	} %>
				
		</div>
			
		</div>		

		</div>
		</div>
</body>
</html>