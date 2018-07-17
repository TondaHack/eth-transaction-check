import 'phoenix_html';
import React from 'react';
import ReactDOM from 'react-dom';
import ConfirmationForm from './components/ConfirmationForm';

const App = () => (
  <div>
    <h1>
      Transaction Confirmation
    </h1>
    <ConfirmationForm />
  </div>
);

ReactDOM.render(
  <App />,
  document.getElementById('root'),
);
