import Calender from './../../components/calender/calender'
import React,{useEffect,useState,UseState} from 'react';
import apihost,{token,customerdata} from './../../constants'

const Mycalender = () =>{
    const [customerid,Setcustmerid]=useState(localStorage.getItem('customerid'))
    function addHoursToDate(date) {
        let newdate=date.split('T')
        return newdate=newdate[0]+"T23:00:00"
      }
    const [eventdata,Seteventdata]=useState([])
    const basicAuth = 'Token ' + token;
    let apiurl=apihost+'/api/orders/getordersbycust/'+customerid;
    console.log(customerid)
    useEffect(()=>{
        fetch(apiurl,{
            method:'GET',
            withcredential:true,
            credential:'include',
            headers:{
                'authorization':basicAuth
            }
        }).then(result=>result.json()).then((data)=>{
           console.log(data)
           const schedulerData=data.map((item,index)=>{
            return {
                startDate:item['schedule_delivery_date'],
                endDate:addHoursToDate(item['schedule_delivery_date']),
                title:"Delivery"
            }
           
        });
        console.log(schedulerData)


           Seteventdata(schedulerData)
        }).catch((error)=>{
           console.log(error)
        });

    },[])
        


    return <Calender eventdata={eventdata}/>
}
export default Mycalender;