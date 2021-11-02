let reviewData;
const getReviewData = async () => {
    await fetch("http://3.138.194.75:8080/auth-non/review", {
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
    // 여기다가 get set 설정해두고
}

const createEle = (sortOfElement, className) => {
    let nameOfElement = document.createElement(sortOfElement);
    if (className !== undefined) nameOfElement.className = className;
    return nameOfElement;
}

getReviewData();