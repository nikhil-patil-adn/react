import React, { useEffect ,useState} from 'react'
import apihost,{token} from './../../constants'
import { useHistory } from "react-router-dom";
import ImageCarousel from "./../imagecarousel/ImageCaurosel";

const ProductBanner = () => {
    const history=useHistory();
    const [banner,setbanner]=useState([]);
    useEffect(()=>{
        fetch(apihost+"/api/products/fetch_products/").then(result => result.json()).then((data)=>{
            setbanner(data);
    });
    },[]);

    const redirecttodetail = (e) =>{
        const selectedqty=0;
        const id=e.target.id;
        history.push({
            pathname:"/detail",
            state:{productid:id,productqty:selectedqty}
        })

    }

   


    
    
    return (
        <>
        <ImageCarousel images={banner}  redirect={redirecttodetail} />

        </>
    );
}

export default ProductBanner;