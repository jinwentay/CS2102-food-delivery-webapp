//Basic React Imports
import React, { Component } from 'react';
//Semantic
import { Button, Form, Grid, Header, Image, Message, Segment } from 'semantic-ui-react'

//Own Stuff
import SelectView from './SelectView';
import SignUp from './SignUp';
import Login from './Login';
import axios from 'axios'


class LoginPage extends Component {
  constructor() {
    super();
    this.state = {
      loginStage: 'viewSelect',
      userType: 'rider',
      msg: null
    };
    this.changeView = this.changeView.bind(this);
  }

  changeView(loginStageSelect, userTypeSelect) {
    this.setState({
      userType: (userTypeSelect != undefined) ? userTypeSelect : this.state.userType,
      loginStage: loginStageSelect
    });
  }

  componentDidMount() {
    axios.get('/hello').then(res => window.alert(res.data.message))
    .catch(err => console.log(err))
  }
  
  render() {
    let view;
    if (this.state.loginStage == 'viewSelect') {
      view = <SelectView viewSelector={this.changeView} />;
    } else if (this.state.loginStage == 'viewLogin') {
      view = <Login viewSelector={this.changeView} userType={this.state.userType} />;
    } else {
      view = <SignUp viewSelector={this.changeView} userType={this.state.userType} />;
    }

    return (
      <Grid textAlign='center' style={{ height: '100vh' }} verticalAlign='middle'>
        <Grid.Column style={{ maxWidth: 450 }}>
          <h1 className="ui center aligned icon header blue">
            <i className="circular users icon"></i>
                    MoodPanda</h1>
                    <div style={{color: 'red'}}>{this.state.msg ? <p>{this.state.msg}</p>: null}</div>
          {view}
        </Grid.Column>
      </Grid>
    );
  }
}


export default LoginPage
