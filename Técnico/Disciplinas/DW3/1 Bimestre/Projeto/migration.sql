-- Cria a tabela de projetos
CREATE TABLE projetos (
  id   SERIAL PRIMARY KEY,
  nome TEXT NOT NULL
);

-- Adiciona projeto_id em tarefas como FK (nullable: tarefa pode existir sem projeto)
ALTER TABLE tarefas
  ADD COLUMN projeto_id INTEGER REFERENCES projetos(id);
