<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); //한글이 깨질 경우 %>

<%
    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";

    String num = request.getParameter("num");
    String pass = request.getParameter("password");
    String verificationPass = null;

    Connection connection = null;

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url, username, password);
        System.out.println("deleteConnection Success");
    }catch (SQLException e){
        System.out.println("DeleteError : " + e.toString());
    }

    try{
    String sql = "select password from board_tb where num = ?";

        PreparedStatement pstmt = connection.prepareStatement(sql);

        //resultSet이 선언되기 전에 setString 해야 한다.
        pstmt.setString(1, num);

        //()안에 sql을 넣게 되면 setString에 값이 안들어가지는 에러가 발생한다.
        ResultSet rs = pstmt.executeQuery();

        while(rs.next()){
        verificationPass = rs.getString("password");
        }

    if(verificationPass.equals(pass)){

        String sqlDelete = "delete from board_tb where num = ?";

        PreparedStatement pstmtDelete = connection.prepareStatement(sqlDelete);

        pstmtDelete.setString(1,num);

        pstmtDelete.execute();

        pstmtDelete.close();
        pstmt.close();
        rs.close();
        connection.close();
%>

<script type="text/javascript">
    self.window.alert("삭제되었습니다.");
    location.href='boardList.jsp';
</script>

<%}else{%>

<script type="text/javascript">
    self.window.alert("비밀번호가 틀렸습니다.");
    history.back();
</script>

<%}
}catch (SQLException e){
    System.out.println("SqlDeleteError : " + e.toString());
}%>