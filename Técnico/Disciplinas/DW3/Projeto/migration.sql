-- Roteiro 10: primeira persistencia real das tarefas no PostgreSQL
CREATE TABLE IF NOT EXISTS tarefas (
  id SERIAL PRIMARY KEY,
  descricao TEXT NOT NULL,
  concluido BOOLEAN NOT NULL DEFAULT FALSE
);

-- Estrutura de projetos (roteiros seguintes)
CREATE TABLE IF NOT EXISTS projetos (
  id SERIAL PRIMARY KEY,
  nome TEXT NOT NULL
);

-- Adiciona projeto_id em tarefas sem quebrar caso a coluna ja exista
ALTER TABLE tarefas
  ADD COLUMN IF NOT EXISTS projeto_id INTEGER REFERENCES projetos(id);
