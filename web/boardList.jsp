<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    Connection connection = null;

    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";

    int cnt = 0;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url,username,password);
        System.out.println("connect success");

    }catch (SQLException e){
        System.out.println("error : " + e.toString());
    }

    String sql = "select * from board_tb";
    String sqlCount = "select count(num) AS countNum from board_tb";

    PreparedStatement pstmt = connection.prepareStatement(sql);
    ResultSet rs = pstmt.executeQuery();

    PreparedStatement pstmtCount = connection.prepareStatement(sqlCount);
    ResultSet rsCount = pstmtCount.executeQuery();

    //게시글 총 수를 cnt에 담아준다. 별칭을 사용하여 게시글 수를 가져온다.
    while(rsCount.next()){
        cnt = rsCount.getInt("countNum");
    }

    System.out.println("cnt : " + cnt);

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
<%--1. 한 블록에 10개의 게시글이 보인다.--%>
<%--db count 쿼리 사용? count로 1~10개를 1page로 등록하고 page 값은 ++로 설정 --%>
<%--전체 게시글을 10으로 나눠서 페이징을 하고 남은 값은 마지막 페이지로 넣기--%>
<%--게시글을 어떻게 10으로 나눌 것인가?--%>
<%--전체 게시글 수를 파악--%>
<%--전체 게시글 수를 어떻게 파악할 것인가?--%>
<%--DB문으로 select all하고 그 값들을 count 해준뒤에 그것을 변수에 넣는다(별칭을 사용해주면 될까?)--%>
<%--select count(*) AS cnt from board_tb 별칭은 필요 없을지도? 어차피 변수에 게시글 숫자만 담는거니까--%>
<%--or select count(num) AS cnt from board_tb--%>
<%--count 까지는 ok 변수에 어떻게 넣어줄 수 있지?--%>
<%--rs.next()를 하면 게시글 숫자 값이 반환될까?--%>
<%--cnt에 rs.next()값을 담아주고 length를 사용한 뒤에 10으로 나눠줘볼까?--%>
<%--변수에 넣어진 값을 10으로 나누고 1~10, 11~20, 방식으로 1page, 2page에 담아준다.--%>
<%--블록화가 필요하다. 총 게시글 수를 cnt에 담아주는 것 까지는 성공했다. 이제 이것들을 10씩 나눈다음에 블록화 시켜서 페이징을 시켜야한다.--%>
<%--문제는 블록화를 어떻게 하는지 모른다는 것이다--%>
<%--cnt를 10씩 나눈다고 가정해보자 그럼 5개의 페이지가 나올 것이다. 10개씩 출력해야 하므로 html 부분에서 손을 봐야 할 것이다.--%>
<%--for문을 사용해서 cnt =1 ~ cnt 10까지 출력하게 할 수 있을 것 같다.--%>
<%--ex) for(cnt = 1; cnt <= 10; cnt++){--%>
<%--while(rs.next()){--%>
<%--.--%>
<%--.--%>
<%--.--%>
<%--}//while--%>
<%--}//for--%>
<%-- 만약 이게 성공한다면 1~10을 1page로 만들어주면 된다.--%>
<%--생각해보면 cnt가 인덱스 1부터 오름차순으로 가져올 것이라고 생각하는건 온전히 내 생각이다. 실제로 그러하지 않을 가능성도 있다.--%>

<%--나머지는 마지막 페이지에 담는다.--%>

<%--2. 페이지 넘김 번호는 1~10까지--%>
<%--이부분은 보여지는 부분으로 로직과는 크게 상관 없을듯. --%>
<%--3. 게시글이 10개 이상이어야 한다.(페이징을 확인하려면)--%>
<%--4. 블록마다 고유한 num를 부여한다.(2page는 11~20, 3page 21~30, 4page 31~40)--%>

</body>
</html>
