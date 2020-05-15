//Basic React Imports
import React, { Component } from "react";
import moment from 'moment';


import { Button, Divider, List, Table, Container, Dropdown, Grid, Segment } from "semantic-ui-react";
import axios from 'axios';
import { LoginContext } from '../../../LoginContext';
import PartTimeDay from "./PartTimeDay";

const dateOptions = [
  { key: '1', value: '1', text: moment().format('DD/MM/YYYY, [Today]'), disabled: false },
  { key: '2', value: '2', text: moment().add(1, 'days').format('DD/MM/YYYY, [Tomorrow]'), disabled: false },
  { key: '3', value: '3', text: moment().add(2, 'days').format('DD/MM/YYYY, dddd'), disabled: false },
  { key: '4', value: '4', text: moment().add(3, 'days').format('DD/MM/YYYY, dddd'), disabled: false },
  { key: '5', value: '5', text: moment().add(4, 'days').format('DD/MM/YYYY, dddd'), disabled: false },
  { key: '6', value: '6', text: moment().add(5, 'days').format('DD/MM/YYYY, dddd'), disabled: false },
  { key: '7', value: '7', text: moment().add(6, 'days').format('DD/MM/YYYY, dddd'), disabled: false },
]


const dayOptions = [
  { key: 'Mo', value: 'Mo', text: 'Monday' },
  { key: 'Tu', value: 'Tu', text: 'Tuesday' },
  { key: 'We', value: 'We', text: 'Wednesday' },
  { key: 'Th', value: 'Th', text: 'Thursday' },
  { key: 'Fr', value: 'Fr', text: 'Friday' },
  { key: 'Sa', value: 'Sa', text: 'Saturday' },
  { key: 'Su', value: 'Su', text: 'Sunday' },
]

const shiftOptions = [
  { key: 'Shift 1', value: '1', text: 'Shift 1: 10am - 2pm, 3pm - 7pm' },
  { key: 'Shift 2', value: '2', text: 'Shift 2: 11am - 3pm, 4pm - 8pm' },
  { key: 'Shift 3', value: '3', text: 'Shift 3: 12pm - 4pm, 5pm - 9pm' },
  { key: 'Shift 4', value: '4', text: 'Shift 4: 1pm - 5pm, 6pm - 10pm' },
]

class DeliveryScheduleTab extends Component {
  constructor(props) {
    super(props);
    var d = new Date();
    this.state = {
      status: '', // 1 means FT, 0 means PT
      month: d.getMonth() + 1,
      monthName: d.toLocaleString('default', { month: 'long' }),
      count: 0,
      /**FULL TIMERS**/
      monthShift: '',
      startDay: 0,
      day1: 0,
      day2: 0,
      day3: 0,
      day4: 0,
      day5: 0,
      testDate: d.toDateString(),

      /**PART TIMERS**/
      weekShift: [],
      dropDownCount: 0,
      dropDown: [],
      addShift: [],
    };
    this.handleConfirmSchedule = this.handleConfirmSchedule.bind(this);
    this.handleDay1Shift = this.handleDay1Shift.bind(this);
    this.handleDay2Shift = this.handleDay2Shift.bind(this);
    this.handleDay3Shift = this.handleDay3Shift.bind(this);
    this.handleDay4Shift = this.handleDay4Shift.bind(this);
    this.handleDay5Shift = this.handleDay5Shift.bind(this);
    this.handleAddDay = this.handleAddDay.bind(this);
    this.addTimings = this.addTimings.bind(this);
    this.handleConfirmPTSchedule = this.handleConfirmPTSchedule.bind(this);

  }

  componentDidMount() {
    let cid = this.context.user.id;
    console.log(this.state.testDate);

    //Determine rider's status (PT or FT)
    axios.get('/rider/api/get/getRiderStatus', { params: { cid: cid } }).then(res => {
      this.setState({ status: res.data[0].ft })
      console.log(this.state.status)
    }).catch(err => console.log(err))

    //Get past weeks records (PT)
    axios.get('/rider/api/get/getPastWeekSchedule', { params: { cid: cid } }).then(res => {
      this.setState({ weekShift: res.data })
      console.log(res.data)
    }).catch(err => console.log(err))
    //} else {
    //Get past months record (FT)
    axios.get('/rider/api/get/getPastMonthSchedule', { params: { cid: cid } }).then(res => {
      this.setState({ monthShift: res.data })
      console.log(this.state.monthShift);
    }).catch(err => console.log(err))
    //}
  }

  componentDidUpdate(prevProps, prevState) {
    console.log(this.state.count);
    if (prevState.count !== this.state.count) {
      let cid = this.context.user.id;

      //Get past months record (FT)
      axios.get('/rider/api/get/getPastMonthSchedule', { params: { cid: cid } }).then(res => {
        this.setState({ monthShift: res.data })
        console.log(this.state.monthShift);
      }).catch(err => console.log(err))
    }
  }

  /* 
   * FULL TIMERS 
   */

  handleStartDay = (e, { value }) => {
    let index;
    console.log(value);
    for (let i = 0; i < dayOptions.length; i++) {
      if (dayOptions[i].value === value) {
        index = dayOptions[i].text;
      }
    }
    this.setState({
      startDay: index
    });
  }

  handleDay1Shift = (e, { value }) => {
    let index;
    console.log(value);
    for (let i = 0; i < shiftOptions.length; i++) {
      if (shiftOptions[i].value === value) {
        index = i + 1;
      }
    }
    this.setState({
      day1: index
    });
  }

  handleDay2Shift = (e, { value }) => {
    let index;
    console.log(value);
    for (let i = 0; i < shiftOptions.length; i++) {
      if (shiftOptions[i].value === value) {
        index = i + 1;
      }
    }
    this.setState({
      day2: index
    });
  }

  handleDay3Shift = (e, { value }) => {
    let index;
    console.log(value);
    for (let i = 0; i < shiftOptions.length; i++) {
      if (shiftOptions[i].value === value) {
        index = i + 1;
      }
    }
    this.setState({
      day3: index
    });
  }

  handleDay4Shift = (e, { value }) => {
    let index;
    console.log(value);
    for (let i = 0; i < shiftOptions.length; i++) {
      if (shiftOptions[i].value === value) {
        index = i + 1;
      }
    }
    this.setState({
      day4: index
    });
  }

  handleDay5Shift = (e, { value }) => {
    let index;
    console.log(value);
    for (let i = 0; i < shiftOptions.length; i++) {
      if (shiftOptions[i].value === value) {
        index = i + 1;
      }
    }
    this.setState({
      day5: index
    });
  }

  updateClick() {
    if (this.state.startDay == 0 | this.state.day1 == 0 | this.state.day2 == 0 | this.state.day3 == 0 | this.state.day4 == 0 | this.state.day5 == 0) {
      return;
    }
    this.setState({ count: this.state.count + 1 })
  }

  handleConfirmSchedule() {
    let cid = this.context.user.id;
    if (this.state.startDay == 0 | this.state.day1 == 0 | this.state.day2 == 0 | this.state.day3 == 0 | this.state.day4 == 0 | this.state.day5 == 0) {
      alert('Please ensure you indicated all options!');
      return;
    }
    axios.post('/rider/api/posts/insertMWSSchedule',
      { cid: cid, month: this.state.month, startDay: this.state.startDay, day1shift: this.state.day1, day2shift: this.state.day2, day3shift: this.state.day3, day4shift: this.state.day4, day5shift: this.state.day5 })
      .then((res) => {
        alert("Successfully Updated!");
        console.log(res)
      })
      .catch(err => console.log(err));
  }

  /*
   * PART TIMERS !!! HELPS !!!
   */

  handleAddDay() {
    let count = this.state.dropDowncount + 1;
    this.setState({ dropDownCount: this.state.dropDownCount + 1 })
    let add = this.state.dropDown;
    add.push({
      count: count
    })
    this.setState({ dropDown: add })
    console.log(add);
  }

  addTimings(shift) {
    try {
      let tempShift = this.state.addShift;
      let repeat = false;
      for (let i = 0; i < tempShift.length; i++) {
        if (tempShift[i].day === shift.day) {
          tempShift[i] = shift;
          repeat = true;
        }
      }

      if (!repeat) {
        tempShift.push(shift);
      }
      this.setState({ addShift: tempShift });
    } catch (err) {
      console.log(err);
    }
  }

  handleConfirmPTSchedule() {
    let cid = this.context.user.id;
    let allShifts = this.state.addShift;
    console.log(allShifts);
    const d = new Date();
    for (let i = 0; i < allShifts.length; i++) {
      for (let j = 0; j < 3; j++) {
        let currshift;
        if (j === 0) {
          currshift = allShifts[i].shift1;
        } else if (j === 1) {
          currshift = allShifts[i].shift2;
        } else {
          currshift = allShifts[i].shift3;
        }
        if (currshift !== []) {
          axios.post('/rider/api/posts/insertWWSSchedule',
            { cid: cid, date: allShifts[i].day, shiftstart: currshift.start, shiftend: currshift.end })
            .then((res) => {
              //alert(res.data);
              // console.log('test');
              // console.log(res);
            })
            .catch(err => console.log(err));
        }

      }

    }

  }

  render() {
    const FTRiderSchedule = (this.state.monthShift.length === 0) ?
      <Table.Row>
        <Table.Cell>-</Table.Cell>
        <Table.Cell>-</Table.Cell>
        <Table.Cell>-</Table.Cell>
        <Table.Cell>-</Table.Cell>
        <Table.Cell>-</Table.Cell>
        <Table.Cell>-</Table.Cell>
        <Table.Cell>-</Table.Cell>
      </Table.Row> :
      this.state.monthShift.map((item) =>
        <Table.Row>
          <Table.Cell>{item.month}</Table.Cell>
          <Table.Cell>{item.startday}</Table.Cell>
          <Table.Cell>{item.day1shift}</Table.Cell>
          <Table.Cell>{item.day2shift}</Table.Cell>
          <Table.Cell>{item.day3shift}</Table.Cell>
          <Table.Cell>{item.day4shift}</Table.Cell>
          <Table.Cell>{item.day5shift}</Table.Cell>
        </Table.Row>
      );

    const PTRiderSchedule = (this.state.weekShift.length === 0) ?
      <Table.Row>
        <Table.Cell>-</Table.Cell>
        <Table.Cell>-</Table.Cell>
        <Table.Cell>-</Table.Cell>
        <Table.Cell>-</Table.Cell>
        <Table.Cell>-</Table.Cell>
      </Table.Row> :
      this.state.weekShift.map((item) =>
        <Table.Row>
          <Table.Cell>{item.month}</Table.Cell>
          <Table.Cell>{item.week}</Table.Cell>
          <Table.Cell>{item.day}</Table.Cell>
          <Table.Cell>{item.startt}</Table.Cell>
          <Table.Cell>{item.endt}</Table.Cell>
        </Table.Row>
      );

      const days = this.state.dropDown.map(item =>
        <PartTimeDay DayNum={item.count} addTimings={this.addTimings} dateOptions={dateOptions}></PartTimeDay>);

    let view = (this.state.status === 1) ?
      <>
        <div>
          <h1>Monthly Schedule</h1>

          <Table striped>
            <Table.Header>
              <Table.Row>
                <Table.HeaderCell>Month</Table.HeaderCell>
                <Table.HeaderCell>Start Date</Table.HeaderCell>
                <Table.HeaderCell>Day 1 Shift</Table.HeaderCell>
                <Table.HeaderCell>Day 2 Shift</Table.HeaderCell>
                <Table.HeaderCell>Day 3 Shift</Table.HeaderCell>
                <Table.HeaderCell>Day 4 Shift</Table.HeaderCell>
                <Table.HeaderCell>Day 5 Shift</Table.HeaderCell>
              </Table.Row>
            </Table.Header>
            <Table.Body>
              {FTRiderSchedule}
            </Table.Body>
          </Table>

          <Container fluid>
            <p>Shift 1: 10am - 2pm, 3pm - 7pm | Shift 2: 11am - 3pm, 4pm - 8pm | Shift 3: 12pm - 4pm, 5pm - 9pm | Shift 4: 1pm - 5pm, 6pm - 10pm</p>
          </Container>
          <h2> {this.state.monthName}'s Work Schedule</h2>

          <Grid columns={2} divided>
            <Grid.Row>
              <Grid.Column>
                <h4> Start Day </h4>
                <Dropdown
                  placeholder='Select Day'
                  fluid
                  selection
                  options={dayOptions}
                  onChange={this.handleStartDay}
                />
              </Grid.Column>
              <Grid.Column>
                <h4> Day 1 Shift </h4>
                <Dropdown
                  placeholder='Select Shift'
                  fluid
                  selection
                  options={shiftOptions}
                  onChange={this.handleDay1Shift}
                />
              </Grid.Column>
            </Grid.Row>

            <Grid.Row>
              <Grid.Column>
                <h4> Day 2 Shift </h4>
                <Dropdown
                  placeholder='Select Shift'
                  fluid
                  selection
                  options={shiftOptions}
                  onChange={this.handleDay2Shift}
                />
              </Grid.Column>
              <Grid.Column>
                <h4> Day 3 Shift </h4>
                <Dropdown
                  placeholder='Select Shift'
                  fluid
                  selection
                  options={shiftOptions}
                  onChange={this.handleDay3Shift}
                />
              </Grid.Column>
            </Grid.Row>

            <Grid.Row>
              <Grid.Column>
                <h4> Day 4 Shift </h4>
                <Dropdown
                  placeholder='Select Shift'
                  fluid
                  selection
                  options={shiftOptions}
                  onChange={this.handleDay4Shift}
                />
              </Grid.Column>
              <Grid.Column>
                <h4> Day 5 Shift </h4>
                <Dropdown
                  placeholder='Select Shift'
                  fluid
                  selection
                  options={shiftOptions}
                  onChange={this.handleDay5Shift}
                /></Grid.Column>
            </Grid.Row>
          </Grid>
          <Divider />
          <Button positive onClick={() => {
            this.handleConfirmSchedule();
            this.updateClick();
          }}>Confirm Schedule</Button>
        </div>
      </>
      :
      <div>
        <h1>Weekly Schedule</h1>
        <Table striped>
          <Table.Header>
            <Table.Row>
              <Table.HeaderCell>Month</Table.HeaderCell>
              <Table.HeaderCell>Week</Table.HeaderCell>
              <Table.HeaderCell>Day</Table.HeaderCell>
              <Table.HeaderCell>Start Time</Table.HeaderCell>
              <Table.HeaderCell>End Time</Table.HeaderCell>
            </Table.Row>
          </Table.Header>
          <Table.Body>
            {PTRiderSchedule}
          </Table.Body>
        </Table>
        <h3>Next 7 Days</h3>
        <Segment basic>
          <Button color='blue' onClick={() => { this.handleAddDay(); }} > Add Day </Button>
        </Segment>

        <Divider hidden />
        {days}
        <Segment basic>   
            <Button positive onClick={() => { this.handleConfirmPTSchedule(); }}>Save Selection</Button>
        </Segment>
      </div>

    return (
      <>
        {view}
      </>
    );
  }
}

DeliveryScheduleTab.contextType = LoginContext;
export default DeliveryScheduleTab;
