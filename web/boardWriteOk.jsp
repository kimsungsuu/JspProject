<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>

<%
    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";

    Connection connection = null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, username, password);
        System.out.println("connection success : " + connection);

        String sql = "Insert into board_tb(category, title, writer, password, text) values(?,?,?,?,?)";
        PreparedStatement pstmt;
        pstmt = connection.prepareStatement(sql);

        pstmt.setString(1,"category");
        pstmt.setString(2,"title");
        pstmt.setString(3,"writer");
        pstmt.setString(4,"password");
        pstmt.setString(5,"text");

    }catch (Exception e){
        e.printStackTrace();
    }

%>
