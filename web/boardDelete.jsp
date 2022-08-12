
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String num = request.getParameter("num");
%>
<html>
<head>
    <title>Title</title>
</head>
<script type="text/javascript">
  function writeCheck(){
    const form = document.deleteForm;

    if(!form.password.value){
      alert("비밀번호를 입력해주세요");
      form.password.focus();
      return false;
    }
  }
</script>
<body>
<h1>Delete Board</h1>
<form name="deleteForm" action="boardDeleteOk.jsp" onsubmit="return writeCheck()">
  <table>
    <tr>
      <th>비밀번호</th>
      <td>
        <input type="password" name="password">
      </td>
    </tr>
  </table>

  <input type="hidden" name="num" value="<%=num%>">
  <input type="submit" value="삭제">
  <input type="button" value="취소" onclick="history.back()">
</form>

</body>
</html>
