//Basic React Imports
import React, { Component } from 'react';

//Semantic
import { Button, Form, Grid, Header, Radio, Message, Segment, Select } from 'semantic-ui-react'

import axios from 'axios';

class SignUp extends Component {
  constructor(props) {
    super(props);

    this.state = {
      name: '',
      email: '',
      password: '',
      riderType: '',
      selectedRestaurant: '',
      restaurants: []
    };

    this.handleLoginClick = this.handleLoginClick.bind(this);
    this.handleSubmitClick = this.handleSubmitClick.bind(this);

    this.handleChange = (event) => {
      const { name, value } = event.target;
      this.setState({
        [name]: value
      });
    };
    this.handleRadio = (e, {value}) => {
      this.setState({
        riderType: value
      })
    }
    this.handleDropdown = (event, data) => {
      this.setState({
        [data.name]: data.value
      });
    };
  }

  componentDidMount() {
    axios.get('/restaurant/api/get/restaurantsfromdb').then(res => {
      let data = res.data;
      let restaurantObj = data.map(rname => {
        return {
          key: rname.rname,
          text: rname.rname,
          value: rname.rname
        }
      })
      console.log("Restaurants\n", restaurantObj);
      this.setState({
        restaurants: restaurantObj
      })
    })
  }

  handleLoginClick() {
    this.props.viewSelector('viewLogin');
  }

  handleSubmitClick() {
    const profile = {
      userType: this.props.userType,
      name: this.state.name,
      email: this.state.email,
      password: this.state.password,
      riderType: this.state.riderType,
      selectedRestaurant: this.state.selectedRestaurant
    }
    axios.post('/api/posts/userprofiletodb', profile)
      .then(res => alert(res.data.message))
      .catch(err => console.log(err));

    //clear form inputs
    this.setState({
      name: '',
      email: '',
      password: '',
      riderType: '',
      selectedRestaurant: '',
    })
  }

  render() {
    const riderType = this.state.riderType;
    const extraField = (this.props.userType === 'rider') ? 
    <Form.Group inline>
    <label>Rider Type</label>
    <Form.Field
      control={Radio}
      label='Full-time'
      value='FTRiders'
      required={true}
      checked={riderType === 'FTRiders'}
      name="riderType"
      onChange={this.handleRadio}
    />
    <Form.Field
      control={Radio}
      label='Part-time'
      value='PTRiders'
      required={true}
      checked={riderType === 'PTRiders'}
      name="riderType"
      onChange={this.handleRadio}
    />
    </Form.Group> : (this.props.userType === 'staff') ?
    <Form.Field
      fluid
      control={Select}
      placeholder='Select Restaurant'
      /*label='Restaurant'*/
      name='selectedRestaurant'
      options={this.state.restaurants}
      required={true}
      value={this.state.selectedRestaurant}
      onChange={this.handleDropdown}
    /> : <></>;
    return (
      <>
        <Segment raised>
          <Form size='large'>

            <Form.Input
              fluid
              icon='user'
              iconPosition='left'
              placeholder='Name'
              required={true}
              name='name'
              value={this.state.name}
              onChange={this.handleChange} />
            <Form.Input
              fluid
              icon='mail'
              iconPosition='left'
              placeholder='E-mail address'
              required={true}
              name='email'
              value={this.state.email}
              onChange={this.handleChange} />
            <Form.Input
              fluid
              icon='lock'
              iconPosition='left'
              placeholder='Password'
              type='password'
              required={true}
              name='password'
              value={this.state.password}
              onChange={this.handleChange}
            />
            {extraField}
            <Button color='blue' fluid size='large' onClick={this.handleSubmitClick}>
              Sign Up
          </Button>
          </Form >
        </Segment>
        <Message>
          Already with us? <a href='#' onClick={this.handleLoginClick}>Login</a>
        </Message>
      </>
    )
  }
}

export default SignUp
