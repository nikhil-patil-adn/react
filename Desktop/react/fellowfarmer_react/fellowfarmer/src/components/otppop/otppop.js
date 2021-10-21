import { Modal} from 'react-bootstrap';
import apihost,{token} from '../../constants'
import './otppop.css';
import React, {useState} from 'react';
import { ReactSearchAutocomplete } from 'react-search-autocomplete';

function Otppop(props) {
    const number=/^[0-9]+$/; 
    const basicAuth = 'Token ' + token;
    let [otp1,Setotp1]=useState()
    let [otp2,Setotp2]=useState()
    let [otp3,Setotp3]=useState()
    let [otp4,Setotp4]=useState()
const checkotp = () =>{
  const allotp=otp1+otp2+otp3+otp4
  console.log(allotp)
  if(allotp === '1234'){
    alert("match")
    localStorage.setItem("customerdata",'')
    localStorage.setItem("customerdata",props.mobile)
    props.getpopresponse('1')
  }else{
    alert("not match")
    props.getpopresponse('0')
  }
}



    return (
      <Modal
        {...props}
        size="md"
        aria-labelledby="contained-modal-title-vcenter"
        centered
      >
        
        <Modal.Body>
        <div class="d-flex justify-content-center align-items-center container">
    <div class="card py-5 px-3">
        <h5 class="m-0">Mobile phone verification</h5><span class="mobile-text">Enter the code we just send on your mobile phone 
        <b class="text-danger">{props.mobile}</b></span>
        <div class="d-flex flex-row mt-5">
          <input type="text" class="form-control" autofocus="true" onChange={(e)=>Setotp1(e.target.value)}/>
          <input type="text" class="form-control" onChange={(e)=>Setotp2(e.target.value)} />
          <input type="text" class="form-control" onChange={(e)=>Setotp3(e.target.value)} />
          <input type="text" class="form-control" onChange={(e)=>Setotp4(e.target.value)} />
          </div>
          <div className="row pt-3 justify-content-md-center">
        <div className="col">
       <button type="button" className="form-control" onClick={checkotp} style={{backgroundColor:'#4a1821',color:'white'}}>Check</button>
        </div>
    </div>
        <div class="text-center mt-5"><span class="d-block mobile-text">Don't receive the code?</span><span class="font-weight-bold text-danger cursor">Resend</span></div>
    </div>
</div>
        </Modal.Body>
       
      </Modal>
    );
  }

  export default Otppop;
  
