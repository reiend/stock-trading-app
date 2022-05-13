import React from "react";
import ReactDOM from "react-dom";
import App from "./App.js";
import Element from "@libs/reiend/element.js";

const app = Element()
  .createElement("div")
  .init();

Element()
  .queryElement("body")
  .appendChild(app)

ReactDOM.render(<App />, app);
