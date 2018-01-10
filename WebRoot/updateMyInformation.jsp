<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="data.userBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>修改个人信息</title>
 <jsp:include page="head.jsp"/>
</head>
<body>
<% userBean user = (userBean)session.getAttribute("user");
	   String avatarSrc = "avatar/"+user.getAvatar(); //头像路径
	   
	%>
	<div class="container" style="margin-top: 30px">
    <div class="row">
        <div class="col-xs-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation" class="active"><a href="MyZone.jsp">我的信息</a></li>
                  <li role="presentation"><a href="mySend.jsp">我的发帖</a></li>
                  <li role="presentation"><a href="myReply.jsp">我的回帖</a></li>
                  <li role="presentation"><a href="myCollect.jsp">我的收藏</a></li>
            </ul>
		</div>
<div class="col-xs-9">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        个人信息修改
                    </h3>
                </div>
                <div class="panel-body">
				
				<form id="form1" action="alterInformationServlet" method="post" >


                        <div class="form-group">
                            <img  height="70" src="<%=avatarSrc %>" width="70" />
                           <a href="alterAvatar.jsp"> 更新头像</a><br/>

                        </div>                       

                        <div class="form-group">
                            <label for="name">用户名</label>
                            <input id="username" type="text" class="form-control" name="username" id="name" width="200px" height="80px" value="<%=user.getUsername() %>"
                                   placeholder="请输入名称"> <p class="help-block"></p>
                        </div>

                        <div class="form-group">
                            <label for="name">性 别</label><br/> 
                             
                            <%if(user.getSex() == null || user.getSex()==""){
                            	user.setSex(" "); %>
                            
                            <%} %>
                            <% if (user.getSex().equals("男")){%>
                            男<input type="radio" name="sex" value="男" checked="checked"> 
                             &nbsp &nbsp女<input type="radio" name="sex" value="女">
                            <%} else if (user.getSex().equals("女")){%>
                            男<input type="radio" name="sex" value="男" >   
                             &nbsp &nbsp女<input type="radio" name="sex" value="女" checked="checked">
                           <%} else {%>
                             男<input type="radio" name="sex" value="男" >  
                             &nbsp &nbsp女<input type="radio" name="sex" value="女">
                           <%} %>
                        </div>


                        <dl class="form-group">
                            <dt><label for="user_profile_blog">个人简介：</label></dt>
                            <dd><textarea name="info" cols="20" rows="10"><%=user.getInfo()%></textarea>
                            <p class="help-block"></p>
                            </dd>
                        </dl>
                        
                        <input type="submit" value="提交"> 
                    </form>
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