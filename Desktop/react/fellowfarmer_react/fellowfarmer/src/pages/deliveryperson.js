import {useState, useEffect} from 'react';
import apihost, {token} from './../constants';
import {useHistory} from "react-router-dom";
import './deliveryperson.css';



const DeliveryPerson = () => {
    const history = useHistory()
    const basicAuth = 'Token ' + token;

    const [formData, setFormData] = useState({mobile : '', password : ''});

    const handleChange = (event) => {
        const name = event.target.name
        const value = event.target.value
        setFormData({...formData, [name] : value})

    }

    const handleSubmit = (event) => {
        if (formData.mobile == ""){
            alert('Enter Mobile Number');
            event.preventDefault();
        }
        else if(formData.password == ""){
            alert('Enter Password');
            event.preventDefault();
        }else{
            event.preventDefault();

            const credentials={
                password: formData.password,
                mobile: formData.mobile,
            }

            const requestOptions = {
                method: 'POST',
                withCrdential:true,
                credential:'include',
                headers: { 'Content-Type': 'application/json' ,'Authorization': basicAuth},
                body: JSON.stringify(credentials)
            }

            fetch(apihost + "/api/staffpersons/checklogin/", requestOptions)
            .then(result => result.json())
            .then((data)=>{
                if(data.length > 0){
                    console.log(data);

                    localStorage.setItem("deliverypersonid", data[0]['id'])
                    

                    history.push({
                        pathname:"/mydelivery",
                    })
                }
            });
        }

    }
    return (
        <>
        <div>
            <div class="row">
                <div class='col-lg-12'>
                    <div className='container table-container'>
                        <div class='col-lg-5' style={{marginLeft: 'auto', marginRight: 'auto'}}>
                            <h5 > Login </h5>
                        </div>
                        <div class='col-lg-5 deliverypersonform'>
                            <form style={{border:'0px'}} onSubmit = {handleSubmit}>
                                <div class="form-group formfield">
                                    <label for="mobileid" class="col-sm-3" style={{marginBottom:'8px'}}>Mobile</label>
                                    <input type="tel" name="mobile" value={formData.mobile} class="form-control" id="mobileid" onChange={handleChange} placeholder="Mobile" autocomplete="off"/>
                                </div>
                                <div class="form-group formfield">
                                    <label for="passwordid" class="col-sm-3">Password</label>
                                    <input type="password" name="password" value={formData.password} class="form-control" id="passwordid" onChange={handleChange} placeholder="Password" style={{padding: '6px 12px 6px 12px'}}/>
                                </div>
                                <div class="col-sm-12">
                                    <input type="submit" value="Login" class="btn btn-primary submit-btn"/>
                                </div>
                            </form>   
                        </div>
                        <div class='col-lg-5 forgotpass'>
                            <span>Forgot <a href='' style={{color:'blue'}}>password?</a></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </>
    );
}

export default DeliveryPerson;