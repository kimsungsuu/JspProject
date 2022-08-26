<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    Connection connection = null;

    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";

    int cnt = 0;

    //startRow 로직
    String pageNum = request.getParameter("pageNum");

    if(pageNum==null){
        pageNum="1";
    }

    int currentPage = Integer.parseInt(pageNum);

    int pageSize = 10;

    int startRow = (currentPage - 1)*pageSize + 1;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url,username,password);
        System.out.println("connect success");

    }catch (SQLException e){
        System.out.println("error : " + e.toString());
    }

    //게시글 출력 및 cnt 로직
    String sqlShow = "select * from board_tb order by num desc limit ?,?";
    String sqlCount = "select count(num) as cnt from board_tb";

    PreparedStatement pstmtShow = connection.prepareStatement(sqlShow);
    PreparedStatement pstmtCount = connection.prepareStatement(sqlCount);

    pstmtShow.setInt(1, startRow);
    pstmtShow.setInt(2, pageSize);

    ResultSet rs = pstmtShow.executeQuery();
    ResultSet rsCount = pstmtCount.executeQuery();

    while(rsCount.next()){
        cnt = rsCount.getInt("cnt");
    }

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
                    if( pstmtShow != null ) pstmtShow.close();
                    if( pstmtCount != null) pstmtCount.close();
                    if( connection != null ) connection.close();
                }
        %>
    </table>

    <footer>
        <input type = "button" onclick="location.href = 'boardWrite.jsp'" value="글쓰기">
    </footer>

<%--    pageBlock 로직--%>
    <%
        if(cnt > 0){
            int pageCount = cnt/pageSize+(cnt%pageSize==0?0:1);

            int pageBlock = 10;

            int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;

            int endPage = startPage + (pageBlock-1);

            if(endPage > pageCount){
                endPage = pageCount;
            }
    %>

    <%
        if(startPage > pageBlock){
    %>
            <a href="boardList.jsp?pageNum=<%=startPage-pageBlock%>">Prev</a>
    <%
        }
    %>

    <%
        for(int i = startPage; i<=endPage; i++){
    %>
            <a href="boardList.jsp?pageNum=<%=i%>"><%=i%></a>
    <%
        }
    %>

    <%
        if(endPage > pageBlock){
    %>
            <a href="boardList.jsp?pageNum=<%=startPage+pageBlock%>">Next</a>
    <%
        }
        }
    %>

<%--TODO : 페이징 구현--%>

</body>
</html>
