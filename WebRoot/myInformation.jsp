<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="data.LoginBean" %>
<%@ page import="data.jdbcBean" %>
<%@ page import="java.sql.*" %>
<%@ page import="data.userBean" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title></title>
</head>
<body>
	<%
		LoginBean login= (LoginBean)session.getAttribute("loginBean");
		userBean user = new userBean();
		jdbcBean db = new jdbcBean();
		int userid = login.getId(); //得到当前登录的用户id
		String sql = "select * from user where id=?";
		String []params = {String.valueOf(userid)};
		session.setAttribute("user", user); //当前登陆用户的bean存到session中
		try{
		ResultSet rs = db.query(sql, params);
		while(rs.next()){
			user.setUsername(rs.getString(2));
			user.setInfo(rs.getString(4));
			user.setAvatar(rs.getString(5));
			user.setSex(rs.getString(6));
			user.setStatus(rs.getInt(8));
			user.setType(rs.getInt(9));
			user.setRegister_time(rs.getString(11));
		}
		}catch(Exception e){}
			
	 %>
	 <% String avatarSrc = "avatar/"+user.getAvatar();   %>
	 <img src="<%=avatarSrc %>" width=100 height=100>
	<a href="updateMyInformation.jsp">更新自己的头像和档案</a>
	 	<h1>	<%=user.getUsername() %> </h1> <br>
	 	性别：<%=user.getSex() %><br>自我介绍:<%=user.getInfo() %><br>加入时间：<%=user.getRegister_time() %><br>
	

</body>
</html>