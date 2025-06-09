import './Section.css'

export default function Section({ title, children }) {
    return (
        <section className="card">
            <h2>{ title }</h2>
            <div>{ children }</div>
        </section>
    )
}