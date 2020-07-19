//Basic React Imports
import React from 'react';
import { Card, Grid, Button } from 'semantic-ui-react'
import OrderItems from './OrderItemsDetail'
import Axios from 'axios';
function OrderCardsGrid(props) {
    const order = {
        orid: props.order.orid,
        rid: props.rid
    }
    console.log("Rider id ", props.rid);
    function handleAcceptOrder() {
        Axios.post('/rider/api/posts/acceptOrder', order)
        .then(res => {
            alert(res.data.message)
            if (res.data.message === "Order Accepted!") {
                props.handleActiveOrder()    
            }
        })   
        .catch(err => console.log(err));
    }
    const orderCards =
        <Grid.Column key={props.order.orid} mobile={16} tablet={8} computer={5} >
            <Card name={props.order.orid} >
                <Card.Content>
                    <Card.Header>Order #{props.order.orid}</Card.Header>
                    <Card.Meta>
                        <span className='cid'>{props.order.rname}</span>
                    </Card.Meta>
                    <Card.Description>
                        Delivery Location: {props.order.location}
                        <OrderItems orid={props.order.orid}/>
                    </Card.Description>
                </Card.Content>
                <Card.Content extra>
                    <div className='ui two buttons'>
                        <Button basic color = 'green' onClick={handleAcceptOrder}>
                            Accept Delivery
                        </Button>
                    </div>
                </Card.Content>
            </Card>
        </Grid.Column>
    return (
        <>
            {orderCards}
        </>
    )
}

export default OrderCardsGrid;