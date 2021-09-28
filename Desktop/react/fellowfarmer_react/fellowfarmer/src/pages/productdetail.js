import React ,{useEffect,useState} from 'react'
import apihost,{token} from './../constants'
import { useLocation,Link } from "react-router-dom";
import './productdetail.css';
const ProductDetail = () =>{
    const [productid,SetProductid]=useState(0)
    const [productqty,SetProductqty]=useState(0)
    const [productdetail,SetProductdetail]=useState([])
    const location = useLocation();

    useEffect(() => {
         SetProductid(location.state.productid)
         SetProductqty(location.state.productqty)
         const apiurl=apihost+"/api/products/details/"+location.state.productid;
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
           
         }).catch((error)=>{
            console.log(error)
         })
     }, [location]);


     const decrementQty = (event) =>{
        if(productqty > 0){
            SetProductqty(parseInt(productqty)-1)
          
        }else{
            SetProductqty(0)
         
        }
      }
    
      const incrementQty = (event) =>{
      
        SetProductqty(parseInt(productqty)+1)
        
    }


    return(
        <>
        <h1>detail</h1>
        <div className="row">
            <div className="col cst-img-box">
        <img src={productdetail.image_url} />
                </div>
                <div className="col cst-productdetail-box">
                    <div className="row">
                         <div className="col">
                        <span>Product Name:</span>
                        </div>
                        <div className="col">
                        <span>{productdetail.name}</span>
                        </div>
                     </div> 
                     <div className="row">
                         <div className="col">
                        <span>Product Price:</span>
                        </div>
                        <div className="col">
                        <span>{productdetail.price}</span>
                        </div>
                     </div>  
                     <div className="row cst-desciption-box">
                     <div className="col">
                     {productdetail.desciption}
                        </div>
                     </div>   

                     <div className="row justify-content-md-center">
                         <div className="col col-md-auto">
                        
                    <button type="button" className="btn" onClick={decrementQty}  style={{width:"40px",margin:"10px",backgroundColor:'#ed1c22'}}><i className="fa fa-cart-plus mr-2"></i> -</button>
                    <input type="number" value={productqty}  onChange={event =>SetProductqty(event.target.value)}  style={{width:"50px",textAlign:'center'}} />
                    <button type="button"  className="btn "  onClick={incrementQty}  style={{margin:"10px",backgroundColor:'#ed1c22'}}><i className="fa fa-cart-plus mr-2"></i> +</button>
                      
                         </div>    
                    </div>

                    <div className="row ">
                        <div className="col-md-6 justify-content-md-center" style={{paddingLeft:"72px"}}>
                        <button type="button"  className="btn "    style={{width:"61%",backgroundColor:'#ed1c22'}}> 
                        <Link  className="cst-linkstyle" to={{pathname:"/cartpage",state:{page:'buynow',productid:productid,qty:productqty}}}> Buy Now</Link></button>
                        </div>
                        <div className="col-md-6" style={{paddingLeft:"90px"}}>
                        <button type="button"  className="btn "   style={{backgroundColor:'#ed1c22'}}>
                             <Link  to={{pathname:"/cartpage",state:{page:'subscription',productid:productid,qty:productqty}}} className="cst-linkstyle" >Subscription </Link></button>
                        </div>
                     </div>   
                </div>
         </div>   
        </>
    );
}

export default ProductDetail;