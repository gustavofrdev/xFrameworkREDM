window.addEventListener('message', event => {
    let data = event.data
    if (data.ler) {
        script.openRead(data.conteudo, data.remetente, data.destinatario)
    } else if (data.escrever) {
        script.openWrite()
    } else if (data.closeAll) {
        script.closeAll()
    } else if (data.sendError) {
        script.sendError(data.errorMsg, 5)
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
        script.closeAll()
    }
};

const script = {
    sendError: (message, time) => {
        $("#js-error").html(message)
        setTimeout(() => {
            $("#js-error").html("")
        }, time * 1000)
    },
    submit: () => {
        let content = $("#js-content-main").val()
        let id = $("#js-content-id").val()
        if (id && content) {

            $.post('http://x_cartas/submitContent', JSON.stringify({
                content: content,
                targetID: id
            }));
            script.closeAll()
            script.clearHTMLatributes()
        } else {
            script.sendError("ERRO: Faltam valores", 5)
        }
    },
    closeAll: () => {
        $("#js-main-cont").css('display', 'none')
        $("#js-reader").css('display', 'none')
        script.clearHTMLatributes()
        $.post('http://x_cartas/closeAll', JSON.stringify({}));
    },
    openWrite: () => {
        script.clearHTMLatributes()
        $("#js-main-cont").css('display', 'block')
        $("#js-writer").css('display', 'block')
    },
    openRead: (conteudo, remetente, destinatario) => {
        script.clearHTMLatributes()
        let remetente_reader = "Remetente: " + remetente + "<br>" + "Destinatário: " + destinatario + "</br>"
        $("#js-main-cont").css('display', 'block')
        $("#js-reader").css('display', 'block')
        $("#js-remetente-read").html(remetente_reader)
        $("#js-reader-content").html(conteudo)
    },
    clearHTMLatributes: () => {
        $("#js-remetente-read").html("")
        $("#js-reader-content").html("")
        $("#js-error").html("")
        $('#js-content-main').val('')
        $('#js-content-id').val('')
        $("#js-main-cont").css('display', 'none')
        $("#js-writer").css('display', 'none')
        $("#js-main-cont").css('display', 'none')
        $("#js-reader").css('display', 'none')
    }
}