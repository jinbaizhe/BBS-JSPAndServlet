<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="data.LoginBean"%>
<%@ page import="data.jdbcBean" %>
<%@ page import="java.sql.*" %>
<%@ page import="data.userBean" %>
 <jsp:include page="head.jsp"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>个人中心</title>


<script language="JavaScript">   
if (window != top)   
top.location.href = location.href;     
</script>  

</head>
<body>
	<%
				
				userBean user = new userBean();
				jdbcBean db = new jdbcBean();
				if(session.getAttribute("others") != null){
					session.removeAttribute("others"); //销毁之前的对象
				}
				
				session.setAttribute("others", user);//设置新的对象
				int userid = Integer.parseInt(request.getParameter("userid"));
				user.setUserid(userid);
				
				String sql = "select * from user where id=?";
				String []params = {String.valueOf(userid)};
				
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
                <li role="presentation" class="active"><a href="ohtersInformation.jsp">Ta的信息</a></li>
                  <li role="presentation"><a href="othersSend.jsp">Ta的发帖</a></li>
                  <li role="presentation"><a href="othersReply.jsp">Ta的回帖</a></li>
                  <li role="presentation"><a href="othersCollect.jsp">Ta的收藏</a></li>
            </ul>
		</div>
 
        <div class="col-xs-9">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        个人信息
                    </h3>
                </div>
                <div class="panel-body">			


                        <div class="form-group">
                            <img  height="70" src="<%=avatarSrc %>" width="70" />
                          

                        </div>
                        
                        <div class="form-group">
                            <label for="name">用户名:</label>
                            <br>
                            <%=user.getUsername() %>
                                   <p class="help-block">
                        </div>

                        <div class="form-group">
                            <label for="name">性 别:</label><br/>
                            <%= user.getSex()%>
                       
                     
                        </div>


                        <dl class="form-group">
                            <dt><label for="user_profile_blog">个人简介：</label></dt><br>
                            <%=user.getInfo() %>
                            <p class="help-block">	
                           
                        </dl>
                        <dl class="form-group">
                            <dt><label for="user_profile_blog">加入时间：</label></dt><br>
                            <%=user.getRegister_time() %>
                            <p class="help-block">	
                           
                        </dl>
                        
                   
                </div>
            </div>




                </div>
            </div>
        </div>
    </div>
</div>


</body>

</html>
 <jsp:include page="bottom.jsp"/>