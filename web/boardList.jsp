<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    Connection connection = null;

    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";

    String pageNum = request.getParameter("pageNum");
    if(pageNum == null){
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int pageSize = 10;

    int startRow = (currentPage - 1) * pageSize;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url,username,password);
        System.out.println("connect success");

    }catch (SQLException e){
        System.out.println("error : " + e.toString());
    }

    String sql = "select * from board_tb order by num desc limit ?,?";

    PreparedStatement pstmt = connection.prepareStatement(sql);

    pstmt.setInt(1,startRow);
    pstmt.setInt(2,pageSize);

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
            <td>
                <%--여기서 parameter 값을 넘겨준다.--%>
                <a href="boardView.jsp?num=<%=rs.getInt("num")%>"> <%=rs.getString("title")%> </a>
            </td>
            <td><%=rs.getInt("hit")%></td>
            <td><%=rs.getDate("create_date")%></td>
            <td><%=rs.getDate("mod_date")%></td>
        </tr>

        <%
            }   //while
                } catch ( Exception e ) {
                  System.out.println( "Exception : " + e );
                } finally {
                    if( rs != null ) rs.close();
                    if( pstmt != null ) pstmt.close();
                    if( connection != null ) connection.close();
                }
        %>
    </table>

    <footer>
        <input type = "button" onclick="location.href = 'boardWrite.jsp'" value="글쓰기">
    </footer>

<%--TODO : 페이징 구현--%>

</body>
</html>
