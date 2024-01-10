
## CLICK

### 소개

<aside>
💡 FOLLOW - LIKE - POST

</aside>

---

CLICK 은 자신의 관심사를 포스팅하여 자신만의 페이지를 만들고, 자신의 관심사와 비슷한 사용자를 검색할 수 있습니다. 또한 애플리케이션에 가입한 사용자들의 피드를 확인하고 마음에 드는 게시물에 좋아요를 표시할 수 있는 소셜 네트워크 서비스 기반의 애플리케이션입니다. 

### 팀원

---

[정지연](https://www.notion.so/d606c2b8d0b243f0bcd2786496832575?pvs=21) 

[sanananan3 - Repositories](https://github.com/sanananan3?tab=repositories)

[박현우](https://www.notion.so/59e39685a4fb45589be212eebbe01cae?pvs=21) 

[siesdart - Overview](https://github.com/siesdart)

### 개발 환경

---

Language: Dart & JavaScript

Frontend: Flutter
  - State Management: Riverpod

Backend: Node.js(Express)
  - DataBase: PostgreSQL
  - ORM: drizzle
  - Cloud: Render Web Service & Render PostgreSQL

### **주요 기능**

---

<aside>
💡 회원가입

</aside>

[Users](https://www.notion.so/b0b20bf5fe3840c5aa53dc15b4a8213d?pvs=21)

 위에서 볼 수 있듯이, 데이터베이스에 users 테이블을 생성해주었다. SERIAL로써 행이 추가될 때 자동으로 증가하는 ID 컬럼을 기본키로 지정해주었다. 또한, user_id와 kakao_id 는 자체 로그인이거나 카카오를 통하여 로그인 할 경우의 ID이다. 

 카카오로 로그인을 할 경우에는 user_id가 null값이 될 수 있고, 자체 로그인을 통하여 로그인 할 경우에는 kakao_id가 null값이 될 수 있다. user_pw는 보안을 유지하기 위하여 해싱 과정을 거쳐 저장하였다. 

 카카오와 자체 로그인 모두 추가적인 사용자 정보를 얻고 있는데, 그 과정에서 name과 phone, birth_date를 입력해야 한다. created_at 컬럼은 가입한 날짜로써, 데이터가 추가될 때 자동으로 local time이 지정된다. 

<img src = "https://github.com/sanananan3/madweek2/assets/127393132/42353949-0769-4971-9537-1b92c78d4555" width = 20%, height = 20%>

애플리케이션을 실행하면 로그인 화면이 뜸


<img src = "https://github.com/sanananan3/madweek2/assets/127393132/e4b8eb68-7e3e-4c7b-86bc-d43f43e935d0" width = 20%, height = 20%>

회원가입이 되어 있지 않은 사용자의 경우 회원가입을 해야 함 

<img src = "https://github.com/sanananan3/madweek2/assets/127393132/02e153fa-7369-41bd-a73a-cacd28294464" width = 20%, height = 20%>


아이디와 비밀번호는 지정된 자릿수 이상을 입력해야 회원가입을 할 수 있음 

<img src = "https://github.com/sanananan3/madweek2/assets/127393132/0f994afc-5eb9-4886-88a0-a70e9bfd0e72" width = 20%, height = 20%>



전화번호는 11자리수이며, 생년월일은 8자리여야 함

<img src = "https://github.com/sanananan3/madweek2/assets/127393132/3b360d22-9787-429c-9aef-ef9f996f0af4" width = 20%, height = 20%>



회원가입에 성공하면 프로필 화면이 뜨게 된다. 

 앞선 이미지에서 볼 수 있듯이, 회원가입이 되어있지 않은 사용자는 회원가입을 우선적으로 해야한다. 사용자는 카카오톡으로 연동된 로그인과 자체 로그인 2개가 가능하다. 만약 둘 다 회원가입되어있지 않다면, 회원가입 버튼을 눌러 회원가입을 해야한다. ID 및 PW는 글자수 제한이 있으며, 생년월일은 8글자이며 전화번호는 11자리를 입력해야 회원가입에 성공할 수 있다. 회원가입에 성공한다면 바로 프로필 화면으로 넘어가게 되며, 프로필 화면에는 추가 정보에서 입력한 생년월일과 가입한 날짜, 팔로우 및 팔로잉 수, 이름, ID가 뜨게 된다. 

<aside>
💡 로그인

</aside>

 

 만약 회원가입이 되어 있는 경우의 사용자라면, 회원가입 버튼을 누르지 않고 바로 로그인으로 넘어갈 수 있다. 
 <br>
 

<img src = "https://github.com/sanananan3/madweek2/assets/127393132/e6687889-388d-4921-b829-496ec04d6c7d" width = 20%, height = 20%>


<br>
회원가입이 되어 있는 사용자의 경우에는 바로 로그인으로 넘어갈 수 있다. 

 

<img src = "https://github.com/sanananan3/madweek2/assets/127393132/fbaae0d9-e99d-47cf-9396-aaf6eb5b5fe8" width = 20%, height = 20%>
 <br>

 
로그인을 완료한 사용자의 프로필 페이지가 나온다. 
<br> 


<aside>
💡 포스팅

</aside>
 <br>


<img src = "https://github.com/sanananan3/madweek2/assets/127393132/6c15f945-c4d1-40fc-91bb-3ae4de67e0b7" width = 20%, height = 20%>


 <br>

 
우측 하단의 + 아이콘을 누를 시에 새로운 포스트를 작성할 수 있다. 

 <br>

 
<img src = "https://github.com/sanananan3/madweek2/assets/127393132/8bb042d4-9f52-4ce8-b0d8-63bf5bc3cab1" width = 20%, height = 20%>
 <br>

 
<img src = "https://github.com/sanananan3/madweek2/assets/127393132/46de0aab-31dc-4ff4-b5b2-ef7bb2f8ad8f" width = 20%, height = 20%>



해당 text field에 자신이 게시하고 싶은 내용을 입력한 후, 게시하기 버튼을 누르면 게시에 성공한다. 

해당 이미지와 같이 성공적으로 새로운 포스팅이 완료되었음을 알 수 있다. 

<aside>
💡 검색

</aside>

 검색 탭에서는 유튜브 API를 받아와 현재의 인기 동영상 플레이 리스트를 JSON 형식으로 변환한 뒤 애플리케이션에 띄우게 된다. 스크롤을 당겨 화면을 초기화 할 때마다 인기 동영상에 있는 동영상들이 랜덤으로 재생된다. 또한 아래에는 트위터 실시간 트렌드 창을 만들어 현재의 트렌드를 반영한 키워드들이 뜨게 된다. 

 검색 바에는 애플리케이션에 가입한 사용자의 ID 혹은 이름을 부분적으로 검색하여도 하단에 뜨게 되며 해당 텍스트를 누르게 되면 검색한 사용자의 프로필이 뜬다. 

 <br>

 
<img src = "https://github.com/sanananan3/madweek2/assets/127393132/e2c7906a-e09f-4766-9be1-aff0526a74cb" width = 20%, height = 20%>



유튜브 인기 동영상이 뜸 
 <br>

 
<img src = "https://github.com/sanananan3/madweek2/assets/127393132/6b976ac7-e55e-4255-a47f-a70e50b2e777" width = 20%, height = 20%>

애플리케이션에 가입한 사용자의 ID 혹은 이름을 부분적으로 검색하여도 하단에 뜸

 <br>

 
<img src = "https://github.com/sanananan3/madweek2/assets/127393132/6a59274d-145f-4c42-83a6-c7c1a263c01a" width = 20%, height = 20%>

해당 사용자의 프로필이 뜨게 됨

<aside>
💡 추천 게시물

</aside>
 <br>

 


<img src = "https://github.com/sanananan3/madweek2/assets/127393132/d3ff03cd-896d-4cb0-a30f-2de9dc1d8ace" width = 20%, height = 20%>



사용자 ‘kickkick’으로 로그인을 하였을 때 메인 탭에는 추천 게시물들이 뜨게 된다. 

현재 애플리케이션에 가입한 사용자들이 포스팅 한 게시물들이 뜬다. 해당 게시물에 좋아요를 누를 수 있는 버튼도 존재한다. 

<aside>
💡 좋아요

</aside>


추천 게시물들에 뜨는 애플리케이션에 가입한 모든 유저들의 게시물에 좋아요 버튼이 존재하는데, 좋아요 버튼을 누르게 되면 자신의 페이지의 마음에 들어요 함에 해당 게시물이 저장되게 된다.


<img src = "https://github.com/sanananan3/madweek2/assets/127393132/37e20c1a-6453-4fa8-86b5-5b4cc806e66f" width = 20%, height = 20%>



<br> 


<img src = "https://github.com/sanananan3/madweek2/assets/127393132/2ef513d6-bd98-48df-b009-84025456dd54" width = 20%, height = 20%>


<aside>
💡 로그아웃

</aside>
 <br>

 
<img src = "https://github.com/sanananan3/madweek2/assets/127393132/53d4707c-1c8c-4b13-b93b-3f57ab996ff3" width = 20%, height = 20%>
우측 상단에 있는 로그아웃 버튼 

 <br>

 
<img src = "https://github.com/sanananan3/madweek2/assets/127393132/8ad8b399-0126-4d08-8831-bc890ca21154" width = 20%, height = 20%>


로그아웃 버튼을 누르게 되면 로그아웃에 대한 다이얼로그가 뜨게 된다. 

모든 탭의 우측 상단에 존재하는 로그아웃 버튼을 누르게 되면, 로그아웃을 실행하겠냐는 Alert Dialog가 뜨게 되고, 해당 버튼을 누르게 되면 로그인 화면 창으로 되돌아가게 된다. 

### 스크럼

### 1) 2024/01/04

**진행 상황** 

flutter + mongodb + nodejs 

GitHub 레포지토리를 생성하였고, 각자의 branch 를 생성함

안드로이드 스튜디오에 Flutter 개발 환경을 구축함

Tab 5개를 만들었음 

**To do**

애플리케이션을 처음으로 실행했을 때 로그인 화면 구현 

카카오톡 로그인과 자체 로그인 2개 구현하기 

Tab 1에 프로필 화면 구현하기 

### 2) 2024/01/05

**진행 상황**

mongodb → postgresql

모바일: 자체 회원가입 카카오톡 회원가입 UI 및 기능 구현

서버: 각 회원가입 요청이 오면 body를 받아 계정을 생성해 DB에 넣는 기능 구현

**To do**

회원가입한 정보를 바탕으로 프로필 페이지 UI 그리기 ⇒ Tab 1에 프로필 정보 불러오려고 했으나 회원가입 페이지에서 tab1 으로 넘어가지가 않음.. .. . . .. . 

이미 앱에서 회원가입을 했었으면 앱 실행시 회원가입 스킵하고 자동으로 로그인 정보 불러오도록 하기

### 3) 2024/01/06

**진행 상황**

모바일: 프로필 UI 그리기, Tab 1 페이지에 프로필과 하단 Tab Bar 생성하여 게시물과 좋아요한 게시물이 list view 로써 나타나게 함 + 게시물을 작성할 수 있는 페이지 만듬 

서버: 로그인 및 로그인 정보 저장

**To do**

게시하기 버튼 눌렀을 때 데이터 베이스에 사용자 name 별로 content가 생성되어서 로그인 했을 때 Tab1의 게시물에 뜨게하기

### 4) 2024/01/07

**진행 상황**

게시물 작성 및 내 게시물 보기 구현

Tab 2에 검색 기능 추가하고 실제 트위터처럼 실시간 인기동영상을 유튜브 api 를 통하여 가져옴 

**To do**

게시물 수정 / 삭제 및 팔로우 / 좋아요 등 기능 추가

검색 기능에 실제 데이터 베이스에서 회원가입한 사용자의 정보를 검색할 수 있게 하기

### 5) 2024/01/10

**진행 상황**

검색 기능에 실제 데이터 베이스에서 회원가입한 사용자의 정보를 검색할 수 있게 함

게시물 수정 / 삭제 기능 구현

다른 사람이 작성한 최신 트윗 리스트 구현

**To do**

팔로우 / 좋아요 기능 추가 및 버그 / 오류 있는지 확인하고 수정

READ.ME 작성 및 노션 작성, 발표 

---
