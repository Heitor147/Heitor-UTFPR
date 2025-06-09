import React, { useState } from 'react'; 

export default function Calculadora() {
    const [peso, setPeso] = useState('');
    const [altura, setAltura] = useState('');
    const [imc, setImc] = useState(null);
    const [classificacao, setClassificacao] = useState('');
    const [erro, setErro] = useState('');

    const handlePesoChange = (e) => {
        setPeso(e.target.value);
    }

    const handleAlturaChange = (e) => {
        setAltura(e.target.value);
    }

    const handleSubmit = (e) => {
        e.preventDefault(); 

        const pesoNum = parseFloat(peso);
        const alturaNum = parseFloat(altura);

        if (isNaN(pesoNum) || pesoNum <= 0 || isNaN(alturaNum) || alturaNum <= 0) {
            setErro('Por favor, digite valores válidos para peso e altura!');
            setImc(null);
            setClassificacao('');
            return;
        }

        setErro('');

        const imcCalculado = pesoNum / (alturaNum * alturaNum);
        setImc(imcCalculado.toFixed(2));

        if (imcCalculado < 18.5) {
            setClassificacao('Abaixo do peso');
        } else if (imcCalculado >= 18.5 && imcCalculado <= 24.9) {
            setClassificacao('Peso normal');
        } else if (imcCalculado >= 25 && imcCalculado <= 29.9) {
            setClassificacao('Sobrepeso')
        } else if (imcCalculado >= 30 && imcCalculado <= 34.9) {
            setClassificacao('Obesidade Grau I')
        } else if (imcCalculado >= 35 && imcCalculado <= 39.9) {
            setClassificacao('Obesidade Grau II')
        } else {
            setClassificacao('Obesidade Grau III ou Obesidade Mórbida')
        }
    }

    return (
        <form onSubmit={handleSubmit}>
            <div>
                <label htmlFor="peso">Peso (kg):</label>
                <input type="number" id="peso" name="peso" placeholder="Ex: 70" value={peso} onChange={handlePesoChange} step="0.01"/>
            </div>
            <div>
                <label htmlFor="peso">Altura (m):</label>
                <input type="number" id="altura" name="altura" placeholder="Ex: 1.75" value={altura} onChange={handleAlturaChange} step="0.01"/>
            </div>
            <button type="submit">Calcular IMC</button>

            {erro && <p style={{ color: 'red'}}>{erro}</p>}

            {imc && (
                <div>
                    <h3>Seu IMC é: {imc}</h3>
                    <p>Classificação: {classificacao}</p>
                </div>
            )}
        </form>
    )
}