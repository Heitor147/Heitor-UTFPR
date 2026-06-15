/**
 * exemplos.service.js
 * Funções de exemplo para demonstrar o tratamento avançado de exceções
 * Seguindo conceitos do Roteiro 09 Complementar
 */

import { ValidationError, NotFoundError, ConflictError } from '../../shared/errors/AppError.js'

/**
 * Divisão segura - Lança erro se o divisor for zero
 * @param {number} dividendo - O número a ser dividido
 * @param {number} divisor - O número que divide
 * @returns {number} O resultado da divisão
 * @throws {ValidationError} Se o divisor for zero
 */
export async function divisaoSegura(dividendo, divisor) {
  console.log(`Realizando divisão: ${dividendo} / ${divisor}`)
  
  if (divisor === 0) {
    throw new ValidationError('O divisor não pode ser zero. Operação matemática inválida.')
  }
  
  if (typeof dividendo !== 'number' || typeof divisor !== 'number') {
    throw new ValidationError('Dividendo e divisor devem ser números.')
  }
  
  const resultado = dividendo / divisor
  console.log(`Resultado da divisão: ${resultado}`)
  return resultado
}

/**
 * Cadastro de Produto - Valida campos obrigatórios
 * @param {object} produto - Objeto contendo dados do produto
 * @param {string} produto.nome - Nome do produto (obrigatório)
 * @param {number} produto.preco - Preço do produto (obrigatório, deve ser > 0)
 * @param {string} produto.categoria - Categoria do produto (obrigatório)
 * @returns {object} Produto validado e registrado com ID
 * @throws {ValidationError} Se campos obrigatórios faltarem ou forem inválidos
 */
export async function cadastrarProduto(produto) {
  console.log('Iniciando cadastro de produto:', produto)
  
  // Validação de campos obrigatórios
  if (!produto.nome || typeof produto.nome !== 'string' || produto.nome.trim() === '') {
    throw new ValidationError('O campo "nome" é obrigatório e deve ser uma string não vazia.')
  }
  
  if (!produto.preco || typeof produto.preco !== 'number' || produto.preco <= 0) {
    throw new ValidationError('O campo "preco" é obrigatório e deve ser um número maior que zero.')
  }
  
  if (!produto.categoria || typeof produto.categoria !== 'string' || produto.categoria.trim() === '') {
    throw new ValidationError('O campo "categoria" é obrigatório e deve ser uma string não vazia.')
  }
  
  // Simulando ID auto-incrementado
  const produtoRegistrado = {
    id: Math.floor(Math.random() * 10000) + 1,
    nome: produto.nome.trim(),
    preco: produto.preco,
    categoria: produto.categoria.trim(),
    dataCadastro: new Date().toISOString(),
  }
  
  console.log('Produto cadastrado com sucesso:', produtoRegistrado)
  return produtoRegistrado
}

/**
 * Busca de Usuário em Memória
 * Simula um banco de dados em memória com usuários pré-registrados
 * @param {number} usuarioId - ID do usuário a buscar
 * @returns {object} Objeto do usuário encontrado
 * @throws {NotFoundError} Se o usuário com o ID dado não existir
 */
export async function buscarUsuario(usuarioId) {
  console.log(`Buscando usuário com ID: ${usuarioId}`)
  
  // Base de dados simulada em memória
  const usuarios = [
    { id: 1, nome: 'Alice Silva', email: 'alice@example.com', ativo: true },
    { id: 2, nome: 'Bob Johnson', email: 'bob@example.com', ativo: true },
    { id: 3, nome: 'Carol Davis', email: 'carol@example.com', ativo: false },
    { id: 4, nome: 'David Chen', email: 'david@example.com', ativo: true },
  ]
  
  // Busca o usuário na lista
  const usuario = usuarios.find(u => u.id === usuarioId)
  
  if (!usuario) {
    throw new NotFoundError(`Usuário com ID ${usuarioId} não encontrado na base de dados.`)
  }
  
  console.log('Usuário encontrado:', usuario)
  return usuario
}

/**
 * Atualizar Status de Usuário
 * Valida permissões e estado antes de atualizar
 * @param {number} usuarioId - ID do usuário a atualizar
 * @param {boolean} ativo - Novo status do usuário
 * @returns {object} Usuário com status atualizado
 * @throws {NotFoundError} Se o usuário não existir
 * @throws {ConflictError} Se tentar atualizar com o mesmo status
 */
export async function atualizarStatusUsuario(usuarioId, ativo) {
  console.log(`Atualizando status do usuário ${usuarioId} para: ${ativo}`)
  
  // Primeiro, busca o usuário (lança NotFoundError se não existir)
  const usuario = await buscarUsuario(usuarioId)
  
  if (usuario.ativo === ativo) {
    throw new ConflictError(
      `O usuário já possui o status "${ativo ? 'ativo' : 'inativo'}". Nenhuma alteração necessária.`
    )
  }
  
  // Simula a atualização
  usuario.ativo = ativo
  usuario.dataUltimaAtualizacao = new Date().toISOString()
  
  console.log('Status do usuário atualizado:', usuario)
  return usuario
}
