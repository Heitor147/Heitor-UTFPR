import Fastify from 'fastify'

const server = Fastify({
    logger: true
})

server.get('/', async (req, res) => {
    console.log('Requisição recebida')
    res.send('Olá, mundo!')
})

server.get('/json', async (req, res) => {
    console.log('Requisição JSON recebida')
    res.send({ nome: "Rafael" })
})

server.get('/html', async (req, res) => {
    console.log('Requisição HTML recebida')
    res.send("<h1>Olá, mundo!</h1>")
})

try {
    await server.listen({ port: 3000 })
    console.log('Servidor rodando na porta 3000')

} catch (erro) {
    console.error('Erro ao iniciar o servidor:', erro)
}