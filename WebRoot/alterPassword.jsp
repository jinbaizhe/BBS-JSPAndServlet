<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<%@ page import="data.LoginBean"%>
<%@ page import="data.jdbcBean" %>
<%@ page import="java.sql.*" %>
<%@ page import="data.userBean" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>��������</title>
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
				int userid = login.getId(); //�õ���ǰ��¼���û�id
				String sql = "select * from user where id=?";
				String []params = {String.valueOf(userid)};
				session.setAttribute("user", user); //��ǰ��½�û���bean�浽session��
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
                <li role="presentation"><a href="MyZone.jsp">�ҵ���Ϣ</a></li>
                  <li role="presentation"><a href="mySend.jsp">�ҵķ���</a></li>
                  <li role="presentation"><a href="myReply.jsp">�ҵĻ���</a></li>
                  <li role="presentation"><a href="myCollect.jsp">�ҵ��ղ�</a></li>
                  <li role="presentation" class="active"><a href="alterPassword.jsp">�ҵİ�ȫ</a></li>
            </ul>
		</div>
 
        <div class="col-xs-9">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        �޸�����
                    </h3>
                </div> 
                <div class="panel-body">			

 			<form action="alterPasswordServlet" method="post">
                        <div class="form-group">
                            <label for="name">����������룺</label>
        <input id="password" type="password" class="form-control" name="oldPassword" id="name" width="200px" height="80px" placeholder="�����������"> <p class="help-block"></p>
                     
                        </div>
                        
                        <div class="form-group">
                             <label for="name">�����������룺</label>
                                 <input id="password" type="password" class="form-control" name="newPassword" id="name" width="200px" height="80px" placeholder="������������"> <p class="help-block"></p>
                     
                        </div>
                        
		<div style="float:left;width: 50%;padding: 20px;">
                <input type="submit" class="btn btn-primary" value="�޸�"
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
//ȡ���������Ĳ���error�Ƚ�
  var infoi ='<%=request.getParameter("info")%>';
  if(infoi=='empty'){
   alert("���벻��Ϊ�գ�");
  }
  else if(infoi=='duplicate'){
  	alert("�¾����벻����ͬ��")
  }
  else if(infoi=='success'){
  	alert("�޸ĳɹ���")
  }
  else if(infoi=='fail'){
  	alert("���ֲ���Ԥ���Ĵ����޸�ʧ�ܣ�")
  }
   else if(infoi=='wrong'){
  	alert("�������������")
  }
  else {
  
  }
</script>