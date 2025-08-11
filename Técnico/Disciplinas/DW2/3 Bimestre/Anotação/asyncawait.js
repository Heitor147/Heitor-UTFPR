function tarefa1() {
    const sucesso = true
    console.log("Executando tarefa1")

    const promessa = new Promise((resolve, reject) => {
        if (sucesso) {
            resolve()
        } else {
            reject()
        }
    })

    return promessa
}

function tarefa1meio() {
    const sucesso = false
    console.log("Executando tarefa1meio");

    return new Promise((resolve, reject) => {
        setTimeout(() => {
            if (sucesso) resolve();
            else reject();
        }, 2000);
    });
}

function tarefa2() {
    const sucesso = true
    console.log("Executando tarefa2");

    return new Promise((resolve, reject) => {
        setTimeout(() => {
            if (sucesso) resolve("tarefa2 concluída com sucesso");
            else reject("Erro na tarefa2");
        }, 4000);
    });
}

async function executar() {
    console.log('tarefa2: Antes do await');
    const resultado = await tarefa2()
    console.log('tarefa2: Depois do await');
    console.log(resultado);
}

// Tratamento de erros
async function buscarDados() {
    try {
        const response = await fetch('https://jsonplaceholder.typicode.com/users/1');
        const data = await response.json();
        console.log(data);
    } catch (error) {
        console.error('Erro ao buscar dados:', error)
    }
}

tarefa1().then(() => console.log("tarefa1 concluída com sucesso")).catch(() => console.log("Erro na tarefa1"))
tarefa1meio().then(() => console.log("tarefa1meio concluída com sucesso")).catch(() => console.log("Erro na tarefa1meio"))
tarefa2()
executar()
buscarDados()