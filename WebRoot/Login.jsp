<%@ page language="java" contentType="text/html; charset=gb2312" pageEncoding="gb2312"%>
 <jsp:include page="head.jsp"/>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Insert title here</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/login.css" rel="stylesheet">
</head>
  <%
  	String preurl=request.getHeader("referer");
  	int pos=preurl.lastIndexOf('/');
  	preurl=preurl.substring(pos+1);
   %>
<body>
<div class="container" style="margin-top: 50px" >
	  <div class="col-md-4"></div>
	  <div class="col-md-4">
		 <div class="login">
		    <form id="form1" role="form" action="loginServlet" method="post">
		            <!--<label for="name">�û���:</label>-->
		            <input id="username" required type="text" class="form-control" name="logname" style="height: 55px; margin-top: 30px;"
		                   placeholder="�������û���"><s:fielderror fieldName="username"></s:fielderror>
		            <!--<label for="name"></label>-->
		            <input type="password" required class="form-control" name="logpassword" style="height: 55px;margin-top: 30px;"
		                   placeholder="����������"><s:fielderror fieldName="password"></s:fielderror>
		        <div style="height: 100px;width: 100%;margin-top: 30px;">
		            <div style="float:left;width: 50%;padding: 20px;">
		            	<input type="hidden" name="preurl" value="<%=preurl%>"></input>
		                <input type="submit" class="btn btn-primary" value="��¼"
		                   style="margin:auto;width: 80%;height: 50px;padding: 13px;"></input>
		            </div>
		            <div style="float:right;width: 50%;padding: 20px;">
		                <a href="register.jsp" type="button" class="btn btn-primary"
		                   style="margin:auto;width: 80%;height: 50px;padding: 13px;">ע��</a>
		            </div>
		
		        </div>
		    </form>
		</div>
	</div>
</div>
</body>
</html>
<script> 
//ȡ���������Ĳ���error�Ƚ�
  var errori ='<%=request.getParameter("error")%>';
  if(errori=='unexist'){
   alert("��¼ʧ��!");
  }
  else if(errori == 'illegal'){
  	alert("�����������û��������룡");
  }
  else {
  
  }
</script>

 <jsp:include page="bottom.jsp"/>