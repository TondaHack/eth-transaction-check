import React from "react";

class ConfirmationForm extends React.Component {
  constructor(props){
    super(props)

    this.sendTxhash = this.sendTxhash.bind(this)
    this.onChange = this.onChange.bind(this)
    this.state = {
      value: "",
      valid: false,
      active: false
    }
  }

  sendTxhash(e)  {
    e.preventDefault()

    if(this.state.value) {
      fetch(`http://localhost:4000/api/v1/confirmation/${this.state.value}`, {
        headers: {
          'Content-Type': 'application/json'
        }
      })
      .then(response => response.json())
      .then(json => this.setState({valid: json.valid, active: true}))
      .catch(console.error)
    }
  }

  onChange(e){
    this.setState({value: e.target.value, active: false})
  }

  render() {
    const { value, valid, active } = this.state

    return (
      <div className="App">
        <header className="App-header">
          <input onChange={this.onChange} value={this.state.value} />
          <button onClick={this.sendTxhash}>Send</button>
        </header>
        <section>
          {
            active &&
              <div>Token {value} is {valid ? "valid" : "invalid"}</div>
            }
        </section>
      </div>
    );
  }
}

export default ConfirmationForm;
