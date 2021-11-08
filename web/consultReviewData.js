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

}

getReviewData();
