<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    Connection connection = null;

    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";

    //총 게시글 수
    int cnt = 0;

    String pageNum = request.getParameter("pageNum");
    if(pageNum == null){
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int pageSize = 10;

    System.out.println("currentPage = " + currentPage);

    int startRow = (currentPage - 1) * pageSize + 1;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url,username,password);
        System.out.println("connect success");

    }catch (SQLException e){
        System.out.println("error : " + e.toString());
    }

    String sql = "select * from board_tb order by num desc limit ?,?";

    String sqlCount = "select count(num) AS cnt from board_tb";

    PreparedStatement pstmt = connection.prepareStatement(sql);
    PreparedStatement pstmtCnt = connection.prepareStatement(sqlCount);

    //TODO : pageNum을 쿼리스트링 값으로 어떻게 받아올 것인가?
    //pageNum 값을 받아올 수 있다면 currentPage를 할당할 수 있다. 즉, startRow를 설정할 수 있다.

    //만약 block으로 1, 2, 3, 4... 의 페이지 번호를 부여했을 때 그 페이지 번호가 pageNum이 될 수 있다면 문제가 해결될 수 있지 않을까?


    pstmt.setInt(1,startRow);
    pstmt.setInt(2,pageSize);

    ResultSet rs = pstmt.executeQuery();
    ResultSet rsCnt = pstmtCnt.executeQuery();

    while (rsCnt.next()){
        cnt = rsCnt.getInt("cnt");
    }

    //TODO : 하단에 글페이지 번호 + prev + next 구현

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

<%--    pageCount = 페이지 번호 수 지정--%>
<%--    cnt%pageSize==0?0:1는 여분의 게시글 수가 존재할 시 마지막 페이지 번호에 추가--%>
<%--    pageBlock = 한번에 보여질 페이지 번호 수--%>
<%--    startBlock = currentPage에 따라 1,11,21과 같이 보여지는 startPage가 달라짐--%>
<%--    endPage = 게시글 수에 따른 마지막 페이지 번호--%>
    <%
        if(cnt>0){
            int pageCount = cnt/pageSize + (cnt%pageSize==0?0:1);

            int pageBlock = 10;

            int startPage = ((currentPage-1)/pageBlock)*pageBlock+1;

            int endPage = startPage + (pageBlock-1);
            if(endPage > pageCount){
                endPage = pageCount;
            }
        }
    %>

<%--TODO : 페이징 구현--%>

</body>
</html>
