<%@ page language="java" contentType="text/html;charset=gb2312" pageEncoding="gb2312"%>
<%@ include file="head.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>Insert title here</title>

<script language="JavaScript">   
if (window != top)   
top.location.href = location.href;     
</script>  
  
</head>
<body>
 
<div class="container" style="margin-top: 30px">
    <div class="row">
 <div class="col-xs-3">
            <ul class="nav nav-pills nav-stacked"> 
                <li role="presentation" class="active" ><a href="addMainForum.jsp">��������</a></li>
                  <li role="presentation"><a href="addSubForum.jsp">����Ӱ��</a></li>
                  <li role="presentation"><a href="deleteMainForum.jsp">ɾ�������</a></li>
                  <li role="presentation"><a href="deleteSubForum.jsp">ɾ���Ӱ��</a></li>
                  <li role="presentation"><a href="changeMainForum.jsp">�޸������</a></li>
                  <li role="presentation"><a href="changeSubForum.jsp">�޸��Ӱ��</a></li>
               
            </ul>
		</div>
		</div>
		</div>


</body>
</html>

<script> 
//ȡ���������Ĳ���error�Ƚ�
  var info0 ='<%=request.getParameter("info")%>';
  if(info0=='success'){
   alert("�����ɹ���");
  }
  else if(info0=='fail'){
  	alert("����ʧ�ܣ�")
  }
  else if(info0=='duplicate'){
  	alert("�����Ѿ����ڣ�")
  }
  else {
  
  }
</script>