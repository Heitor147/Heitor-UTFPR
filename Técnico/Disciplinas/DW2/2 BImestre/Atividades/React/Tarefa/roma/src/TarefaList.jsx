import TarefaItem from './TarefaItem';

export default function TarefaList({ tarefas, onToggleConcluir, oRemoverTarefa }) {
    return (
        <ul>
            {tarefas.map((tarefa) => (
                <TarefaItem 
                    tarefa={tarefa}
                    onToggleConcluir={onToggleConcluir}
                    onRemoverTarefa={onRemoverTarefa}
                />
            ))}
        </ul>
    );
}