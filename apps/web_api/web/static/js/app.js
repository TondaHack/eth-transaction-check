import "phoenix_html"
import React from "react"
import ReactDOM from "react-dom"
import ConfirmationForm from './components/ConfirmationForm'

class HelloReact extends React.Component {
  render() {
    return (
    <div>
      <h1>Transaction Confirmation</h1>
      <ConfirmationForm />
    </div>)
  }
}

ReactDOM.render(
  <HelloReact/>,
  document.getElementById("root")
)
