# Chapter 07 델리게이트 패턴 - 텍스트 필드
----
## 텍스트 펠드
- 텍스트 필드는 델리게이트 패턴을 사용하는 대표적인 객체 중의 하나.
- 기본적인 기능은 델리게이트 패턴 없이도 사용 가능
- 입력값 제어 등의 고급 기능 구현 시에는 델리게이트 패턴을 적용해야 함. (특정 문자열 입력 배제, 입력 가능 문자열 길이 제한 등...)

- 텍스트 필드에 델리게이트 패턴을 적용하려면 아래의 두 가지 작업이 필요하다.
  1. **텍스트 필드에 대한 델리게이트 프로토콜을 구현한다.(프로토콜 이름 : 객체 클래스명 + Delegate)**
  2. **텍스트 필드의 델리게이트 속성을 뷰 컨트롤러에 연결한다.**
     - 델리게이트 속성 : 델리게이트 메소드가 구현되어 있는 객체 

**[ 텍스트 필드르 최초 응답자 객체로 만들고, 다시 해제하기 ]**
```
let tf = UITextField()

tf.becomeFirstResponder() // 키보드가 나타나고 입력 상태가 된다.

/* ... 필요한 코드 삽입 ... */

tf.resignFirstResponder() // 키보드가 사라짐
```