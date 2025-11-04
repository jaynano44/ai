// function sumAll(...numbers){
//     if(numbers.length===0){
//         return -999;
//     }else{
//         let totalSum=0;
//         for(let i=0;i<numbers.length;i++){
//         totalSum=totalSum+numbers[i];
//         }
//         return totalSum;
//     }
// }
// function sumAll(){
//     if(arguments.length===0){
//         return -999;
//     }else{
//         let totalSum=0;
//         for(let i=0;i<arguments.length;i++){
//         totalSum=totalSum+arguments[i];
//         }
//         return totalSum;
//     }
// }
function sumAll(){
    let resultSum=0;
    if(arguments.length===0){
        return -999;
    }else{
        for(let data of arguments){
            resultSum +=data;
        }
        return resultSum;
    }
}
// console.log(sumAll());
// console.log(sumAll(1,3,5,7));
// console.log(sumAll(7));