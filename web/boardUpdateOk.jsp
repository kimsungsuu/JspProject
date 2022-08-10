<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); //한글이 깨질 경우 %>

<%
    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";

    Connection connection = null;

    String num = request.getParameter("num");
    String category = request.getParameter("category");
    String pass = request.getParameter("password");
    String writer = request.getParameter("writer");
    String text = request.getParameter("text");
    String title = request.getParameter("title");

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url,username,password);
        System.out.println("connection success!");

    }catch (SQLException e){
        System.out.println(e.toString());
    }

//    TODO : pstmt에 sql쿼리 두개를 어떻게 담을 수 있을까
//    TODO : 비밀번호와 쿼리스트링으로 넘어온 비밀번호가 같은지 검사
//    TODO : 비밀번호 검증을 어떻게 구현할 것인가?

//    String sqlSelect = "select password from board_tb where num = " + num;

    try {
        //update sql 쿼리 선언
        String sqlUpdate = "update board_tb " +
                "set category = ?, title = ?, writer = ?, text = ?, mod_date = now()" +
                "where num = ?";

        PreparedStatement pstmt = connection.prepareStatement(sqlUpdate);

//    ResultSet rs = pstmt.executeQuery(sqlSelect);

        pstmt.setString(1, category);
        pstmt.setString(2, title);
        pstmt.setString(3, writer);
        pstmt.setString(4, text);
        pstmt.setString(5, num);

        //맨 마지막에 선언을 해줘야 쿼리스트링 값이 DB에 넘어가서 수정이 완료된다.
        pstmt.executeUpdate();

        pstmt.close();
        connection.close();

    }catch (SQLException e){
        System.out.println("sqlUpdate error : " + e.toString());
    }
%>

<%--TODO : 비밀번호 검증--%>
<%--error Illegal operation on empty result set.--%>
<%--추측 : script 안에서 jsp 사용 불가 --%>
<%--<script type="text/javascript">--%>

<%--    <%if(pass==rs.getString("password")){--%>
<%--    }else{--%>
<%--        %>--%>
<%--    alert("비밀번호가 일치하지 않습니다.");--%>
<%--    <%--%>
<%--    }--%>
<%--    %>--%>
<%--</script>--%>

<%--수정 완료--%>
<%--<script type="text/javascript">--%>
<%--    <%--%>
<%--    if(rs.getString("password") == pass){--%>

<%--    %>--%>
<%--        window.alert("수정완료!");--%>
<%--        location.href='boardList.jsp';--%>
<%--    <%}%>--%>
<%--</script>--%>

<script type="text/javascript">
    self.window.alert("수정완료!");
    location.href='boardList.jsp';
</script>


