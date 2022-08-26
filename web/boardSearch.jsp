<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); //한글이 깨질 경우 %>

<%--TODO : 검색 후에 페이징 구현하기--%>
<%
    Connection connection = null;

    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";
    String jdbc = "com.mysql.cj.jdbc.Driver";

    String searchOption = request.getParameter("searchOption");
    String boardSearch = request.getParameter("boardSearch");


    String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);


    try{
        Class.forName(jdbc);
        connection = DriverManager.getConnection(url, username, password);
        System.out.println("connection sucess!!");
    }catch (Exception e){
        e.printStackTrace();
    }

    //search 로직
    String sqlSearch = "select * from board_tb where " + searchOption.trim();

    try{
        if(boardSearch != null && !boardSearch.equals("")){
            sqlSearch += " LIKE '%" + boardSearch.trim() + "%' order by num desc limit 10";
        }
    }catch (Exception e){
        System.out.println("SQL searchError" + e.toString());
    }

    PreparedStatement pstmtSearch = connection.prepareStatement(sqlSearch);

    ResultSet rs = pstmtSearch.executeQuery();

%>
<html>
<head>
</head>
<body>
    <table>
        <tr>
            <td>카테고리</td>
            <td>제목</td>
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
            }
            }catch (SQLException e){
                System.out.println("boardSearchError" + e.toString());
            }finally {
                if(rs != null) rs.close();
                if(pstmtSearch != null) pstmtSearch.close();
                if(connection != null) connection.close();
            }
        %>
    </table>
</body>
</html>
