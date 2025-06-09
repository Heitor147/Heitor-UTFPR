import Section from "./Section";
import Calculadora from "./Calculadora";
import './MainContent.css'

export default function MainContent() {
    return (
        <main className="conteudo">
            <Section title="Calcular IMC">
                <Calculadora />
            </Section>
        </main>
    );
}