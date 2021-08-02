let writeReturner = "";
let useHtmlAsMethodReturn = true;
let newsObject = new Object();
let switcherObject = new Object();
let readingId = 0;
const defaultCoverMargin = 14.2 // %
const readModeBg = "assets/readMode.png"
const viewModeBg = "assets/viewMode.png"
window.addEventListener('message', event => {
    let data = event.data;
    let param = event.data.param;
    if (data.action){
    switch (data.action) {
        case "writerEvent":
            tinymce_options.initialize_default();
            writeReturner = param.cb;
            useHtmlAsMethodReturn = true 
            writer.gotoWriter(param.title);
            break;
        case "promptEvent":
            writeReturner = param.cb;
            writer.gotoWriter(param.title)
            useHtmlAsMethodReturn = false 
            break;
        case "readOnly":
            const max = param.newsLength;
            actualNewsTable = param.news;
            for(i = max-1; i >= 0; i--){
                    utils.postData({copy: JSON.stringify(param.news[i])})
                    let html = '<div class="content">'
                    + '<div class="item-info">'
                        + '<img src="'+param.news[i]["noticia_capa"]+'"'
                            + 'class="content-photo">'
                        + '<div style="right: 50%;">'
                        + '</div id="js-news-title-id///">'
                        + '<span class="news_title" onclick="utils.readNews(' + param.news[i]["noticia_id"] + ')">'+ param.news[i]["title"] +'</span>'
                    + '</div>'
                    +'<div class = "noticeid">' + param.news[i]["noticia_id"] + " - " + param.news[i]["noticia_data"] + '</div>'
                    +'<p> </p>'
                    +'<p> </p>'
                + '</div>'
                $("#js-contents-wrapper").append(html);
                newsObject[param.news[i]["noticia_id"]] = param.news[i]["noticia_html"] + " - " + param.news[i]["noticia_data"];
                switcherObject[i] = {noticia_id: param.news[i]["noticia_id"], noticia_html: param.news[i]["noticia_html"] + " - " + param.news[i]["noticia_data"]}
            }
            render.news();
            break;
        default:
           // console.log("supostamente, isso não deveria acontecer");
            break;
        }
    }
})


document.onkeydown = (evt) => {
    evt = evt || window.event;
    var isEscape = false;
    if ("key" in evt) {
        isEscape = (evt.key === "Escape" || evt.key === "Esc");
    } else {
        isEscape = (evt.keyCode === 27);
    }
    if (isEscape) {
        utils.closeAll();
    }
};

const writer = {
    gotoWriter: title => {
        utils.resetHtml()
        setTimeout(()=>{
            utils.simpleInnerHtml("js-textarea-title-mother", title);
            utils.removeBodyBg();
            utils.changeNewsCoverMargin(undefined, true)
            $("#js-body").css('display', 'block');
            $("#js-news-write").css('display', 'block');
            $("#js-screen").css('display', 'block');
        }, 150)
        utils.removeBodyBg();
    },
    sendContent: (content, useHtml) => {
       // console.log(content, useHtml)
        if(useHtmlAsMethodReturn){
            utils.postData({ action: "writerCb", type: writeReturner, content: content });
        } else {
            utils.postData({ action: "writerCb", type: writeReturner, content: content.replace(/<(.|\n)*?>/g, '') });
        }
        utils.closeAll();
        utils.resetHtml();
        utils.resetLocal();
        utils.clearTextarea();
        utils.changeNewsCoverMargin(undefined, true)
    },
}

const render = {
    news: () => {
        $("#js-body").css('display', 'block');
        $("#js-news-selector").css('display', 'block');
        $("#js-screen").css('display', 'block');
        utils.changeNewsCoverMargin(undefined, true)
    },
    exitNewsAndGoToReadMode: noticia_html =>{
        $("#js-body").css('display', 'block');
        $("#js-news-selector").css('display', 'none');
        $("#js-news-min").css('display', 'block');
        $("#js-notice-here").html(noticia_html);
        utils.setBodyBg(readModeBg)
        utils.changeNewsCoverMargin(5, false)
        render.renderReadModeButtons()
    },
    exitReadModeAndGoToNews: () =>{
        $("#js-notice-here").html("");
        $("#js-body").css('display', 'block');
        $("#js-news-min").css('display', 'none');
        $("#js-news-selector").css('display', 'block');
        utils.changeNewsCoverMargin(undefined, true)
        utils.setBodyBg(viewModeBg)
        render.removeReadModeButtons()
    },
    renderReadModeButtons: () => {
        $("#js-homeBtn").css('display', 'block');
        $("#js-nextBtn").css('display', 'block');
        $("#js-previousBtn").css('display', 'block');
    },
    removeReadModeButtons: () => {
        $("#js-homeBtn").css('display', 'none');
        $("#js-nextBtn").css('display', 'none');
        $("#js-previousBtn").css('display', 'none');
    }
}

const utils = {
    simpleInnerHtml: (element, value) => {
        document.getElementById(element).innerHTML = value;
    },
    closeAll: () => {
        utils.postData({ action: "closeAll" })
        utils.resetHtml();
        utils.resetLocal();
    },
    postData: data => {
        $.post("https://x_jornal/action", JSON.stringify(data));
    },
    resetHtml: () => {
        utils.changeNewsCoverMargin(undefined, true)
        utils.setBodyBg(viewModeBg)
        setTimeout(()=>{
        $("#js-body").css('display', 'none');
        $("#js-news-min").css('display', 'none');
        $("#js-news-write").css('display', 'none');
        $("#js-screen").css('display', 'none');
        $("#js-news-selector").css('display', 'none');
        $("#js-screen").css('display', 'none');
        $("#js-notice-here").html("");
        $("#js-contents-wrapper").html("")
        render.removeReadModeButtons()
        }, 50)
    },
    resetLocal: () => {
        writeReturner = "";
        useHtmlAsMethodReturn = true;
        newsObject = [{}];
        switcherObject = [{}];
    },
    clearTextarea: () => {
        tinymce.get("content").setContent(''); 
    },
    readNews: noticia_id => {
        readingId = noticia_id
       // console.log(utils.getActualKeyInSwitcherObject(noticia_id))
        render.exitNewsAndGoToReadMode(newsObject[noticia_id]);
    },
    homeBtn: ()=> {
        render.exitReadModeAndGoToNews();
    },
    nextBtn: () => {
        let actual_key = utils.getActualKeyInSwitcherObject(readingId);
        let length = Object.keys(switcherObject).length
        if(actual_key-1 >= 0 && actual_key-1 <= length){
            let newReadingId = utils.getActualNoticeIdBySwitcherObjectKey(actual_key-1);
            readingId = newReadingId;
            utils.readNews(newReadingId)
        }
        
    },
    previousBtn: () => {
        let actual_key = utils.getActualKeyInSwitcherObject(readingId);
        let length = Object.keys(switcherObject).length
        if(actual_key+1 >= 0 && actual_key+1 <= length && switcherObject.hasOwnProperty(actual_key+1)){
            let newReadingId = utils.getActualNoticeIdBySwitcherObjectKey(actual_key+1);
            readingId = newReadingId;
            utils.readNews(newReadingId)
        }
    },
    setBodyBg: bgLoc => {
        $("#js-body").css("background-image", "url("+bgLoc+")")

    },
    removeBodyBg: () => {
        $("#js-body").css("background", "none;")
    },
    changeNewsCoverMargin: (margin, setDefault) => {
       // console.log("Setando margin: " + margin + setDefault)
        if(!setDefault || margin != undefined){
            $(".news_cover").css("margin-top", margin + "%")
        }else{
           // console.log("set w = "+defaultCoverMargin)
            $(".news_cover").css("margin-top", defaultCoverMargin + "%")
        }
    },
    screenWidth: () => {
        return window.screen.availWidth;
    },
    getActualKeyInSwitcherObject: noticia_id => {
        let result = 0;
        for( [key, value] of Object.entries(switcherObject)){
            if(value.noticia_id == noticia_id){
                result = key
            }
        }
       // console.log(result)
        return parseInt(result);
    },
    getActualNoticeIdBySwitcherObjectKey: switchObjectKey => {
        switchObjectKey = parseInt(switchObjectKey)
        console.log("switchObj key " + switchObjectKey)
        return switcherObject[switchObjectKey].noticia_id;
    }
}


const tinymce_options = {
    initialize_default: () => {
        tinymce.init({
            selector: 'textarea',
            plugins: 'media image imagetools template save',
            language: 'pt_BR',
            toolbar: 'formatselect fontsizeselect fontselect undo redo styleselect bold italic alignleft aligncenter alignright alignjustify | bullist numlist outdent indent',
            tinycomments_mode: 'embedded',
            tinycomments_author: '--',
            // height: "830", ]  -->
                         //   ]     [ => Removido para deixar responsivo ]
            // width: "1103", ]  -->
            editor_css: "text_editor.css",
        });
    },
}


