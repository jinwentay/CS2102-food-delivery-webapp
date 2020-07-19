//Basic React Imports
import React, { Component } from "react";
import "./css/App.css";

//Own Import
import LoginPage from "./components/views/Login/LoginPage";
import StaffView from "./components/views/StaffView/StaffView";
import RiderView from "./components/views/RiderView/RiderView.jsx";
import CustomerView from "./components/views/CustomerView/CustomerView";
import FDSManagerView from "./components/views/FDSManagerView/FDSManagerView";
import { Route, Switch } from "react-router-dom";
import { LoginContext } from "./components/LoginContext";
import io from 'socket.io-client';
class App extends Component {
  constructor() {
    super();
    
    this.signIn = (user) => {
      if (user != null) {
        this.setState(() => ({
          isLoggedIn: true,
          user: user,
        }));
        localStorage.setItem('isLoggedIn', this.state.isLoggedIn);
        localStorage.setItem('id', this.state.user.id);
        localStorage.setItem('email', this.state.user.email);
        localStorage.setItem('name', this.state.user.name);
      } else {
        alert("Password or username is wrong!");
      }
    };
    this.signOut = () => {
      this.setState(() => ({
        isLoggedIn: false,
        user: {
          id: 0,
          email: '',
          name: ''
        },
      }));
      localStorage.setItem('isLoggedIn', this.state.isLoggedIn);
      localStorage.setItem('id', this.state.user.id);
      localStorage.setItem('email', this.state.user.email);
      localStorage.setItem('name', this.state.user.name);
    };
    this.state = {
      isLoggedIn: localStorage.getItem('isLoggedIn'),
      user: { 
        id: localStorage.getItem('id'),
        email: localStorage.getItem('email'),
        name: localStorage.getItem('name')
      },
      signIn: this.signIn,
      signOut: this.signOut,
    };
  }

  componentDidMount() {
    io.connect('http://localhost:5000');
  }

  render() {
    return (
      <div className="App">
        <LoginContext.Provider value={this.state}>
          <Switch>
            <Route exact path="/" component={LoginPage} />
            <Route path="/customer" component={CustomerView} />
            <Route path="/staff" component={StaffView} />
            <Route path="/rider" component={RiderView} />
            <Route path="/manager" component={FDSManagerView} />
          </Switch>
        </LoginContext.Provider>
      </div>
    );
  }
}

export default App;
