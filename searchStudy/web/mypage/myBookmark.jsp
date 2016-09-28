<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member, mypage.model.vo.SearchStore, java.util.ArrayList"%>
<%
	Member member = (Member)session.getAttribute("member");
	ArrayList<SearchStore> list = (ArrayList<SearchStore>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<link rel="stylesheet" type="text/css" href="/easyStudy/css/main.css"/>
<link rel="stylesheet" type="text/css" href="/easyStudy/css/layout.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/function.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/review.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/star.css">
 <script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"> </script>
 <script type="text/javascript" src="/easyStudy/js/navigation.js"> </script>
 <script type="text/javascript" src="/easyStudy/js/jquery.leanModal.min.js"></script>

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
			<div id="mypage_bookmark">
			<div id="mypage_bookmarkList">
			<% if(list.size() != 0){ %>
			 <%for(int i=0; i<list.size(); i++){ %>
				          
                <%if(i%3==0){ %>
             <div class="element medium first ">
                  
                  <a href="#" class="image" style="background-image: url(<%=list.get(i).getImgRoute() %>);">
            
                    <div class="shading"></div>
        			<div class="top"> 
        				<button class="" onclick="return false;" tabindex="-1">
                    		<div class="icon favorite" id="mypageGo<%=list.get(i).getStoreId() %>"></div>
                		</button>
            			</div>
<script type="text/javascript">
$(document).ready(function() {
	
	$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
	
	$("#mypageGo<%=list.get(i).getStoreId() %>").click(function(){
				if(confirm("즐겨찾기에 해지하시겠습니까?")){ //해지
						location.href="/easyStudy/mbookmarkdel?userid=<%=member.getUserId() %>&storeid=<%=list.get(i).getStoreId() %>";
				}else{
					return false;
				}
	});

});
</script>            			
                       <div class="mypage_bottom">
                                <span class="name"><%=list.get(i).getStoreName() %></span>                
                                <span class="area"><%=list.get(i).getLocalName() %>/<%=list.get(i).getCategoryName() %></span>            
                        </div>
                  </a>

                     <div class="desc">
                            <div class="place_info">
                                <div class="rating">
                                    <div class="stars">
                                       <span class="star odd"></span>
                                       <span class="star even"></span>
                                       <span class="star odd"></span>
                                       <span class="star even"></span>
                                       <span class="star odd"></span>
                                       <span class="star even"></span>
                                       <span class="star odd"></span>
                                       <span class="star even"></span>
                                       <span class="star odd "></span>
                                       <span class="star even "></span>
                                    </div>
                                  <div class="grade"><%=list.get(i).getScore() %></div>
                              </div>
                             <div class="budget">금액 : <%=list.get(i).getPrice() %></div>                    
                             <div class="comment">전화번호 : <%=list.get(i).getHomepage() %> </div>           
                           </div>
                       </div>
          </div>
          
             <%}else{ %>
                <div class="element medium">
                  <a href="#" class="image" style="background-image: url(<%=list.get(i).getImgRoute() %>);">
                    <div class="shading"></div>
        				<div class="top"> 
        				<button class="" onclick="return false;" tabindex="-1">
                    		<div class="icon favorite " id="mypageGo<%=list.get(i).getStoreId() %>"></div>
                		</button>
            			</div>        
<script type="text/javascript">
$(document).ready(function() {
	
	$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
	
	$("#mypageGo<%=list.get(i).getStoreId() %>").click(function(){
				if(confirm("즐겨찾기에 해지하시겠습니까?")){ //해지
						location.href="/easyStudy/mbookmarkdel?userid=<%=member.getUserId() %>&storeid=<%=list.get(i).getStoreId() %>";
				}else{
					return false;
				}
	});

});
</script>                     			
                       <div class="mypage_bottom">
                                <span class="name"><%=list.get(i).getStoreName() %></span>                
                                <span class="area"><%=list.get(i).getLocalName() %>/<%=list.get(i).getCategoryName() %></span>            
                        </div>
                  </a>

                     <div class="desc">
                            <div class="place_info">
                                <div class="rating">
                                    <div class="stars">
                                       <span class="star odd"></span>
                                       <span class="star even"></span>
                                       <span class="star odd"></span>
                                       <span class="star even"></span>
                                       <span class="star odd"></span>
                                       <span class="star even"></span>
                                       <span class="star odd"></span>
                                       <span class="star even"></span>
                                       <span class="star odd "></span>
                                       <span class="star even "></span>
                                    </div>
                                  <div class="grade"><%=list.get(i).getScore() %></div>
                              </div>
                             <div class="budget">금액 : <%=list.get(i).getPrice() %></div>                    
                             <div class="comment">전화번호 : <%=list.get(i).getHomepage() %> </div>
                           </div>
                       </div>
          </div>
             <%} %>
          <%}}else{ %>
   			 <div id="mypage_noContents">
   			  	등록하신 즐겨찾기가 없습니다.<br>
   			  	즐겨찾기를 등록해 주세요.<br>
   			 </div>
   			 <div id="mypage_noContentsgomain">
   			  	<a href="/easyStudy/index.jsp">장소 검색하러 가기.</a>
   			  </div>
			<%} %>
			</div>
		</div>
		</div>
</body>
</html>