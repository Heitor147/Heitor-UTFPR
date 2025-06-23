import Section from "./Section";
import './MainContent.css'

export default function MainContent() {
    return (
        <main className="conteudo">
            <Section title="Sobre nós">
                <p>
                    Disciplina de Desenvolvimento Web 2.
                </p>
            </Section>
            <Section title="Contato">
                <p>
                    Você pode nos contatar pelo e-mail:
                    <a href="mailto:heitorchagas@alunos.utfpr.edu.br"> heitorchagas@alunos.utfpr.edu.br</a>
                </p>
            </Section>
        </main>
    );
}