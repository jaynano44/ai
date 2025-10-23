// 2.js :동적인부분(파일에서 다른 이름으로 저장 ->utf-8)

name = prompt("이름은?", "홍길동") // 취소를 클릭 'null' 리턴
if (name != 'null') {
    document.write(name + '님 반갑습니다<br>');
}