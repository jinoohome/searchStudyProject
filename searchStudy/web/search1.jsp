<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="member.model.vo.Member"%>
<%@ page import="store.model.vo.SearchStore, java.util.*"%>
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
	/* 
	String storeId = (String)request.getAttribute("storeId");
	String score = (String)request.getAttribute("score");
	System.out.print(storeId+":"+score+"=================\n");
	 */
	 
	Cookie[] cook = request.getCookies();
	for(Cookie c : cook){
		System.out.print("search 쿠키 받아지나? "+c.getValue()+"\n");
	/* 	c.setMaxAge(0);//초단위  
		c.setPath("/");
		response.addCookie(c); */
		
	}
	
	String item[] = new String[cook.length];
	String name[] = new String[cook.length];
	String key[] = new String[cook.length];
	String score[] = new String[cook.length];
	System.out.print("search cook length: "+cook.length+"\n");
	if(cook != null){
			for(int i=0;i<cook.length; i++){
				
				key[i] =cook[i].getName();
				if(!(java.net.URLDecoder.decode(key[i],"utf-8").equals("JSESSIONID"))){
				
				String value= java.net.URLDecoder.decode(cook[i].getValue(),"utf-8");
				score[i] = value.split(",")[2];
				name[i] =value.split(",")[0];
				item[i] = value.split(",")[1];
				System.out.print("search cook item:"+ i +" : "+key[i]+"\n");
					System.out.print("search cook item:"+item[i]+"\n");
					System.out.print("search cook item:"+name[i]+"\n");
					System.out.print("search cook item:"+score[i]+"\n");
			
				
					//System.out.print("search cook key: "+i+" - "+name[i]+"\n");
					//System.out.print("search cook item: "+i+" - "+item[i]+"\n");
				}
				
				
				
			
		}
	}
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/main.css" />
<link rel="stylesheet" href="css/layout.css" type="text/css">
<link rel="stylesheet" href="css/function.css" type="text/css">

<script type="text/javascript" src="js/jquery-3.1.0.min.js"> </script>
<script type="text/javascript" src="js/navigation.js"> </script>
<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
<!--dialog -->


<script>
$( document ).ready(function() {
	   $("button").attr("tabindex", "-1");
	   $("body").on("click", " button", function(e)
	   {
	      var type = $(this).data("type");
	      if(type != null)
	      {
	         $(this).blur();
	         $.proxy(eval(type), this)();
	      }
	   });
	   $("#banner").on("selectstart", function()
	         {
	             return false;
	         });
	$("#banner").on("selectstart", function()
	      {
	          return false;
	      });
	      function TriSlider(options) {
	          var slider = $(options.selector);
	          var pieces = slider.children(".pieces");
	          var max = pieces.data('max');
	          var fake_pieces = options.fake_pieces? options.fake_pieces:2;
	          var width = 850;
	          var start_point = -width * (fake_pieces-1);
	          var start_index = options.start_index? options.start_index:0;
	          var isSliding = false;
	          (function() {
	              pieces.data('index', start_index);
	              pieces.css('left', (-width*(start_index+1) + start_point)+'px');
	          
	              slider.find(".index>li").removeClass('current');
	              slider.find(".index>li[data-id="+start_index+"]").addClass('current');
	              pieces.show();
	          })();
	          var piece = slider.find(".piece"),
	              first   = piece.filter(':first'),
	              last    = piece.filter(':last');
	          // 슬라이더가 0개임
	          if(piece.length == 0) 
	              return false;
	          // 가짜 페이지들을 만들 때, 설정한 갯수가 진짜 페이지의 최대 갯수보다 많을 경우
	          var rest = fake_pieces % piece.length;
	          if(rest > 0) {
	              first.before( piece.slice(-1 * rest).clone(true) );
	              last.after( piece.slice(0, rest).clone(true) );
	          }
	          for(var i=0, len = Math.floor(fake_pieces / piece.length); i<len; ++i) {
	              first.before( piece.clone(true) );
	              last.after( piece.clone(true) );
	          }
	          var slide = function(add) {
	              isSliding = true;
	              var index = pieces.data('index');
	              index += add;
	              pieces.data('index', index);
	              pieces.animate({left : (-width*(index+1) + start_point)+'px'}, 
	                  {'duration':300,
	                   'complete':function() {
	                      if(index == -1) { // attach to left
	                          index = max - 1;
	                          pieces.data('index', index);
	                          pieces.css('left', (-width*(index+1) + start_point)+'px');
	                      } else if(index == max) { // attach to right
	                          index = 0;
	                          pieces.data('index', index);
	                          pieces.css('left', (-width*(index+1) + start_point)+'px');
	                      }
	                      slider.find(".index>li").removeClass('current');
	                      slider.find(".index>li[data-id="+index+"]").addClass('current');
	                      if( options.complete )
	                          options.complete( pieces.children(".piece").get(index+fake_pieces) );
	                      isSliding = false;
	                  }
	              });
	          }
	          this.prev = function() {
	              if(isSliding === false)
	                  slide(-1);
	          };
	          this.next = function() {
	              if(isSliding === false)
	                  slide(1);
	          };
	          
	          slider.find(".nav>.left").click(this.prev);
	          slider.find(".nav>.right").click(this.next);
	          if(options.duration > 0)
	              setInterval(this.next, options.duration);
	      };
	      var TriSlider = new TriSlider({'selector':'#banner>.trislider'});
	});
</script>

<!-- 로그인시 버튼관련 -->
<%if(member != null){ %>
<%if(list.size() >= 1 ){ %>
<script type="text/javascript">
	$(document).ready(function() {
			
		//0번째
		var str0 = false;			
		if(<%=list.get(0).getStoreId().equals(bookmarks[0]) %>){
			$("#mypageGo<%=list.get(0).getStoreId() %>").addClass("on");
			str0 = true;
		}
		$("#mypageGo<%=list.get(0).getStoreId() %>").click(function(){
			
			if( str0 == true ){
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkdel?userid=<%=member.getUserId()%>&storeid=<%=list.get(0).getStoreId() %>",
						success: function(data) {
							$("#mypageGo<%=list.get(0).getStoreId() %>").removeClass("on");
							str0 = false;
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
				
			}else{
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkins?userid=<%=member.getUserId()%>&storeid=<%=list.get(0).getStoreId() %>",
						success: function(data) {
							if(data.result == 10){
								if(confirm("즐겨찾기 갯수가 초과되었습니다. 즐겨찾기 페이지로 이동하시겠습니까?")){
									location.href="/easyStudy/mbookmark?userid=<%=member.getUserId() %>";
								}else{
									return false;
								}
							}else{
								$("#mypageGo<%=list.get(0).getStoreId() %>").addClass("on");
								str0 = true;
							}
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}
			
		});
		
	});
</script>
<%}
if(list.size() >= 2){ %>
<script type="text/javascript">
	$(document).ready(function() {
		//1번째
		
		var str1 = false;
		if(<%=list.get(1).getStoreId().equals(bookmarks[1]) %>){
			$("#mypageGo<%=list.get(1).getStoreId() %>").addClass("on");
			str1 = true;
		}
		$("#mypageGo<%=list.get(1).getStoreId() %>").click(function(){
			
			if( str1 == true ){
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkdel?userid=<%=member.getUserId()%>&storeid=<%=list.get(1).getStoreId() %>",
						success: function(data) {
							$("#mypageGo<%=list.get(1).getStoreId() %>").removeClass("on");
							str1 = false;
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}else{
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkins?userid=<%=member.getUserId()%>&storeid=<%=list.get(1).getStoreId() %>",
						success: function(data) {
							if(data.result == 10){
								if(confirm("즐겨찾기 갯수가 초과되었습니다. 즐겨찾기 페이지로 이동하시겠습니까?")){
									location.href="/easyStudy/mbookmark?userid=<%=member.getUserId() %>";
								}else{
									return false;
								}
							}else{
								$("#mypageGo<%=list.get(1).getStoreId() %>").addClass("on");
								str1 = true;
							}
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}
			
		});
	});
	</script>
<%}
if(list.size() >= 3){ %>

<script type="text/javascript">
		$(document).ready(function() {
		
		
		//2번째
		
		var str2 = false;
		if(<%=list.get(2).getStoreId().equals(bookmarks[2]) %>){
			$("#mypageGo<%=list.get(2).getStoreId() %>").addClass("on");
			str2 = true;
		}
		$("#mypageGo<%=list.get(2).getStoreId() %>").click(function(){
			if( str2 == true ){
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkdel?userid=<%=member.getUserId()%>&storeid=<%=list.get(2).getStoreId() %>",
						success: function(data) {
							$("#mypageGo<%=list.get(2).getStoreId() %>").removeClass("on");
							str2 = false;
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}else{
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkins?userid=<%=member.getUserId()%>&storeid=<%=list.get(2).getStoreId() %>",
						success: function(data) {
							if(data.result == 10){
								if(confirm("즐겨찾기 갯수가 초과되었습니다. 즐겨찾기 페이지로 이동하시겠습니까?")){
									location.href="/easyStudy/mbookmark?userid=<%=member.getUserId() %>";
								}else{
									return false;
								}
							}else{
								$("#mypageGo<%=list.get(2).getStoreId() %>").addClass("on");
								str2 = true;
							}
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}
			
		});
		
});
		</script>
<%}
if(list.size() >= 4){ %>

<script type="text/javascript">
			$(document).ready(function() {
		//3번째
		
		var str3 = false;
		if(<%=list.get(3).getStoreId().equals(bookmarks[3]) %>){
			$("#mypageGo<%=list.get(3).getStoreId() %>").addClass("on");
			str3 = true;
		}
		$("#mypageGo<%=list.get(3).getStoreId() %>").click(function(){
			 
			if( str3 == true ){
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkdel?userid=<%=member.getUserId()%>&storeid=<%=list.get(3).getStoreId() %>",
						success: function(data) {
							$("#mypageGo<%=list.get(3).getStoreId() %>").removeClass("on");
							str3 = false;
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}else{
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkins?userid=<%=member.getUserId()%>&storeid=<%=list.get(3).getStoreId() %>",
						success: function(data) {
							if(data.result == 10){
								if(confirm("즐겨찾기 갯수가 초과되었습니다. 즐겨찾기 페이지로 이동하시겠습니까?")){
									location.href="/easyStudy/mbookmark?userid=<%=member.getUserId() %>";
								}else{
									return false;
								}
							}else{
								$("#mypageGo<%=list.get(3).getStoreId() %>").addClass("on");
								str3 = true;
							}
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}
			
		});
			});
			</script>
<%}
if(list.size() >= 5){ %>

<script type="text/javascript">
				$(document).ready(function() {
		
		//4번째
		var str4 = false;
		if(<%=list.get(4).getStoreId().equals(bookmarks[4]) %>){
			$("#mypageGo<%=list.get(4).getStoreId() %>").addClass("on");
			str4 = true;
		}
		$("#mypageGo<%=list.get(4).getStoreId() %>").click(function(){
			 
			if( str4 == true ){
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkdel?userid=<%=member.getUserId()%>&storeid=<%=list.get(4).getStoreId() %>",
						success: function(data) {
							$("#mypageGo<%=list.get(4).getStoreId() %>").removeClass("on");
							str4 = false;
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}else{
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkins?userid=<%=member.getUserId()%>&storeid=<%=list.get(4).getStoreId() %>",
						success: function(data) {
							if(data.result == 10){
								if(confirm("즐겨찾기 갯수가 초과되었습니다. 즐겨찾기 페이지로 이동하시겠습니까?")){
									location.href="/easyStudy/mbookmark?userid=<%=member.getUserId() %>";
								}else{
									return false;
								}
							}else{
								$("#mypageGo<%=list.get(4).getStoreId() %>").addClass("on");
								str4 = true;
							}
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}
			
		});
				});
				</script>
<%}
if(list.size() >= 6){ %>

<script type="text/javascript">
					$(document).ready(function() {
		
		//5번째
		var str5 = false;
		if(<%=list.get(5).getStoreId().equals(bookmarks[5]) %>){
			$("#mypageGo<%=list.get(5).getStoreId() %>").addClass("on");
			str5 = true;
		}
		$("#mypageGo<%=list.get(5).getStoreId() %>").click(function(){
			 
			if( str5 == true ){
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkdel?userid=<%=member.getUserId()%>&storeid=<%=list.get(5).getStoreId() %>",
						success: function(data) {
							$("#mypageGo<%=list.get(5).getStoreId() %>").removeClass("on");
							str5 = false;
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}else{
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkins?userid=<%=member.getUserId()%>&storeid=<%=list.get(5).getStoreId() %>",
						success: function(data) {
							if(data.result == 10){
								if(confirm("즐겨찾기 갯수가 초과되었습니다. 즐겨찾기 페이지로 이동하시겠습니까?")){
									location.href="/easyStudy/mbookmark?userid=<%=member.getUserId() %>";
								}else{
									return false;
								}
							}else{
								$("#mypageGo<%=list.get(5).getStoreId() %>").addClass("on");
								str5 = true;
							}
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}
			
		});
					});
					</script>
<%}
if(list.size() >= 7){ %>

<script type="text/javascript">
						$(document).ready(function() {
		
		//6번째
		var str6 = false;
		if(<%=list.get(6).getStoreId().equals(bookmarks[6]) %>){
			$("#mypageGo<%=list.get(6).getStoreId() %>").addClass("on");
			str6 = true;
		}
		$("#mypageGo<%=list.get(6).getStoreId() %>").click(function(){
			 
			if( str6 == true ){
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkdel?userid=<%=member.getUserId()%>&storeid=<%=list.get(6).getStoreId() %>",
						success: function(data) {
							$("#mypageGo<%=list.get(6).getStoreId() %>").removeClass("on");
							str6 = false;
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}else{
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkins?userid=<%=member.getUserId()%>&storeid=<%=list.get(6).getStoreId() %>",
						success: function(data) {
							if(data.result == 10){
								if(confirm("즐겨찾기 갯수가 초과되었습니다. 즐겨찾기 페이지로 이동하시겠습니까?")){
									location.href="/easyStudy/mbookmark?userid=<%=member.getUserId() %>";
								}else{
									return false;
								}
							}else{
								$("#mypageGo<%=list.get(6).getStoreId() %>").addClass("on");
								str6 = true;
							}
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}
			
		});
						});
						</script>
<%}
if(list.size() >= 8){ %>

<script type="text/javascript">
							$(document).ready(function() {
		
		//7번째
		var str7 = false;
		if(<%=list.get(7).getStoreId().equals(bookmarks[7]) %>){
			$("#mypageGo<%=list.get(7).getStoreId() %>").addClass("on");
			str7 = true;
		}
		$("#mypageGo<%=list.get(7).getStoreId() %>").click(function(){
			 
			if( str7 == true ){
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkdel?userid=<%=member.getUserId()%>&storeid=<%=list.get(7).getStoreId() %>",
						success: function(data) {
							$("#mypageGo<%=list.get(7).getStoreId() %>").removeClass("on");
							str7 = false;
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}else{
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkins?userid=<%=member.getUserId()%>&storeid=<%=list.get(7).getStoreId() %>",
						success: function(data) {
							if(data.result == 10){
								if(confirm("즐겨찾기 갯수가 초과되었습니다. 즐겨찾기 페이지로 이동하시겠습니까?")){
									location.href="/easyStudy/mbookmark?userid=<%=member.getUserId() %>";
								}else{
									return false;
								}
							}else{
								$("#mypageGo<%=list.get(7).getStoreId() %>").addClass("on");
								str7 = true;
							}
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}
			
		});
							});
							</script>
<%}
if(list.size() >= 9){ %>

<script type="text/javascript">
								$(document).ready(function() {
		
		//8번째
		var str8 = false;
		if(<%=list.get(8).getStoreId().equals(bookmarks[8]) %>){
			$("#mypageGo<%=list.get(8).getStoreId() %>").addClass("on");
			str8 = true;
		}
		$("#mypageGo<%=list.get(8).getStoreId() %>").click(function(){
			 
			if( str8 == true ){
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkdel?userid=<%=member.getUserId()%>&storeid=<%=list.get(8).getStoreId() %>",
						success: function(data) {
							$("#mypageGo<%=list.get(8).getStoreId() %>").removeClass("on");
							str8 = false;
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}else{
					$.ajax({
						type:'GET',
						url:"/easyStudy/mbookmarkins?userid=<%=member.getUserId()%>&storeid=<%=list.get(8).getStoreId() %>",
						success: function(data) {
							if(data.result == 10){
								if(confirm("즐겨찾기 갯수가 초과되었습니다. 즐겨찾기 페이지로 이동하시겠습니까?")){
									location.href="/easyStudy/mbookmark?userid=<%=member.getUserId() %>";
								}else{
									return false;
								}
							}else{
								$("#mypageGo<%=list.get(8).getStoreId() %>").addClass("on");
								str8 = true;
							}
							
						},
						error: function(data) {
							alert("에러");
						}			
					});
			}
			
		});
		
		
		
	});
</script>
<%} %>

<!-- 비로그인시 버튼 클릭 관련 -->
<% }else{%>
<!-- 로그아웃상태 -->
<% if(list.size() >= 1){  %>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mypageGo<%=list.get(0).getStoreId() %>").click(function(){
			alert("즐겨찾기 기능은 로그인 후에 사용 가능합니다.");
		});
	});
</script>
<%} if(list.size() >= 2){  %>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mypageGo<%=list.get(1).getStoreId() %>").click(function(){
			alert("즐겨찾기 기능은 로그인 후에 사용 가능합니다.");
		});
	});
</script>
<%} if(list.size() >= 3){  %>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mypageGo<%=list.get(2).getStoreId() %>").click(function(){
			alert("즐겨찾기 기능은 로그인 후에 사용 가능합니다.");
		});
	});
</script>
<%} if(list.size() >= 4){  %>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mypageGo<%=list.get(3).getStoreId() %>").click(function(){
			alert("즐겨찾기 기능은 로그인 후에 사용 가능합니다.");
		});
	});
</script>
<%} if(list.size() >= 5){  %>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mypageGo<%=list.get(4).getStoreId() %>").click(function(){
			alert("즐겨찾기 기능은 로그인 후에 사용 가능합니다.");
		});
	});
</script>
<%} if(list.size() >= 6){  %>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mypageGo<%=list.get(5).getStoreId() %>").click(function(){
			alert("즐겨찾기 기능은 로그인 후에 사용 가능합니다.");
		});
	});
</script>
<%} if(list.size() >= 7){  %>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mypageGo<%=list.get(6).getStoreId() %>").click(function(){
			alert("즐겨찾기 기능은 로그인 후에 사용 가능합니다.");
		});
	});
</script>
<%} if(list.size() >= 8){  %>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mypageGo<%=list.get(7).getStoreId() %>").click(function(){
			alert("즐겨찾기 기능은 로그인 후에 사용 가능합니다.");
		});
	});
</script>
<%} if(list.size() >= 9){  %>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mypageGo<%=list.get(8).getStoreId() %>").click(function(){
			alert("즐겨찾기 기능은 로그인 후에 사용 가능합니다.");
		});
	});
</script>
<%} %>



<%} %>
<script>
$( document ).ready(function() {
	/*WebStorge 최근 저장된 로그인정보 가져오기 */
	if(!window.localStorage) { 
		alert('이 Browser 는 Local Storage 를 지원하지 않습니다.'); 
	}else { 
			var key = localStorage.key(0); 
			var value = localStorage[key];
			$('#main_loginUserId').val(key);
			$('#main_loginUserPwd').val(value);
	};
	/* localStorage.clear(); */
	
	/*로그인 패스워드 확인여부*/
	$("#main_loginBtn").click(function(){
		if ($("#main_login_chk").is(":checked")) {
			$.fnWebStorge();
		}
		var str = $("#loginForm").serialize();
		$.ajax({
			type:'POST',
			url:"/easyStudy/pwCheck",
			data: str,
			success: function(data) {
				if(data.result==0){
					$("#main_loginPwCheckArea").css('display','block');
					$("#main_loginPwCheckArea").css('background','#ffeeee');
					$("#main_loginPwCheckLabel").css('color','red');
					$("#main_loginPwCheckLabel").html("이메일 또는 비밀번호를 다시 확인해주세요");
				}else{
					$("#main_loginPwCheckArea").css('display','none');
					$("#loginForm").submit();
				}			
			},
			error: function(data) {
				alert("에러");
			}			
		});
	});
	/*회원가입 아이디 존재여부확인*/
	var joinIdCheck = false;
	$("#main_joinUserId").blur(function(){
		if($("#main_joinUserId").val().length != 0){
			var str = $("#joinForm").serialize();
			$.ajax({
				type:'POST',
				url:"/easyStudy/idCheck",
				data: str,
				success: function(data) {
					var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
					if (re.test($("#main_joinUserId").val())) {
						if(data.result>0){
							$("#main_joinIdCheckArea").css('display','block');
							$("#main_joinIdCheckArea").css('background','#ffeeee');
							$("#main_joinIdCheckLabel").css('color','red');
							$("#main_joinIdCheckLabel").html("이미 존재하는 이메일 입니다");
						}else{
							$("#main_joinIdCheckArea").css('display','block');
							$("#main_joinIdCheckArea").css('background','#def7de');
							$("#main_joinIdCheckLabel").css('color','green');
							$("#main_joinIdCheckLabel").html("사용가능한 이메일입니다");
							joinIdCheck = true;
						}	
					 
				   return false;
				 }else{
					 $("#main_joinIdCheckArea").css('display','block');
						$("#main_joinIdCheckArea").css('background','#ffeeee');
						$("#main_joinIdCheckLabel").css('color','red');
						$("#main_joinIdCheckLabel").html("올바른 이메일 형식이 아닙니다.");
				 }
				
				},
				error: function(data) {
					alert("에러");
				}			
			});
		}
		
	});
	
	/*회원가입 비밀번호 사용가능여부확인*/
	var joinPwdCheck= false;
	$("#main_joinUserPwd").blur(function(){
		var joinPassword = $("#main_joinUserPwd").val();
		if(joinPassword.length !=0){
			if(joinPassword.length > 0 && joinPassword.length < 8){
				$("#main_joinPwCheckArea").css('display','block');
				$("#main_joinPwCheckArea").css('background','#ffeeee');
				$("#main_joinPwCheckLabel").css('color','red');
				$("#main_joinPwCheckLabel").html("비밀번호는 8글자이상 입력하시기 바랍니다");
			}else{
				$("#main_joinPwCheckArea").css('display','block');
				$("#main_joinPwCheckArea").css('background','#def7de');
				$("#main_joinPwCheckLabel").css('color','green');
				$("#main_joinPwCheckLabel").html("사용가능한 비밀번호 입니다");
				joinPwdCheck = true;
			}
		}
	});
	
	
	/*회원가입 비밀번호 동일여부확인*/
	var joinPwdChkCheck = false;
	$("#main_joinUserPwdChk").blur(function(){
		var joinPassword = $("#main_joinUserPwd").val();
		var joinPasswordChk = $("#main_joinUserPwdChk").val();
		if(joinPasswordChk.length !=0){
			if(joinPassword != joinPasswordChk ){
				$("#main_joinPwCheckChkArea").css('display','block');
				$("#main_joinPwCheckChkArea").css('background','#ffeeee');
				$("#main_joinPwCheckChkLabel").css('color','red');
				$("#main_joinPwCheckChkLabel").html("비밀번호가 동일하지 않습니다");
			}else{
				$("#main_joinPwCheckChkArea").css('display','block');
				$("#main_joinPwCheckChkArea").css('background','#def7de');
				$("#main_joinPwCheckChkLabel").css('color','green');
				$("#main_joinPwCheckChkLabel").html("비밀번호가 동일합니다");
				joinPwdChkCheck = true;
			}
		}
	});
	
	/*회원가입 nickname 동일여부확인*/
	var joinNicknameCheck= false;
	$("#main_joinUserNickName").blur(function(){
		if($("#main_joinUserNickName").val().length != 0){
			var str = $("#joinForm").serialize();
			$.ajax({
				type:'POST',
				url:"/easyStudy/nickNameCheck",
				data: str,
				success: function(data) {
					if(data.result>0){
						$("#main_joinNickCheckArea").css('display','block');
						$("#main_joinNickCheckArea").css('background','#ffeeee');
						$("#main_joinNickCheckLabel").css('color','red');
						$("#main_joinNickCheckLabel").html("이미 존재하는 nickname 입니다");
					}else{
						$("#main_joinNickCheckArea").css('display','block');
						$("#main_joinNickCheckArea").css('background','#def7de');
						$("#main_joinNickCheckLabel").css('color','green');
						$("#main_joinNickCheckLabel").html("사용가능한 nickname");
						joinNicknameCheck =true;
					}	
				},
				error: function(data) {
					alert("에러");
				}			
			});
		}
	});
	/*회원가입 가능 여부 확인*/
	$("#main_joinBtn").click(function(){
		if(joinIdCheck == true && joinPwdCheck == true && 
				joinPwdChkCheck == true && joinNicknameCheck == true){
			$("#joinForm").submit();
		}
			
	});
	
	/*비밀번호 찾기 아이디 존재여부확인*/
	$("#main_sendEamilBtn").click(function(){
		if($("#main_pwSearchUser").val().length != 0){
			var str = $("#pwSearchForm").serialize();
			$.ajax({
				type:'POST',
				url:"/easyStudy/idCheck",
				data: str,
				success: function(data) {
					if(data.result>0){
						$("#main_pwSearchCheckArea").css('display','none');
						$("#pwSearchForm" ).submit();
					}else{
						$("#main_pwSearchCheckArea").css('display','block');
						$("#main_pwSearchCheckArea").css('background','#ffeeee');
						$("#main_pwSearchCheckLabel").css('color','red');
						$("#main_pwSearchCheckLabel").html("존재하지 않은 이메일 입니다. 다시 확인해주세요");
					}	
				},
				error: function(data) {
					alert("에러");
				}			
			});
		}
		
	});
	
		/*********팝업창 관련 jQeury**********/
		// 로그인 버튼 클릭시
		$(".main_loginPopupBtn").leanModal({
			top : 100,
			overlay : 0.6,
			closeButton : ".modal_close"
		});
		$(".main_loginPopupBtn").click(function() {
			$("#main_login").show();
			$("#main_join").hide();
			$("#main_pwSearch").hide();
			return false;
		});
		// 회원가입 버튼 클릭시
		$(".main_joinPopupBtn").leanModal({
			top : 100,
			overlay : 0.6,
			closeButton : ".modal_close"
		});
		$(".main_joinPopupBtn").click(function() {
			$("#main_join").show();
			$("#main_login").hide();
			$("#main_pwSearch").hide();
			return false;
		});
		
		// 비밀번호찾기 버튼 클릭시
		$(".main_pwSearchBtn").leanModal({
			top : 100,
			overlay : 0.6,
			closeButton : ".modal_close"
		});
		$(".main_pwSearchBtn").click(function() {
			$("#main_pwSearch").show();
			$("#main_login").hide();
			$("#main_join").hide();
			return false;
		});
		
		/* 주변 화면으로 팝업 종료 */
		$("#lean_overlay").click(function(){
			$("#main_loginWrap input[type=text]").val("");
			$("#main_loginWrap input[type=email]").val("");
			$("#main_loginWrap input[type=password]").val("");
			$("#main_loginWrap input[type=checkbox]").prop('checked', false);
			$(".main_labelRow").css("display","none");
		});
		
	});
</script>
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
							<a id="nav_logo" href="index.jsp"><img class="logo"
								src="images/logo.png"></a>

							<!-- area search section -->
							<%if(member != null){ %>
							<input type="hidden" name="userid"
								value="<%=member.getUserId() %>">
							<%} %>
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
									<%if(member !=null){ %>
										<span id="nav_login" ><a class="main_loginPopupBtn" href="/easyStudy/logout">로그아웃</a></span>
										&nbsp;|&nbsp;
										<span id="nav_join" style="color:#fff"><%=member.getNickName() %></span>
									<%}else{ %>
										<span id="nav_login" ><a class="main_loginPopupBtn" href="#main_loginModal">로그인</a></span>
										&nbsp;|&nbsp;
										<span id="nav_join"><a class="main_joinPopupBtn" href="#main_joinModal">회원가입</a></span>
									<%} %>	
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
						<a href="/easyStudy/mmanagement?page=1" style="margin-left:300px;">회원 관리</a> 
					    <a href="/easyStudy/detail/StoreAdmin.jsp" style="margin-left:100px;">글쓰기</a>
					<%}else{ %>		
						<a href="/easyStudy/mbookmark?userid=<%=member.getUserId() %>" style="margin-left:300px;">즐겨찾기</a> 
						<a href="/easyStudy/mreview?page=1&nickname=<%=member.getNickName() %>" style="margin-left:50px;">내가 쓴 리뷰</a> 
						<a href="/easyStudy/mypage/myinfo.jsp" style="margin-left:40px;">내 정보 변경</a> 		
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
				<div id="banner">
    <div class="trislider">
       <div class="pieces" data-index="0" data-max="5" style="left: -1700px; display: block;">
                       <a href="" class="piece" style="background-image:url(images/content_04.jpg);"></a>
                       <a href="" class="piece" style="background-image:url(images/content_02.jpg)"></a>
                       <a href="" class="piece" style="background-image:url(images/content_03.jpg)"></a>
                       <a href="" class="piece" style="background-image:url(images/content_06.jpg)"></a>
                       <a href="" class="piece" style="background-image:url(images/content_05.jpg)"></a>
                    
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
        			<img class="left" alt="icon" src="images/left_arrow.png" />
        			<img class="right" alt="icon" src="images/right_arrow.png"/>
       			</div>
    </div>
</div>
			</div>
			<!--배너 슬라이더 이미지 banner_warp-->

			<!--쉬운 카테고리 선택 content_warp -->
			<div id="content_wrap">
				<div id="content" class="search">

					<div class="result">
						<span class="highlight"><%=areaW %></span>의 <span
							class="highlight"><%=categoryW %></span>이(가)<br> 총 <span
							class="highlight"><%=listCount %></span>개가 검색되었습니다.
					</div>

					<% if(member != null){ %>
					<ul class="sort_order_spread">
						<%if(sort.equals("view_count")) {%>
						<li class="selected"><a
							href="/easyStudy/search.store?sort=view_count&categorys=<%=cg%>&areas=<%=as%>&userid=<%=member.getUserId() %>">조회순</a></li>
						<li class=""><a
							href="/easyStudy/search.store?sort=avg_grade&categorys=<%=cg%>&areas=<%=as%>&userid=<%=member.getUserId() %>">별점순</a></li>
						</a>
						<%} else{ %>
						<li class=""><a
							href="/easyStudy/search.store?sort=view_count&categorys=<%=cg%>&areas=<%=as%>&userid=<%=member.getUserId() %>">조회순</a></li>
						<li class="selected"><a
							href="/easyStudy/search.store?sort=avg_grade&categorys=<%=cg%>&areas=<%=as%>&userid=<%=member.getUserId() %>">별점순</a></li>
						</a>
						<%} %>
					</ul>
					<%}else{ %>
					<ul class="sort_order_spread">
						<%if(sort.equals("view_count")) {%>
						<li class="selected"><a
							href="/easyStudy/search.store?sort=view_count&categorys=<%=cg%>&areas=<%=as%>">조회순</a></li>
						<li class=""><a
							href="/easyStudy/search.store?sort=avg_grade&categorys=<%=cg%>&areas=<%=as%>">별점순</a></li>
						</a>
						<%} else{ %>
						<li class=""><a
							href="/easyStudy/search.store?sort=view_count&categorys=<%=cg%>&areas=<%=as%>">조회순</a></li>
						<li class="selected"><a
							href="/easyStudy/search.store?sort=avg_grade&categorys=<%=cg%>&areas=<%=as%>">별점순</a></li>
						</a>
						<%} %>
					</ul>
					<%} %>
					<div class="list">
						<%for(int i=0; i<list.size(); i++){ %>
						<%if(i%3==0){ %>
						<div class="element medium first ">

							<a
								href="/easyStudy/DView?storeId=<%=list.get(i).getStoreId() %>&score=<%=list.get(i).getScore() %>"
								class="image"
								style="background-image: url(images/<%=list.get(i).getImgRoute() %>);">

								<div class="shading"></div> <%if( member != null && !("관리자".equals( member.getNickName() )) ){ %>
								<div class="top">
									<button class="" onclick="return false;" tabindex="-1">
										<div class="icon favorite"
											id="mypageGo<%=list.get(i).getStoreId() %>"></div>
									</button>
								</div> <%}else{} %>
								<div class="bottom">
									<span class="name"><%=list.get(i).getStoreName() %></span> <span
										class="area"><%=list.get(i).getLocalName() %>/<%=list.get(i).getCategoryName() %></span>
								</div>
							</a>

							<div class="desc">
								<div class="place_info">
									<div class="rating">
										<%
							if(list.get(i).getScore() <= 0.5){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore() <= 1){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore()<= 1.5){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span class="star even"></span>
											<span class="star odd"></span> <span class="star even"></span>
											<span class="star odd"></span> <span class="star even"></span>
											<span class="star odd"></span> <span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore()<= 2){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore()<= 2.5){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span class="star even"></span>
											<span class="star odd"></span> <span class="star even"></span>
											<span class="star odd"></span> <span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore()<= 3){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore()<= 3.5){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span class="star even"></span>
											<span class="star odd"></span> <span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore()<= 4){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span class="star odd"></span>
											<span class="star even"></span>
										</div>
										<%	}else if(list.get(i).getScore()<= 4.5){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span class="star even"></span>
										</div>
										<%	
							}else if(list.get(i).getScore()<= 5){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span>
										</div>
										<%
										}
									%>
										<div class="grade"><%=list.get(i).getScore() %>점
										</div>
									</div>
									<div class="budget">
										<span class="price"><%=list.get(i).getPrice() %></span>
									</div>
									<%if(list.get(i).getHomepage()== null){ %>
									<div class="comment"></div>
									<% }else{ %>
									<div class="comment">
										주소 :
										<%=list.get(i).getHomepage() %>
									</div>
									<%} %>
								</div>
							</div>
						</div>

						<%}else{ %>
						<div class="element medium">
							<a href="/easyStudy/DView?storeId=<%=list.get(i).getStoreId() %>&score=<%=list.get(i).getScore() %>" class="image"
								style="background-image: url(images/<%=list.get(i).getImgRoute() %>);">
								<div class="shading"></div> <%if( member != null && !("관리자".equals( member.getNickName() )) ){ %>
								<div class="top">
									<button class="" onclick="return false;" tabindex="-1">
										<div class="icon favorite"
											id="mypageGo<%=list.get(i).getStoreId() %>"></div>
									</button>
								</div> <%}else{} %>
								<div class="bottom">
									<span class="name"><%=list.get(i).getStoreName() %></span> <span
										class="area"><%=list.get(i).getLocalName() %>/<%=list.get(i).getCategoryName() %></span>
								</div>
							</a>

							<div class="desc">
								<div class="place_info">
									<div class="rating">
										<%
							if(list.get(i).getScore() <= 0.5){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore() <= 1){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore()<= 1.5){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span class="star even"></span>
											<span class="star odd"></span> <span class="star even"></span>
											<span class="star odd"></span> <span class="star even"></span>
											<span class="star odd"></span> <span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore()<= 2){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore()<= 2.5){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span class="star even"></span>
											<span class="star odd"></span> <span class="star even"></span>
											<span class="star odd"></span> <span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore()<= 3){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span class="star odd"></span>
											<span class="star even"></span> <span class="star odd"></span>
											<span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore()<= 3.5){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span class="star even"></span>
											<span class="star odd"></span> <span class="star even"></span>
										</div>
										<%
							}else if(list.get(i).getScore()<= 4){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span class="star odd"></span>
											<span class="star even"></span>
										</div>
										<%	}else if(list.get(i).getScore()<= 4.5){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span class="star even"></span>
										</div>
										<%	
							}else if(list.get(i).getScore()<= 5){
						%>
										<div class="stars">
											<span class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span> <span
												class="star odd active"></span> <span
												class="star even active"></span>
										</div>
										<%
										}
									%>
										<div class="grade"><%=list.get(i).getScore() %>점
										</div>
									</div>
									<div class="budget">
										<span class="price"><%=list.get(i).getPrice() %></span>
									</div>
									<%if(list.get(i).getHomepage()== null){ %>
									<div class="comment"></div>
									<% }else{ %>
									<div class="comment">
										주소 :
										<%=list.get(i).getHomepage() %>
									</div>
									<%} %>

								</div>
							</div>
						</div>
						<%} %>
						<%} %>

					</div>
					<div id="pager">
						<div class="page-list">
							<% if(member != null){ %>
							<ul class="pagination">
								<% if(currentPage <= 1){ %>
								<li>&lt;&lt;</li>
								<%}else{ %>
								<li><a
									href="/easyStudy/search.store?page=<%= currentPage - 1 %>&categorys=<%=cg%>&areas=<%=as%>&sort=<%=sort%>&userid=<%=member.getUserId() %>">&lt;&lt;</a></li>
								<% } %>


								<% for(int p = startPage; p <= endPage; p++){ 
				                if(p == currentPage){ %>
								<li class="active"><%= p %></li>
								<%}else{ %>
								<li><a
									href="/easyStudy/search.store?page=<%= p %>&categorys=<%=cg%>&areas=<%=as%>&sort=<%=sort%>&userid=<%=member.getUserId() %>"><%= p %></a></li>
								<% } %>
								<% } %>


								<% if(currentPage >= maxPage){ %>
								<li>&gt;&gt;</li>
								<%}else{ %>
								<li><a
									href="/easyStudy/search.store?page=<%= currentPage + 1 %>&categorys=<%=cg%>&areas=<%=as%>&sort=<%=sort%>&userid=<%=member.getUserId() %>">&gt;&gt;</a></li>
								<% } %>
							</ul>
							<%}else{ %>
							<ul class="pagination">
								<% if(currentPage <= 1){ %>
								<li>&lt;&lt;</li>
								<%}else{ %>
								<li><a
									href="/easyStudy/search.store?page=<%= currentPage - 1 %>&categorys=<%=cg%>&areas=<%=as%>&sort=<%=sort%>">&lt;&lt;</a></li>
								<% } %>


								<% for(int p = startPage; p <= endPage; p++){ 
				                if(p == currentPage){ %>
								<li class="active"><%= p %></li>
								<%}else{ %>
								<li><a
									href="/easyStudy/search.store?page=<%= p %>&categorys=<%=cg%>&areas=<%=as%>&sort=<%=sort%>"><%= p %></a></li>
								<% } %>
								<% } %>


								<% if(currentPage >= maxPage){ %>
								<li>&gt;&gt;</li>
								<%}else{ %>
								<li><a
									href="/easyStudy/search.store?page=<%= currentPage + 1 %>&categorys=<%=cg%>&areas=<%=as%>&sort=<%=sort%>">&gt;&gt;</a></li>
								<% } %>
							</ul>
							<%} %>
						</div>
					</div>


				</div>
				<!-- side bar 찾아본 페이지 -->
				<div id="sidebar_wrap" class="detail">
					<div id="find" class="sidebar">
						<div class="title">찾아 본 페이지</div>
						<ul class="list">
						<%if(cook.length==1){ %>
							<li class="item_none">최근 본 페이지가 없습니다.</li>
						<%}else if(cook.length < 5){ %>
							<%for(int i=1; i<cook.length; i++){ %>
								<% if(name[i] != null && item[i] !=null){%>
						
								<li class="item">
								<a class="i_wrap" href="/easyStudy/DView?storeId=<%=key[i]%>&score=<%=score[i]%>">
								
								<div id="sideimg" style="background-image:url(images/<%=item[i] %>)"></div>
								
								<div class="desc">
										<div class="name"><%=name[i] %></div>
									</div>
								</a>
									</li>
									
									<%}
								} 
							}else{	%>
							
								<%for(int i=cook.length-4; i<cook.length; i++){ %>
								<% if(name[i] != null && item[i] !=null){%>
						
								<li class="item">
								<a class="i_wrap" href="/easyStudy/DView?storeId=<%=key[i]%>&score=<%=score[i]%>">
								
								<div id="sideimg" style="background-image:url(images/<%=item[i] %>)"></div>
								
								<div class="desc">
										<div class="name"><%=name[i] %></div>
									</div>
								</a>
									</li>
								
									<%}
								} 
							}%>

						</ul>
					</div>
				</div>
				<!-- sidebar end -->
			</div>
		</div>
		<!-- content_warp 쉬운 카테고리 선택 -->


		<div id="footer_wrap">
      <div id="footer" style="width:970px; height:208px;">
         <img class="logo" src="images/logo.png" style="width:100px; height:auto;">
         <div class="slogan">특별한 공간에서 공부하는 방법.<br>즐거운 공부 하세요.<br>성공 할 수 있습니다.</div>
         <div class="author">(주)이지스터디  만든이들 : 최진형, 유의현, 하지수, 박유화, 양명준&nbsp;&nbsp;|&nbsp;&nbsp;HK정보교육원&nbsp;&nbsp;|&nbsp;&nbsp;등록번호 :778484758&nbsp;&nbsp;|&nbsp;&nbsp;1F 서울시 강남구 역삼동 152309 </div>
      </div>
   </div>

		<div id="main_loginWrap">
			<div id="main_loginModal" class="main_loginPopup"
				style="display: none;">
				<!-- 로그인 페이지-->
				<div id="main_login">
					<div id="main_loginHeader">
						<h1>SEARCH STUDY</h1>
					</div>

					<div class="sel">
						<form action="login" method="post" id="loginForm">
							<div class="main_inputRow" id="main_loginIdArea">
								<input type="email" placeholder="이메일" id="main_loginUserId"
									name="main_loginUserId" class="inputBox1">
							</div>
							<div class="main_labelRow" id="main_loginIdCheckArea"
								style="display: none">
								<label class="main_loginCheck" id="main_loginIdCheckLabel">
								</label>
							</div>
							<div class="main_inputRow" id="main_passwordArea">
								<input type="password" placeholder="비밀번호" id="main_loginUserPwd"
									name="main_loginUserPwd" class="inputBox1">
							</div>
							<div class="main_labelRow" id="main_loginPwCheckArea"
								style="display: none">
								<label class="main_loginCheck" id="main_loginPwCheckLabel">
									패스워드를 다시 확인해주세요</label>
							</div>
							<div id="main_loginBtn_area">
								<input type="button" value="로그인" id="main_loginBtn">
							</div>
							<div id="main_sendLoginBtn" class="box">
								<ul class="content">
									<li><input type="checkbox" id="main_login_chk" value="off">
										<label for="main_login_chk">로그인 상태 저장</label></li>
								</ul>
								
							</div>
						</form>
					</div>

					<div id="main_find_info">
						<div>
							<!-- <a href="#"> 아이디 찾기</a> <span>|</span> -->
							<a href="#main_pwSearchModal" class="main_pwSearchBtn"> 비밀번호
								찾기</a> <span>|</span> <a href="#main_joinModal"
								class="main_joinPopupBtn"> 회원가입</a>
						</div>
					</div>

				</div>
			</div>

			<div id="main_joinModal" class="main_joinPopup"
				style="display: none;">
				<!-- 회원가입 페이지-->
				<div id="main_join">
					<div id="main_joinHeader">
						<h1>SEARCH STUDY</h1>
					</div>

					<div>
						<form action="mjoin" method="post" id="joinForm">
							<div id="main_joinIdArea" class="divBox1">
								<input type="email" placeholder="이메일" class="inputBox1"
									name="main_joinUserId" id="main_joinUserId">
							</div>
							<div class="main_labelRow" id="main_joinIdCheckArea"
								style="display: none">
								<label class="main_loginCheck" id="main_joinIdCheckLabel">
								</label>
							</div>
							<div id="main_joinPwArea" class="divBox1">
								<input type="password" placeholder="비밀번호" class="inputBox1"
									name="main_joinUserPwd" id="main_joinUserPwd">
							</div>
							<div class="main_labelRow" id="main_joinPwCheckArea"
								style="display: none">
								<label class="main_loginCheck" id="main_joinPwCheckLabel">
								</label>
							</div>
							<div id="main_joinPwcheckArea" class="divBox1">
								<input type="password" placeholder="비밀번호확인" class="inputBox1"
									name="main_joinUserPwdChk" id="main_joinUserPwdChk">
							</div>
							<div class="main_labelRow" id="main_joinPwCheckChkArea"
								style="display: none">
								<label class="main_loginCheck" id="main_joinPwCheckChkLabel">
								</label>
							</div>
							<div id="main_joinNickArea" class="divBox1">
								<input type="text" placeholder="닉네임" class="inputBox1"
									name="main_joinUserNickName" id="main_joinUserNickName">
							</div>
							<div class="main_labelRow" id="main_joinNickCheckArea"
								style="display: none">
								<label class="main_loginCheck" id="main_joinNickCheckLabel">
								</label>
							</div>
							<div id="main_sendInfoBtn">
								<input type="button" value="가입하기" id="main_joinBtn">
							</div>
						</form>
					</div>
					<div id="main_backArea">
						<a href="#main_loginModal" class="main_loginPopupBtn"> 로그인</a>
					</div>
				</div>
			</div>

			<div id="main_pwSearchModal" class="main_pwSearchPopup"
				style="display: none;">
				<!-- 비밀번호찾기 페이지-->
				<div id="main_pwSearch">
					<div id="main_pwSearchHeader">
						<h1>SEARCH STUDY</h1>
					</div>

					<div>
						<form action="sendEmail" method="post" id="pwSearchForm">
							<div id="main_pwSearchArea" class="divBox1">
								<input type="text" placeholder="이메일" class="inputBox1"
									name="main_pwSearchUser" id="main_pwSearchUser">
							</div>
							<div class="main_labelRow" id="main_pwSearchCheckArea"
								style="display: none">
								<label class="main_loginCheck" id="main_pwSearchCheckLabel">
								</label>
							</div>
							<div id="main_sendEamilBtn">
								<input type="button" value="이메일로 보내기">
							</div>
						</form>
					</div>
					<div id="main_backArea">
						<a href="#main_loginModal" class="main_loginPopupBtn"> 로그인</a>
					</div>
				</div>
			</div>

		</div>

	</div>
</body>
</html>