import Carousel from 'react-bootstrap/Carousel';
import './carousel.css';

const TextCarousel = ( props) =>{
    
    const datefunc = (date_arg) => {
        const date = new Date(date_arg);
        const months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
        const returndate = months[date.getMonth()] + ' ' + date.getDate() + ', ' + date.getFullYear()
        return returndate
    }
    return (
        
        <Carousel variant="dark" >
    {props.textdata.map((item,index)=>{
        console.log(item)
        return (
            <Carousel.Item >
                <div className="cst-textbox" key={index}>
       
       <div className="col-md-12">{item.details}</div>
       <div className="col-md-12 d-flex flex-row-reverse">-{item.customer.name}</div>
       <div className="col-md-12 d-flex flex-row-reverse">{datefunc(item.feedback_date)}</div>
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