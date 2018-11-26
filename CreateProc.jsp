<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>접속 정보 확인</title>
</head>

<body>
    <% request.setCharacterEncoding("UTF-8"); %>
    <form action="RegisterOk.jsp" method="post" name="regForm">
        <fieldset>
            <legend>접속 정보 확인</legend>
            <%
            // scriptlet
            
            String ins_name = request.getParameter("ins_name");          
            String region = request.getParameter("region");      
            String vendor = "";
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
            <%
                Process process = null;
                BufferedReader in = null;
                BufferedReader err = null;
                String s = "";
                String ip = "";

                try {
                    //String command = " terraform show -no-color";
                    String command = "terraform show|grep 'public_ip ='|grep -o -P '(?<=public_ip =).*(?=)'";
                    //String command = "pwd";
                    process = Runtime.getRuntime().exec(command);
                    in =  new BufferedReader (new InputStreamReader(process.getInputStream()));
                    while ((s = in.readLine ())!= null) {
                        out.println("result :" + s+"<br>");
                    }
                    ip = s;
                    err = new BufferedReader(new InputStreamReader(process.getErrorStream()));
                    while (err.ready()) {
                            out.println("result2 : " + err.readLine()+"<br>");
                    }
                } catch (Exception e) {
                    out.println("Error : "+e);
                System.out.println(new java.util.Date()+" process.jsp "+e);
                } finally {
                    if (in != null) try { in.close(); }  catch (Exception sube) {}
                if (err != null) try { err.close(); }  catch (Exception sube) {}
                }
                %>

            <%= ins_name %> 인스턴스가 생성되었고 접속 방법은 "ssh -i {업로드한 키 경로}
            <%= vendor %>@
            <%= ip %> 입니다.<p>
        </fieldset>
    </form>
</body>

</html>