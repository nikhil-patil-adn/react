import React from 'react';
import './home.css';
import Banner from './../components/home/banner';
import ProductBanner from './../components/home/productbanner';
import Feedback from './../components/home/feedback';
import Footer from './../components/footer/footer'

const Home = () =>{
    return (
        <>
       
        <div className="cst-box cst-topspace" >
        <Banner/>
        </div>
       
       <div className="cst-box cst-topspace"> <ProductBanner/></div>
       <div className="cst-txtbox cst-topspace"> <Feedback/></div>
       <Footer/>
        </>
    );
}

export default Home;