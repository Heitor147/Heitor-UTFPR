import "./contador.css";

export default function Contador() {
  return (
    <div className="container">
      <h1>Contador</h1>
      <div className="contador-display">0</div>
      <div className="botaoContainer">
        <button className="botao">-</button>
        <button className="botao">+</button>
      </div>
      <button className="botao">Reset</button>
    </div>
  );
}
