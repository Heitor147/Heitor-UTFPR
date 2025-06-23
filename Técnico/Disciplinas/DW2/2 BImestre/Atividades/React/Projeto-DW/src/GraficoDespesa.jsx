import React, { useState } from 'react';
import {
    BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer,
    PieChart, Pie, Cell,
    LineChart, Line
} from 'recharts';

export default function GraficoDespesa({ despesas }) {
    // Adicione um estado para a categoria selecionada do gráfico de linhas
    const [lineChartTargetCategory, setLineChartTargetCategory] = useState('');

    // Se não houver despesas, exiba uma mensagem
    if (!despesas || despesas.length === 0) {
        return <p>Não há despesas para exibir nos gráficos.</p>;
    }

    // --- Dados para o Gráfico de Barras (Número de Despesas por Categoria) ---
    const categoryData = despesas.reduce((acc, despesa) => {
        acc[despesa.category] = (acc[despesa.category] || 0) + 1;
        return acc;
    }, {});

    const barChartData = Object.keys(categoryData).map(category => ({
        name: category,
        'Número de Despesas': categoryData[category]
    }));

    // --- Dados para o Gráfico de Pizza (Distribuição de Despesas no Mês Atual) ---
    const currentMonth = new Date().getMonth();
    const currentYear = new Date().getFullYear();

    const despesaMensal = despesas.filter(item => {
        const despesaDate = new Date(item.date); // Corrigido: usar 'item.date'
        return despesaDate.getMonth() === currentMonth && despesaDate.getFullYear() === currentYear;
    });

    const categoriaDadoMensal = despesaMensal.reduce((acc, despesa) => {
        acc[despesa.category] = (acc[despesa.category] || 0) + 1;
        return acc;
    }, {});

    const pieChartData = Object.keys(categoriaDadoMensal).map(category => ({
        name: category,
        value: categoriaDadoMensal[category]
    }));

    const COLORS = ['#0088FE', '#00C49F', '#FFBB28', '#FF8042', '#AF19FF', '#FF0000'];

    // --- Dados para o Gráfico de Linhas (Evolução de Categoria ao Longo do Ano) ---
    // Extrai todas as categorias únicas para o dropdown
    const allCategories = [...new Set(despesas.map(despesa => despesa.category))];

    const dadoAnual = despesas.filter(item => {
        const despesaDate = new Date(item.date); // Corrigido: usar 'item.date'
        return despesaDate.getFullYear() === currentYear && item.category === lineChartTargetCategory; // Corrigido: usar 'item.category'
    }).reduce((acc, item) => {
        const month = new Date(item.date).getMonth();
        acc[month] = (acc[month] || 0) + 1;
        return acc;
    }, {});

    const lineChartData = Array.from({ length: 12 }, (_, i) => {
        const monthName = new Date(currentYear, i).toLocaleString('pt-BR', { month: 'short' });
        return {
            name: monthName,
            [lineChartTargetCategory]: dadoAnual[i] || 0 // Corrigido: usar 'dadoAnual'
        };
    });

    return (
        <div>
            ---
            <h2>Gráficos de Despesas</h2>

            {/* Gráfico de Barras: Número de Itens por Categoria */}
            <h3>Número de Itens por Categoria</h3>
            {barChartData.length > 0 ? (
                <ResponsiveContainer width="100%" height={300}>
                    <BarChart
                        data={barChartData}
                        margin={{ top: 5, right: 30, left: 20, bottom: 5 }}
                    >
                        <CartesianGrid strokeDasharray="3 3" />
                        <XAxis dataKey="name" />
                        <YAxis />
                        <Tooltip />
                        <Legend />
                        <Bar dataKey="Número de Despesas" fill="#8884d8" /> {/* Corrigido: dataKey */}
                    </BarChart>
                </ResponsiveContainer>
            ) : (
                <p>Adicione itens para ver o gráfico de categorias.</p>
            )}

            {/* Gráfico de Pizza: Distribuição de Itens no Mês Atual */}
            <h3>Distribuição de Itens no Mês Atual</h3>
            {pieChartData.length > 0 ? (
                <ResponsiveContainer width="100%" height={300}>
                    <PieChart>
                        <Pie
                            data={pieChartData}
                            cx="50%"
                            cy="50%"
                            labelLine={false}
                            outerRadius={80}
                            fill="#8884d8"
                            dataKey="value"
                            label={({ name, percent }) => `${name} ${(percent * 100).toFixed(0)}%`}
                        >
                            {pieChartData.map((entry, index) => (
                                <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                            ))}
                        </Pie>
                        <Tooltip />
                        <Legend />
                    </PieChart>
                </ResponsiveContainer>
            ) : (
                <p>Adicione itens no mês atual para ver o gráfico de distribuição.</p>
            )}

            {/* Gráfico de Linhas: Evolução de Itens de uma Categoria Selecionada ao Longo do Ano */}
            <h3>Evolução de Itens por Categoria ao Longo do Ano</h3>

            <p>Selecione a categoria para analisar a evolução:</p>
            <select
                value={lineChartTargetCategory}
                onChange={(e) => setLineChartTargetCategory(e.target.value)}
            >
                <option value="">Selecione uma categoria</option>
                {allCategories.map((category) => (
                    <option key={category} value={category}>
                        {category}
                    </option>
                ))}
            </select>

            {lineChartTargetCategory && (
                lineChartData.length > 0 && lineChartData.some(data => data[lineChartTargetCategory] > 0) ? (
                    <ResponsiveContainer width="100%" height={300}>
                        <LineChart
                            data={lineChartData}
                            margin={{ top: 5, right: 30, left: 20, bottom: 5 }}
                        >
                            <CartesianGrid strokeDasharray="3 3" />
                            <XAxis dataKey="name" />
                            <YAxis />
                            <Tooltip />
                            <Legend />
                            <Line type="monotone" dataKey={lineChartTargetCategory} stroke="#82ca9d" activeDot={{ r: 8 }} />
                        </LineChart>
                    </ResponsiveContainer>
                ) : (
                    <p>Adicione itens na categoria '{lineChartTargetCategory}' ao longo do ano para ver a evolução.</p>
                )
            )}
            {!lineChartTargetCategory && <p>Selecione uma categoria acima para ver o gráfico de evolução.</p>}

        </div>
    );
}