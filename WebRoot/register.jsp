<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<jsp:include page="head.jsp"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>ע��</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/regist.css" rel="stylesheet">
</head>
<div class="container" style="margin-top: 50px" >
	<div class="col-md-4"></div>
	<div class="col-md-4">
		<div class="regist">
		    <form id="form1" role="form" action="registerServlet" method="post">
		            <!--<label for="name">�û���:</label>-->
		            <input id="username" type="text" class="form-control" name="logname" style="height: 40px; margin-top: 20px;"
		                   placeholder="�������û���"><s:fielderror fieldName="username"></s:fielderror>
		            <!--<label for="name"></label>-->
		        <input id="password" type="password" class="form-control" name="logpassword" style="height: 40px;margin-top: 20px;"
		               placeholder="����������"><s:fielderror fieldName="password"></s:fielderror>
		      
		
		        <input id="confirm_password" type="password" class="form-control" name="againpassword" style="height: 40px;margin-top: 20px;"
		               placeholder="���ظ�����"><s:fielderror fieldName="password"></s:fielderror>
		
		      <br>
		                <input type="submit" class="btn btn-primary" value="ע��"
		                   style="margin:auto;width: 100%;height: 40px;padding: 10px;"></input>
			</form>
		</div>
	</div>
</div>
</html>
<script> 
//ȡ���������Ĳ���error�Ƚ�
  var errori ='<%=request.getParameter("error")%>';
  if(errori=='notequal'){
   alert("�����������벻һ��!");
  }
  else if(errori == 'illegal'){
  	alert("�����������û��������룡");
  }
  else if(errori == 'duplicate'){
  	alert("���û����Ѿ�����!");
  }
  else if(errori == 'failregister'){
  	alert("ע��ʱ�������⣬ע��ʧ�ܣ�");
  }
  else {
  
  }
</script>

 <jsp:include page="bottom.jsp"/>