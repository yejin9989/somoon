let bannerMinHeight = 987654321;
const bannerImgs = document.getElementsByClassName("bannerImg");
for(let i = 0; i < bannerImgs.length; i++){
    if(bannerImgs[i].naturalHeight < bannerMinHeight){
        bannerMinHeight = bannerImgs[i].naturalHeight;
    }
}

const makeBanner = () => {
    const bannerParent = document.getElementById("bannerParent");
    for(let i = 0; i < bannerData.length; i++){
        let bannerBox = document.createElement("a"),
            bannerImg = document.createElement("img");
        bannerBox.className = "bannerBox";
        bannerBox.href = bannerData[i].url;
        bannerImg.className = "bannerImg";
        bannerImg.src = bannerData[i].img_path;
        bannerBox.appendChild(bannerImg);
        bannerParent.appendChild(bannerBox);
    }
}

let bannerData;
const getBannerData = async () => {
    await fetch("https://somunbackend.com/auth-non/recommend/display", {
        method: "GET",
        headers: {
        }
    })
        .then((res) => {
            return res.json();
        })
        .then((res) => {
            bannerData = res;
            makeBanner();
        })
        .catch((err) => {
            console.log(err);
        })
}
getBannerData();

const banner = document.getElementsByClassName("bannerBox");
let bannerPos = 0;
const bannerLeft = () => {
    if(bannerPos === 0){
        bannerPos = banner.length * -100;
    }
    bannerPos += 100;
    for(let i = 0; i < banner.length; i++){
        banner[i].style.transform = "translateX(" + bannerPos + "%)";
    }
}
const bannerRight = () => {
    if(bannerPos === -100 * (banner.length - 1)){
        bannerPos = 100;
    }
    bannerPos -= 100;
    for(let i = 0; i < banner.length; i++){
        banner[i].style.transform = "translateX(" + bannerPos + "%)";
    }
}
let wait = -1;
const turn = document.getElementsByClassName("turn");
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
    for(let i = 0; i < banner.length; i++){
        banner[i].style.transform = "translateX(" + bannerPos + "%)";
    }
}
let bannerSlideTime = setInterval(bannerAutoSlide, 3000);