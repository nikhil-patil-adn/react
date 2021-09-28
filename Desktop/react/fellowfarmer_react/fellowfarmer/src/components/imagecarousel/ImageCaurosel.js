import Carousel from 'react-bootstrap/Carousel';
import './carousel.css';
const ImageCarousel = ( props) =>{
    return (
        <div style={{height:"300px"}}>
        <Carousel variant="dark" >
    {props.images.map((item,index)=>{
      item.image_url = item.image_url ? item.image_url : item.banner
        return (
            <Carousel.Item>
    <img
      className="d-block w-100 cst-img-carousel"
      src={item.image_url}
      alt="First slide"
       
      key={item.index}
      id={item.id}

      onClick={props.redirect}
     
    />
    {/* <Carousel.Caption>
      <h5>First slide label</h5>
      <p>Nulla vitae elit libero, a pharetra augue mollis interdum.</p>
    </Carousel.Caption> */}
  </Carousel.Item> 
        );
    })}
    </Carousel>
   </div>
        );
   
}

export default ImageCarousel;