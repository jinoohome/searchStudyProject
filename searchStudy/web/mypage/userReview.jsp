<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.Member, mypage.model.vo.Review, mypage.model.vo.ReviewImage, java.util.ArrayList"%>
<%
	Member member = (Member)session.getAttribute("member");
	ArrayList<Review> reviewPageList = (ArrayList<Review>)request.getAttribute("list");
	ArrayList<ReviewImage> reviewImagePageList = (ArrayList<ReviewImage>)request.getAttribute("reviewImagePageList");
	System.out.println("member" + member);
	
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
<link rel="stylesheet" type="text/css" href="/easyStudy/css/layout.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/function.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/review.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/star.css">
<link rel="stylesheet" type="text/css" href="/easyStudy/css/main.css"/>

<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyA29xkBAMN_bvriR7uE8dSqVFFwjKXZjcw"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript" src="/easyStudy/js/navigation.js"> </script>
<script type="text/javascript" src="/easyStudy/js/review.js"></script>
<script type="text/javascript" src="/easyStudy/js/jquery.leanModal.min.js"></script> <!--dialog -->


<title>DetailView</title>

  <style>
body{
	width:100%;
	margin:0;
}
a {
    text-decoration: none;
}
ol, ul {
    list-style: none;
}
#bannerSlider{
	position: relative;
    overflow: hidden; 
    width: 100%;
    height: 420px;
 	background-size: cover; 
    background-position: center center;
}
.trislider{
	width: 850px;
    height: 100%;
    position: relative;
    margin: 0 auto;
}
.pieces{
    width: 30000px;
    height: 100%;
    position: relative; 
    left: -730px;
    overflow: hidden; 
 	display: none; 
}
.pieces .piece{
    float: left;
    height: 100%;
    width: 730px;
    background-size: cover;
    background-position: center center;
    background-repeat: no-repeat;
}
.nav{
    position: absolute;
    top: 10%;
    width: 730px;
    margin: -25px auto 0 -130px;
   }
.nav i {
    position: absolute;
    width: 51px;
    height: 51px;
    cursor: pointer;
   /*  background-image: url(../image/recent_sheet.png);  */
}
.left{
		position: absolute;
 	 	 background-image: url(/easyStudy/images/detail_leftArrow.png);
    	width: 730px;
    	margin-left:155px;
}
.right{
     background-image: url(/easyStudy/images/detail_rightArrow.png);
     background-repeat: no-repeat;
    
}
.shadow{
	height: 100%;
    width: 30000px;
    position: absolute;
    top: 0;
    /* background-image: url(../image/mask.png); */
    background: white;
}
.left.shadow{
    right: 0;
    margin-right: 730px;
}
.right.shadow{
    left: 0;
    margin-left: 730px;
}
.index {
    position: absolute;
    left: 0;
    width: 100%;
    top: 22px;
    text-align: center;
    color: #fff;
}
.index li{
    display: inline-block;
    font-size: 11px;
    letter-spacing: 1px;
}
.index li.current {
    color: #c91b3c;
}
</style>
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
	
	/* 사진 올리기 input type=file 태그 안보이게하기  */
	.file_input_hidden{
		/* font-size: 45px; */
		/* right: 0px; */
		/* position: absolute; */
		top: 0px;
		opacity: 0; 
		z-index: -100;
    	width: 0px;
    	height: 0px;
	
		filter: alpha(opacity=0);
		-ms-filter: "alpha(opacity=0)";
		-khtml-opacity: 0;
		-moz-opacity: 0;
	}
	
	/* 뒷화면 어둡게 하기*/
	#lean_overlay {
		position: fixed;
		z-index: 100;
		top: 0px;
		left: 0px;
		height: 100%;
		width: 100%;
		background: #000;
		display: none;
	}
	/*로그인 팝업창*/
	.review_loginPopup {
		position: absolute;
		width: 600px;
		height: 500px;
		left: 45%;
		top: 60px;
		background: #FFF;
		z-index: 20000;
	}
</style>
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
	$("#bannerSlider").on("selectstart", function()
			{
			    return false;
			});
$("#bannerSlider").on("selectstart", function()
		{
		    return false;
		});
		function TriSlider(options) {
		    var slider = $(options.selector);
		    var pieces = slider.children(".pieces");
		    var max = pieces.data('max');
		    var fake_pieces = options.fake_pieces? options.fake_pieces:2;
		    var width = 730;
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
		var TriSlider = new TriSlider({'selector':'#bannerSlider>.trislider'});
});
</script>



</head>
<body>
		<!-- 상세페이지 내용  -->
		<div id="container">
			<div id="tabs">
				<div id="content_wrap">
					<div id="content" class="detail info">
					
						<!--reivew area  -->
						<div id="tabs-2">
						<div id="content" class="detail review">
					<!-- 	<ul class="tab">
							<li class="item "><a href="">정보</a></li>
							<li class="item"><a href="">포토</a></li>
							<li class="item"><a href="">리뷰</a></li>
						</ul> -->

						<div class="review_titleWrap">
						<div class="title" id="review_title">
								Review
						</div>
					</div>
					<!-- reviewPageList != null -->
					<%	if(reviewPageList != null){%>
					<%	for(int z = 0; z < reviewPageList.size(); z++){ %>
			
					<div class="body review list ">
						<div class="review_detail">
							<a class="i_wrap" href="/timeline/50b6dc12d20c781e6700004b">
							<i class="image border_radius circle" style="display: inline-block; background-image: url(&quot;http://c4.poing.co.kr/55ea410bd820b94b140000f7.jpg&quot;);"></i>
							</a>
							<div class="user">
								<div class="name ">
								<a href="#"><%= reviewPageList.get(z).getNickName() %></a>									
								</div>
								
								
								
								<%
									if(reviewPageList.get(z).getScore() == 5){
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
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 4.5){
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
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 4){
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
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 3.5){
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
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 3){
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
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 2.5){
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
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 2){
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
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 1.5){
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
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}else if(reviewPageList.get(z).getScore() == 1){
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
									<span style="display:inline-block;vertical-align:super;" data-id="57d11962668a4835bd000012" data-grade="50"><%= reviewPageList.get(z).getScore() %> 점</span>
								</div>
								<%
									}
								%>
								
							</div>
						
						<!--리뷰 내용 리스트  -->
							<div class="review">
								<div class="text">
								<pre><%= reviewPageList.get(z).getContents() %></pre>
								</div>
						<%-- 	<%	if(reviewImagePageList.get(z).getRenamePhoto1() != null){ %>
											
								<ul class="photo_list">
									<li class="item">
										<a class="review_loginPopupBtn" href="#review_loginModal">
									
										<%if( reviewImagePageList.get(z).getRenamePhoto1()!=null){ %>
										<img src="uploadFiles/<%= reviewImagePageList.get(z).getRenamePhoto1() %>" width="84" height="84">
										<%}else{ %>
										<%} %>
										
										<%if( reviewImagePageList.get(z).getRenamePhoto2()!=null){ %>
										<img src="uploadFiles/<%= reviewImagePageList.get(z).getRenamePhoto2() %>" width="84" height="84">
										<%}else{ %>
										<%} %>
										
										<%if( reviewImagePageList.get(z).getRenamePhoto3()!=null){ %>
										<img src="uploadFiles/<%= reviewImagePageList.get(z).getRenamePhoto3() %>" width="84" height="84">
										<%}else{ %>
										<%} %>
										
										<%if( reviewImagePageList.get(z).getRenamePhoto4()!=null){ %>
										<img src="uploadFiles/<%= reviewImagePageList.get(z).getRenamePhoto4() %>" width="84" height="84">
										<%}else{ %>
										<%} %>
										
										<%if( reviewImagePageList.get(z).getRenamePhoto5()!=null){ %>
										<img src="uploadFiles/<%= reviewImagePageList.get(z).getRenamePhoto5() %>" width="84" height="84">
										<%}else{ %>
										<%} %>
										
										</a>
									</li>
								</ul>
								
								
							<%	}else{ %>
								<div style="text-align: center">사진 없음</div>
							<%	} %>
 --%>									<div class="action">

										<a href="urdel?listNo=<%= reviewPageList.get(z).getListNo()%>&page=<%=currentPage %>&nickname=<%=member.getNickName() %>" onclick="return confirm('정말 리뷰를 삭제하시겠습니까?')" class="func">
											삭제하기
										</a>

									</div>
								</div>
							</div>
						</div>
					<%} %>
					<div id="pager">
				    	<div class="page-list">
				    	 <ul class="pagination">
				    	
				    	<% if(currentPage <= 1){ %> 
				             <li>&lt;&lt;</li>
				            <%}else{ %> 
				           	<li><a href="/easyStudy/ureview?page=<%= currentPage - 1 %>&nickname=<%=member.getNickName() %>">&lt;&lt;</a></li>
				            <% } %> 
				          
				            
				            <% for(int p = startPage; p <= endPage; p++){ 
				                if(p == currentPage){ %> 
				                	<li class="active"><%= p %></li>
				                <%}else{ %> 
				               <li> <a href="/easyStudy/ureview?page=<%= p %>&nickname=<%=member.getNickName() %>"><%= p %></a></li>
				                <% } %> 
				            <% } %> 
				            
				 			
				            <% if(currentPage >= maxPage){ %> 
				            	<li>&gt;&gt;</li>
				            <%}else{ %> 
				            <li><a href="/easyStudy/ureview?page=<%= currentPage + 1 %>&nickname=<%=member.getNickName() %>">&gt;&gt;</a></li>
				            <% } %>
				            
				            </ul>
				    	</div>
				    </div>
							
					<!--reviewPageList ==null  -->		
					<% }else{ %>	
						<br>
						<div style="text-align:center">리뷰가 없습니다.</div>
							
					<%	} %>	
						</div><!-- class= review  -->
					</div><!--tab2  -->
				</div>
			</div>
		</div>
	</div>
</div>

</div>

</body>

</html>