# JspProject

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
   
   - 
