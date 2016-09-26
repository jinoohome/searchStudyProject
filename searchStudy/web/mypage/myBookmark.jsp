<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="mypage.model.vo.Member, mypage.model.vo.SearchStore, java.util.ArrayList"%>
<%
	Member loginUser = (Member)session.getAttribute("loginUser");
	ArrayList<SearchStore> list = (ArrayList<SearchStore>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>main</title>
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/easyStudy/css/main.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/layout.css" >

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
			<div id="mypage_bookmark">
			<div id="mypage_bookmarkList">
			<% if(list != null){ %>
				             <%for(int i=0; i<list.size(); i++){ %>
				          
                <%if(i%3==0){ %>
             <div class="element medium first ">
                  
                  <a href="#" class="image" style="background-image: url(<%=list.get(i).getImgRoute() %>);">
            
                    <div class="shading"></div>
        
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
                              <div id="mypage_bookmarkbuttondiv">
           					 	<a href="/easyStudy/mbookmarkdel?userid=<%=loginUser.getUserId() %>%storeid=<%=list.get(i).getStoreId() %>" onclick="return confirm('<%=list.get(i).getStoreName() %>을(를) 즐겨찾기에서 해제하시겠습니까?')" >
           					 					<input type="button" value="즐겨찾기 해제" id="bookmarkdelBtn"></a>
           					 </div>
           
                           </div>
                       </div>
          </div>
          
             <%}else{ %>
                <div class="element medium">
                  <a href="#" class="image" style="background-image: url(<%=list.get(i).getImgRoute() %>);">
                    <div class="shading"></div>
        
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
           					 <div id="mypage_bookmarkbuttondiv">
           					 	<a href="/easyStudy/mbookmarkdel?userid=<%=loginUser.getUserId() %>%storeid=<%=list.get(i).getStoreId() %>" onclick="return confirm('<%=list.get(i).getStoreName() %>을(를) 즐겨찾기에서 해제하시겠습니까?')">
           					 					<input type="button" value="즐겨찾기 해제" id="bookmarkdelBtn"></a>
           					 </div>
                           </div>
                       </div>
          </div>
             <%} %>
          <%}}else{ %>
   			 <div id="mypage_nobookmark">
   			  	등록하신 즐겨찾기가 없습니다.<br>
   			  	즐겨찾기를 등록해 주세요.
   			 </div>
   			 <div id="mypage_nobookmarkgomain">
   			  	<a href="">장소 검색하러 가기.</a>
   			  </div>
			<%} %>
			</div>
		</div>
		</div>
</body>
</html>