import { useLocation,useHistory} from "react-router-dom";
import React ,{useState,useEffect} from 'react'
import apihost,{token} from './../constants'
import Loader from './../components/loader'

const ConfirmOrder = () =>{
    const location = useLocation()
    const history = useHistory()
    const [orderdata,setOrderdata]=useState([])
    const [stoploader,SetStoploader]=useState()
    console.log(location.state);

    const currentdate = location.state.details.selecteddate;
    const datetimeval =currentdate.getFullYear() + "-"
                + (currentdate.getMonth()+1)  + "-" 
                + currentdate.getDate() + " "  
                + currentdate.getHours() + ":"  
                + currentdate.getMinutes() + ":" 
                + currentdate.getSeconds();
    console.log(datetimeval)
    const basicAuth = 'Token ' + token;
       const payload={
           name: location.state.details.customerdetail.customername,
           mobile: location.state.details.customerdetail.customermobile,
           email: location.state.details.customerdetail.customeremail,
           city: location.state.details.customerdetail.customercity,
           society: location.state.details.customerdetail.customersoc,
           prize: location.state.finalamount,
           quantity: location.state.productqty,
           address: location.state.details.customerdetail.customerflat,
           pincode: location.state.details.customerdetail.customerpincode.toString(),
           transactionid: location.state.transactionid,
           fetchorder: '1',
           btntype: location.state.details.pagename,
           selecteddate:datetimeval,
           subscriptiontype:location.state.frequencytype,
           subscriptionpaymenttype:location.state.subscriptionpaymenttype,
           prepaidoption:location.state.prepaidoption.toString(),
           selectedproductcode:location.state.details.productid           
        }

        console.log(payload);
                    
        const requestOptions = {
            method: 'POST',
            withCrdential:true,
            credential:'include',
            headers: { 'Content-Type': 'application/json' ,'Authorization': basicAuth},
            body: JSON.stringify(payload)
        };

    useEffect(()=>{
        fetch(apihost+"/api/orders/insertorder/",requestOptions).then(result => result.json()).then((data)=>{
            console.log(data);
            history.push({
                pathname:"/order",
                state:{details:data}
            })
    });
    },[location]);    

   


    return (
        <>
       
        <Loader/>
        
        </>
    );
}

export default ConfirmOrder;