import "./contador.css";
import React, { useState } from 'react'; 

export default function Contador() {
  
  let [contador, setContador] = useState(0)

  function incrementar(){
    setContador(contador => contador + 1)
  }

  function decrementar(){
    setContador(contador => contador - 1)
  }
  
  return (
    <div className="container">
      <h1>Contador</h1>
      <div className="contador-display">{ contador }</div>
      <div className="botaoContainer">
        <button className="botao" onClick={ decrementar}>-</button>
        <button className="botao" onClick={ incrementar}>+</button>
      </div>
      <button className="botao">Reset</button>
    </div>
  );
}
