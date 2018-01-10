<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="data.LoginBean"%>
<%@ page import="data.jdbcBean" %>
<%@ page import="java.sql.*" %>
<%@ page import="data.userBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>个人中心</title>
 <jsp:include page="head.jsp"/>

<script language="JavaScript">   
if (window != top)   
top.location.href = location.href;     
</script>  

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
				
 <% String avatarSrc = "avatar/"+user.getAvatar();  %>
 
 <div class="container" style="margin-top: 30px">
    <div class="row">
        <div class="col-xs-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation"><a href="MyZone.jsp">我的信息</a></li>
                  <li role="presentation"><a href="mySend.jsp">我的发帖</a></li>
                  <li role="presentation"><a href="myReply.jsp">我的回帖</a></li>
                  <li role="presentation"><a href="myCollect.jsp">我的收藏</a></li>
                  <li role="presentation" class="active"><a href="alterPassword.jsp">我的安全</a></li>
            </ul>
		</div>
 
        <div class="col-xs-9">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        修改密码
                    </h3>
                </div> 
                <div class="panel-body">			

 			<form action="alterPasswordServlet" method="post">
                        <div class="form-group">
                            <label for="name">请输入旧密码：</label>
        <input id="password" type="password" class="form-control" name="oldPassword" id="name" width="200px" height="80px" placeholder="请输入旧密码"> <p class="help-block"></p>
                     
                        </div>
                        
                        <div class="form-group">
                             <label for="name">请输入新密码：</label>
                                 <input id="password" type="password" class="form-control" name="newPassword" id="name" width="200px" height="80px" placeholder="请输入新密码"> <p class="help-block"></p>
                     
                        </div>
                        
		<div style="float:left;width: 50%;padding: 20px;">
                <input type="submit" class="btn btn-primary" value="修改"
                   style="margin:auto;width: 80%;height: 50px;padding: 13px;"></input>
            </div>
                      
           </form>             
                   
                </div>
            </div>




                </div>
            </div>
        </div>
    </div>
</div>


</body>
 <jsp:include page="bottom.jsp"/>
</html>
<script> 
//取出传回来的参数error比较
  var infoi ='<%=request.getParameter("info")%>';
  if(infoi=='empty'){
   alert("密码不能为空！");
  }
  else if(infoi=='duplicate'){
  	alert("新旧密码不能相同！")
  }
  else if(infoi=='success'){
  	alert("修改成功！")
  }
  else if(infoi=='fail'){
  	alert("出现不可预见的错误，修改失败！")
  }
   else if(infoi=='wrong'){
  	alert("旧密码输入错误！")
  }
  else {
  
  }
</script>