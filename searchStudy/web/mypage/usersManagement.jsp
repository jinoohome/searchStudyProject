<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, member.model.vo.Member"%>
<%
	Member member = (Member) session.getAttribute("member");

	ArrayList<Member> list = (ArrayList<Member>) request.getAttribute("list");
	
	int listCount = ((Integer)request.getAttribute("listCount")).intValue(); 
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue(); 
	int maxPage =((Integer)request.getAttribute("maxPage")).intValue(); 
	int startPage = ((Integer)request.getAttribute("startPage")).intValue(); 
	int endPage = ((Integer)request.getAttribute("endPage")).intValue(); 
%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/main.css" />
<link rel="stylesheet" type="text/css" href="/easyStudy/css/layout.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/function.css" />
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"></script>
<style>
input[type=checkbox], input[type=radio] {
    display: block;
}

</style>
<script type="text/javascript">
$(function() {
	// 소트를 설정
	var sortOrder = 1; // 1:ASC -1:DESC
	// 열을 클릭하면
	$(".dothesort").click(function() {
		var type = $(this).data('type'); // string, integer
		var col = $(this).index(); // 0, 1, ...
		// 행 전체를 취득
		var $rows = $('tbody>tr');
		// 행을 소트
		//https://developer.mozilla.org/ja/docs/Web/JavaScript/Reference/Global_Objects/Array/sort
		//array.sort(compareFunction);
		$rows.sort(function(a, b) {
			return compare(a, b, type, col) * sortOrder;
		});
		// tbody를 소트된 행 전체로 바꾸기
		$('tbody').empty().append($rows);

		var arrow = sortOrder === 1 ? "▲" : "▼";
		$('.dothesort > span').text('');
		$(this).find('span').text(arrow);

		// 소트 순서를 반전
		sortOrder *= -1;
	});
	function compare(a, b, type, col) {
		var _a = $(a).find('td').eq(col).text(); // eq(index)
		var _b = $(b).find('td').eq(col).text();
		if (type == "string") {
			if (_a < _b)
				return -1;
			if (_a > _b)
				return 1;
			return 0;
		} else {
			_a *= 1;
			_b *= 1; // a, b를 숫자로 만든다.
			return _a - _b;
		}
	}
});


	$(function() {
		//회원 검색시 검색 text와 submit버튼 변경
		$('#searchhow').change(
				function() {
					$('#searchID')[($("option[value='searchid']")
							.is(":checked")) ? "show" : "hide"]();
					$('#searchNickname')[($("option[value='searchnick']")
							.is(":checked")) ? "show" : "hide"]();
					$('#searchDate')[($("option[value='searchdate']")
							.is(":checked")) ? "show" : "hide"]();
				});
	});
	$(function() {
		//전체선택 체크박스 클릭
		$("#allCheck")
				.click(
						function() {
							if ($("#allCheck").prop("checked")) {
								$(
										"table.mypage_userManager input[type=checkbox]")
										.prop("checked", true);

							} else {
								$(
										"table.mypage_userManager input[type=checkbox]")
										.prop("checked", false);
							}
							$("table.mypage_userManager input[type=checkbox]")
									.change();
						})
	})
	//체크박스 선택시 tr 색 변경
	$(function() {
		$("table.mypage_userManager input[type=checkbox]").change(function() {
			if ($(this).is(":checked")) {
				$(this).closest("tr").find("td").each(function() {
					$(this).css("background", "#e0e0e0");
				});
			} else {
				$(this).closest("tr").find("td").each(function() {
					$(this).css("background", "white");
				});
			}
		
		} );
	});

</script>
				<script type="text/javascript">
					//모두삭제 실행전 조건 확인 밑 확인창
					function checkAlldel(){
						if(confirm("체크된 회원 모두를 정리하시겠습니까?")){
							mypage_alldelete_form.submit();
						}else{
							return;
						}
					}
				</script>

<title>main</title>


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
							if (member != null) {
								if ("admin".equals(member.getUserId())) {
						%>
						<%=member.getNickName()%>님 &nbsp; &nbsp; &nbsp; <a
							href="/easyStudy/mmanagement">회원 관리</a> &nbsp; &nbsp; &nbsp;
						&nbsp; &nbsp; &nbsp; <a href="#">글쓰기</a>
						<%
							} else {
						%>
						<%=member.getNickName()%>님 &nbsp; &nbsp; &nbsp; <a
							href="/easyStudy/mypage/myBookmark.jsp">즐겨찾기</a> &nbsp; &nbsp;
						&nbsp; &nbsp; &nbsp; &nbsp; <a
							href="/easyStudy/mypage/myReview.jsp">내가 쓴 리뷰</a> &nbsp; &nbsp;
						&nbsp; &nbsp; &nbsp; &nbsp; <a href="/easyStudy/mypage/myinfo.jsp">내
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
			<div id="mypages">
				<div id="mypage_usersearch">
					<div  id="searchhow">
						<select class="searchhow_select">
							<option value="searchid" selected> &nbsp; I &nbsp;D  </option>
							<option value="searchnick">닉네임</option>
							<option value="searchdate">가입일</option>
						</select>
					 	&nbsp; 
					</div> 
					
					<div id="searchID">
						<form action="/easyStudy/searchuserid" method="post">
							<input type="text" name="userid" size="30"> &nbsp; <input
								type="submit" value="검색" class="mypage_userM_searchBtn">
						</form>
					</div>

					<div id="searchNickname" style="display: none">
						<form action="/easyStudy/searchnickname" method="post">
							<input type="text" name="nickname" size="30"> &nbsp; <input
								type="submit" value="검색" class="mypage_userM_searchBtn">
						</form>
					</div>

					<div id="searchDate" style="display: none">
						<form action="/easyStudy/searchenroll_date" method="post">
							<input type="date" name="start"> ~ <input type="date"
								name="end"> &nbsp; <input type="submit" value="검색"
								class="mypage_userM_searchBtn">
						</form>
					</div>
				</div>

				<div id="mypage_usercount">
				<br><br><br>
					현재 &nbsp;
					<span class="mypage_usercount_num"><%=listCount %></span> 
					&nbsp;명의 회원이 존재합니다.
				</div>
				<!-- 다수의 회원 정리 기능 -->
				<form action="/easyStudy/malldel" id="mypage_alldelete_form" method="post"  >
				  <input type="button" onclick="checkAlldel()" value="모두 정리" id="mypage_alldelete">
					<div id="mypage_userManager_T">
						<table class="mypage_userManager">
							<thead>
								<tr>
									<th><input type="checkbox" id="allCheck"></th>
									<th class="dothesort" data-type="string">회원 ID ▼</th>
									<th class="dothesort" data-type="string">회원 닉네임 ▼</th>
									<th class="dothesort" data-type="string">가입 날짜 ▼</th>
									<th>회원 관리</th>
								</tr>
							</thead>
							<tbody>
								<%
									if (list != null) {
										for (Member m : list) {
								%>
								<tr>
									<td><input type="checkbox" name="userids_del" value="<%=m.getUserId()%>"></td>
									<td><%=m.getUserId()%></td>
									<!-- 리뷰 페이지로 이동... -->
									<td><a href="/easyStudy/ureview?page=1&nickname=<%=m.getNickName() %>"  onClick="window.open(this.href, '', 'width=900, height=500'); return false;"><%=m.getNickName()%></a></td>
									<td><%=m.getEnrollDate()%></td>
									<td><a href="/easyStudy/mdelete?userid=<%=m.getUserId()%>,admin"
										onclick="return confirm('정말 <%=m.getNickName()%> 회원을 정리하시겠습니까?')">
											<input type=button id="<%=m.getUserId() %>" class="mypage_del_btn" value="회원 정리"></td>
								</tr>
							
						<%} }else{ };	%>
						</tbody>
						</table>
						
						
						<div id="mypage_tablepage">
            <% if(currentPage <= 1){ %> 
            [이전] 
            <%}else{ %> 
            <a href="/easyStudy/mmanagement?page=<%= currentPage - 1 %>">[이전]</a>
            <% } %> 
             
            <% for(int p = startPage; p <= endPage; p++){ 
                if(p == currentPage){ %> 
                [<%= p %>] 
                <%}else{ %> 
                <a href="/easyStudy/mmanagement?page=<%= p %>">[<%= p %>]</a> 
                <% } %> 
            <% } %> 
            <% if(currentPage >= maxPage){ %> 
            [다음] 
            <%}else{ %> 
            <a href="/easyStudy/mmanagement?page=<%= currentPage + 1 %>">[다음]</a> 
            <% } %> 
        
						</div>
					</div>
				</form>
			</div>

		</div>
	</div>

 
 

</body>
</html>