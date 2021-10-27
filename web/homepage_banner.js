var bannerMinHeight = 987654321;
var bannerImgs = document.getElementsByClassName("bannerImg");
for(var i = 0; i < bannerImgs.length; i++){
    if(bannerImgs[i].naturalHeight < bannerMinHeight){
        bannerMinHeight = bannerImgs[i].naturalHeight;
    }
}


const makeBanner = () => {
    var bannerParent = document.getElementById("bannerParent");

    for(var i = 0; i < bannerData.length; i++){
        var bannerBox = document.createElement("a");
        bannerBox.className = "bannerBox";
        bannerBox.href = bannerData[i].url;
        var bannerImg = document.createElement("img");
        bannerImg.className = "bannerImg";
        bannerImg.src = bannerData[i].img_path;
        bannerBox.appendChild(bannerImg);
        bannerParent.appendChild(bannerBox);
    }
}

let bannerData;
const getBannerData = async () => {
    await fetch("http://3.138.194.75:8080/auth-non/recommend/display", {
        method: "GET",
        headers: {
        }
    })
        .then((res) => {
            return res.json();
        })
        .then((res) => {
            bannerData = res;
            console.log(bannerData);
            makeBanner();
            //setBannerData(res);
        })
        .catch((err) => {
            console.log(err);
        })
}
getBannerData();

var banner = document.getElementsByClassName("bannerBox");
var bannerPos = 0;
const bannerLeft = () => {
    if(bannerPos === 0){
        bannerPos = banner.length * -100;
    }
    bannerPos += 100;
    for(var i = 0; i < banner.length; i++){
        banner[i].style.transform = "translateX(" + bannerPos + "%)";
    }
}
const bannerRight = () => {
    if(bannerPos === -100 * (banner.length - 1)){
        bannerPos = 100;
    }
    bannerPos -= 100;
    for(var i = 0; i < banner.length; i++){
        banner[i].style.transform = "translateX(" + bannerPos + "%)";
    }
}
let wait = -1;
var turn = document.getElementsByClassName("turn");
turn[0].addEventListener("click", () => {
    if(wait === bannerSlideTime) return;
    clearInterval(bannerSlideTime);
    wait = bannerSlideTime;
    setTimeout(() => {
        bannerSlideTime = setInterval(bannerAutoSlide, 3000);
    }, 5000);
})
turn[1].addEventListener("click", () => {
    if(wait === bannerSlideTime) return;
    clearInterval(bannerSlideTime);
    wait = bannerSlideTime;
    setTimeout(() => {
        bannerSlideTime = setInterval(bannerAutoSlide, 3000);
    }, 5000);
})
const bannerAutoSlide = () => {
    if(bannerPos === -100 * (banner.length - 1)){
        bannerPos = 100;
    }
    bannerPos -= 100;
    for(var i = 0; i < banner.length; i++){
        banner[i].style.transform = "translateX(" + bannerPos + "%)";
    }
}
let bannerSlideTime = setInterval(bannerAutoSlide, 3000);