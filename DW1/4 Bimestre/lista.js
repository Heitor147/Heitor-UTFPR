// Função para adicionar nova tarefa
function addTask() {
    const newTaskInput = document.getElementById('new-task');
    const newTaskText = newTaskInput.value.trim();

    if (newTaskText !== '') {
        // Cria um novo label com checkbox e texto
        const newLabel = document.createElement('label');
        newLabel.className = 'checkbox-option';

        const newCheckbox = document.createElement('input');
        newCheckbox.type = 'checkbox';
        newCheckbox.className = 'task-checkbox';
        newCheckbox.name = `option${document.querySelectorAll('.task-checkbox').length + 1}`;

        const newSpan = document.createElement('span');
        newSpan.className = 'checkbox-text';
        newSpan.textContent = newTaskText;

        // Botão de editar
        const editBtn = document.createElement('button');
        editBtn.className = 'edit-btn';
        editBtn.textContent = '✏️';

        // Botão de excluir
        const deleteBtn = document.createElement('button');
        deleteBtn.className = 'delete-btn';
        deleteBtn.textContent = '🗑️';

        // Adiciona a tarefa ao container
        newLabel.appendChild(newCheckbox);
        newLabel.appendChild(newSpan);
        newLabel.appendChild(editBtn);
        newLabel.appendChild(deleteBtn);

        // Adiciona o novo label à lista de checkboxes
        const checkboxContainer = document.querySelector('.checkbox-container');
        checkboxContainer.appendChild(newLabel);

        // Limpa o campo de input
        newTaskInput.value = '';

        // Atualiza a barra de progresso e o contador de tarefas
        updateProgressBar();
    }
}

// Função para editar uma tarefa
function editTask(taskSpan) {
    const newTaskName = prompt('Edite o nome da tarefa:', taskSpan.textContent);
    if (newTaskName !== null && newTaskName.trim() !== '') {
        taskSpan.textContent = newTaskName.trim();
    }
}

// Função para excluir uma tarefa
function deleteTask(taskLabel) {
    if (confirm('Tem certeza de que deseja excluir esta tarefa?')) {
        taskLabel.remove();
        updateProgressBar();
    }
}

// Função para atualizar a barra de progresso e o contador
function updateProgressBar() {
    const totalTasks = document.querySelectorAll('.task-checkbox').length;
    const completedTasks = document.querySelectorAll('.task-checkbox:checked').length;
    const progressPercentage = (completedTasks / totalTasks) * 100;

    document.getElementById('progress-bar').style.width = progressPercentage + '%';
    document.getElementById('progress-text').textContent = `${completedTasks}/${totalTasks} tarefas concluídas`;
}

// Delegação de eventos para os botões de editar e excluir
document.querySelector('.checkbox-container').addEventListener('click', (event) => {
    if (event.target.classList.contains('edit-btn')) {
        const taskSpan = event.target.previousElementSibling;  // O span com o texto da tarefa
        editTask(taskSpan);
    } else if (event.target.classList.contains('delete-btn')) {
        const taskLabel = event.target.closest('label');  // O label completo da tarefa
        deleteTask(taskLabel);
    }
});

// Adiciona evento de clique no botão para adicionar nova tarefa
document.getElementById('add-task-btn').addEventListener('click', addTask);

// Também permite adicionar tarefa ao pressionar "Enter" no campo de input
document.getElementById('new-task').addEventListener('keypress', (event) => {
    if (event.key === 'Enter') {
        addTask();
    }
});
