//Basic React Imports
import React, { Component } from 'react';

import { Menu } from 'semantic-ui-react'

//Search 
import SearchBar from './SearchBar'
import RestaurantMenu from './RestaurantMenu';
import RestaurantCardsGrid from './RestaurantCardsGrid';

import axios from 'axios';

class RestaurantsTab extends Component {
    constructor(props) {
        super(props);

        this.state = {
            activeRestaurant: '',
            restaurants: []
        }
        this.handleItemClick = this.handleItemClick.bind(this);
        this.changeActiveRestaurant = this.changeActiveRestaurant.bind(this);
    }

    componentDidMount() {
        axios.get('/api/get/restaurantsfromdb').then(res => this.setState({ restaurants: res.data }))
            .catch(err => console.log(err))
    }

    handleItemClick = (e, { name }) => this.setState({ activeItem: name })

    changeActiveRestaurant(name) {
        this.setState({
            activeRestaurant: name,
        });
    }

    render() {
        let view = (this.state.activeRestaurant == '') ?
            <RestaurantCardsGrid handleChangeActive={this.changeActiveRestaurant} restaurants={this.state.restaurants}></RestaurantCardsGrid>
            : <RestaurantMenu restaurantName={this.state.activeRestaurant}></RestaurantMenu>

        return (
            <>
                <SearchBar></SearchBar>
                {view}
            </>
        )
    }
}

export default RestaurantsTab;
