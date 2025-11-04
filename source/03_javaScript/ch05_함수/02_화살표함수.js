let funVar = function(){
    console.log('1. 일반함수()함수표현식 문법 format');
    console.log('명령어 여러줄');
};
funVar();
// 명령어 블록에 명려ㅛㅇ어가 1줄 /여러줄 있을 때/return 한줄 짜리는 return을 생략
//매개변수 1개 / 그외
funcVar = () => {
    console.log('2. 매개변수 없는 2줄짜리 화살표 함수');
    console.log('명령어 여러줄')
};
funcVar();
funcVar = a => {
    console.log('3. 매개변수가 1개인 2줄짜리 화살표 함수');
    console.log('a=' +a)
};
funcVar(10);
funcVar = a => console.log('4. 매개변수가 1개인 1줄짜리 화살표 함수 a= ',a);
funcVar(20);
funcVar = function(a){
    return a*a;
}
funcVar = a => a*a;
console.log('5. 매개변수 1개, return문 1줄 있는 화살표 함수 호출 결과 : funcVar(5) ',funcVar(5));
funVar = function(a,b){
    return a*10 +b;
};
funcVar = (a,b) => a*10+b;
console.log('6. 매개변수 2개, return문 1줄 있는 화살표 함수 호출 결과 : funcVar(5,4) ',funcVar(5,4));