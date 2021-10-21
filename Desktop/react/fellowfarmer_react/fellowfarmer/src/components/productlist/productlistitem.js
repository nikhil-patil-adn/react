import React,{useEffect,useState} from 'react'
import apihost,{token} from './../../constants'
import Rupeeimg from './../Rupeeimg'
import { useHistory } from "react-router-dom";
import './productlist.css'; 

const ProductListItem = () =>{
    const [qty,Setqty]=useState(0)
    const [productlist,setProductlist]=useState([])
    useEffect(()=>{
        const apiurl=apihost+"/api/products/fetch_products/";
        const basicAuth = 'Token ' + token;
        fetch(apiurl,{
            method:'GET',
            withcredential:true,
            credential:'include',
            headers:{
                'authorization':basicAuth
            }
        }).then(result => result.json()).then((data)=>{
            setProductlist(data)
        }).catch((error)=>{
            console.log("error",error)
        })
    },[]);

  const decrementQty = (event) =>{
    if(qty > 0){
        Setqty(parseInt(qty)-1)
        const id=event.target.id.split("_")
    document.getElementById("qty_"+id[1]).value=qty;
    }else{
        Setqty(0)
        const id=event.target.id.split("_")
    document.getElementById("qty_"+id[1]).value=qty;
    }
  }

  const incrementQty = (event) =>{
  
    Setqty(parseInt(qty)+1)
    const id=event.target.id.split("_")
    document.getElementById("qty_"+id[1]).value=qty;
}
const history=useHistory();
const addtocart=(id,e)=>{
    const selectid=e.target.id.split("_")
    let selectedqty=document.getElementById("qty_"+selectid[1]).value;
    history.push({
        pathname:"/detail",
        state:{productid:id,productqty:selectedqty}
    })

}

    return (
        <>
        <div className="container d-flex justify-content-center mt-50 mb-50">
    <div className="row">
      
  {productlist.map((item,index)=>{
      return (
        <>
        
        <div className="col-md-4 mt-2">
            <div className="card">
                <div className="card-body">
                    <div className="card-img-actions">
                         <img src={item.image_url}
                          className="cst-card-img cst-img-fluid cst-img"  alt=""/> </div>
                </div>
                <div className="card-body bg-light text-center" >
                    <div className=" cst-text">
                        
                            {item.desciption} 
                    </div>
                    <h3 className="mb-0 font-weight-semibold"><i class="fa fa-inr"></i>{item.price} </h3>
                    <div className="cst-qty-div">
                    <button type="button" id={"dec_"+index} className="btn" onClick={decrementQty} 
                     style={{width:"38px",margin:"10px",color:"white",backgroundColor:'#4a1821'}}>
                         -</button>
                    <input type="number" id={"qty_"+index}  onChange={event =>Setqty(event.target.value)} 
                     style={{width:"50px",textAlign:'center'}}/>
                    <button type="button" id={"inc_"+index} className="btn "  onClick={incrementQty}
                      style={{margin:"10px",color:"white",backgroundColor:'#4a1821'}}> +</button>
                       </div>
                     <button type="button" className="btn " id={"addtocart_"+index} 
                      onClick={(event)=>addtocart(item.id,event)} style={{color:"white",backgroundColor:'#4a1821'}}>
                           Add to cart</button>
                </div>
            </div>
        </div>
      
       
       
       
       
    
        </>
      );
  })
   
  }
  </div>
</div>

        </>

    );
}
export default ProductListItem