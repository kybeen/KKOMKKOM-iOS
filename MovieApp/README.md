# Chapter 08 테이블 뷰를 이용한 데이터 목록 구현
----

## 테이블 뷰 컨트롤러
테이블 뷰 컨트롤러는 뷰 컨트롤러를 바탕으로 만들어진 특수한 컨트롤러로, 목록 형식의 데이터를 화면에 표현하는 데에 사용된다.

----
**[ 테이블 뷰 컨트롤러의 계층 구조 ]**
- **Table View Controller** (Scene을 담당)
    - **Table View** (최상위 루트 뷰)
        - **Table View Cell** (각각의 행)
            - **Content View** (각 행의 내용)

----
- UITableViewController : 테이블 뷰 컨트롤러가 구현된 클래스
    - 델리게이트 패턴에 기반한 다양한 메소드가 정의되어 있다.

----
#### 프로토타입 셀
프로토타입 셀(Prototype Cell)은 테이블 뷰의 셀을 원하는 대로 쉽게 디자인할 수 있도록 해주는 객체로, 테이블 뷰 설계에 걸리는 시간을 대폭 줄여준다.

프로토타입 셀은 아래의 영역들로 구분된다.
- **Cell Content** : 셀에 표현될 콘텐츠
    - Image
    - Text
- **Accessory View** : 콘텐츠의 부가 정보 여부를 암시

- Editing control : 삭제 버튼, 셀 순서 재배치 컨트롤 등 제공
- Reordering control : 행 추가(+) 삭제(-) 버튼 등 제공