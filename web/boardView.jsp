
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>

<%
    Connection connection = null;

    String num = request.getParameter("num");

    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";
    String jdbc = "com.mysql.cj.jdbc.Driver";

try{
    Class.forName(jdbc);
    connection = DriverManager.getConnection(url, username, password);
    System.out.println("connection sucess!!");
    }catch (Exception e){
    e.printStackTrace();
    }

    //TODO : 1) mySql syntax 에러 발생
    String sql = "select category, title, writer, text from board_tb where num="+num;
    PreparedStatement pstmt = connection.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();
%>
<html>
<head>
    <title>boardView</title>
</head>
<body>
<%
    try{
        while(rs.next()){%>

    <table>
        <tr>
            <td>카테고리</td>
            <td><%= rs.getString("category")%></td>
        </tr>
        <tr>
            <td>제목</td>
            <td><%= rs.getString("title")%></td>
        </tr>
        <tr>
            <td>작성자</td>
            <td><%= rs.getString("writer")%></td>
        </tr>
        <tr>
            <td>내용</td>
            <td>
                <textarea name="text" cols="30" rows="10"><%=rs.getString("text")%></textarea>
            </td>
        </tr>
        <%}
            } catch (Exception e){
                    e.printStackTrace();
            } finally {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(connection != null) connection.close();
            }
        %>
    </table>
</body>
</html>
