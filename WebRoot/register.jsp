<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<jsp:include page="head.jsp"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>注册</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="css/regist.css" rel="stylesheet">
</head>
<div class="container" style="margin-top: 50px" >
	<div class="col-md-4"></div>
	<div class="col-md-4">
		<div class="regist">
		    <form id="form1" role="form" action="registerServlet" method="post">
		            <!--<label for="name">用户名:</label>-->
		            <input id="username" type="text" class="form-control" name="logname" style="height: 40px; margin-top: 20px;"
		                   placeholder="请输入用户名"><s:fielderror fieldName="username"></s:fielderror>
		            <!--<label for="name"></label>-->
		        <input id="password" type="password" class="form-control" name="logpassword" style="height: 40px;margin-top: 20px;"
		               placeholder="请输入密码"><s:fielderror fieldName="password"></s:fielderror>
		      
		
		        <input id="confirm_password" type="password" class="form-control" name="againpassword" style="height: 40px;margin-top: 20px;"
		               placeholder="请重复密码"><s:fielderror fieldName="password"></s:fielderror>
		
		      <br>
		                <input type="submit" class="btn btn-primary" value="注册"
		                   style="margin:auto;width: 100%;height: 40px;padding: 10px;"></input>
			</form>
		</div>
	</div>
</div>
</html>
<script> 
//取出传回来的参数error比较
  var errori ='<%=request.getParameter("error")%>';
  if(errori=='notequal'){
   alert("两次密码输入不一致!");
  }
  else if(errori == 'illegal'){
  	alert("请输入您的用户名和密码！");
  }
  else if(errori == 'duplicate'){
  	alert("该用户名已经存在!");
  }
  else if(errori == 'failregister'){
  	alert("注册时出现意外，注册失败！");
  }
  else {
  
  }
</script>

 <jsp:include page="bottom.jsp"/>