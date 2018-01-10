<%@ page language="java" contentType="text/html; charset=gb2312"
    pageEncoding="gb2312"%>
<%@ page import="data.userBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>�޸ĸ�����Ϣ</title>
 <jsp:include page="head.jsp"/>
</head>
<body>
<% userBean user = (userBean)session.getAttribute("user");
	   String avatarSrc = "avatar/"+user.getAvatar(); //ͷ��·��
	   
	%>
	<div class="container" style="margin-top: 30px">
    <div class="row">
        <div class="col-xs-3">
            <ul class="nav nav-pills nav-stacked">
                <li role="presentation" class="active"><a href="MyZone.jsp">�ҵ���Ϣ</a></li>
                  <li role="presentation"><a href="mySend.jsp">�ҵķ���</a></li>
                  <li role="presentation"><a href="myReply.jsp">�ҵĻ���</a></li>
                  <li role="presentation"><a href="myCollect.jsp">�ҵ��ղ�</a></li>
            </ul>
		</div>
<div class="col-xs-9">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        ������Ϣ�޸�
                    </h3>
                </div>
                <div class="panel-body">
				
				<form id="form1" action="alterInformationServlet" method="post" >


                        <div class="form-group">
                            <img  height="70" src="<%=avatarSrc %>" width="70" />
                           <a href="alterAvatar.jsp"> ����ͷ��</a><br/>

                        </div>                       

                        <div class="form-group">
                            <label for="name">�û���</label>
                            <input id="username" type="text" class="form-control" name="username" id="name" width="200px" height="80px" value="<%=user.getUsername() %>"
                                   placeholder="����������"> <p class="help-block"></p>
                        </div>

                        <div class="form-group">
                            <label for="name">�� ��</label><br/> 
                             
                            <%if(user.getSex() == null || user.getSex()==""){
                            	user.setSex(" "); %>
                            
                            <%} %>
                            <% if (user.getSex().equals("��")){%>
                            ��<input type="radio" name="sex" value="��" checked="checked"> 
                             &nbsp &nbspŮ<input type="radio" name="sex" value="Ů">
                            <%} else if (user.getSex().equals("Ů")){%>
                            ��<input type="radio" name="sex" value="��" >   
                             &nbsp &nbspŮ<input type="radio" name="sex" value="Ů" checked="checked">
                           <%} else {%>
                             ��<input type="radio" name="sex" value="��" >  
                             &nbsp &nbspŮ<input type="radio" name="sex" value="Ů">
                           <%} %>
                        </div>


                        <dl class="form-group">
                            <dt><label for="user_profile_blog">���˼�飺</label></dt>
                            <dd><textarea name="info" cols="20" rows="10"><%=user.getInfo()%></textarea>
                            <p class="help-block"></p>
                            </dd>
                        </dl>
                        
                        <input type="submit" value="�ύ"> 
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