import React, { Component } from 'react'
import axios from 'axios';

import { Header, Item, Divider, Segment, Modal, Button, Rating, Form } from 'semantic-ui-react'

import { LoginContext } from '../../../LoginContext';

class Orders extends Component {
    constructor(props) {
        super(props);
        this.state = ({
            rating: 4,
            review: '',
            orid: this.props.order.orid,
            cartCost: this.props.order.cartCost,
            location: this.props.order.location,
            deliveredTime: this.props.order.deliveredTime,
            deliveryCost: this.props.order.deliveryCost, //need to link with the delivery, is the data consistent?
            rname: this.props.order.rname,
            d_status: this.props.order.dstatus,
            orderItems: []
        })
        this.handleSubmitReview = this.handleSubmitReview.bind(this);
    }

    componentDidMount() {
        axios.get('customer/api/get/getorderitems', { params: { orid: this.state.orid } })
            .then(res => {
                this.setState({
                    orderItems: res.data.map(item => {
                        return {
                            fname: item.fname,
                            quantity: item.quantity
                        }
                    })
                });
            }
            );
    }

    handleSubmitReview() {
        let context = this.context;
        axios.post('customer/api/posts/postreview',
            { orid: this.state.orid, foodReview: this.state.review, deliveryRating: this.state.rating })
            .then(res => alert("Signup Sucessful"))
            .catch(err => console.log(err));
        console.log(context);
    }

    handleReview = (e, { value }) => {
        this.setState({ review: value });
    }


    handleRate = (e, { rating }) => {
        this.setState({ rating })
    }

    render() {
        console.log(this.state.review);
        const orderItems = this.state.orderItems.map((item) =>
            <header className='price'>{item.quantity} x {item.fname}</header>
        )
        return (
            <Segment width={16}>
                <Item >
                    <Item.Content textAlign='left'>
                        <Item.Header as='h3'>{this.state.rname}</Item.Header>
                        <Item.Meta>
                            <span className='price'>Status: {this.state.d_status}</span>
                        </Item.Meta>
                        <Item.Meta>
                            <span className='price'>Delivered On: {this.state.deliveredTime}</span>

                        </Item.Meta>
                        <Item.Meta>
                            <span className='price'>Delivered To: {this.state.location}</span>
                        </Item.Meta>
                        <Item.Header as='h5'>Order Summary</Item.Header>

                        {orderItems}

                        <Divider />
                        <Item.Meta>
                            <p className='price'>Subtotal: ${this.state.cartCost}</p>
                            <p className='price'>Delivery Fee: ${this.state.deliveryCost}</p>
                            <Divider />
                            <span className='price'>Total: ${this.state.cartCost + this.state.deliveryCost}</span>
                        </Item.Meta>
                        <Divider />
                        <Modal trigger={<Button>Review</Button>}>
                            <Modal.Header>Please Leave a Review</Modal.Header>
                            <Modal.Content>
                                <Modal.Description>
                                    <Header>Delivery Rating</Header>
                                    <Rating size='large' icon='star' defaultRating={4} maxRating={5} onRate={this.handleRate} />
                                    <Divider />
                                    <Header>Food Review</Header>
                                    <Form>
                                        <Form.TextArea placeholder='Tell us what you think!' onChange={this.handleReview} />
                                        <Form.Button onClick={this.handleSubmitReview}>Submit</Form.Button>
                                    </Form>
                                </Modal.Description>
                            </Modal.Content>
                        </Modal>
                    </Item.Content>
                </Item>
            </Segment>
        );
    }
}

Orders.contextType = LoginContext;

export default Orders;
