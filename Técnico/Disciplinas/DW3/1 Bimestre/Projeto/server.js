import Fastify from 'fastify'

const server = Fastify()

const tarefas = [
    { id: 1, descricao: "Comprar leite"},
    { id: 2, descricao: "Estudar para a prova"},
    { id: 3, descricao: "Lavar o carro"}
]

server.get('/tarefas', async (req, res) => {
    res.send(tarefas)
})

server.post('/tarefas', async (req, res) => {
    const tarefa = req.body
    tarefas.push(tarefa)
    res.send({ status: 'sucesso', message: 'Tarefa adicionada com sucesso!' })
})

try {
    await server.listen({ port: 3000 })
    console.log('Servidor rodando na porta 3000')

} catch (erro) {
    console.error('Erro ao iniciar o servidor:', erro)
}