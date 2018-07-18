import React from 'react';

class ConfirmationForm extends React.Component {
  constructor(props) {
    super(props);

    this.sendTxhash = this.sendTxhash.bind(this);
    this.onChange = this.onChange.bind(this);
    this.state = {
      value: '',
      valid: false,
      active: false,
      error: '',
    };
  }

  onChange(e) {
    this.setState({ value: e.target.value, active: false, error: '' });
  }

  sendTxhash(e) {
    const { value } = this.state;
    e.preventDefault();

    if (value) {
      window.fetch(`http://localhost:4000/api/v1/confirmation/${value}`, {
        headers: {
          'Content-Type': 'application/json',
        },
      })
        .then((response) => {
          if (response.status === 400) {
            this.setState({ error: 'Invalid Request!' });
            return response;
          }
          return response
            .json()
            .then(json => this.setState({ valid: json.valid, active: true, error: '' }));
        });
    }
  }

  render() {
    const {
      value, valid, active, error,
    } = this.state;
    const validText = `${valid ? 'Confirmed' : 'Not Confirmed'} transaction!`;

    return (
      <div className="App">
        <header className="App-header">
          <input onChange={this.onChange} value={value} />
          <button type="submit" onClick={this.sendTxhash}>
            Send
          </button>
        </header>
        <section>
          {
            active
              && (
              <div>
                {validText}
              </div>
              )
            }
          {error && (
          <div>
            {error}
          </div>
          )}
        </section>
      </div>
    );
  }
}

export default ConfirmationForm;
