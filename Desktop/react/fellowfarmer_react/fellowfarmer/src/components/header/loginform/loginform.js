import React, { useState } from 'react';
import { useHistory } from "react-router-dom";
import apihost, { token } from './../../../constants'
import './loginform.css';

const LoginForm = () => {
  const history = useHistory()
  const [uname, Setuname] = useState()
  const [upass, Setupass] = useState()

  const checklogin = (e) => {
    e.preventDefault()
    console.log(uname)
    console.log(upass)
    const apiurl = apihost + "/api/customers/checklogin/";
    const basicAuth = 'Token ' + token;
    fetch(apiurl, {
      method: 'POST',
      withcredential: true,
      credential: 'include',
      headers: {
        'authorization': basicAuth
      },
      body: JSON.stringify({
        'password': upass,
        'mobile': uname,
      })
    }).then(result => result.json()).then((data) => {


      console.log(data[0]['mobile'])
      if (data[0]['mobile'] == uname) {
        localStorage.setItem("customerdata", '')
        localStorage.setItem("customerid", '')
        localStorage.setItem("customerdata", data[0]['mobile'])
        localStorage.setItem("customerid", data[0]['id'])
        let path = '/home'
        history.push(path)
      }
    }).catch((error) => {
      console.log(error)
    })

  }

  return (
    <>

      <div className="d-flex justify-content-center">
        <div className="row">
          <div className="col-lg">
            <form>
              <div className="imgcontainer">
                <span>Fellofarmer</span>
              </div>

              <div className="container">
                <label for="uname"><b>Mobile</b></label>
                <input type="text" onChange={(e) => Setuname(e.target.value)} placeholder="Enter Mobile" name="uname" required />

                <label for="psw"><b>Password</b></label>
                <input type="password" onChange={(e) => Setupass(e.target.value)} placeholder="Enter Password" name="psw" required />

                <button className="btn cst-loginbtn" style={{ backgroundColor: '#4a1821', color: 'white' }} type="submit" onClick={checklogin} >Login</button>

              </div>

              <div className="container" >
                <span className="psw">Forgot <a href="#">password?</a></span>
              </div>
            </form>

          </div>

        </div>
      </div>



    </>
  );
}

export default LoginForm;