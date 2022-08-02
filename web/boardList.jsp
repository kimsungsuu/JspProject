<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%

    Connection connection = null;

    try{
        String url = "jdbc:mysql://localhost:3306/user";
        String username = "root";
        String password = "pw1234";

        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url,username,password);
        System.out.println("connect success");

    }catch (Exception e){
        e.printStackTrace();
    }

    String sql = "select * from board_tb";
    PreparedStatement pstmt = connection.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

%>

<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>connect test boardList</h1>
    <table>
        <tr>
            <td>카테고리</td>
            <td>재목</td>
            <td>작성자</td>
            <td>조회수</td>
            <td>작성일자</td>
            <td>수정일지</td>
        </tr>
        <%
        try{
            while (rs.next()){
        %>

        <tr>
            <td><%=rs.getString("category")%></td>
            <td><%=rs.getString("writer")%></td>
            <td><%=rs.getString("title")%></td>
            <td><%=rs.getInt("hit")%></td>
            <td><%=rs.getDate("create_date")%></td>
            <td><%=rs.getDate("mod_date")%></td>
        </tr>
        <%

            }
                rs.close();
                pstmt.close();
                connection.close();
        }catch (Exception e){
                System.out.println("Exception : " + e);
            }
    %>
    </table>
</body>
</html>
