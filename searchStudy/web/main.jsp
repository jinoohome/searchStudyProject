<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="css/main.css"/>
 <script type="text/javascript" src="js/jquery-3.1.0.min.js"> </script>
<title>main</title>
<script>
	$(function(){
		$('#box1').css("display","none");
		$('#box2').css("display","none");
		$('#nav_shading').css("display","none");
		
    	$('#nav_area').on('click', function(event) {
    		$(this).toggleClass("focus");
        	 $('#box1').toggle();
        	 $('#nav_shading').toggle();
        	 
        	 $('#nav_shading').click(function(){
        		 $('#nav_area').removeClass("focus");
       			 $('#box1').hide();
       			 $('#nav_shading').hide();
        	});
    	});
    	
    	
    	$('#nav_genre').on('click', function(event) { 
    		$(this).toggleClass("focus");
        	$('#box2').toggle();
         	$('#nav_shading').toggle();
         	
         	$('#nav_shading').click(function(){
         		$('#nav_genre').removeClass("focus");
       			 $('#box2').hide();
       			 $('#nav_shading').hide();
      	 	});
    	});
    	
    	 $('input[type=checkbox]').change(function () {
    	        if ($(this).is(":checked")) {
    	            $(this).closest("li").addClass('selected');
    	        }
    	        else {
    	            $(this).closest("li").removeClass('selected');
    	        };

    	    });
    		
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
			<div id="nav_shading" class="shading_bg"></div>
				<!-- logo section -->
			<a id="nav_logo" href=""><img class="logo" src="images/logo.png"></a>

				<!-- area search section -->
			<div id="nav_area" class="search sel">
				<div class="input">
					<div class="selected">지역 선택</div>
						<!--  <i class="icon searchbox arrow">▼</i>-->
				</div>
				<div class="box" id="box1">
					<ul class="district content">
						<li>
						<input type="checkbox" name="area" id="L10">
						<label for="L10">강남</label>
    					</li>
						<li><input type="checkbox" name="area" id="L20">
							<label for="L20">종로</label></li>
						<li><input type="checkbox" name="area" id="L30">
							<label for="L30">신촌</label></li>
					</ul>
						

					<button class="confirm red_fill border_radius soft" type="button" tabindex="-1">확인</button>
				</div>
			</div>
				<!-- genre search section -->
			<div id="nav_genre" class="search sel">
				<div class="input">
					<div class="selected">카테코리 선택</div>
				</div>
				<div class="box" id="box2">
					<ul class="search_catagory content">
						<li>
						<input type="checkbox" name="catagory" id="S10">
						<label for="S10">도서관/독서실</label>
    					</li>
						<li><input type="checkbox" name="catagory" id="S20">
						<label for="S20">스터디룸</label></li>
						<li><input type="checkbox" name="catagory" id="S30">
						<label for="S30">스터디카페</label></li>
						<li><input type="checkbox" name="catagory" id="S40">
						<label for="S40">스터디룸/스터디카페</label></li>
					</ul>
					<button class="confirm red_fill border_radius soft" type="button" tabindex="-1">확인</button>
				</div>
					
			</div>
				
			<button type="button" id="nav_btn" class="search" tabindex="-1">검색</button>
				
				<!-- account section -->
				<div id="nav_account">
						<div id="nav_guest">
							<span id="nav_login">로그인</span>
							&nbsp;|&nbsp;
							<span id="nav_join">회원가입</span>
						</div>
				</div>
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
			<div class="trislider">
				<div style="width:850px; height:420px; background:green;"></div>
				
			</div>
		</div>
		<!--배너 슬라이더 이미지 banner_warp-->
		
		<!--쉬운 카테고리 선택 content_warp -->
		<div id="content_wrap">
			<div class="section">
    			<div class="title">지역별</div>
    			<div class="body">
       				 <div class="element large first ">
    					<div class="image">
       						<div class="shading"></div>
        		
                    		<div class="center">
               					<div class="middle">
                                <div class="title"><h2>GANGNAM</h2></div>
                                <div class="subtitle"><h1>강남</h1></div>
                                </div>
           					</div>
            			</div>
    				</div>
    				
					<div class="element large">
    					<div class="image">
       						<div class="shading"></div>
        		
                    		<div class="center">
               					<div class="middle">
                                <div class="title"><h2>JONGNO</h2></div>
                                <div class="subtitle"><h1>종로</h1></div>
                                </div>
           					</div>
            			</div>
    				</div>
    				
    				<div class="element large">
    					<div class="image">
       						<div class="shading"></div>
        		
                    		<div class="center">
               					<div class="middle">
                                <div class="title"><h2>SINCHON</h2></div>
                                <div class="subtitle"><h1>신촌</h1></div>
                                </div>
           					</div>
            			</div>
    				</div>
    				
   				</div>
    
     
      			<div class="title">종류별</div>
    			<div class="body">
       				 <div class="element large first ">
    					<div class="image">
       						<div class="shading"></div>
        		
                    		<div class="center">
               					<div class="middle">
                                <div class="title"><h2>ROOM</h2></div>
                                <div class="subtitle"><h1>스터디룸</h1></div>
                                </div>
           					</div>
            			</div>
    				</div>
    				
					<div class="element large">
    					<div class="image">
       						<div class="shading"></div>
        		
                    		<div class="center">
               					<div class="middle">
                                <div class="title"><h2>CAFE</h2></div>
                                <div class="subtitle"><h1>스터디카페</h1></div>
                                </div>
           					</div>
            			</div>
    				</div>
    				
    				<div class="element large">
    					<div class="image">
       						<div class="shading"></div>
        		
                    		<div class="center">
               					<div class="middle">
                                <div class="title"><h2>READING ROOM & LIBRARY</h2></div>
                                <div class="subtitle"><h1>독서실 & 도서관</h1></div>
                                </div>
           					</div>
            			</div>
    				</div>
    				
   				</div>
   				
			</div>	
		</div>
	</div>
	<!--쉬운 카테고리 선택 content_warp -->
	
	
	<div id="footer_wrap">
		<div style="width:970px; height:208px; background:gray;"></div>
	</div>
	
</div>
</body>
</html>