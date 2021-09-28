import Carousel from 'react-bootstrap/Carousel';
import './carousel.css';

const TextCarousel = ( props) =>{
    return (
        
        <Carousel variant="dark" >
    {props.textdata.map((item,index)=>{
        return (
            <Carousel.Item >
                <div className="cst-textbox">
       <div className="col-md-12">{item.feedback_date}</div>
       <div className="col-md-12">{item.details}</div>
       </div>
     
    {/* <Carousel.Caption>
      <h5>First slide label</h5>
      <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
    </Carousel.Caption> */}
  </Carousel.Item> 
        );
    })}
    </Carousel>
   
        );
   
}

export default TextCarousel;