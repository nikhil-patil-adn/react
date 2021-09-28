import React, { useState,useEffect } from 'react';
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
  <navbootstrap.Container>
  <navbootstrap.Navbar.Brand ><Link to="/home" className="cst-linkstyle active">FellowFarmer</Link></navbootstrap.Navbar.Brand>
  <navbootstrap.Navbar.Toggle aria-controls="responsive-navbar-nav" />
  <navbootstrap.Navbar.Collapse id="responsive-navbar-nav">
    <navbootstrap.Nav className="me-auto">
      <navbootstrap.Nav.Link ><Link to="/about" className="cst-linkstyle">About</Link></navbootstrap.Nav.Link>
      <navbootstrap.Nav.Link href="#pricing">contact</navbootstrap.Nav.Link>
      <navbootstrap.NavDropdown title="Dropdown" id="collasible-nav-dropdown">
        <navbootstrap.NavDropdown.Item href="#action/3.1">Action</navbootstrap.NavDropdown.Item>
        <navbootstrap.NavDropdown.Item href="#action/3.2">Another action</navbootstrap.NavDropdown.Item>
        <navbootstrap.NavDropdown.Item href="#action/3.3">Something</navbootstrap.NavDropdown.Item>
        <navbootstrap.NavDropdown.Divider />
        <navbootstrap.NavDropdown.Item href="#action/3.4">Separated link</navbootstrap.NavDropdown.Item>
      </navbootstrap.NavDropdown>
    </navbootstrap.Nav>
    <navbootstrap.Nav>
      { islogin ? 
      <navbootstrap.Nav.Link onClick={logout}>Logout</navbootstrap.Nav.Link>
      :
      <>
      <navbootstrap.Nav.Link ><Link to="/login" className="cst-linkstyle">Login</Link></navbootstrap.Nav.Link>
      <navbootstrap.Nav.Link>
        Sign Up
      </navbootstrap.Nav.Link>
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