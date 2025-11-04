console.log(pow(5,3));
// 선언된 매개변수보다 많은 매개변수로 호출될 경우
console.log(pow(5,2,1,10)); //매개변수보다 많은 것들은 무시.
// 선언된 매개변수보다 적은 매개변수로 호출된 경우 :전달되지 않은 매개변수는 undefined
// x=5 y=undefined
console.log(pow(5));
console.log(pow());
function pow(x,y){
    let result =1;
    for(let cnt=1;cnt<=y;cnt++){
        result *=x; // result = result*x;
    }
    return result;
}

//return result; ***** return이 없으면 undefined로 받음
console.log(pow1(5));
console.log(pow1());
function pow1(x,y){
    let result =1;
    for(let cnt=1;cnt<=y;cnt++){
        result *=x; // result = result*x;
    }
    // return result;
}


let pow2 = (x, y) => {
  let result = 1;
  for(let cnt=1 ; cnt<=y ; cnt++){
    result *= x; // result = result*x;
  }
  //return result; return이 없으면 undefined로 받음
};
console.log(pow2(5, 3));
// 선언된 매개변수보다 많은 매개변수로 호출될 경우 : 뒷부분 무시
console.log(pow2(5, 2, 1, 10));
// 선언된 매개변수보다 적은 매개변수로 호출될 경우 : 전달되지 않은 매개변수는 undefined
console.log(pow2(5));
console.log(pow2());
// function pow(x, y){
//   let result = 1;
//   for(let cnt=1 ; cnt<=y ; cnt++){
//     result *= x; // result = result*x;
//   }
//   //return result; return이 없으면 undefined로 받음
// }