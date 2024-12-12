function addTask() {

    const newTaskInput = document.getElementById('new-task');
    const newTaskText = newTaskInput.value.trim();

    if (newTaskText !== '') {

        const newLabel = document.createElement('label');
        newLabel.className = 'checkbox-option';

        const newCheckbox = document.createElement('input');
        newCheckbox.type = 'checkbox';
        newCheckbox.className = 'task-checkbox';
        newCheckbox.name = `option${document.querySelectorAll('.task-checkbox').length + 1}`;

        const newSpan = document.createElement('span');
        newSpan.className = 'checkbox-text';
        newSpan.textContent = newTaskText;


        const editBtn = document.createElement('button');
        editBtn.className = 'edit-btn';
        editBtn.textContent = '✏️';


        const deleteBtn = document.createElement('button');
        deleteBtn.className = 'delete-btn';
        deleteBtn.textContent = '🗑️';


        newLabel.appendChild(newCheckbox);
        newLabel.appendChild(newSpan);
        newLabel.appendChild(editBtn);
        newLabel.appendChild(deleteBtn);


        const checkboxContainer = document.querySelector('.checkbox-container');
        checkboxContainer.appendChild(newLabel);


        newTaskInput.value = '';


        updateProgressBar();
    }
}

function editTask(taskSpan) {
    const newTaskName = prompt('Edite o nome da tarefa:', taskSpan.textContent);
    if (newTaskName !== null && newTaskName.trim() !== '') {
        taskSpan.textContent = newTaskName.trim();
    }
}

function deleteTask(taskLabel) {
    if (confirm('Tem certeza de que deseja excluir esta tarefa?')) {
        taskLabel.remove();
        updateProgressBar();
    }
}

function updateProgressBar() {
    const totalTasks = document.querySelectorAll('.task-checkbox').length;
    const completedTasks = document.querySelectorAll('.task-checkbox:checked').length;
    const progressPercentage = (completedTasks / totalTasks) * 100;

    document.getElementById('progress-bar').style.width = progressPercentage + '%';
    document.getElementById('progress-text').textContent = `${completedTasks}/${totalTasks} tarefas concluídas`;
}

document.querySelector('.checkbox-container').addEventListener('click', (event) => {
    if (event.target.classList.contains('edit-btn')) {
        const taskSpan = event.target.previousElementSibling;
        editTask(taskSpan);
    } else if (event.target.classList.contains('delete-btn')) {
        const taskLabel = event.target.closest('label');
        deleteTask(taskLabel);
    }
});

document.getElementById('add-task-btn').addEventListener('click', addTask);

document.getElementById('new-task').addEventListener('keypress', (event) => {
    if (event.key === 'Enter') {
        addTask();
    }
});

document.querySelector('.checkbox-container').addEventListener('change', (event) => {
    if (event.target.classList.contains('task-checkbox')) {
        updateProgressBar();
    }
});

var modal = document.getElementById("alunosModal");

var span = document.getElementsByClassName("close-btn")[0];

var themeToggleBtn = document.getElementById("theme-toggle");

function openModal() {
    modal.style.display = "flex";
}

function closeModal() {
    modal.style.display = "none";
}

themeToggleBtn.addEventListener("click", function() {
    document.body.classList.toggle("dark-mode");
});

document.addEventListener("keydown", function(event) {
    if (event.ctrlKey && event.key === 'h') {
        openModal();
    }
});

span.onclick = function() {
    closeModal();
}

window.onclick = function(event) {
    if (event.target === modal) {
        closeModal();
    }
}