# Chapter 07 델리게이트 패턴 - 이미지 피커 컨트롤러
----
## 이미지 피커 컨트롤러(Image Picker Controller)
- 델리게이트 패턴을 활용하는 또 다른 대표적인 객체
- 카메라나 앨범 등을 통해 이미지를 선택할 때 사용하는 컨트롤러
- 개발자가 의도한 시점에 소스 코드를 통해 호출되어 앱의 제어 권한을 가져온 다음, 사용자가 카메라로 사진을 촬영하거나 앨범에서 사진을 선택하면 그 이미지 정보를 델리게이트로 지정된 객체에 메소드 호출을 통해 인자값으로 전달해주어 선택한 이미지를 사용할 수 있도록 해준다.
- **UIImagePickerController** 클래스에 구현되어 있다.
    - 스토리보드를 이용하여 구성할 수 X --> 소스코드를 사용하여 직접 인스턴스 생성 후 화면을 호출해야 함
- 이미지 피커 컨트롤러도 하나의 컨트롤러이기 때문에 화면 전환 방식과 똑같이 불러온다.

----
**[ 필요한 델리게이트 프로토콜 ]**
- **UIImagePickerControllerDelegate** 프로토콜
- **UINavigationControllerDelegate** 프로토콜

**[ 델리게이트 메소드 ]**
- **imagePickerController(_:didFinishPickingMediaWithInfo:)** : 이미지를 선택하거나 카메라 촬영 완료 시 호출
- **imagePickerControllerDidCancel(_:)** : 이미지 선택 없이 그냥 취소했을 떄 호출