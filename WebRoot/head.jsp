<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="data.LoginBean"%>
<%@ page import="data.jdbcBean" %>
<%@ page import="java.sql.*" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
  	<meta http-equiv="pragma" content="no-cache"> 
     <meta http-equiv="cache-control" content="no-cache"> 
     <meta http-equiv="expires" content="0">   
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    
</head>
<body>
 <nav class="navbar navbar-inverse" role="navigation">
    <div class="navbar-header">
        <a class="navbar-brand" href="#">篮球论坛</a>
    </div>

    <ul class="nav navbar-nav">
        <li><a href="index.jsp">首页</a></li>

       
        <li><a href="hot.jsp">论坛热帖</a></li>
        	
        <li><a href="essential.jsp">精华帖</a></li>
        <li><a href="allForum.jsp">版块总览</a></li>
    
    </ul> 
    <% //禁止浏览器缓存。
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1  
	response.addHeader("Cache-Control", "no-store"); //Firefox  
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0  
	response.setDateHeader("Expires", -1);  
	response.setDateHeader("max-age", 0);  
    
     %>
   <%
   		
    	LoginBean login= (LoginBean)session.getAttribute("loginBean");
   		String logname="";
    	String type="";
    	boolean flag = false;
    	try{
    	jdbcBean db = new jdbcBean();
    	if(login == null) {
    	%>  
    	<ul class="nav navbar-nav navbar-right user">
                <li><a href="Login.jsp">登录</a></li>
                <li><a href="register.jsp">注册</a></li>
            </ul>
            <p class="navbar-text navbar-right">尊敬的游客您好！</p>
            
	      
   
            <%}
    
    	else{
    	String sql = "select username,type from user where id=?";
    	String []params={String.valueOf(login.getId())};  //查询用户名 
    	ResultSet rs = db.query(sql, params);  
    	
    	String sql2 = "select userid from bbs.admin";  //查询管理员id 
		ResultSet rs2 = db.query(sql2);
		String admin_id = "";
    	
    	
    	
    	
    	if(rs.next()){
    		logname = rs.getString(1);
    		type = rs.getString(2);
    	}
    	
    	while(rs2.next()){ 
    		admin_id = rs2.getString(1);
    		if(admin_id.equals(String.valueOf(login.getId())))
    			{flag=true;
    			 break;
    			}
    	}
    	
    	
    		
    	
    	if(type.equals("1")){
    	%>   <ul class="nav navbar-nav navbar-right user">

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <%=logname%> <span class="caret"></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li ><a href="managerPage.jsp">管理</a></li>
                             <li ><a href="MyZone.jsp">个人中心</a></li>
                            <li class="divider"></li>
                            <li><a href="exitServlet">退出登录</a></li>
                        </ul>
                    </li>
                </ul>
                 <p class="navbar-text navbar-right">尊敬的总管理员,您好！</p>
             
             <%}
    			
    	else if(flag){%>
    	 <ul class="nav navbar-nav navbar-right user">

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <%=logname%> <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu">
                           
                             <li ><a href="MyZone.jsp">个人中心</a></li>
                            <li class="divider"></li>
                            <li><a href="exitServlet">退出登录</a></li>
                        </ul>
                    </li>
                </ul>
                 <p class="navbar-text navbar-right">尊敬的板块管理员,您好！</p>

    	<% }
    	else{%>
    	 <ul class="nav navbar-nav navbar-right user">

                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <%=logname%> <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu">
                           
                             <li ><a href="MyZone.jsp">个人中心</a></li>
                            <li class="divider"></li>
                            <li><a href="exitServlet">退出登录</a></li>
                        </ul>
                    </li>
                </ul>
                 <p class="navbar-text navbar-right">尊敬的用户,您好！</p>
    	<% 
    	}
    	}
    	}catch(Exception e){}
     %>
  <form class="navbar-form navbar-right" role="search" action="Search.jsp" name="search" method="post">
		       <div class="input-group">
	         <input type="text" class="form-control" name="searchContent" placeholder="search">
	        <span class="input-group-addon"><span class="glyphicon glyphicon-search" onclick="search.submit()"></span> </span>
	     		 </div>
      		</form> 
  </nav>
</body>
</html>
