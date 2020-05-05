import React, { Component } from 'react'

import axios from 'axios';

import { Header, Form, Grid, Button, Segment, Divider } from 'semantic-ui-react'
import Orders from './Orders';

import { LoginContext } from '../../../LoginContext';

class HistoryView extends Component {
    constructor(props) {
        super(props);
        this.state = {
            orders: []
        }
    }

    componentDidMount() {
        let cid = this.context.user.id;
        console.log(cid);
        axios.get('customer/api/get/getorderhistory', { params: { cid: cid } })
            .then(res => {
                this.setState({
                    orders: res.data.map(item => {
                        console.log(item);
                        return {
                            cartCost: item.cartcost,
                            deliveredTime: item.deliveredtime,
                            deliveryCost: item.deliverycost,
                            location: item.location,
                            orid: item.orid,
                            rname: item.rname,
                            dstatus: item.dstatus
                        }
                    })
                });
            }
            );

    }
    render() {
        const orders = this.state.orders.map((item) =>
            <Orders order={item}></Orders>
        )
        return (
            <Grid textAlign='left' padded>
                <Grid.Column width={16}>
                    <Grid.Row>
                        <Header as='h1'>History</Header>
                        <Divider />
                    </Grid.Row>
                    <Grid.Row fluid padded>
                        {orders}
                    </Grid.Row>
                </Grid.Column>
            </Grid >
        )
    }

}

HistoryView.contextType = LoginContext;


export default HistoryView;