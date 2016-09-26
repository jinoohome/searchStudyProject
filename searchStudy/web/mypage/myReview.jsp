<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="mypage.model.vo.Member, mypage.model.vo.Review, mypage.model.vo.ReviewImage, java.util.ArrayList"%>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
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
					<div id="nav_container" class="">
						<div id="nav_shading" class="shading_bg" style="display: none;"></div>
						<!-- logo section -->
						<a id="nav_logo" href="/easyStudy/main.jsp"><img class="logo"
							src="/easyStudy/images/logo.png"></a>

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
				<div id="mymenu">
					<!--마이페이지 메뉴 -->
					<div id="mymenu_in">
						<%
							//일반회원모드
						%>
						<a href="/easyStudy/mypage/myBookmark.jsp">즐겨찾기</a> &nbsp; &nbsp;
						&nbsp; &nbsp; &nbsp; &nbsp; <a
							href="/easyStudy/mypage/myReview.jsp">내가 쓴 리뷰</a> &nbsp; &nbsp;
						&nbsp; &nbsp; &nbsp; &nbsp; <a href="/easyStudy/mypage/myinfo.jsp">내
							정보 변경</a> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
						<%
							//관리자 모드
						%>
						<a href="/easyStudy/mmanagement">회원 관리</a> &nbsp; &nbsp; &nbsp;
						&nbsp; &nbsp; &nbsp; <a href="#">글쓰기</a>
					</div>
				</div>
			</div>
		</div>
		<div id="container">
				<div id="mypage_myreview">
						<div id="content_wrap">
<!-- 			content			 -->
		<div id="content" class="detail review">
		
			<div class="review_titleWrap">
				<div class="title" id="review_title">
								MY Review
				</div>
			</div>
			<%	if(list == null){%>
					<br>
					<div style="text-align:center">리뷰가 없습니다.</div>
					
			<% }else{ %>	
				
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
						<div style="text-align: center">사진 없음</div>
					<%	} %>
					<br><br>
					<%	if(loginUser.getNickName().equals(list.get(i).getNickName())){ %>
						<div class="mypage_reviewButton">
						<div>
 						<a href="rdelete?listNo=<%= list.get(i).getListNo()%>&storeId=<%=list.get(i).getStoreId()  %>" class="func">
								<input type="button"  class="reviewBtn" value="삭제하기">
							</a>
							<a href="rupdate?listNo=<%= list.get(i).getListNo()%>&storeId=<%=list.get(i).getStoreId()  %>" class="func">
								<input type="button" class="reviewBtn" value="수정하기">
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
			           	<li><a href="/easyStudy/mreview?page=<%= currentPage - 1 %>&nickname=<%=loginUser.getNickName() %>">&lt;&lt;</a></li> 
			            <% } %> 
			            <% for(int p = startPage; p <= endPage; p++){ 
			                if(p == currentPage){ %> 
			                	<li class="active"><%= p %></li>
			                <%}else{ %> 
			             <li> <a href="/easyStudy/mreview?page=<%= p %>&nickname=<%=loginUser.getNickName() %>"><%= p %></a></li> 
			                <% } %> 
			            <% } %> 
			            <% if(currentPage >= maxPage){ %> 
			            	<li>&gt;&gt;</li>
			            <%}else{ %> 
			            <li><a href="/easyStudy/mreview?page=<%=currentPage + 1 %>&nickname=<%=loginUser.getNickName() %>">&gt;&gt;</a></li> 
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