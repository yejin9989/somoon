let reviewData;
const getReviewData = async () => {
    await fetch("https://somunbackend.com/auth-non/review", {
        method: "GET",
        headers: {
        }
    })
        .then((res) => {
            return res.json();
        })
        .then((res) => {
            reviewData = res;
            makeNoImgReview();
        })
        .catch((err) => {
            console.log(err);
        })
}

const makeNoImgReview = () => {
    for(let i = 0; i < reviewData.length; i++){
        makeNoImgReviewBox(reviewData[i]);
    }

}

getReviewData();

var value = "value1";
function printValue(){
    return value;
}
function printFunc(func){
    var value = "value2";
    console.log(func());
}

printFunc(printValue);
