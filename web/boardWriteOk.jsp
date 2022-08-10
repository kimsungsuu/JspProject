<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<% request.setCharacterEncoding("UTF-8"); //한글이 깨질 경우 %>

<%
    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";

    // pull write.jsp parameter
    String title = request.getParameter("title");
    String writer = request.getParameter("writer");
    String text = request.getParameter("text");
    String category = request.getParameter("category");
    String pass = request.getParameter("password");

    Connection connection = null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, username, password);
        System.out.println("connection success : " + connection);

        String sql = "Insert into board_tb(category, title, writer, password, text, create_date, mod_date) values(?,?,?,?,?,now(),now())";
        PreparedStatement pstmt;
        pstmt = connection.prepareStatement(sql);

        pstmt.setString(1, category);
        pstmt.setString(2, title);
        pstmt.setString(3, writer);
        pstmt.setString(4, pass);
        pstmt.setString(5, text);

        //pstmt 실행 및 자동 종료
        pstmt.executeUpdate();

        //SQLException
    }catch (SQLException e){
        System.out.println("error : " + e.toString() );
    } finally {
        if(connection != null) connection.close();
    }
%>

<%--저장완료 알림창 + boardList로 화면 이동--%>
<script type="text/javascript">
    self.window.alert("저장 완료");
    location.href="boardList.jsp";
</script>
