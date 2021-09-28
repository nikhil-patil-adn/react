import { useLocation,useHistory} from "react-router-dom";
import React ,{useState} from 'react'
const Productreview = () => {
    const location =useLocation()
    console.log(location)
    const [productdetail,SetProductdetail]=useState(location.state.productdetail)
    const [productqty,SetProductqty]=useState(location.state.productqty)
    
    
    console.log(location)

    return (
        <>
        <h1>Review</h1>
        <div class="container">
  <div class="row">
    <div class="col">
    <div className="col-md-6 mt-3">
            <h3 >Product Name:</h3> <span>{productdetail.name}</span>
        </div>
        <div className="col-md-6 mt-3">
            <h3>Product Price:</h3> <span>{productdetail.price}</span>
        </div>
        <div className="col-md-6 mt-3">
            <h3>Product Quantity:</h3> <span>{productqty}</span>
        </div>
    </div>
    <div class="col">
      <div className="row">
    <div className="col-md-6">
            <input type="text" id="coupon" name="coupon" placeholder="Add coupon"/>
        </div>
        <div className="col-md-6 mt-3">
            <button className="btn btn-success"> Apply coupon</button>
        </div>
        </div>
        <div className="col-md-6">
        <h3>Pay : {productdetail.price}</h3>
        </div>
    </div>
   
  </div>
</div>

    <div className="row pt-5 justify-content-md-center">
        <div className="col-md-3">
       <button type="button" className="form-control" onClick="" style={{backgroundColor:'#c96040'}}>Submit</button>
        </div>
    </div>
  
            </>
    );
}

export default Productreview;