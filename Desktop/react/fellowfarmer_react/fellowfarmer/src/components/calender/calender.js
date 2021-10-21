import Paper from '@material-ui/core/Paper';
import React ,{useState} from 'react'
import { ViewState  } from '@devexpress/dx-react-scheduler';
import {
  Scheduler,
  DayView,
  MonthView,
  Appointments,
  Toolbar,
  DateNavigator,
  TodayButton,
} from '@devexpress/dx-react-scheduler-material-ui';

const currentDate = '2021-10-10';

// const schedulerData = [
//   { startDate: '2021-10-10T09:45', endDate: '2021-10-10T11:00', title: 'Meeting' },
//   { startDate: '2021-10-11T12:00', endDate: '2021-10-11T13:30', title: 'Go to a gym' },
//   { startDate: '2021-11-10T09:45', endDate: '2021-11-10T11:00', title: 'Meeting' },
//   { startDate: '2021-11-11T12:00', endDate: '2021-12-11T13:30', title: 'Go to a gym' },
// ];


const Calender = (props) => {
    

   return (
    <Paper>
    <Scheduler
      data={props.eventdata}
      height={660}
    >
      <ViewState
      //  currentDate={currentDate}
      />
    <MonthView />
          <Toolbar />
          <DateNavigator />
          <TodayButton />
          <Appointments />
    </Scheduler>
  </Paper>
   );
}

export default Calender;