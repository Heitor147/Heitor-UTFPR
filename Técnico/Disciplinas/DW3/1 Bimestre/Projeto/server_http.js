import http from 'http'

http.createServer((req, res) => {
    console.log("chegou uma requisicao")
    res.end("olá, tudo bem?")
}).listen(3000)
console.log("Servidor rodando!")