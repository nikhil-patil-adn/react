import { useLocation,useHistory} from "react-router-dom";
import React ,{useState,useEffect} from 'react'
import apihost,{token} from './../constants'
import Loader from './../components/loader'


const Order = () =>{
    const location = useLocation()
    console.log(location)
    return (
        <>
                 
         <div className="col cst-detail-box">
                    <div className="row">
        <h3>Your order status is <span className="text-success">{location.state.details.order_status.replace(/_/g," ")} </span> and order id is 
            <span  className="text-primary"> {location.state.details.id}</span></h3>
            </div>
            </div>

        <div className="row pt-3">

        <div class="col">
        <div className="col-md-6 mt-3">
            <h3 >Product Name:</h3> <span>{location.state.details.product}</span>
        </div>
        <div className="col-md-6 mt-3">
            <h3>Product Price:</h3> <span><i className="fa fa-inr"></i>{location.state.details.order_amount}</span>
        </div>
        <div className="col-md-6 mt-3">
            <h3>Product Quantity:</h3> <span> {location.state.details.quantity}</span>
        </div>
    </div>
    <div class="col">
    <div className="col-md-6 mt-3">
            <h3 >Payment Status:</h3> <span>{location.state.details.payment_status}</span>
        </div>
        <div className="col-md-6 mt-3">
            <h3 >Delivery address:</h3> <span>{location.state.details.delivery_address}</span>
        </div>
    </div>
        </div>    
        
        </>
    );
}

export default Order;