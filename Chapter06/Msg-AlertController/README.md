# Chapter 06 사용자에게 메시지를 전달하는 방법 - 메시지 창 실습

### [ 메시지 창 구현 방법 ]
1. UIAlertController 클래스의 인스턴스 생성
2. UIAlertAction 버튼 객체 생성
3. UIAlertAction 버튼 클래스의 인스턴스를 UIAlertController 인스턴스에 등록 ( addAction() )
    - .cancel 타입의 버튼은 추가 순서와 상관 없이 항상 매 아래에 위치한다. (하나의 메시지 창에는 하나의 .cancel 버튼만 있을 수 있음)
4. 메시지 창 인스턴스를 실행해서 화면에 출력 ( present() )
