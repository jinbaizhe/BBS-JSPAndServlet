<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Insert title here</title>
<%@ include file="head.jsp" %>
<script language="JavaScript">   
if (window != top)   
top.location.href = location.href;     
</script>  
</head>
<body>

<table width="100%" height="700" border="0" cellpadding="0" cellspacing="0">
  <tr>
  <td width="15%" height="100%" valign="top">
  <a href="setAdmin.jsp" target="mainFrame">添加管理员</a>
  <br>
  <a href="lookAdmin.jsp" target="mainFrame">查看管理员</a>
  <br>
 </td>
    <td width="80%" valign="top"><iframe src="lookAdmin.jsp" name="mainFrame" frameborder="0" marginheight="0" marginwidth="0" height="700" width="100%"></iframe></td>
  </tr>
</table>



</body>
</html>
