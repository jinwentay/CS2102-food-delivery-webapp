import React from 'react';
import ReactDOM from 'react-dom';

//Css need stylesheet from CDN booststrap?
import './css/index.css';
import 'semantic-ui-css/semantic.min.css'

import App from './App';

import * as serviceWorker from './serviceWorker';
import { Router } from "react-router-dom";
import createHistory from 'history/createBrowserHistory';
const history = createHistory();

ReactDOM.render(
  // <Provider store={store}>
  //   <App />
  // </Provider>,
  <Router history={ history }>
    {/* <Routes /> */}
    <App />
  </Router>,
  document.getElementById('root')
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
