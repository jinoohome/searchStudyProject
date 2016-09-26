/*$(function(){
		$('#box1').css("display","none");
		$('#box2').css("display","none");
		$('#nav_shading').css("display","none");
		
    	$('#nav_area').on('click', function(event) {
    		$('#nav_area').addClass("focus");
        	 $('#box1').show();
        	 $('#nav_shading').show();
    	});
    	$("#nav_shading, #off").click(function(event){
   		 $('#nav_area').removeClass("focus");
  			 $('#box1').hide();
  			 $('#nav_shading').hide();
  			event.stopPropagation();
   		});
    	
    	
    	$('#nav_genre').on('click', function() { 
    		$(this).addClass("focus");
        	$('#box2').show();
         	$('#nav_shading').show();
         	
  	 	});
    	$("#nav_shading, #off").click(function(event){
     		$('#nav_genre').removeClass('focus');
   			 $('#box2').hide();
   			 $('#nav_shading').hide();
   			event.stopPropagation();
		});
    	
    	
    	
    	
   	 $('input[type=checkbox]').change(function () {
   		 if ($(this).is(":checked")) {
	            $(this).closest("li").addClass('selected');
	        }
	        else {
	            $(this).closest("li").removeClass('selected');
	      }
   		 
   		 var checkCount = 0;
   		 var allLabel ='';
   		 var checkLast = '';
   		 var areaRow = document.getElementsByName("area");
   		 var catagoryRow = document.getElementsByName("catagory");
   		 
   		 for(var i=0; i<areaRow.length; i++){
   			 if(areaRow[i].checked==false){
   				$('#nav_area>.input>.selected').text("지역 선택");
   			 }
   		 }
   		 
   		 for(var i=0; i<areaRow.length; i++){
   			 if(areaRow[i].checked==true){
   				checkCount++;
   				checkLast = i; 
   			 }else{
   				 checkCount=0;
   			 }
   				 
   		 }
   		 
   		for(var i=0; i<areaRow.length; i++){
   			if(areaRow[i].checked==true){
   				var labelId = $(areaRow[i]).attr('id');
   				//console.log(labelId);
   				var label = $('label[for='+labelId+']').text();
   				if(checkCount ==1){
	            	allLabel += label; 
	            }else{                                            //체크된 체크박스의 개수가 여러 개 일때,
	            	if(i == checkLast){                     //체크된 체크박스 중 마지막 체크박스일 때,
	            		allLabel += label;  
	            		}else{
	            			allLabel += label+", ";	       			
	            		}
	            }
   				$('#nav_area>.input>.selected').text(allLabel);
   				document.getElementsByName("location").value = allLabel;
   			}
   		}
   		 
	    });*/




$(function(){
	$("body").on("beforeHide", ".shading_bg", function()
			{
				if(!$(this).is(":visible"))
				{
					return;
				}
				
				if($(this).hasClass("with_nav"))
				{
					$("#nav_wrap_shading").hide();
					$("#header").removeClass("shading high");
				}

				if(!$(this).hasClass("scroll_enable"))
				{
					var count = parseInt($("body").attr("data-count")) - 1;
					$("body").attr("data-count", count);
					if(count <= 0)
					{
						$("body").removeClass("popup_state");
					}
				}
			});
	
	function shadingHideEvent(selector, beforeFunc, afterFunc)
	{
		if($(selector).hasClass("with_nav"))
		{
			$("#nav_wrap_shading").on("click", function()
			{
				$(selector).click();
			});
		}

		if(typeof beforeFunc == "undefined")
		{
			beforeFunc = function() {};
		}
		if(typeof afterFunc == "undefined")
		{
			afterFunc = function() {};
		}
		$(document).on("keydown", function(e)
		{
			if(!inFocus && e.keyCode === 27)
			{
				$(selector).click();
			}
		});
		$(selector).on("click", function()
		{
			beforeFunc();
			$(this).hide();
			afterFunc();
		});
	}

	var inFocus = false;
	$("body").on("focus", "input, textarea", function()
	{
		inFocus = true;
	});

	$("body").on("blur", "input, textarea", function()
	{
		inFocus = false;
	});
	
	shadingHideEvent("#nav_shading.shading_bg", function()
	{
		$("#nav_container>.search.sel").removeClass('focus');
	});
	
});
   	 	
   	window.search = function(opt) {
   		var query = {
   			place_area: '',
   			category_types: '',
   			
   			r_num: 1531,
   			page: 1,
   			per_page: 12,
   		};
   		var key2 = {key: ""};

   		opt = $.extend({set:[], reset:[]}, opt);

   		for(var i in query) {
   			if(!query[i] || opt['reset'].indexOf(i) > -1)
   				delete query[i];
   		}
   		for(var i in opt['set']) {
   			if(i === 'key')
   				key2['key'] = opt['set'][i];
   			else
   				query[i] = opt['set'][i];
   		}
   		
   		var cookie = getCookie("Prs");
   		var result = jQuery.extend(true, [], query['place_area']);

   		if(cookie !== "")
   			cookie = cookie.split(',');

   		// 중복 제거.
   		for(var i=0; i<cookie.length; ++i)
   		{
   			var duple = false;
   			for(var j=0; j<result.length; ++j)
   			{
   				if(cookie[i] === result[j])
   				{
   					duple = true;
   					delete cookie[i];
   					break;
   				}
   			}
   		}

   		for(var i=0;i < cookie.length; ++i)
   		{
   			if(cookie[i])
   				result.push(cookie[i]);
   		}
   		
   		result = result.slice(0,5).join(',');
   		setCookie("Prs",result);
   		
   		var param = {query: query};
   		if(key2['key'].length > 0)
   			param['key2'] = key2;
   		
   		location.href = "easyStudy/search.text?nav_text?"+$.param(param);
   	};

   	/* search box */
$(document).ready(function(){
	
	
   		var query = {'place_area':[], 'category_types':[]};

   		// toggle box
   		$("#nav_container>.search.sel").click(function(e){
   			$(this).addClass('focus').siblings().removeClass('focus');
   			$("#nav_shading.shading_bg").show();
   			e.stopPropagation();
   		}).on('click', '.box', function(e){ e.stopPropagation() });

   		
   		// active area/genre checkbox
   		$("#nav_area>.box>.content>li, #nav_genre>.box>.content>li").click(function(e){
   			if(e.target.tagName === "LI")
   				$(this).children("input").click();
   		});
   		$("#nav_area>.box>.district input").change(function(){
   			
   			var id = $(this).attr('id');
   			var state = $(this).prop('checked');
   			var name = $(this).siblings("label").text();
   			var text = "지역 선택";

   			if(state)
   				query['place_area'].push(name);
   			else 
   				query['place_area'].splice(query['place_area'].indexOf(name), 1);
   				
   			if(query['place_area'].length > 0)
   			{
   				text = query['place_area'][0];
   				for(var i=1; i<query['place_area'].length; ++i) {
   					if(text.length+query['place_area'][i].length < 11)
   						text += ","+query['place_area'][i];
   					else
   					{
   						text += "외 "+(query['place_area'].length-i)+"개";
   						break;
   					}
   				}
   			}
   			$("#nav_area>.input>.selected").text(text);
   			$(this).parent().toggleClass('selected', state);
   		});
   		
   		$("#nav_genre>.box>.search_catagory input").change(function(){
   			var state = $(this).prop('checked');
   			var id = $(this).attr('id');
   			var name = $(this).siblings("label").text();
   			var text = "음식 종류 선택";

   			if(state)
   				query['category_types'].push(name);
   			else 
   				query['category_types'].splice(query['category_types'].indexOf(name), 1);

   			if(query['category_types'].length > 0)
   			{	
   				text = query['category_types'][0];
   				for(var i=1; i<query['category_types'].length; ++i) {
   					if(text.length+query['category_types'][i].length < 4)
   						text += ", "+query['category_types'][i];
   					else
   					{
   						text += "외 "+(query['category_types'].length-i)+"개";
   						break;
   					}
   				}
   			}
   			$("#nav_genre>.input>.selected").text(text);
   			
   			$(this).parent().toggleClass('selected', state);
   		});
   		// search button
   		$("#nav_btn").click(function() {
   			window.search({set: {
   								place_area: $.unique( $("#nav_area ul input:checked+label").map(function() { return $(this).text(); }).get() ).join(','),
   								category_types: $("#nav_genre ul input:checked+label").map(function() { return $(this).text(); }).get().join(','), 
   								key: $("#nav_search>input").val()
   						   },
   						   reset:[ 'r_num', 'page']});
   		});
   		// box button click
   		$("#nav_container>.search.sel>.box>button").click(function(){
   			$("#nav_shading.shading_bg").click();
   		});
   		
   		
});