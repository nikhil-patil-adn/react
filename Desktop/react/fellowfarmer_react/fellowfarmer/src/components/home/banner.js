import React, { useEffect ,useState} from 'react'
import apihost,{token} from './../../constants'
import { useHistory } from "react-router-dom";
import ImageCarousel from "./../imagecarousel/ImageCaurosel";

const Banner = () => {

const history=useHistory();
const productlist = () =>{
    let path = `products`; 
    history.push(path);
}

    const [banner,setbanner]=useState([]);
    useEffect(()=>{
        fetch(apihost+"/api/banners/fetch_banners/").then(result => result.json()).then((data)=>{
            setbanner(data);
    });
    },[]);


    
    
    return (
        <>
        <ImageCarousel images={banner} redirect={productlist}/>

        </>
    );
}

export default Banner;