<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--writeCheck : 유효성검사--%>
<html>
<head>
    <title>Title</title>
</head>
<body>

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

<form name="writeForm" action="boardWriteOk.jsp" method="post">
    <table>
        <tr>
            <td>
            <%--name을 기입해줘야 값이 등록 된다.--%>
                <label>카테고리</label>
                <select id="category" name="category">
                    <option value="Java">Java</option>
                    <option value="Javascript">Javascript</option>
                    <option value="Database">Database</option>
                </select>
            </td>
        </tr>
        <tr>
            <td>
                <label>제목</label>
                <input type="text" name="title">
            </td>
        </tr>
        <tr>
            <td>
                <label>작성자</label>
                <input type="text" name="writer">
            </td>
        </tr>
        <tr>
            <td>
                <label>비밀번호</label>
                <input type="password" name="password">
            </td>
        </tr>
        <tr>
            <td>
                <label>내용</label>
                <textarea name="text" id="" cols="30" rows="10"></textarea>
            </td>
        </tr>
    </table>

    <input type="submit" value="저장" onclick="writeCheck()" >
    <input type="button" onclick="history.back()" value="취소">

</form>
</body>
</html>
