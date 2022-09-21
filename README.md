# JSPProject
jsp -> javabean -> db 

2022.9.14

- sql = "SELECT * FROM tblzipcode WHERE area3 like = ?";
pstmt.setString(1,"%" +ara3+ "%");

- 투표 프로그램 구현
  - 특정 주제에 대한 투표 기능
  - ex) 가장 좋아하는 과일은?(tblList)
  - 사과, 수박, 귤, .. n(tblItem)
  
  - DROP TABLE IF EXISTS tblList(중복되는 테이블이 존재할 때 삭제)
  - jsp:include 태그 사용, 한 페이지에 많은 코드가 들어가는 것은 가독성을 해치기 때문에 선언
    - ex) <jsp:include page = "pollForm.jsp"/>
    
  - pMgr.getAllList()
    - tblList 테이블 컬럼 값 모두를 가져옴. -> PollListBean.java 객체인 plBean에 데이터를 담는다. -> Vector() 클래스에 값을 담는다.(Vector.add(plBean))
    
  - out.println("<tr><td>" + count + "</td></tr>");
    - java코드 내에서 쓰이는 out클래스에서 html을 선언할 때 쌍따옴표를 사용.(위와 같이)
    - out.println에서 html 코드 안에 따옴표를 사용해야할 경우에는 작은 따옴표를 사용한다.(ex) out.println("<input type = checkbox name = 'itemName'>");
    
  - for문 으로 db 데이터를 가져올 때 Vector 클래스를 사용한다.(PollItemBean으로는 행 별로 데이터를 가져올 수 없기 때문에)
    - Vector가 쓰인 곳을 잘 생각해보면 List를 출력할 때나 Item을 출력할 때 사용했는데 이는 for 문을 사용할 때 사용한다. 즉, 복수의 데이터를 가져오기 위해서
     사용한다는 것이다. 즉,  plBean은 배열의 속성이 아니라 하나의 클래스로 존재하기 때문에 복수로 표현하기 위해 Object 반환형인 Vector에 담아주는 것이다.
     왜냐하면 객체는 Object 반환형 클래스에 담겨질 수 있으니까.
    
    - 반대로 Vector를 안쓰는 곳은 하나의 plBean 객체만 만들어도 되는 경우를 의미한다. 예를 들어 하나의 question 컬럼만 가져오면 되는 경우를 의미한다.
     
  - vlist.add(rs.getString(1))에서 숫자 1은 컬럼을 가져오는 선언문에서 제일 왼쪽의 번호를 의미.(제일 왼쪽부터 1번 2번 3번..n번으로 부여)
    - ex) select item from..의 선언문이 있을 때 rs.getString(1)에서 1은 item
   
   - 회원이 가질 수 있는 취미나, 투표에서 생성되는 item 같은 요소들은 복수개로 저장될 수 있기 때문에 String[] 형식으로 자바에서 선언한다. 또한 Db에서는
   char() 또는 varChar()로 선언해준다.
  
   - input type에서 check는 중복 선택이 가능하고 radio는 하나의 선택만 가능하다. 또한 태그 내에 value는 파라미터 값으로 넘겨주는 값이다. value를 직접 지정해줄 수도 있고
   사용자가 입력하는 값이 value로 지정하고 싶다면 따로 value를 선언하지 않으면 된다.
   
   2022.9.17
   - 회원가입, 게시판, 투표 프로그램 기능이 다 있는 홈페이지 공부
    - index.jsp(화면 프레임으로 분리해서 출력), head.jsp, main.jsp, copy.jsp...
   - EL(Expression Language) 표현언어 공부
    - 내장 객체, page, session, request, application, 
    - Scope, sessionScope, pageScope, requestScope, applicationScope
    - EL 연산자, lt, gt, le, ge, eq, nq
    - context 의미 : 글의 전체적인 정보를 담고 있는.. applicationContext : application의 전체적인 정보를 담고 있는 객체
   - frameset tag, frame tag, target 속성
    - blank, top, self, parent
    
    2022.9.18
    - form에서 넘어온 파라미터 값을 EL 가져올 때 -> ${param.id}
    - JSP 내장함수 객체 속성에 값을 넣어준걸 반환할 때 (ex) request.setAttribute("id", "id");) -> ${id}
    - name="id" beans에 담긴 siteName 변수 값을 가져올 때 -> ${id.siteName};
    - 사용자가 직접 만든 메소드(컴포넌트)를 EL로 직접 사용할 수 있다.
      - 따로 환경설정을 해줘야 한다.(JSp 교재 참고)
  
    - JSTL(JSP Standard Tag Library) 자바 표준 태그 라이브러리
    - JSTL은 일반적인 반복 및 조건, 포매팅 작업, XML 문서, 국제화 태그 및 SQL 태그 조작을 위한 태그에 대해 지원한다.
    - 또한 기존 사용자 정의 태그를 통합하기 위한 프레임 워크를 제공한다고 한다.
    - JSTL에서 제공하는 태그 5가지 core, formatting, sql, xml, functions
    - core 태그 : 일반적인 변수 선언, 제어문, 일반적인 로직 등의 기능을 제공
    - core 태그를 사용하기 위해 지시자를 선언해야함 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    - <c:set var="str3" value="JspStudy" scope="page" />, <c:out value="${str3}" default="기본 메세지"/> 
    - 위 코드에서 default는 str3 값이 null일 경우 반환.
    - 스크립트 릿에서 선언된 변수는 <c:out value="<%=str3%>" default="기본 메세지" />와 같이 반환해준다.
    - <c:remove var="str4"/> remove 속성으로 변수를 제거할 수도 있다. 
    - core 태그로 생성된 변수는 core 태그로만 반환할 수 있다. 스크립트릿으로 반환하는 방법은 scope 방식으로 반환하는 것이다
      - ex) <%String s = (String)pageContext.getAttribute("id");%>
      - pageContext 객체는 반환형이 객체이므로 String으로 형변환 해준다.
      - <c:if test = "${param.id != null}">에서 test는 c:if 에서 붙는 필수 속성 값.
      - </c:if>와 같이 닫아준다.
      - <c:choose> 
      - <c:when test = "${param.color = 'yellow'}">
      - <c:set var = "c" value = "노란색"/>
      - </c:when>
      - <c:otherwise>
      - <c:set var = "c" value ="블랙"/>
      - </c:otherwise>
      - </c:choose>
    - <c:forEach>, <c:forTokens>
      - String str[] = {"수박", "참외", "딸기", "바나나"};
      - <c:set var="arr" value="<%=str%>"/>
      - forEach 태그는 List, 배열을 순서대로 반복해서 처리할 수 있는 태그이다.
      - <c:forEach var="i" items="${arr}" begin = "0" step = "1" end = "3"> ${i} </c:forEach>
      - forTokens 태그는 subString 처럼 특정 구분자로 분리하여 반환하기 위한 태그
      - String s = "JSP, Servlet; Java, DB"
      - <c:forTokens var="st" items="${s}" delims=", ;"> ${s} </c:forTokens>
      - ,와 ;로 분리해서 출력
   - <c:input>, <c:param>, <c:url>
      - include 액션 태그와 유사한 기능
      - <c:input url = "주소"> <c:param name ="id" value="Hi" /> </c:input>
      - 위 선언에서 <c:param>은 요청 url에 요청할 변수명과 값을 의미
      - <c:url>태그는 주소 값을 변수로 선언할 때 사용
      - <c:url var ="url1" value="주소"/> <c:param var="q" value ="plusParam"/> </c:url>
      - 위와 같이 선언하면 주소값 파라미터인 q를 주소에 추가해준다. (출력예시) 주소/?q=plusParam)
  
  2022.9.19
  TIL을 개발 블로그에 적기 시작했습니다. 
  오늘 공부한 자료의 링크입니다 : https://hardkeepgoing.tistory.com/158
  
  2022.9.20
  오늘의 TIL입니다. ^^ : https://hardkeepgoing.tistory.com/159
  
