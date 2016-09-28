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
	
	System.out.println("Asdfasdf" + nickname);
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
 <script type="text/javascript" src="js/jquery-3.1.0.min.js"> </script>
 <script type="text/javascript" src="js/navigation.js"> </script>
 <script type="text/javascript" src="js/jquery.leanModal.min.js"></script>

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
	

</style>
</head>

<body>
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
			<div class="review_titleWrap">
				<div class="title" id="review_title">
								Review
				</div>
			</div>
			<%	if(reviewPageList == null){%>
					<br>
					<div id="mypage_noContents">
						해당 회원이 작성한 리뷰가 존재하지 않습니다.
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
							</div>
						</div>
						<%	} %>
						
					</div>
				</div>
			</div>
			
			
				<%		} %>
				
				
				
				
				<div id="pager">
			    	<div class="page-list">
			    	 <ul class="pagination">
			    	
			    	<% if(currentPage <= 1){ %> 
			             <li>&lt;&lt;</li>
			            <%}else{ %>
			           	<li><a href="/easyStudy/ureview?nickname=<%=nickname %>&page=<%= currentPage - 1 %>">&lt;&lt;</a></li>
			            <% } %> 
			          
			            
			            <% for(int p = startPage; p <= endPage; p++){ 
			                if(p == currentPage){ %> 
			                	<li class="active"><%= p %></li>
			                <%}else{ %> 
			               <li> <a href="/easyStudy/ureview?nickname=<%=nickname %>&page=<%= p %>"><%= p %></a></li>
			                <% } %> 
			            <% } %> 
			            
			 			
			            <% if(currentPage >= maxPage){ %> 
			            	<li>&gt;&gt;</li>
			            <%}else{ %> 
			            <li><a href="/easyStudy/ureview?nickname=<%=nickname %>&page=<%= currentPage + 1 %>">&gt;&gt;</a></li>
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