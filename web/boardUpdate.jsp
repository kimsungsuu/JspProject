<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
</head>
<%--비밀번호 확인 javascript--%>
<script type="text/javascript">
    function writeCheck(){
        const form= document.writeForm;

        if(!form.title.value)
        {
            alert("제목을 입력해주세요");
            form.title.focus()
            return; //유효성 검사 팝업이 여러개가 뜨지 않도록 return 해준다.
        }

        if(!form.writer.value)
        {
            alert("작성자명을 입력해주세요");
            form.writer.focus()
            return;
        }

        if(!form.password.value){
            alert("비밀번호를 입력해주세요")
            form.password.focus()
            return;
        }
    }
</script>

<body>
<form action="post" action="boardUpdateOk.jsp">
<%--    수정할 때 DB에 있던 값이 출력되어야 하므로 select문 필요--%>
    <table>
        <tr>
            <td>
                <th>카테고리</th>
                <select name="category" id="category">
                    <option value="Java">Java</option>
                    <option value="Javascript">Javascript</option>
                    <option value="Database">Database</option>
                </select>
            </td>
        </tr>
        <tr>
            <th>제목</th>
            <td><input type="text" placeholder="제목을 입력하세요"></td>
        </tr>
        <tr>
            <th>작성자</th>
            <td><input type="text" placeholder="작성자명을 입력하세요"></td>
        </tr>
        <tr>
            <th>비밀번호</th>
            <td><input type="password" placeholder="비밀번호를 입력하세요"></td>
        </tr>
        <tr>
            <th>내용</th>
            <td>
                <textarea name="text" id="text" cols="30" rows="10">
                </textarea>
            </td>
        </tr>
    </table>

    <input type="submit" value="수정" onsubmit="writeCheck()">
    <input type="button" value="취소" onclick=history.back()>
</form>
</body>
</html>
