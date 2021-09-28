import React, { useEffect ,useState} from 'react'
import apihost,{token} from './../../constants'
import TextCarousel from "./../imagecarousel/textcarousel";

const Feedback = () => {
    const [banner,setbanner]=useState([]);
    const apiurl=apihost+"/api/feedbacks/fetchallfeedback/";
    const basicAuth = 'Token ' + token;
    useEffect(()=>{
        fetch(apiurl,{
            method:'GET',
            withCrdential:true,
            credential:'include',
            headers:{
                'Authorization': basicAuth
            }
        }).then(result => result.json()).then((data)=>{
           
            setbanner(data);
    }).catch((error)=>{
        console.log("error",error)
    });
    },[]);


    
    
    return (
        <>
        <TextCarousel textdata={banner} />

        </>
    );
}

export default Feedback;