<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";

    Connection connection = null;

    try{
        Class.forName("com.jdbc.cj.mysql.Driver");
        DriverManager.getConnection(url,username,password);
        System.out.println("connection success!");

        //update sql 쿼리 선언
    String sql = "update board_tb set (category, title, writer, text, mod_date)"
    }catch (ClassNotFoundException e){
        System.out.println(e.toString());
    }


%>
<html>
<head>
    <title>Title</title>
</head>
<body>

</body>
</html>
