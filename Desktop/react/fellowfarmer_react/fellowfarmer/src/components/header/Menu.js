import React, { useState,useEffect } from 'react';
import fellowfarmerlogo from './../../assests/images/fellowfarmerlogo.png';
import * as navbootstrap from "react-bootstrap";
import './menu.css';
import {Link,useHistory} from 'react-router-dom';


const Menu = (props) =>{
  const history=useHistory();
  const [islogin,setCustomerdata]=useState('')

  useEffect(() => {
        setInterval(() => {
            const userString = localStorage.getItem("customerdata");
            setCustomerdata(userString);
            }, [])
    }, [1000]);

  const logout = () => {
    localStorage.setItem("customerdata","")
    setCustomerdata('');
   
    let path='/home'
    history.push(path)
    

  }
    return (
<>

<navbootstrap.Navbar collapseOnSelect expand="lg" className="cst-navbar" >
  <Link to="/home" className="cst-linkstyle active">
  <img src={fellowfarmerlogo} width="100px" height="50px" /></Link>
  <navbootstrap.Container>

  <navbootstrap.Navbar.Toggle aria-controls="responsive-navbar-nav" />
  <navbootstrap.Navbar.Collapse id="responsive-navbar-nav">
    <navbootstrap.Nav className="me-auto">
    
      <navbootstrap.Nav.Link ><Link to="/about" className="cst-linkstyle">About</Link></navbootstrap.Nav.Link>
      <navbootstrap.Nav.Link href="#pricing">contact</navbootstrap.Nav.Link>
      {/* <navbootstrap.NavDropdown title="Dropdown" id="collasible-nav-dropdown">
        <navbootstrap.NavDropdown.Item href="#action/3.1">Action</navbootstrap.NavDropdown.Item>
        <navbootstrap.NavDropdown.Item href="#action/3.2">Another action</navbootstrap.NavDropdown.Item>
        <navbootstrap.NavDropdown.Item href="#action/3.3">Something</navbootstrap.NavDropdown.Item>
        <navbootstrap.NavDropdown.Divider />
        <navbootstrap.NavDropdown.Item href="#action/3.4">Separated link</navbootstrap.NavDropdown.Item>
      </navbootstrap.NavDropdown> */}
    </navbootstrap.Nav>
    <navbootstrap.Nav>
          { islogin ? 
          <>
          <navbootstrap.Nav.Link><Link to="/myaccount" className="cst-linkstyle myaccountbutton">My Account</Link></navbootstrap.Nav.Link>
          <navbootstrap.NavDropdown title="My Account" id="collasible-nav-dropdown" className="myaccountdropdown">
              <navbootstrap.NavDropdown.Item><Link exact to = '/myaccount' style={{color:'black'}}>My Account</Link></navbootstrap.NavDropdown.Item>
              <navbootstrap.NavDropdown.Item><Link exact to = '/deliveryperson' style={{color:'black'}}>Delivery Person</Link></navbootstrap.NavDropdown.Item>
              <navbootstrap.NavDropdown.Item><Link exact to = '' style={{color:'black'}}>Edit Profile</Link></navbootstrap.NavDropdown.Item>
              <navbootstrap.NavDropdown.Item><Link exact to = '/addfeedback' style={{color:'black'}}>Add Feedback</Link></navbootstrap.NavDropdown.Item>
              <navbootstrap.NavDropdown.Item><Link exact to = '/myfeedback' style={{color:'black'}}>My Feedback</Link></navbootstrap.NavDropdown.Item>
              <navbootstrap.NavDropdown.Item><Link exact to = '' style={{color:'black'}}>My Calender</Link></navbootstrap.NavDropdown.Item>
              <navbootstrap.NavDropdown.Item><Link exact to = '' style={{color:'black'}}>My Plan</Link></navbootstrap.NavDropdown.Item>
              <navbootstrap.NavDropdown.Item><Link exact to = '/subscription' style={{color:'black'}}>My Subscription</Link></navbootstrap.NavDropdown.Item>
              <navbootstrap.NavDropdown.Item><Link exact to = '/regularorder' style={{color:'black'}}>My Regular Order</Link></navbootstrap.NavDropdown.Item>
              <navbootstrap.NavDropdown.Item><Link exact to = '' style={{color:'black'}}>Statement</Link></navbootstrap.NavDropdown.Item>
          </navbootstrap.NavDropdown>
          <navbootstrap.Nav.Link onClick={logout}>Logout</navbootstrap.Nav.Link>
          </>
          :
          <>
          <navbootstrap.Nav.Link ><Link to="/login" className="cst-linkstyle">Login</Link></navbootstrap.Nav.Link>
          <navbootstrap.Nav.Link>
            Sign Up
          </navbootstrap.Nav.Link>
          <navbootstrap.Nav.Link ><Link to="/deliveryperson" className="cst-linkstyle">Delivery Person Login</Link></navbootstrap.Nav.Link>
          </>
          
        
          }
        

        
          
        </navbootstrap.Nav>
  </navbootstrap.Navbar.Collapse>
  </navbootstrap.Container>
</navbootstrap.Navbar>


</>

    );
}




export default Menu;