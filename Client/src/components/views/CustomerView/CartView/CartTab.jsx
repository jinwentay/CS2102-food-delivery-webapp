import React, { Component } from 'react'

import { Header, Item, Divider, Form, Grid, Button, Segment, Modal, Checkbox } from 'semantic-ui-react'
import CartItem from './CartItem';

import axios from 'axios';

import { LoginContext } from '../../../LoginContext';

class CartTab extends Component {
    constructor(props) {
        super(props);
        this.state = {
            promoCode: '',
            address: '',
            subtotal: 0,
            deliveryCost: 0,
            rname: (this.props.cartItems.length === 0) ? '' : this.props.cartItems[0].rname,
            descript: '',
            minOrder: 0,
            addresshistory: [],
            ccnumber: 0,
            points: 0,
            isPointsUsed: false,
            promoapplied: '',
            promos: [],
            cartItems: this.props.cartItems.map(item => {
                return {
                    fname: item.fname,
                    price: item.price,
                    category: item.category,
                    rname: item.rname,
                    qty: 0,
                }
            })
        }
        this.handleDeleteItem = this.handleDeleteItem.bind(this);
        this.incOrDecItem = this.incOrDecItem.bind(this);
        this.handleChange = this.handleChange.bind(this);
        this.handleGetPrice = this.handleGetPrice.bind(this);
        this.handleSubmitOrder = this.handleSubmitOrder.bind(this);
        this.handleUpdateAddress = this.handleUpdateAddress.bind(this);
        this.handleUpdateCC = this.handleUpdateCC.bind(this);
        this.handleSelectUsePts = this.handleSelectUsePts.bind(this);
        this.handleSelectPromo = this.handleSelectPromo.bind(this);
    }

    componentDidMount() {
        let cid = this.context.user.id;
        axios.get('/customer/api/get/getaddresshistory', { params: { cid: cid } }).then(res => {
            if (res != "") {
                this.setState({
                    addresshistory: res.data.map((item) => {
                        return item.location;
                    })
                })
            }
        });
        this.handleUpdateCC();
        if (this.state.cartItems.length === 0) return;
        axios.get('/restaurant/api/get/gettherestaurantfromdb', { params: { rname: this.state.rname } }).then(res => {
            this.setState({
                minOrder: res.data[0].minorder,
                descript: res.data[0].descript
            });
        });


        axios.get('/customer/api/get/getpromo', { params: { rname: this.state.rname } }).then(res => {
            console.log(res.data);
            this.setState({
                promos: res.data
            })
        });
    }


    handleDeleteItem(item) {
        const fname = item.fname;
        this.setState(prevState => {
            return {
                cartItems: prevState.cartItems.filter(function (obj) {
                    return obj.fname !== fname;
                })
            }
        })

        this.props.handleDeleteItem(item);
    }

    incOrDecItem(item, op) {
        const name = item.fname;

        //increment/decrement here 
        this.setState(prevState => {
            return {
                cartItems: prevState.cartItems.map((item) => {
                    if (item.fname === name) {
                        if (!(op < 0 && item.qty === 0)) item.qty += op;
                    }
                    return item;
                }),
                subtotal: this.state.cartItems.reduce((total, item) => total += item.qty * item.price, 0)
            }
        }, () => console.log(this.state))
    }

    handleChange(event) {
        this.setState({
            [event.target.name]: event.target.value
        });
    }

    handleGetPrice() {
        if (this.state.address === '') {
            alert("Please input an address");
            return;
        }
        axios.get('/customer/api/get/getdeliverycost').then(res => {
            this.setState({
                deliveryCost: res.data[0].getdeliverycost,
            });

        })
            .catch(err => console.log(err))
    }

    handleUpdateAddress(event) {
        this.setState({
            address: event.target.name
        })
    }

    handleUpdateCC() {
        let cid = this.context.user.id;
        axios.get('/customer/api/get/getccnumberandpts', { params: { cid: cid } }).then(res => {
            this.setState({
                ccnumber: res.data[0].creditcard,
                points: res.data[0].points
            })
        });
    }

    handleSelectUsePts() {
        this.setState(prevState => ({
            isPointsUsed: !prevState.isPointsUsed
        }))
    }

    handleSelectPromo(event) {
        alert("Promotion applied");
        let i = event.target.name;
        let temp = this.state.promos;
        temp[i].selected = true;
        this.setState({
            promos: temp,
            promoapplied: temp[i]
        })
    }

    handleSubmitOrder() {
        let cid = this.context.user.id;
        if (this.state.deliveryCost === 0) {
            alert('Please click get price first!');
            return;
        }

        var subtotal = this.state.subtotal;
        if (this.state.promoapplied.promotiontype === 'fixed') {
            subtotal = subtotal - this.state.promoapplied.discount;
        } else if (this.state.promoapplied.promotiontype === 'percentage') {
            subtotal = subtotal * ((100 - this.state.promoapplied.discount) / 100);
        }

        axios.post('/customer/api/posts/insertorder',
            { cid: cid, rname: this.state.rname, cartcost: subtotal, location: this.state.address, deliverycost: this.state.delieryCost - ((this.state.isPointsUsed) ? 0 : this.state.deliveryCost), points: (this.state.isPointsUsed) ? 0 : this.state.points })
            .then(
                (res) => {
                    if (res.data === 'MinOrder Failed') {
                        alert("Min order not hit, please order more :)")
                        return;
                    } else {
                        let orid = res.data[0].insertandscheduleorder;
                        this.state.cartItems.map((item) =>
                            axios.post('/customer/api/posts/insertorderitem',
                                { orid: orid, fname: item.fname, quantity: item.qty })
                                .then((res) => { if (res.data == 'soldout') alert(item.fname + " is sold out."); })
                                .catch(err => console.log(err)
                                ));
                        if (this.state.isPointsUsed) this.setState({ points: 0 })
                        alert("Order sucessfully placed, you can check the status of your order the history tab");
                    }
                })
            .catch(err => console.log(err));
    }

    render() {
        var displayPromoTotal = "";
        if (this.state.promoapplied === "") {
            displayPromoTotal = '$' + (this.state.subtotal + this.state.deliveryCost - (this.state.isPointsUsed ? this.state.points : 0));
        } else if (this.state.promoapplied.promotiontype === 'fixed') {
            displayPromoTotal = '$' + (this.state.subtotal + this.state.deliveryCost - (this.state.isPointsUsed ? this.state.points : 0)) + ' - $' + this.state.promoapplied.discount + ' = $' + Math.max(0, (this.state.deliveryCost + this.state.subtotal - (this.state.isPointsUsed ? this.state.points : 0) - this.state.promoapplied.discount));
        } else {
            displayPromoTotal = '$' + (this.state.subtotal) + ' x ' + (100 - this.state.promoapplied.discount) / 100 + ' + $' + (this.state.deliveryCost - (this.state.isPointsUsed ? this.state.points : 0)) + ' = $' + ((this.state.promoapplied.discount / 100) * (this.state.subtotal) + this.state.deliveryCost - (this.state.isPointsUsed ? this.state.points : 0));
        }

        let restaurantPromo = this.state.promos.map((item, i) =>
            <Modal trigger={<Button size='mini' color={(item.selected) ? 'blue' : ''}  >{item.promoname}</Button>}>
                <Modal.Header>{item.promoname}</Modal.Header>
                <Modal.Content>
                    <Modal.Description>
                        <p>{item.promotiondescript}</p>
                        <Button name={i} color='blue' onClick={this.handleSelectPromo}>Select Promotion</Button>
                    </Modal.Description>
                </Modal.Content>
            </Modal>)
        let addresshistorybtn = this.state.addresshistory.map((item) => (
            <Button name={item} size='mini' onClick={this.handleUpdateAddress}>{item}</Button>
        ))
        let header = (this.state.cartItems.length === 0) ? <Header>There is nothing in your cart!</Header> :
            <Item.Group>
                <Item >
                    <Item.Content verticalAlign='middle'>
                        <Item.Header style={{ fontSize: '50px' }} as='h1'>{this.state.rname}</Item.Header>
                        <Item.Meta>{this.state.descript}</Item.Meta>
                        <Item.Description>Min Order: ${this.state.minOrder}</Item.Description>
                    </Item.Content>
                </Item>
            </Item.Group>

        let deliveryFee = (this.state.isPointsUsed) ? <text style={{ float: 'right' }}>${this.state.deliveryCost} - ${this.state.points} = ${this.state.deliveryCost - this.state.points}</text>
            : <text style={{ float: 'right' }}>${this.state.deliveryCost}</text>
        return (
            <>
                <Grid padded>
                    <Grid.Row>
                        <Grid.Column textAlign='left' width={16}>
                            {header}
                            <Divider />
                            <Form>
                                <CartItem updateItem={this.incOrDecItem} handleDeleteItem={this.handleDeleteItem} menuItems={this.state.cartItems}></CartItem>
                                <Segment>
                                    <Form.Field>
                                        <label>Please key in your address</label>
                                        {addresshistorybtn}
                                        <input style={{ margin: '5px 0px' }} name='address' value={this.state.address} type='text' onChange={this.handleChange} placeholder='Address' />
                                    </Form.Field>
                                    <Form.Field>
                                        <label>Available Promotions</label>
                                        {restaurantPromo}
                                    </Form.Field>
                                    <Header as='h5'>You have {this.state.points} points left, would you like to use it to offset your delivery cost?</Header>
                                    <Checkbox onChange={this.handleSelectUsePts} toggle label='Use points' />
                                </Segment>
                                <Button fluid color='blue' onClick={this.handleGetPrice} type='submit'>Get Price</Button>
                                <Segment>
                                    <Segment basic>
                                        <text>Subtotal:</text>
                                        <text style={{ float: 'right' }}>${this.state.subtotal}</text>
                                    </Segment>
                                    <Segment basic>
                                        <text>Delivery:</text>
                                        {deliveryFee}
                                    </Segment>

                                    <Segment basic>
                                        <text>Total:</text>
                                        <text style={{ float: 'right' }}> {displayPromoTotal} </text>
                                    </Segment>

                                    {/* promo code? */}
                                </Segment>

                                <Button.Group fluid size='large' color='blue'>
                                    <Button onClick={this.handleSubmitOrder}>Cash</Button>
                                    <Button.Or />
                                    <Modal trigger={<Button>Card</Button>}>
                                        <Modal.Header>Please key in your credit card number</Modal.Header>
                                        <Modal.Content>
                                            <Modal.Description>
                                                <Form>
                                                    <Button value onClick={this.handleUpdateCC}>Saved Card</Button>
                                                    <Form.Input name='ccnumber' value={this.state.ccnumber} onChange={this.handleChange} style={{ margin: '5px 0px' }} placeholder='Credit Card Number' />
                                                    <Form.Button color='blue' onClick={this.handleSubmitOrder}>Place Order</Form.Button>
                                                </Form>
                                            </Modal.Description>
                                        </Modal.Content>
                                    </Modal>
                                </Button.Group>
                            </Form>
                        </Grid.Column>
                    </Grid.Row>
                </Grid>
            </>
        )
    }
}

CartTab.contextType = LoginContext;


export default CartTab;