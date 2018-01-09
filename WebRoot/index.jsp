<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="data.userBean" %>
<html>
  <head>
  <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <title>篮球BBS</title>
 <jsp:include page="head.jsp"/>
  </head>
  
  <body>
  	
  	<div id="myCarousel" class="carousel slide">
	<!-- 轮播（Carousel）指标 -->
	<ol class="carousel-indicators">
		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		<li data-target="#myCarousel" data-slide-to="1"></li>
		<li data-target="#myCarousel" data-slide-to="2"></li>
	</ol>   
	<!-- 轮播（Carousel）项目 -->
	<div class="carousel-inner">
		<div class="item active">
			<img src="image/play1.jpg" alt="First slide">
		</div>
		<div class="item">
			<img src="image/play2.jpg" alt="Second slide">
		</div>
		<div class="item">
			<img src="image/play3.jpg" alt="Third slide">
		</div>
	</div>
	<!-- 轮播（Carousel）导航 -->
	<a class="carousel-control left" href="#myCarousel" 
	   data-slide="prev">&lsaquo;</a>
	<a class="carousel-control right" href="#myCarousel" 
	   data-slide="next">&rsaquo;</a>
</div> 
  	
 	
  </body>
   <jsp:include page="bottom.jsp"/>
  
</html>
