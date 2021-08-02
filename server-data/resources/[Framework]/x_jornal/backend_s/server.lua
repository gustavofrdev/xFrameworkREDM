local Tunnel = module('Server/CallBack/Callback_Tunnel')
local Proxy = module('Server/CallBack/Callback_Proxy')

x_jornalSV = Proxy.getInterface('x_jornal')
x_jornalCL = Tunnel.getInterface('x_jornal')
FrameworkSV = Proxy.getInterface('_xFramework')
FrameworkCL = Tunnel.getInterface('_xFramework')

Function = {}
Proxy.addInterface('x_jornal', Function)
Tunnel.bindInterface('x_jornal', Function)

local cache = {}

function Function.sendNews(html, thumbnail, title)
    local date = os.date('%Y-%m-%d %H:%M:%S')
    FrameworkSV.SQLExecute("INSERT INTO xframework_jornal(noticia_capa, noticia_html, title, noticia_data) VALUES(@thumbnail, @html, @nottitle, @noticia_data)", {["@thumbnail"] = thumbnail, ["@html"] = html, ["@nottitle"] = title, ["@noticia_data"] = date})
    print("operação efetuada")
    TriggerClientEvent("xFramework:Notify", -1, "negado", "Uma nova notícia foi publicada no jornal dos condados! Confira já!")
end

function Function.removeNews(id)
    local source = source 
    print(source)
    local exists = FrameworkSV.SQLExecute("SELECT * FROM xframework_jornal WHERE noticia_id = @id", {["@id"] = id})
    if exists and exists[1] and exists[1].title then 
        FrameworkSV.SQLExecute("DELETE FROM xframework_jornal WHERE noticia_id = @id", {["@id"] = id})
        TriggerClientEvent("xFramework:Notify", source, "sucesso", "Noticia "..id.. " removida!")
    else 
        TriggerClientEvent("xFramework:Notify", source, "negado", "Noticia "..id.. " não existe!")
    end
end

function Function.perm()
    return FrameworkSV.HasPermission(FrameworkSV.GetUserId(source), "sistema.jornal.permissao")
end

function Function.retrieveAllNews()
    local news = FrameworkSV.SQLExecute("SELECT * FROM xframework_jornal", {})
    if news and news[1] then 
        local t = {}
        for i = 1, #news do
            t[i] = {noticia_html = news[i].noticia_html, noticia_capa = news[i].noticia_capa, title = news[i].title, noticia_id = news[i].noticia_id, noticia_data = news[i].noticia_data}
        end
        return t, #t
    else 
        return {}
    end
end