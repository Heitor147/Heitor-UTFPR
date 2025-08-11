function tarefa(id) {
    const sucesso = true

    const promessa = new Promise((resolve, reject) => {
        if (sucesso) {
            resolve()
        } else {
            reject()
        }
    })

    return promessa
}

tarefa().then(()=>console.log("ok")).catch(()=>console.log("erro"))