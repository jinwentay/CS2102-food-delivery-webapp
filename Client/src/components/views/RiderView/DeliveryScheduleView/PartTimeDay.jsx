import React, { Component, useEffect } from "react";
import moment from 'moment';

import { Button, Divider, List, Table, Container, Dropdown, Grid, Item, Segment } from "semantic-ui-react";
import axios from 'axios';
import { LoginContext } from '../../../LoginContext';
import { useState } from "react";
import PartTimeShift from "./PartTimeShift";


function PartTimeDay(props) {
    const[date, setDate] = useState('');
    const[shift1, set1] = useState([]);
    const[shift2, set2] = useState([]);
    const[shift3, set3] = useState([]);
    const[noOfShifts, setNumShifts] = useState(1);
    const[shift, setShift] = useState([1]);

    useEffect(()=> {
        console.log(shift1);
        console.log(shift2);
        console.log(shift3);
        console.log(checkValid(date,shift1,shift2,shift3));
        if(checkValid(date,shift1,shift2,shift3)) {
            saveDay();
        }
    }, [date,shift1,shift2,shift3]);

    function handleDay(e, { value }) {
        let index;
        for (let i = 0; i < props.dateOptions.length; i++) {
            if (props.dateOptions[i].value === value) {
                index = i;
            }
        }
        setDate(index);
    }

    function handleAddShift() {
        if (noOfShifts <= 3) {
            let count = noOfShifts + 1;
            setNumShifts(count);
            let add = shift;
            add.push(count);
            setShift(add);
            console.log(add);
        } else {
            alert("Maximum number of shifts in a day reached!")
        }
    }

    function saveShift(timing, shiftNum) {
        if(shiftNum === 1) {
            set1(timing);
        } else if(shiftNum === 2) {
            set2(timing);
        } else {
            set3(timing);
        };
    }

    function checkValid(date, shift1, shift2, shift3) {
        if (shift1.end >= shift2.start || shift2.end >= shift3.start || shift1.end >= shift3.start) {
            alert('Top shift must end earlier than the start of bottom shift!')
            return false;
        } else {
            if (shift1.end === "" || shift1.start === "" || date === '') {
                return false;
            }
            return true;
        }
    }

    function saveDay() {
        const shift = {
            day: date,
            shift1: shift1,
            shift2: shift2,
            shift3: shift3
        }
        props.addTimings(shift);
    }


    const shifts = shift.map(item =>
        <PartTimeShift shiftNum={item} saveShift={saveShift}></PartTimeShift>);

    return (
        <Grid columns='equal' padded>
            <Grid.Row>
                <Grid.Column width={11}>
                    <Segment>
                        <Dropdown
                            placeholder='Select Day'
                            fluid
                            selection
                            options={props.dateOptions}
                            onChange={handleDay}
                        />
                    </Segment>
                </Grid.Column>
                <Grid.Column>
                    <Segment basic>
                        <Button onClick={handleAddShift} >Add Shift</Button>
                    </Segment>
                </Grid.Column>
            </Grid.Row>
            <Grid.Row>
                <Grid.Column>
                    {shifts}
                </Grid.Column>

            </Grid.Row>
            {/* <Button onClick={saveDay}> Save Day</Button> */}

        </Grid>


    )
}

export default PartTimeDay;