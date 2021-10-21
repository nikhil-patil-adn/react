import Sidebar from '../../components/sidebar';
import React, { useState } from 'react';
import DatePicker from "react-datepicker";
import {useHistory} from "react-router-dom";
import {NavLink} from 'react-router-dom'
import apihost, {token} from '../../constants';
const Planholiday = () => {
    const history = useHistory()
    const [startDate, setStartDate] = useState(new Date());
    const [endDate, setEndDate] = useState(new Date());
    const [customerid, Setcustmerid] = useState(localStorage.getItem('customerid'))
    const basicAuth = 'Token ' + token;
    const submitplan = (e) =>{

        function formatDate(date) {
            var d = new Date(date),
                month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();
        
            if (month.length < 2) 
                month = '0' + month;
            if (day.length < 2) 
                day = '0' + day;
        
            return [year, month, day].join('-');
        }

        e.preventDefault();
        console.log(formatDate(startDate))
        
        console.log(endDate)
        var d1 = new Date();
var d2 = new Date(d1);

    if(startDate.getTime() > endDate.getTime()){
        alert("start date can not be gretter")
    }else{
        const plan={
            custid: customerid,
            startdate: formatDate(startDate)+" 00:00:00",
            enddate: formatDate(endDate)+" 23:23:23",
        }
        const requestOptions = {
            method: 'POST',
            withCrdential:true,
            credential:'include',
            headers: { 'Content-Type': 'application/json' ,'Authorization': basicAuth},
            body: JSON.stringify(plan)
        };

        fetch(apihost+"/api/myholidays/insertholidays/",requestOptions).then(result => result.json()).then((data)=>{
            history.push({
                pathname:"/myholidaylist",
            })
            
        });
    }
    }

    return (
        <>
            <div>
                <div class="row">
                    <div class="col-lg-3 sidebar-container">
                        <Sidebar />
                    </div>
                    <div class='col-lg-9'>
                    <NavLink exact to = '/myholidaylist' ><p className="text-primary">My plan holiday list</p></NavLink>
                        <div className='container table-container'>
                            <h5> My Holiday Plan</h5>
                            
                            <div class='col-lg-9'>
                                <form>
                                    <label for="startdate"> Start date   </label>
                                    <DatePicker
                                        selected={startDate} onChange={(date) => setStartDate(date)}
                                        minDate={new Date()}
                                        dateFormat="dd/MM/yyyy"
                                    />
                                    <label for="enddate"> End date   </label>
                                    <DatePicker
                                        selected={endDate} onChange={(date) => setEndDate(date)}
                                        minDate={new Date()}
                                        dateFormat="dd/MM/yyyy"
                                    />
                                    
                                    <div className="row pt-3 justify-content-md-center">
                                        <div className="col-md-3">
                                       
                                            <button type="button" onClick={submitplan} className="form-control" style={{ backgroundColor: '#4a1821', color: 'white' }}>Submit</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </>
    );
}

export default Planholiday;