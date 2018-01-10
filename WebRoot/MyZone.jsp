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
<title>��������</title>


<script language="JavaScript">   
if (window != top)    
top.location.href = location.href;     
</script>  

</head>
<body>
	<%
				LoginBean login= (LoginBean)session.getAttribute("loginBean");
				userBean user = new userBean();
				
				int userid = login.getId(); //�õ���ǰ��¼���û�id
				String sql = "select * from user where id=?";
				String []params = {String.valueOf(userid)};
				session.setAttribute("user", user); //��ǰ��½�û���bean�浽session��
				try{ 
				jdbcBean db = new jdbcBean();
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
                <li role="presentation" class="active"><a href="MyZone.jsp">�ҵ���Ϣ</a></li>
                  <li role="presentation"><a href="mySend.jsp">�ҵķ���</a></li>
                  <li role="presentation"><a href="myReply.jsp">�ҵĻ���</a></li>
                  <li role="presentation"><a href="myCollect.jsp">�ҵ��ղ�</a></li>
                  <li role="presentation"><a href="alterPassword.jsp">�ҵİ�ȫ</a></li>
            </ul>
		</div>
 
        <div class="col-xs-9">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        ������Ϣ
                    </h3>
                </div>
                <div class="panel-body">			


                        <div class="form-group">
                            <img  height="70" src="<%=avatarSrc %>" width="70" />
                           <a href="updateMyInformation.jsp"> �޸�ͷ��͸�����Ϣ</a><br/>

                        </div>
                        
                        <div class="form-group">
                            <label for="name">�û���:</label>
                            <br>
                            <%=user.getUsername() %>
                                   <p class="help-block">
                        </div>

                        <div class="form-group">
                            <label for="name">�Ա�:</label><br/>
                            <%= user.getSex()%>
                       
                     
                        </div>


                        <dl class="form-group">
                            <dt><label for="user_profile_blog">���˼�飺</label></dt><br>
                            <%=user.getInfo() %>
                            <p class="help-block">	
                           
                        </dl>
                        <dl class="form-group">
                            <dt><label for="user_profile_blog">����ʱ�䣺</label></dt><br>
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
 <jsp:include page="bottom.jsp"/>
</html>
<script> 
//ȡ���������Ĳ���error�Ƚ�
  var errori ='<%=request.getParameter("error")%>';
  if(errori=='illegal'){
   alert("�û�������Ϊ�գ�");
  }
  else if(errori=='duplicate'){
  	alert("���û����Ѿ���ռ�ã��޸�ʧ�ܣ�")
  }
  else {
  
  }
</script>