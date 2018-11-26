<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입확인</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");
%>
<form action="RegisterOk.jsp" method="post" name="regForm">
    <fieldset>
        <legend>접속 정보 확인</legend>
        <%
            // scriptlet
            
            String name = request.getParameter("ins_name");          
            String region = request.getParameter("region");      
            String vendor = "";
            String ip = "";

            if (region.equals("1")){
                // azure 생성
                vendor = "azureuser";
            }
            else if (region.equals("2")){
                // aws 생성
                vendor = "ec2-user";
            }
            else{
                // toast 생성
                vendor = "ubuntu";
            }
         %>

         <%= ins_name %> 인스턴스가 생성되었고 접속 방법은 "ssh -i {업로드한 키 경로} <% =vendor %>@<% =ip %> 입니다.<p>
    </fieldset>
</form>
</body>
</html>