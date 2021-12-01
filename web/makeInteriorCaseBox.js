const createEle = (sortOfElement, className) => {
    let nameOfElement = document.createElement(sortOfElement);
    if (className !== undefined) nameOfElement.className = className;
    return nameOfElement;
}