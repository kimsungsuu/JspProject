<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    Connection connection = null;

    String url = "jdbc:mysql://localhost:3306/user";
    String username = "root";
    String password = "pw1234";

    String num = request.getParameter("num");

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        connection = DriverManager.getConnection(url,username,password);
        System.out.println("connect success");

    }catch (SQLException e){
        System.out.println("error : " + e.toString());
    }

    //TODO : DB에 있는 category를 어떻게 수정란에 출력할 것인가.
//    option 값에 category 값들을 다 넣어준다 그런 다음 수정했을 때 그 값이 DB에만 들어가면 된다.
    String sql = "select category, title, writer, password, text from board_tb where num = ?";

    PreparedStatement pstmt = connection.prepareStatement(sql);
    pstmt.setString(1,num);
    ResultSet rs = pstmt.executeQuery();
%>

<html>
<head>
    <title>Title</title>
</head>
<%-- 유효성검사 javascript--%>
<%--TODO : 유효성검사가 안되는데 이유가 뭘까?--%>
<%--로직자체가 잘못되었음--%>
<script type="text/javascript">
    function writeCheck(){
        const form = document.updateForm;

        if(!form.title.value){
            alert("제목을 입력해주세요");
            form.title.focus()
            return;
        }

        if(!form.writer.value){
            alert("제목을 입력해주세요");
            form.writer.focus()
            return;
        }

        if(!form.password.value){
            alert("비밀번호를 입력해주세요");
            form.password.focus()
            return;
        }
    }
</script>

<body>
<form name = "updateForm" method="post" action="boardUpdateOk.jsp" onsubmit="return writeCheck()">

<%--    수정할 때 DB에 있던 값이 출력되어야 하므로 select문 필요--%>
    <%
        try{
            while(rs.next()){
    %>

    <table>
        <tr>
            <th>카테고리</th>
            <td>
                <select name="category" id="category">
                    <option value="<%=rs.getString("category")%>"><%=rs.getString("category")%></option>
                    <option value="Java">Java</option>
                    <option value="Javascript">Javascript</option>
                    <option value="Database">Database</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>제목</th>
            <td><input name = "title" type="text" value=<%=rs.getString("title")%>></td>
        </tr>
        <tr>
            <th>작성자</th>
            <td><input name = "writer" type="text" value=<%=rs.getString("writer")%>></td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td><input name = "password" type="password"></td>
        </tr>
        <tr>
            <th>내용</th>
            <td>
                <textarea name="text" id="text" cols="30" rows="10"><%=rs.getString("text")%>
                </textarea>
            </td>
        </tr>
    </table>

    <%
            } //while
        } catch (SQLException e){
                System.out.println("error : " + e.toString());
        } finally {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(connection != null) connection.close();
            }
    %>

    <input type="hidden" name="num" value="<%=num%>">
    <input type="submit" value="수정">
    <input type="button" value="취소" onclick=history.back()>
</form>
</body>
</html>
