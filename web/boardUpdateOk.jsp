<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("UTF-8"); //한글이 깨질 경우 %>

<%
    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";

    Connection connection = null;

    String verrificationPass = null;
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
//    if문으로 setString을 모두 담아주고 db에 있는 password 값과 쿼리스트링으로 넘어온 password 값을 비교해서
//    맞다면 수정된 값을 db에 넘겨주고 그렇지 않다면 alert 창을 뜨게 해준다.
//    password를 db에서 찾기 위해 select 문을 사용해준다

    String sql = "select password from board_tb where num = ?";

    try {
        PreparedStatement pstmt = connection.prepareStatement(sql);

        pstmt.setString(1,num);

        ResultSet rs = pstmt.executeQuery();

        //rs.next()로 db에서 값을 불러온 뒤 호출해줘야 한다. 그렇지 않으면 java.sql.SQLException: Before start of result set
        //error가 발생한다.
        if(rs.next()){
            verrificationPass = rs.getString("password");
        }

        if(verrificationPass.equals(pass)) {
            //update sql 쿼리 선언
            String sqlUpdate = "update board_tb " +
                    "set category = ?, title = ?, writer = ?, text = ?, mod_date = now()" +
                    "where num = ?";

            PreparedStatement pstmt2 = connection.prepareStatement(sqlUpdate);

            //pstmt와 pstmt2를 만들어주어 각각 서로 다른 setString을 해줘야 error가 발생하지 않는다.
            pstmt2.setString(1, category);
            pstmt2.setString(2, title);
            pstmt2.setString(3, writer);
            pstmt2.setString(4, text);
            pstmt2.setString(5, num);

            //맨 마지막에 선언을 해줘야 쿼리스트링 값이 DB에 넘어가서 수정이 완료된다.
            pstmt2.executeUpdate();

            pstmt.close();
            pstmt2.close();
            rs.close();
            connection.close();
%>
        <script type="text/javascript">
            self.window.alert("수정완료!");
            location.href='boardView.jsp?num=<%=num%>';
        </script>
<%
    }else{
%>

        <script type="text/javascript">
            self.window.alert("비밀번호가 틀렸습니다!");
            history.back();
        </script>

<%
        }//else
    }catch (SQLException e){
    System.out.println("sqlError : " + e.toString());
    }

%>