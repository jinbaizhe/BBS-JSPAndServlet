<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<jsp:include page="head.jsp"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.min.js"></script>
  </head>
  <%
  	String preurl=request.getHeader("referer");
  	if(preurl==null)
  		preurl="";
  	else
  	{
  		int pos=preurl.lastIndexOf('/');
  		preurl=preurl.substring(pos+1);
  	}
  	
   %>
  <body>
    <div style="height:55%">
            <div class="container" style="margin-top: 100px">
                <div class="row">
                    <div class="col-md-2"></div>
                    <div class="col-md-6">
                        <div style="font-size: 26px;color: grey">That's an error.</div>
                        <br>
                        <br>
                        <div style="font-size: 18px;">
                            <p>The requested URL <code>/<%=preurl%></code> was not found on this server.
                        </div>
                        <div style="font-size: 26px;color: grey">That's all we know.</div>
                    </div>
                    <div class="col-md-2">
                        <img src="image/robot.png" alt="">
                    </div>
                    <div class="col-md-2"></div>
                </div>
            </div>
        </div>
  </body>
</html>
<jsp:include page="bottom.jsp"/>