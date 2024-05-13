document.addEventListener("DOMContentLoaded", function() {
    // 페이지 로딩 완료 후 실행될 코드
    // URL에서 쿼리 파라미터를 파싱하는 함수
    function getQueryParam(param) {
        var queryString = window.location.search.substring(1);
        var params = queryString.split("&");
        for (var i = 0; i < params.length; i++) {
            var pair = params[i].split("=");
            if (pair[0] == param) {
                return decodeURIComponent(pair[1]);
            }
        }
        return null;
    }
    
    // 'page' 쿼리 파라미터 값을 가져옴
    var page = getQueryParam("page");
    
    // 제목이 존재하면, 페이지 상단에 제목을 추가
    if (page) {
        var header = document.createElement("h1");
        header.textContent = "Page " + page;
        document.body.insertBefore(header, document.body.firstChild);
    } else {
        var header = document.createElement("h1");
        header.textContent = "Main Page";
        document.body.insertBefore(header, document.body.firstChild);
    }
});

/* 기본 브라우저 기능 */
document.getElementById("tapOpenAndCloseWindow").onclick = function() {
    openNextPageInNewWindow();
    setTimeout(function() {
        window.close();
    }, 1000); // 1000밀리초(1초) 후에 창 닫음
};

document.getElementById("tapOpenWindow").onclick = function() {
    openNextPageInNewWindow();
};

document.getElementById("tapCloseWindow").onclick = function() {
    window.close();
};

document.getElementById("tapCloseParentWindow").onclick = function() {
    if (window.opener) {
        window.opener.close();
    } else {
        alert("No opener available");
    }
};

// 부모에게 값 전달
document.getElementById("tapSendMessageToParent").onclick = function() {
    setParentText();
};

/* Function */
function openNextPageInNewWindow() {
    // 'page' 쿼리 파라미터 값 추출 및 다음 페이지 번호 계산
    var currentPage = getQueryParam("page");
    var nextPage = currentPage ? Number(currentPage) + 1 : 2;  // 페이지 정보가 없으면 기본값으로 2로 설정

    // 새 창에서 다음 페이지 URL 열기
    var baseUrl = window.location.href.split('?')[0];
    var newUrl = baseUrl + "?page=" + nextPage;
    window.open(newUrl, '_blank');
    resetMessage()
}

// 현재 URL에서 페이지 번호 추출
function getQueryParam(param) {
    var queryString = window.location.search.substring(1);
    var params = queryString.split("&");
    for (var i = 0; i < params.length; i++) {
        var pair = params[i].split("=");
        if (pair[0] === param) {
            return decodeURIComponent(pair[1]);
        }
    }
    return null;
}

// 앱에서 javascript로 응답 확인용
function resetMessage() {
    var messageContainer = document.getElementById('message-container');
    messageContainer.innerText = 'Waiting Message!';
}

function onAppResponse(message) {
    var messageContainer = document.getElementById('message-container');
    messageContainer.innerText = message;
}

// 부모와 자식 간의 통신
window.addEventListener("message", (event) => {
    var messageContainer = document.getElementById('message-container');
    messageContainer.innerText = event.data;
}, false);

function setParentText() {
    if (window.opener) {
        var currentPage = getQueryParam("page");
        window.opener.postMessage("Send message from Page " + currentPage + ".", "*"); // 최대한 안전을 위해 '*' 대신 정확한 부모 URL 사용
    } else {
        alert("No opener available");
    }
}
