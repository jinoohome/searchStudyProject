<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="detail.model.vo.Store,detail.model.vo.Image, java.util.* , member.model.vo.*"%>
<%
	Store s=(Store)request.getAttribute("store");
	Image i=(Image)request.getAttribute("image"); 
	Member member = (Member)session.getAttribute("member");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"> </script>
<script type="text/javascript" src="/easyStudy/js/navigation.js"> </script>
<script type="text/javascript" src="/easyStudy/js/jquery.leanModal.min.js"></script> <!--dialog -->
<script type="text/javascript" src="http://maps.googleapis.com/maps/api/js?key=AIzaSyA29xkBAMN_bvriR7uE8dSqVFFwjKXZjcw"></script>
<script type="text/javascript" src="/easyStudy/js/jquery-3.1.0.min.js"></script>
<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

<link rel="stylesheet" href="/easyStudy/css/main.css" type="text/css"/>
<link rel="stylesheet"  href="/easyStudy/css/detail.css" type="text/css"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

<title>DetailView</title>
<!-- GoogoleMap Asynchronously Loading the API ********************************************* -->
<script type="text/javascript">
/*WebStorge 로그인 상태저장 */
<%-- $.fnWebStorge = function() {
		var storeId = <%=s.getStoreId()%>;
		var StoreMainImg = <%=i.getPhoto1()%>;
		if(id.length != 0 && password !=0){
			localStorage.setItem(storeId, StoreMainImg);
		}

}
 --%>
    function initialize() {
        var mapOptions = {
                            zoom: 18, // 지도를 띄웠을 때의 줌 크기
                            mapTypeId: google.maps.MapTypeId.ROADMAP
                        };
         
        var map = new google.maps.Map(document.getElementById("map-canvas"), // div의 id과 값이 같아야 함. "map-canvas"
                                    mapOptions);
         
        var size_x = 40; // 마커로 사용할 이미지의 가로 크기
        var size_y = 40; // 마커로 사용할 이미지의 세로 크기
     
        // 마커로 사용할 이미지 주소
        var image = new google.maps.MarkerImage( '<%= s.getAddress() %>',
                                                    new google.maps.Size(size_x, size_y),
                                                    '',
                                                    '',
                                                    new google.maps.Size(size_x, size_y));
         
        // Geocoding *****************************************************
        var address = '<%= s.getAddress() %>'; // DB에서 주소 가져와서 검색하거나 왼쪽과 같이 주소를 바로 코딩.
        var marker = null;
        var geocoder = new google.maps.Geocoder();
        geocoder.geocode( { 'address': address}, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                marker = new google.maps.Marker({
                                map: map,
                                icon: image, // 마커로 사용할 이미지(변수)
                                title: '<%= s.getStoreName() %>', // 마커에 마우스 포인트를 갖다댔을 때 뜨는 타이틀
                                position: results[0].geometry.location
                            });
              
                // 마커를 클릭했을 때의 이벤트. 말풍선 뿅~
/*                  var infowindow = new google.maps.InfoWindow({ content: content});
                google.maps.event.addListener(marker, "click", function() {infowindow.open(map,marker);});  */
            } else {
                alert("Geocode was not successful for the following reason: " + status);
            }
        });
        // Geocoding // *****************************************************
         
    }
    google.maps.event.addDomListener(window, 'load', initialize);
</script>


<script>
  $(function() {
    /* $("#tabs").tabs(); */
  });
  </script>
  
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
    left: -850px;
    overflow: hidden; 
 	display: none; 

}
.pieces .piece{
    float: left;
    height: 100%;
    width: 850px;
    background-size: cover;
    background-position: center center;
    background-repeat: no-repeat;
}
.nav{
    position: absolute;
    top: 30%;
    width: 850px;
   }

.nav i {
    position: absolute;
    width: 51px;
    height: 51px;
    cursor: pointer;
    margin-left:500px;
   /*  background-image: url(../image/recent_sheet.png);  */
}
.left{
	
 	  background-image: url(/easyStudy/images/detail_leftArrow.png);
 	  background-repeat: no-repeat;
 	  /*  margin-left : 25px; */
}
.right{
	right: 0;
     background-image: url(/easyStudy/images/detail_rightArrow.png);
     background-repeat: no-repeat;
     /* margin-right:9px; */
    
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
    margin-right: 850px;

}
.right.shadow{
    left: 0;
    margin-left: 850px;

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
		var TriSlider = new TriSlider({'selector':'#bannerSlider>.trislider'});
});

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
						<a id="nav_logo" href=""><img class="logo"
							src="images/logo.png"></a>

						<!-- area search section -->
						<div id="nav_area" class="search sel">
							<div class="input">
								<div class="selected">지역 선택</div>
							</div>
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
				</div>
			</div>
		</div>

		<!-- 상세페이지 내용  -->
		<div id="container">
			<!--배너 슬라이더 이미지 banner_warp-->
			<div id="banner_warp">
				<div id="banner">
					<div class="detail_imageArea">
						<img src="/easyStudy/images/<%=i.getPhoto1()%>" id="detail_titleImage">
					</div>
				</div>
			</div>
			<div class="nav">
				<i class="icon left"></i> <i class="icon right"></i>
			</div>

			<div id="tabs">
				<div id="content_wrap">
					<div id="content" class="detail info">
					<div id="detail_title"><%=s.getStoreName() %></div>
					<div><%=s.getLocalName() %> / <%=s.getCategoryName() %></div>
						<!-- <ul class="tab">
							<li class="item "><a href="#tabs-1">정보</a></li>
							<li class="item"><a href="#tabs-2">포토</a></li>
							<li class="item"><a href="#tabs-3">리뷰</a></li>
						</ul> -->
						
						<!-- 정보 탭 관련 정보  -->
						<div id="tabs-1">
							<form action="DView" method="post">
								<div id="detail_firstImageWrap">
									<%if (i !=null){  %> 
									<div id="banner_wrap">
										<div id="bannerSlider">
										    <div class="trislider">
										    	<div class="pieces" data-index="0" data-max="5" style="left: -1700px; display: block;">
										    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto1() %>);"></a>
										    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto2() %>)"></a>
										    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto3() %>)"></a>
										    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto4() %>)"></a>
										    		    			<a href="" class="piece" style="background-image:url(/easyStudy/images/<%=i.getPhoto5() %>)"></a>
										    		    		
										    		    	</div>
										   		<div class="left shadow"></div>
										        <div class="right shadow"></div>
										        <ul class="index">
										        	        	<!-- 	<li data-id="0" class="current">●</li>
										        	        		<li data-id="1" class="">●</li>
										        	        		<li data-id="2" class="">●</li>
										        	        		<li data-id="3" class="">●</li>
										        	        		<li data-id="4" class="">●</li> -->
										        	        </ul> 
										        <div class="nav">
										        	<i class="icon left"></i>
										        	<i class="icon right"></i>
										        </div>
										    </div>
										</div></div>
									
									
									<%-- <img src="/easyStudy/images/<%=i.getPhoto1()%>" id="detail_firstImage"> --%>
								</div>
									<% } %>
								<p class="detail_h">공간소개</p>
								<table border="1" id="detail_table" style="">
									<tr>
										<th>상점명</th>
										<td><%=s.getStoreName() %></td>
									</tr>
									<tr>
										<th> </th>
										<td></td>
									</tr>
									
									<tr>
										<th>주 소</th>
										<td><%=s.getAddress() %></td>
									</tr>
									<tr>
										<th>사 이 트</th>
										<td><%=s.getHomepage() %></td>
									</tr>
									<tr>
										<th>평일 영업</th>
										<td><%=s.getWeekDayTime() %></td>
									</tr>
									<th>주말 영업</th>
									<td><%=s.getWeekEndTime() %></td>
									</tr>
									<tr>
										<th>가 격</th>
										<td><%=s.getPrice() %></td>
									</tr>
									<tr>
										<th>전화번호</th>
										<td><%=s.getTell() %></td>
									</tr>
									<tr>
										<th>비 고</th>
										<td><%=s.getEtc() %></td>
									</tr>
									
								</table>
							</form>
						
								<form action="DMap" method="post">
								<p class="detail_h">지도</p>
									<div id="map-canvas" style="width: 100%; height: 340px"></div>
									<br>
								<%-- 	<%
									if(member !=null){
										if(member.getUserId().equals("admin")){
									%> --%>
									<div id="detail_btnAera">
									<a href="/easyStudy/StoreUpdateView?storeId=<%= s.getStoreId() %>">
									<input type="button" value="수정하기" id="detail_updateBtn"></a> &nbsp; &nbsp; 
									<a href="/easyStudy/StoreDelete?storeId=<%= s.getStoreId() %>" >
									<input type="button" value="삭제하기" id="detail_deleteBtn"></a> &nbsp; &nbsp;
									</div>
									<%-- <% 		} 
										}		
										%> --%>
									
								</form>
						</div>
						<div id="tabs-2">
							
						</div>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>