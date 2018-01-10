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
                <li role="presentation" class="active" ><a href="addMainForum.jsp">添加主板快</a></li>
                  <li role="presentation"><a href="addSubForum.jsp">添加子版块</a></li>
                  <li role="presentation"><a href="deleteMainForum.jsp">删除主版块</a></li>
                  <li role="presentation"><a href="deleteSubForum.jsp">删除子版块</a></li>
                  <li role="presentation"><a href="changeMainForum.jsp">修改主版块</a></li>
                  <li role="presentation"><a href="changeSubForum.jsp">修改子版块</a></li>
               
            </ul>
		</div>
		</div>
		</div>


</body>
</html>

<script> 
//取出传回来的参数error比较
  var info0 ='<%=request.getParameter("info")%>';
  if(info0=='success'){
   alert("操作成功！");
  }
  else if(info0=='fail'){
  	alert("操作失败！")
  }
  else if(info0=='duplicate'){
  	alert("名称已经存在！")
  }
  else {
  
  }
</script>