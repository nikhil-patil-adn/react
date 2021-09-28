import React ,{useState,useEffect} from 'react';

import { useLocation,useHistory} from "react-router-dom";

import apihost,{token,customerdata} from './../constants'
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import './cartpage.css';
const CartPage= (props) =>{
    const history = useHistory()
    const [alert, setAlert] = useState('')
    const [productid,SetProductid]=useState(0)
    const [productqty,SetProductqty]=useState(0)
    const [pagename,SetPage]=useState('')
    const [customername,Setcustomername]=useState()
    const [customermobile,Setcustomermobile]=useState('')
    const [customeremail,Setcustomeremail]=useState('')
    const [customerpincode,Setcustomerpincode]=useState('')
    const [customercity,Setcustomercity]=useState('')
    const [productdetail,SetProductdetail]=useState([])
    const [customersoc,Setcustomersociety]=useState('')
    const [customerflat,Setcustomerflat]=useState('')
    const [customerdetail,SetCustomerdetail]=useState([])
    const [allcity,Setallcity]=useState([])
    const [allsoc,Setallsociety]=useState([])
    const [startDate, setStartDate] = useState(new Date());
    let location=useLocation()
   

    useEffect(() => {
        SetProductid(location.state.productid)
        SetProductqty(location.state.qty)
        SetPage(location.state.page)
        let apiurl=apihost+"/api/products/details/"+location.state.productid;
        const basicAuth = 'Token ' + token;
        fetch(apiurl,{
            method:'GET',
            withcredential:true,
            credential:'include',
            headers:{
                'authorization':basicAuth
            }
        }).then(result=>result.json()).then((data)=>{
           
           SetProductdetail(data[0])
           console.log(data[0])
          
        }).catch((error)=>{
           console.log(error)
        });
        if(localStorage.getItem('customerdata') === null || localStorage.getItem('customerdata') === ""){
            let apiurl=apihost+"/api/city/allcity/";
            const basicAuth = 'Token ' + token;
            fetch(apiurl,{
                method:'GET',
                withcredential:true,
                credential:'include',
                headers:{
                    'authorization':basicAuth
                }
            }).then(result=>result.json()).then((data)=>{
                Setallcity(data)
            }).catch((error)=>{
                console.log(error)
            });

            apiurl=apihost+"/api/location/allsociety/";
            fetch(apiurl,{
                method:'GET',
                withcredential:true,
                credential:'include',
                headers:{
                    'authorization':basicAuth
                }
            }).then(result=>result.json()).then((data)=>{
                console.log(data)
                Setallsociety(data)
            }).catch((error)=>{
                console.log(error)
            });

        }else{
            apiurl=apihost+"/api/customers/checkregister/"+localStorage.getItem('customerdata')
             fetch(apiurl,{
                 method:'GET',
                 withcredential:true,
                 credential:'include',
                 headers:{
                     'authorization':basicAuth
                 }
             }).then(result=>result.json()).then((data)=>{
     
                 console.log(data[0])

                
                 SetCustomerdetail(data[0])
                 Setcustomername(data[0]['name'])
                 Setcustomermobile(data[0]['mobile'])
                 Setcustomeremail(data[0]['email'])
                 Setcustomerpincode(data[0]['pincode'])
                 Setcustomerflat(data[0]['address'])

                apiurl=apihost+"/api/city/getcitybyid/"+data[0]['city']
             fetch(apiurl,{
                 method:'GET',
                 withcredential:true,
                 credential:'include',
                 headers:{
                     'authorization':basicAuth
                 }
             }).then(result=>result.json()).then((data)=>{
                 Setcustomercity(data[0]['name'])
                
               
             }).catch((error)=>{
                console.log(error)
             });
             console.log(data)
             apiurl=apihost+"/api/location/getsocietybyid/"+data[0]['society']
             fetch(apiurl,{
                 method:'GET',
                 withcredential:true,
                 credential:'include',
                 headers:{
                     'authorization':basicAuth
                 }
             }).then(result=>result.json()).then((data)=>{
                 console.log(data)
                 Setcustomersociety(data[0]['name'])
                
               
             }).catch((error)=>{
                console.log(error)
             });

               
             }).catch((error)=>{
                console.log(error)
             });

        }
      


    }, [location]);

    
    

    const submitcart= (e) =>{
        e.preventDefault();
    //     const [pagename,SetPage]=useState('')
    // const [customername,Setcustomername]=useState('')
    // const [customermobile,Setcustomermobile]=useState('')
    // const [customeremail,Setcustomeremail]=useState('')
    // const [customerpincode,Setcustomerpincode]=useState('')
    // const [customercity,Setcustomercity]=useState('')
    // const [productdetail,SetProductdetail]=useState([])
    // const [customersoc,Setcustomersociety]=useState('')
    console.log("customername",customername)
    if(customername === "" || customername === undefined){
        setAlert('custname')
    }

    const customerdetails={
        customername:customername,
        customermobile:customermobile,
        customeremail:customeremail,
        customerpincode:customerpincode,
        customercity:customercity,
        customersoc:customersoc,
        customerflat:customerflat
    }
   
    history.push({
        pathname:"/review",
        state:{productid:productid,productqty:productqty,pagename:pagename,customerdetail:customerdetails,productdetail:productdetail}
    })

    }
    
    return ( 
    <>
   
    <div className="row pt-3 cst-detail-box">
        <div className="col-md-3">
            <span>Product Name:</span> <span>{productdetail.name}</span>
        </div>
        <div className="col-md-3">
            <span>Product Price:</span> <span>{productdetail.price}</span>
        </div>
        <div className="col-md-3">
            <span>Product Quantity:</span> <span>{productqty}</span>
        </div>
    </div>
    <div className="row pt-3">
        <div className="col-md-6">
        <label for="Name">Name    {alert === 'custname'?  <span className="text-danger" >Please Enter name</span> : ''}</label>
        <input type="text" className="form-control" id="Name" value={customername} onChange={(e) => {
             Setcustomername(e.target.value); setAlert('')} } placeholder="Name" />
      
        </div>

        <div className="col-md-6">
        <label for="mobile">Mobile</label>
        <input type="text" className="form-control" id="mobile" value={customermobile} placeholder="Mobile" />
        </div>
    </div>

   

    <div className="row pt-3">
        <div className="col-md-6">
        <label for="email">Email</label>
        <input type="text" className="form-control" id="email" value={customeremail} placeholder="Email" />
        </div>

        {customercity ?
   
        <div className="col-md-6">
        <label for="city">City</label>
        <input type="text" className="form-control" id="city" value={customercity} placeholder="City" />
        </div>
   
    :
   
        <div className="col-md-6">
        <label for="city">City</label>
        <select className="form-control"  aria-label="Default select example">
            <option value="">--Select--</option>
       { allcity.map((city,index)=>{
                    return (
                        <>
                         <option value={city.name}>{city.name}</option>
                        </>
                    );
                })
            }
 
</select>
        </div>
  
}
    </div>
   

{customersoc ? 
<div className="row pt-3" >
        <div className="col-md-6">
        <label for="society">Society</label>
        <input type="text" className="form-control" id="society" value={customersoc} placeholder="Society" />
        </div>
        <div className="col-md-6">
        <label for="pincode">Pincode</label>
        <input type="text" className="form-control" id="pincode" value={customerpincode} placeholder="Pincode" />
        </div>
    </div>
:
<div className="row pt-3">
<div className="col-md-6">
<label for="society">Society</label>
<select className="form-control"  aria-label="Default select example">
    <option value="">--Select--</option>
{ allsoc.map((soc,index)=>{
            return (
                <>
                 <option value={soc.name}>{soc.name}</option>
                </>
            );
        })
    }

</select>
</div>

<div className="col-md-6">
        <label for="pincode">Pincode</label>
        <input type="text" className="form-control" id="pincode" value={customerpincode} placeholder="Pincode" />
        </div>
</div>
}

{pagename == 'subscription' ?
<div className="row pt-3">
    <div className="col-md-6">
        <label for="subscription_startdate">Subscription Start Date</label>
        <DatePicker selected={startDate} onChange={(date) => setStartDate(date)}
        minDate={new Date()}
        dateFormat="dd/MM/yyyy"
        />
        </div>

        

        <div className="col-md-6">
        <label for="subscription_startdate">Subscription Frequency</label>
        <div className="row pt-3">
        <div className="col-md-auto">
        <input type="radio" id="daily" name="frequency" value="daily" />
  <label for="daily">Daily</label>
        </div>
        <div className="col-md-auto">
        <input type="radio" id="alternate" name="frequency" value="alternate" />
  <label for="alternate">Alternate</label>
  </div>        
        </div>
        </div> 
         
</div>   :null }

<div className="row pt-3">
<div className="col-md-6">
    <label for="customerflat" >Flat/Wing</label>
    <input type="text" name="customerflat" value={customerflat}  placeholder="flat/wing"/>
    </div>
    </div>

    <div className="row pt-3 justify-content-md-center">
        <div className="col-md-3">
       <button type="button" className="form-control" onClick={submitcart} style={{backgroundColor:'#c96040'}}>Submit</button>
        </div>
    </div>
    </> 
    );

}
export default CartPage;
