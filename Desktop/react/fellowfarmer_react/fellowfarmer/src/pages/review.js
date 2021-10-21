import { useLocation,useHistory} from "react-router-dom";
import React ,{useState,useEffect} from 'react'
import apihost,{token} from './../constants'

const Productreview = () => {
    const location =useLocation()
    const history=useHistory()
    console.log("nikhil==",location.state)
    const [productdetail,SetProductdetail]=useState(location.state.productdetail)
    const [productqty,SetProductqty]=useState(location.state.productqty)
    const [coupon,SetCoupon]=useState()
    const [couponError,setCouponError]=useState('')
    const [finalamt,Setfinalamt]=useState(location.state.productdetail.price)
    const [frequencytype,Setfrequencytype]=useState(location.state.frequency)
    const [subscriptionrange,Setsubscriptionrange]=useState([])
    const [subscriptionpaymenttype,Setsubscriptionpaymenttype]=useState('')
    const [couponper,SetCouponPer]=useState('')
    const [totdays,settotdays]=useState('0')
    
    useEffect(() => {
        const script = document.createElement('script');
        script.src = 'https://checkout.razorpay.com/v1/checkout.js';
        script.async = true;
        document.body.appendChild(script);

    }, []);

    
    const fetchprepaidoption = (e) =>{
        console.log(e.target.value)
        Setsubscriptionpaymenttype(e.target.value)
        console.log(subscriptionpaymenttype)


        if(location.state.pagename === 'subscription'){
            const apiurl=apihost+"/api/frequency/fetchfrquencybyproduct/" + productdetail.id;
            const basicAuth = 'Token ' + token;
            fetch(apiurl,{
                method:'GET',
                withcredential:true,
                credential:'include',
                headers:{
                    'authorization':basicAuth
                }}).then(result => result.json()).then((value) => {
                    console.log(value)
                    Setsubscriptionrange(value)
                }).catch((error)=>{
                    console.log(error)
                });

            
        }

    }
    
  

    const checkcoupon=()=>{
        console.log(coupon)
        const apiurl=apihost+"/api/coupons/checkcoupon/" + coupon;
        const basicAuth = 'Token ' + token;
        fetch(apiurl,{
            method:'GET',
            withcredential:true,
            credential:'include',
            headers:{
                'authorization':basicAuth
            }}).then(result=>result.json()).then((value)=>{
                if(value.length > 0){
                    console.log(value)
                   SetCouponPer(value[0]['dis_count_per'])
                    calculatefinalamt(totdays,value[0]['dis_count_per'])
                    setCouponError("")

                }else{
                    Setfinalamt(productdetail.price)
                    setCouponError("Wrong coupon!!!")
                }

            }).catch((error)=>{
                console.log(error)
            })


    }

    const paybyrazor= () =>{
       
    
        var options = {
            "key": "rzp_test_gqIXbVvdcyfrlx", // Enter the Key ID generated from the Dashboard
            "amount": parseInt(finalamt)*100, // Amount is in currency subunits. Default currency is INR. Hence, 50000 refers to 50000 paise
            "currency": "INR",
            "name": "Fellowfarmer",
            "description": "Test Transaction",
            "image": "https://example.com/your_logo",
           // "order_id": "order_9A33XWu170gUtm", //This is a sample Order ID. Pass the `id` obtained in the response of Step 1
            "handler": function (response){
                alert(response.razorpay_payment_id);
                alert(response.razorpay_order_id);
                alert(response.razorpay_signature);
                if(response.razorpay_payment_id){

                    history.push({
                        pathname:"/confirm",
                        state:{details:location.state,productqty:productqty,
                            finalamount:finalamt,transactionid:response.razorpay_payment_id,
                            subscriptionpaymenttype:subscriptionpaymenttype,
                            prepaidoption:totdays,
                            frequencytype:frequencytype

                        }
                    })
                }
            },
            "prefill": {
                "name": location.state.customerdetail.customername,
                "email": location.state.customerdetail.customeremail,
                "contact": location.state.customerdetail.customermobile

            },
            "notes": {
                "address": location.state.customerdetail.customerflat
            },
            "theme": {
                "color": "#3399cc"
            }
        };
        var rzp1 = new window.Razorpay(options);
            rzp1.open();

    }

    const setdays = (e) => {
        settotdays(e.target.value)
        calculatefinalamt(e.target.value,couponper);
        
    }

    const setpostpaid = (e) =>{
        Setsubscriptionpaymenttype(e.target.value)
        settotdays(0)
        calculatefinalamt(0,couponper);
    }

    const calculatefinalamt =(days,coupon)=>{
        let famt=productdetail.price;
        if(days > 0){
             famt=parseInt(famt * days)
        }
        if(coupon > 0){
            famt=famt-(famt*parseInt(coupon)/100)
        }
        Setfinalamt(Number(famt).toFixed(2))

    }

    return (
        <>
        <h1>Review</h1>
        <div className="container">
  <div className="row">
    <div className="col">
    <div className="col-md-6 mt-3">
            <h3 >Product Name:</h3> <span>{productdetail.name}</span>
        </div>
        <div className="col-md-6 mt-3">
            <h3>Product Price:</h3> <span><i className="fa fa-inr"></i>{productdetail.price}</span>
        </div>
        <div className="col-md-6 mt-3">
            <h3>Product Quantity:</h3> <span>{productqty} {productdetail.unit}</span>
        </div>
    </div>


    
    <div className="col">
    {location.state.pagename === 'subscription' ?
        <div className="row">
        <div className="col-md-6">
        <label for="subscription_startdate">Subscription </label>
        <div className="row pt-3">
        <div className="col-md-auto">
        <input type="radio" id="prepaid" name="frequency" 
         onChange={fetchprepaidoption} value="prepaid" />
  <label for="prepaid">Prepaid</label>
        </div>
        <div className="col-md-auto">
        <input type="radio" id="postpaid" name="frequency"
         onChange={setpostpaid}  value="postpaid"   />
  <label for="postpaid">Postpaid</label>
  </div>        
        </div>
        </div>
        </div>
        :""}


        {subscriptionpaymenttype === 'prepaid'?
        

subscriptionrange.map((sub,index)=>{
    return (
        <>
    <div className="row" key={index}>
    <div className="col-md-6">
   
    <div className="row pt-3">
    <div className="col-md-auto">
    <input type="radio" id={sub.id} name="subdays" onChange={setdays}  value={sub.number_of_days}  />
 <label for={sub.id}>{sub.label_name} <span className="text-danger">(delivery will be {sub.number_of_days})</span></label> 
    </div>
       
    </div>
    </div>
    </div>
    </>

    );
    

})

       
        : ""
}

      <div className="row">
     
    <div className="col-md-6">
            <input type="text" id="coupon" name="coupon" placeholder="Add coupon" onChange={ (e) => SetCoupon(e.target.value)}/>
            <p className="text-danger">{couponError}</p>
        </div>
        <div className="col-md-6 mt-3">
            <button className="btn btn-success" onClick={checkcoupon}> Apply coupon</button>
        </div>
        </div>
        <div className="col-md-6">
        <h3>Pay : <i className="fa fa-inr"></i>{finalamt}</h3>
        </div>
    </div>
   
  </div>
</div>

    <div className="row pt-5 justify-content-md-center">
        <div className="col-md-3">
       <button type="button" className="form-control" onClick={paybyrazor} style={{backgroundColor:'#4a1821',color:'white'}}>Pay</button>
        </div>
    </div>
  
            </>
    );
}

export default Productreview;