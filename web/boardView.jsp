
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<%
Connection connection = null;

String num = request.getParameter("num");
String category;
String title;
String text;
String writer;


try{
    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";
    String jdbc = "com.mysql.cj.jdbc.Driver";

    Class.forName(jdbc);
    connection = DriverManager.getConnection(url, username, password);
    System.out.println("connection sucess!!");
}catch (Exception e){
    e.printStackTrace();
}
    //TODO : 1) mySql syntax 에러 발생
    String sql = "select category, title, writer, text from board_tb where num=" + num;
    PreparedStatement pstmt = connection.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

    while(rs.next()){
       category =  rs.getString("category");
       title =  rs.getString("title");
       writer = rs.getString("writer");
       text =  rs.getString("text");

%>
<html>
<head>
    <title>boardView</title>
</head>
<body>
    <table>
        <tr>
            <td>카테고리</td>
            <td>제목</td>
            <td>작성자</td>
            <td>내용</td>
        </tr>

        <tr>
            <td><%= category%></td>
            <td><%= title%></td>
            <td><%= writer%></td>
            <td>
                <textarea name="text" id="" cols="30" rows="10"><%= text%></textarea>
            </td>
        </tr>
    </table>
<%}%>
</body>
</html>
