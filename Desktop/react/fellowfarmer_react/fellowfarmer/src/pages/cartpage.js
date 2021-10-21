import React ,{useState,useEffect} from 'react';
import { confirmAlert } from 'react-confirm-alert'; // Import
import 'react-confirm-alert/src/react-confirm-alert.css';
import Otppop from '../components/otppop/otppop';
import { useLocation,useHistory} from "react-router-dom";
import { ReactSearchAutocomplete } from 'react-search-autocomplete'
import apihost,{token,customerdata} from './../constants'
import DatePicker from "react-datepicker";
import { Button} from 'react-bootstrap';
import "react-datepicker/dist/react-datepicker.css";
import './cartpage.css';
const CartPage= (props) =>{
    const basicAuth = 'Token ' + token;
    const [modalShow, setModalShow] = useState(false);
    const [searchsoc, setSerachSoc] = useState('');
    const [searchcity, setSerachCity] = useState('');
      const handleOnSearchSoc = (string, results) => {
        console.log("aaaa",string, results)
        setSerachSoc(string)

      }
      const handleOnSearchCity = (string, results) => {
        console.log("aaaa",string, results)
        setSerachCity(string)

      }
    
      const handleOnHover = (result) => {
        // the item hovered
        console.log("onhover",result)
      }
    
      const handleOnSelectcity = (item) => {
        // the item selected
        console.log("city",item)
        Setcustomercity(item.name)
      }

      const handleinputSearchString = (item) => {
          console.log("search item ===",item)
      }

      const handleOnSelectsoc = (item) => {
        // the item selected
        console.log("society",item)
        Setcustomersociety(item.name)
      }
    
      const handleOnFocus = () => {
        console.log('Focused')
      }
    
      const formatResult = (item) => {
        return item;
       // return (<p dangerouslySetInnerHTML={{__html: '<strong>'+item+'</strong>'}}></p>); //To format result as html
      }


    const letter=/^[a-zA-Z ' ' ]+$/;  
    const number=/^[0-9]+$/; 
    function validateEmail(email) {
        const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(String(email).toLowerCase());
    }
    const history = useHistory()
    const [valueauto,Setvalueauto]=useState()
    const [productid,SetProductid]=useState(0)
    const [productqty,SetProductqty]=useState(0)
    const [pagename,SetPage]=useState('')
    const [customername,Setcustomername]=useState()
    const [customermobile,Setcustomermobile]=useState()
    const [customeremail,Setcustomeremail]=useState('')
    const [customerpincode,Setcustomerpincode]=useState()
    const [customercity,Setcustomercity]=useState('')
    const [productdetail,SetProductdetail]=useState([])
    const [customersoc,Setcustomersociety]=useState('')
    const [frequency,Setfrequency]=useState('')
    const [customerflat,Setcustomerflat]=useState('')
    const [customerdetail,SetCustomerdetail]=useState([])
    const [allcity,Setallcity]=useState([])
    const [allsoc,Setallsociety]=useState([])
    const [startDate, setStartDate] = useState(new Date());
    let location=useLocation()
    const [validation, Setvalidation] = useState([{
        custmsg:'',
        custmob:'',
        custemail:'',
        custpincode:'',
        custflat:'',
        custcity:'',
        custsoc:''
    }]);


    const getpopresponse=(data)=>{
        alert(data);
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
            state:{productid:productid,productqty:productqty,pagename:pagename,
                customerdetail:customerdetails,productdetail:productdetail,frequency:frequency,selecteddate:startDate}
        })
    }

  
   

    useEffect(() => {
        SetProductid(location.state.productid)
        SetProductqty(location.state.qty)
        SetPage(location.state.page)
        let apiurl=apihost+"/api/products/details/"+location.state.productid;
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
    if(customername === "" || customername === undefined){
       let oldarr=[...validation];
       oldarr[0]['custmsg']='Please enter name'
        Setvalidation(oldarr)
    }if(customermobile === "" || customermobile === undefined){
        let oldarr=[...validation];
        oldarr[0]['custmob']='Please enter mobile number'
         Setvalidation(oldarr)
    }if(customeremail === "" || customeremail === undefined){
        let oldarr=[...validation];
        oldarr[0]['custemail']='Please enter email'
         Setvalidation(oldarr)
    }if(customerpincode === "" || customerpincode === undefined){
        let oldarr=[...validation];
        oldarr[0]['custpincode']='Please enter pincode'
         Setvalidation(oldarr)
    }if(customerflat === "" || customerflat === undefined){
        let oldarr=[...validation];
        oldarr[0]['custflat']='Please enter flat/wing'
         Setvalidation(oldarr)
         
    }if(customercity === "" || customercity === undefined){
        let oldarr=[...validation];
        oldarr[0]['custcity']='Please select city'
         Setvalidation(oldarr)
         
    }if(customersoc === "" || customersoc === undefined){
        let oldarr=[...validation];
        oldarr[0]['custsoc']='Please select society'
         Setvalidation(oldarr)
         
    }if(customersoc === "" || customersoc === undefined && searchsoc != ""){
        confirmAlert({
            closeOnClickOutside: true,
            overlayClassName:'',
            title: '',
            message: 'We currently do not serve your society. Someone from our customer support team will get in touch with you soon',
            buttons: [
              {
                label: 'Ok',
                onClick: () => {
                   const data={
                        subject:"Society error",
                        message:searchsoc,
                        to:'patilnikhil991@gmail.com'
                    }

                const apiurl=apihost+"/api/sendsmsemails/sendemailapi/"
                fetch(apiurl,{
                    method:'POST',
                    withcredential:true,
                    credential:'include',
                    body:JSON.stringify(data),
                    headers:{
                        'authorization':basicAuth
                    }
                }).then(result=>result.json()).then((data)=>{
                    console.log(data)
                    
                }).then((error)=>{
                    console.log(error)
                })
                }
                   
              },
              {
                label: 'No',
                onClick: () => {
                    
                }
              }
            ]
          });
    }else{
        if(customername !== undefined){
            if(!customername.match(letter)){
                let oldarr=[...validation];
                oldarr[0]['custmsg']='Please enter proper name'
                 Setvalidation(oldarr)
            }if(!customermobile.match(number)){
                let oldarr=[...validation];
                oldarr[0]['custmob']='Please enter proper mobile'
                 Setvalidation(oldarr)
            }if(!validateEmail(customeremail)){
                let oldarr=[...validation];
                oldarr[0]['custemail']='Please enter proper email'
                 Setvalidation(oldarr)
            } else{

                if(localStorage.getItem('customerdata') === null || localStorage.getItem('customerdata') === ""){

                   // const apiurl=apihost+"/api/sendsmsemails/sendsmsapi/"
                // fetch(apiurl,{
                //     method:'POST',
                //     withcredential:true,
                //     credential:'include',
                //     body:{
                //         mobile:customermobile.toString(),
                //         otp: Math.floor(1000 + Math.random() * 9000).toString()
                //     },
                //     headers:{
                //         'authorization':basicAuth
                //     }
                // }).then(result=>result.json()).then((data)=>{
                //     console.log(data)
                //     if(data.length === 1){
                //         setModalShow(true);
                        
                //     }
                  
                setModalShow(true);

                }else{
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
                        state:{productid:productid,productqty:productqty,pagename:pagename,
                            customerdetail:customerdetails,productdetail:productdetail,frequency:frequency,selecteddate:startDate}
                    })

                }
                
            }

        }
    } 
    }

    const clearval = (name) =>{
        let oldArr=[...validation]
        oldArr[0][name]=''
        Setvalidation(oldArr)
    }
    const checkcustname = (e) =>{
        Setcustomername(e.target.value); 
            if(!e.target.value.match(letter)){
                let oldarr=[...validation];
                oldarr[0]['custmsg']='Please enter proper name'
                 Setvalidation(oldarr)
            }
            else{
                clearval('custmsg')
            }     
    }
    const checkcustmob = (e) =>{
        Setcustomermobile(e.target.value); 
            if(!e.target.value.match(number)){
                let oldarr=[...validation];
                oldarr[0]['custmob']='Please enter proper mobile'
                 Setvalidation(oldarr)
            }
            else{
                clearval('custmob')
            }     
            if(e.target.value.length === 10){
                const apiurl=apihost+"/api/customers/checkmobile/" + e.target.value
                fetch(apiurl,{
                    method:'GET',
                    withcredential:true,
                    credential:'include',
                    headers:{
                        'authorization':basicAuth
                    }
                }).then(result=>result.json()).then((data)=>{
                    console.log(data)
                    if(data.length === 1){
                        confirmAlert({
                            closeOnClickOutside: true,
                            overlayClassName:'',
                            title: '',
                            message: 'Entered mobile number already register.Kindly change number or click yes to continue?',
                            buttons: [
                              {
                                label: 'Yes',
                                onClick: () => {
                                 
                                }
                              },
                              {
                                label: 'No',
                                onClick: () => {
                                    Setcustomermobile('');
                                }
                              }
                            ]
                          });
                        
                    }

                   
                  
                }).catch((error)=>{
                   console.log(error)
                });
            }
    }
    const checkcustemail = (e) =>{
        Setcustomeremail(e.target.value); 
            if(!validateEmail(e.target.value)){
                let oldarr=[...validation];
                oldarr[0]['custemail']='Please enter proper email'
                 Setvalidation(oldarr)
            }
            else{
                clearval('custemail')
            }     
    }
    const checkpincode = (e) =>{
        Setcustomerpincode(e.target.value); 
            if(!e.target.value.match(number)){
                let oldarr=[...validation];
                oldarr[0]['custpincode']='Please enter proper pincode'
                 Setvalidation(oldarr)
            }
            else{
                clearval('custpincode')
            }     
    }
    
    
    
    return ( 
    <>
   
    <div className="row pt-3 cst-detail-box">
        <div className="col-md-3">
            <span>Product Name:</span> <span>{productdetail.name}</span>
        </div>
        <div className="col-md-3">
            <span>Product Price:</span> <span><i className="fa fa-inr"></i>{productdetail.price}</span>
        </div>
        <div className="col-md-3">
            <span>Product Quantity:</span> <span>{productqty} {productdetail.unit}</span>
        </div>
    </div>
    <div className="row pt-3">
        <div className="col-md-6">
        <label for="Name">Name    {validation[0].custmsg ?  <span className="text-danger" >{validation[0].custmsg}</span> : ''}</label>
        <input type="text" className="form-control" id="Name" value={customername} onChange={checkcustname } placeholder="Name" />
      
        </div>

        <div className="col-md-6">
        <label for="mobile">Mobile {validation[0].custmob ?  <span className="text-danger" >{validation[0].custmob}</span> : ''}</label>
        <input type="text" className="form-control" id="mobile" value={customermobile} onChange={checkcustmob} placeholder="Mobile" />
        </div>
    </div>

   

    <div className="row pt-3">
        <div className="col-md-6">
        <label for="email">Email {validation[0].custemail ?  <span className="text-danger" >{validation[0].custemail}</span> : ''}</label>
        <input type="text" className="form-control" id="email" value={customeremail} onChange={checkcustemail} placeholder="Email" />
        </div>

        {customercity ?
   
        <div className="col-md-6">
        <label for="city">City</label>
        <input type="text" className="form-control" id="city" value={customercity} placeholder="City" />
        </div>
   
    :
   
        <div className="col-md-6">
        <label for="city">City {validation[0].custcity ?  <span className="text-danger" >{validation[0].custcity}</span> : ''}</label>
        {/* <select className="form-control"  aria-label="Default select example">
            <option value="">--Select--</option>
       { allcity.map((city,index)=>{
                    return (
                        <>
                         <option value={city.name}>{city.name}</option>
                        </>
                    );
                })
            }
 
</select> */}
<ReactSearchAutocomplete
            items={allcity}
            onSearch={handleOnSearchCity}
            onHover={handleOnHover}
            onSelect={handleOnSelectcity}
            onFocus={handleOnFocus}
            autoFocus
            formatResult={formatResult}
            styling={{
                searchIconMargin: "10px 12px 0 11px",
                clearIconMargin: "10px 0 8px 0",
                borderRadius: "",
                boxShadow:"",
                height:"50px",
                marginTop:"100px",
              }}
          />
        </div>
  
}
    </div>
   

{customersoc ? 
<div className="row pt-3" >
        <div className="col-md-6">
        <label for="society">Society</label>
        <input type="text" className="form-control" id="society" readonly value={customersoc} placeholder="Society" />
        </div>
        <div className="col-md-6">
        <label for="pincode">Pincode {validation[0].custpincode ?  <span className="text-danger" >{validation[0].custpincode}</span> : ''}</label>
        <input type="text" className="form-control" id="pincode" onChange={checkpincode} value={customerpincode} placeholder="Pincode" />
        </div>
    </div>
:
<div className="row pt-3">
<div className="col-md-6">
<label for="society" >Society {validation[0].custsoc ?  <span className="text-danger" >{validation[0].custsoc}</span> : ''}</label>
{/* <select className="form-control"  aria-label="Default select example">
    <option value="">--Select--</option>
{ allsoc.map((soc,index)=>{
            return (
                <>
                 <option value={soc.name}>{soc.name}</option>
                </>
            );
        })
    }

</select> */}
<ReactSearchAutocomplete
            items={allsoc}
            onSearch={handleOnSearchSoc}
            onHover={handleOnHover}
            onSelect={handleOnSelectsoc}
            onFocus={handleOnFocus}
           // inputSearchString={handleinputSearchString}
            autoFocus
            formatResult={formatResult}
            styling={{
                searchIconMargin: "10px 12px 0 11px",
                clearIconMargin: "10px 0 8px 0",
                borderRadius: "",
                boxShadow:"",
                height:"50px",
                marginTop:"100px",
              }}
          />
</div>

<div className="col-md-6">
        <label for="pincode">Pincode {validation[0].custpincode ?  <span className="text-danger" >{validation[0].custpincode}</span> : ''}</label>
        <input type="text" className="form-control" id="pincode" onChange={checkpincode} value={customerpincode} placeholder="Pincode" />
        </div>
</div>
}


<div className="row pt-3">
    <div className="col-md-6">
        <label for="subscription_startdate"> Date</label>
        <DatePicker selected={startDate} onChange={(date) => setStartDate(date)}
        minDate={new Date()}
        dateFormat="dd/MM/yyyy"
        />
        </div>

        
        {pagename == 'subscription' ?
        <div className="col-md-6">
        <label for="subscription_startdate">Subscription Frequency</label>
        <div className="row pt-3">
        <div className="col-md-auto">
        <input type="radio" id="daily" name="frequency" value="daily" onChange={(e) => Setfrequency(e.target.value)}/>
  <label for="daily">Daily</label>
        </div>
        <div className="col-md-auto">
        <input type="radio" id="alternate" name="frequency" value="alternate"  onChange={(e) => Setfrequency(e.target.value)} />
  <label for="alternate">Alternate</label>
  </div>        
        </div>
        </div> 
         :null }
</div>   

<div className="row pt-3">
<div className="col-md-6">
    <label for="customerflat" >Flat/Wing {validation[0].custflat ?  <span className="text-danger" >{validation[0].custflat}</span> : ''}</label>
    <input type="text" name="customerflat" value={customerflat} onChange={(e) => Setcustomerflat(e.target.value)}
     placeholder="flat/wing"/>
    </div>
    </div>

    <div className="row pt-3 justify-content-md-center">
        <div className="col-md-3">
       <button type="button" className="form-control" onClick={submitcart} style={{backgroundColor:'#4a1821',color:'white'}}>Submit</button>
        </div>
    </div>

    {/* <Button variant="primary" onClick={() => setModalShow(true)}>
        Launch vertically centered modal
      </Button> */}
    <Otppop  show={modalShow} mobile={customermobile}
        onHide={() => setModalShow(false)} getpopresponse={getpopresponse}/>
    </> 


    );

}
export default CartPage;
