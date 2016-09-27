<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.model.vo.Member" %>
<%@ page import="store.model.vo.SearchStore, java.util.*" %>
<% Member member = (Member)session.getAttribute("member"); %>
<%
	ArrayList<SearchStore> list = (ArrayList<SearchStore>)request.getAttribute("list");

	String areaW = (String)request.getAttribute("area");
	String categoryW = (String)request.getAttribute("category");
	int listCount = ((Integer)request.getAttribute("listCount")).intValue(); 
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 
	int maxPage =((Integer)request.getAttribute("maxPage")).intValue(); 
	int startPage = ((Integer)request.getAttribute("startPage")).intValue(); 
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	String as = (String)request.getAttribute("areas");
	String cg = (String)request.getAttribute("categorys");
	String sort = (String)request.getAttribute("sort");
	String[] bookmarks = (String[])request.getAttribute("bookmarks");
	
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/main.css"/>
 <script type="text/javascript" src="js/jquery-3.1.0.min.js"> </script>
 <script type="text/javascript" src="js/navigation.js"> </script>

<title>main</title>
<script>
</script>
<style>
a {
    color: inherit;
}
</style>
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
				<!-- search -->
				<button type="submit" id="nav_btn" class="search" tabindex="-1">검색</button>
				
				<!-- account section -->
				<div id="nav_account">
						<div id="nav_guest">
							<span id="nav_login">로그인</span>
							&nbsp;|&nbsp;
							<span id="nav_join">회원가입</span>
						</div>
				</div>
		</div>
		</form>
	</div>
		<div class="menu_wrap">
			<div id="nav_menu">
				<!-- <a href="#" class="underline ">메뉴</a>
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
		<!--배너 슬라이더 이미지 banner_warp-->
		<div id="banner_warp">
			<div id="banner" style="background-color:rgba(0,0,0,0.3);">
				<div style="width:850px; height:100%; margin: 0 auto; background-color:rgba(0,0,0,0.6);"></div>
			</div>
		</div>
		<!--배너 슬라이더 이미지 banner_warp-->
		
		<!--쉬운 카테고리 선택 content_warp -->
		<div id="content_wrap">
		<div id="content" class="search">
    
			<div class="result">
                <span class="highlight"><%=areaW %></span>의 
                 <span class="highlight"><%=categoryW %></span>이(가)<br>
				 총 <span class="highlight"><%=listCount %></span>개가 검색되었습니다.
    		</div>

    		<ul class="sort_order_spread">
    		<%if(sort.equals("view_count")) {%>
    			<li class="selected"><a href="/easyStudy/search.store?sort=view_count&categorys=<%=cg%>&areas=<%=as%>">조회순</a></li>
        		<li class=""><a href="/easyStudy/search.store?sort=avg_grade&categorys=<%=cg%>&areas=<%=as%>">별점순</a></li></a>
        	<%} else{ %>
        		<li class=""><a href="/easyStudy/search.store?sort=view_count&categorys=<%=cg%>&areas=<%=as%>">조회순</a></li>
        		<li class="selected"><a href="/easyStudy/search.store?sort=avg_grade&categorys=<%=cg%>&areas=<%=as%>">별점순</a></li></a>
        	<%} %>
    		</ul>
			
			<div class="list">
             <%for(int i=0; i<list.size(); i++){ %>
                <%if(i%3==0){ %>
             <div class="element medium first ">
                  
                  <a href="/easyStudy/DView?storeId=<%=list.get(i).getStoreId() %>" class="image" style="background-image: url(<%=list.get(i).getImgRoute() %>);">
            
                    <div class="shading"></div>
        			<div class="top"> 
        				<button class="" onclick="return false;" tabindex="-1">
                    		<div class="icon favorite" id="mypageGo<%=list.get(i).getStoreId() %>"></div>
                		</button>
            		</div>
<%if(member != null){ %> 
<script type="text/javascript">
$(document).ready(function() {
		if(<%=list.get(i).getStoreId().equals(bookmarks[0]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[1]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[2]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[3]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[4]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[5]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[6]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[7]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[8]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
});
</script>
<script type="text/javascript">
$(document).ready(function() {

	$("#mypageGo<%=list.get(i).getStoreId() %>").click(function(){
		if(!($(this).hasClasss('on'))){//현재 상태 확인
			if(confirm("즐겨찾기에 등록하시겠습니까?")){ //등록
				$.ajax({
					type:'GET',
					url:"/easyStudy/mbookmarkins?userid=<%=member.getUserId()%>&storeid=<%=list.get(i).getStoreId() %>",
					success: function(data) {
						if(data.result == 10){
							alert("즐겨찾기 갯수가 초과되었습니다. 즐겨찾기 페이지로 이동하시겠습니까?");
						}else{
							alert("성공");
							$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
						}
						
					},
					error: function(data) {
						alert("에러");
					}			
				});
			}else{
				return false;
			}
				
		}else{
			if(confirm("즐겨찾기에 해지하시겠습니까?")){ //해지
			$.ajax({
				type:'GET',
				url:"/easyStudy/mbookmarkdel?userid=<%=member.getUserId()%>&storeid=<%=list.get(i).getStoreId() %>",
				success: function(data) {
					alert("성공");
					$("#mypageGo<%=list.get(i).getStoreId() %>").removeClass("on");
					
				},
				error: function(data) {
					alert("에러");
				}			
			});
			}else{
				return false;
			}
		}

		
	});
});
</script>            		
 <% }%>           	
                       <div class="bottom">
                                <span class="name"><%=list.get(i).getStoreName() %></span>                
                                <span class="area"><%=list.get(i).getLocalName() %>/<%=list.get(i).getCategoryName() %></span>            
                        </div>
                  </a>

                     <div class="desc">
                            <div class="place_info">
                                <div class="rating">
                                              <%
							if(list.get(i).getScore() <= 0.5){
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
							}else if(list.get(i).getScore() <= 1){
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
							}else if(list.get(i).getScore()<= 1.5){
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
							}else if(list.get(i).getScore()<= 2){
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
							}else if(list.get(i).getScore()<= 2.5){
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
							}else if(list.get(i).getScore()<= 3){
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
							}else if(list.get(i).getScore()<= 3.5){
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
							}else if(list.get(i).getScore()<= 4){
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
						<%	}else if(list.get(i).getScore()<= 4.5){
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
							}else if(list.get(i).getScore()<= 5){
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
                                  <div class="grade"><%=list.get(i).getScore() %>점</div>
                              </div>
                             <div class="budget"><span class="price"><%=list.get(i).getPrice() %></span></div>
                             <%if(list.get(i).getHomepage()== null){ %>               
                             <div class="comment"></div>
           					 <% }else{ %>
           					 	<div class="comment">주소 : <%=list.get(i).getHomepage() %> </div>
           					 <%} %>
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

<%if(member != null){ %> 
<script type="text/javascript">
$(document).ready(function() {	
		if(<%=list.get(i).getStoreId().equals(bookmarks[0]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[1]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[2]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[3]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[4]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[5]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[6]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[7]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
		if(<%=list.get(i).getStoreId().equals(bookmarks[8]) %>){
			$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
		}
});
</script>
<script type="text/javascript">
$(document).ready(function() {

	$("#mypageGo<%=list.get(i).getStoreId() %>").click(function(){
		if(!($(this).hasClasss('on'))){//현재 상태 확인
			if(confirm("즐겨찾기에 등록하시겠습니까?")){ //등록
				$.ajax({
					type:'GET',
					url:"/easyStudy/mbookmarkins?userid=<%=member.getUserId()%>&storeid=<%=list.get(i).getStoreId() %>",
					success: function(data) {
						if(data.result == 10){
							alert("즐겨찾기 갯수가 초과되었습니다. 즐겨찾기 페이지로 이동하시겠습니까?");
						}else{
							alert("성공");
							$("#mypageGo<%=list.get(i).getStoreId() %>").addClass("on");
						}
						
					},
					error: function(data) {
						alert("에러");
					}			
				});
			}else{
				return false;
			}
				
		}else{
			if(confirm("즐겨찾기에 해지하시겠습니까?")){ //해지
			$.ajax({
				type:'GET',
				url:"/easyStudy/mbookmarkdel?userid=<%=member.getUserId()%>&storeid=<%=list.get(i).getStoreId() %>",
				success: function(data) {
					alert("성공");
					$("#mypageGo<%=list.get(i).getStoreId() %>").removeClass("on");
					
				},
				error: function(data) {
					alert("에러");
				}			
			});
			}else{
				return false;
			}
		}

		
	});
});
</script>            		
 <% }%>              	            			
                       <div class="bottom">
                                <span class="name"><%=list.get(i).getStoreName() %></span>                
                                <span class="area"><%=list.get(i).getLocalName() %>/<%=list.get(i).getCategoryName() %></span>            
                        </div>
                  </a>

                     <div class="desc">
                            <div class="place_info">
                                <div class="rating">
                                             <%
							if(list.get(i).getScore() <= 0.5){
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
							}else if(list.get(i).getScore() <= 1){
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
							}else if(list.get(i).getScore()<= 1.5){
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
							}else if(list.get(i).getScore()<= 2){
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
							}else if(list.get(i).getScore()<= 2.5){
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
							}else if(list.get(i).getScore()<= 3){
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
							}else if(list.get(i).getScore()<= 3.5){
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
							}else if(list.get(i).getScore()<= 4){
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
						<%	}else if(list.get(i).getScore()<= 4.5){
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
							}else if(list.get(i).getScore()<= 5){
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
                                  <div class="grade"><%=list.get(i).getScore() %>점</div>
                              </div>
                             <div class="budget"><span class="price"><%=list.get(i).getPrice() %></span></div>                    
                             <%if(list.get(i).getHomepage()== null){ %>               
                             <div class="comment"></div>
           					 <% }else{ %>
           					 	<div class="comment">주소 : <%=list.get(i).getHomepage() %> </div>
           					 <%} %>
           
                           </div>
                       </div>
          </div>
             <%} %>
          <%} %>
   			 
    	</div>
    <div id="pager">
    	<div class="page-list">
    	 <ul class="pagination">
    	
    	<% if(currentPage <= 1){ %> 
             <li>&lt;&lt;</li>
            <%}else{ %> 
           	<li><a href="/easyStudy/search.store?page=<%= currentPage - 1 %>&categorys=<%=cg%>&areas=<%=as%>&sort=<%=sort%>">&lt;&lt;</a></li>
            <% } %> 
          
            
            <% for(int p = startPage; p <= endPage; p++){ 
                if(p == currentPage){ %> 
                	<li class="active"><%= p %></li>
                <%}else{ %> 
               <li> <a href="/easyStudy/search.store?page=<%= p %>&categorys=<%=cg%>&areas=<%=as%>&sort=<%=sort%>"><%= p %></a></li>
                <% } %> 
            <% } %> 
            
 			
            <% if(currentPage >= maxPage){ %> 
            	<li>&gt;&gt;</li>
            <%}else{ %> 
            <li><a href="/easyStudy/search.store?page=<%= currentPage + 1 %>&categorys=<%=cg%>&areas=<%=as%>&sort=<%=sort%>">&gt;&gt;</a></li>
            <% } %>
            
            </ul>
    	</div>
    </div>
    
    	
    </div>
	<!-- side bar 찾아본 페이지 -->
		<div id="sidebar_wrap" class="detail">
    	<div id="find" class="sidebar">
			<div class="title">찾아 본 페이지</div>
				<ul class="list">
					<li class="item">
					<a class="i_wrap" href="#">
						<i class="image border_radius soft" style="background-color:#eee;"></i>
					</a>
					<div class="desc">					
					<div class="name">상점이름</div>
					<div class="comment"></div>
					</div>
					</li>
				
				</ul>
				</div>
			</div>
			<!-- sidebar end -->
	</div>
</div>	
	<!-- content_warp 쉬운 카테고리 선택 -->

	
	<div id="footer_wrap">
		<div style="width:970px; height:208px; background:gray;"></div>
	</div>
	
</div>
</body>
</html>