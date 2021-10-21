import React, { useEffect, useState, UseState } from 'react';
import apihost, { token, customerdata } from './../../constants'
import Sidebar from './../../components/sidebar';
import CollapsNavBar from './../../components/CollapsNavBar';
import { confirmAlert } from 'react-confirm-alert';
import { ReactSearchAutocomplete } from 'react-search-autocomplete'
import './SidebarSec.css';

const Editprofile = () => {
    const letter = /^[a-zA-Z ' ' ]+$/;
    const number = /^[0-9]+$/;
    function validateEmail(email) {
        const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        return re.test(String(email).toLowerCase());
    }
    const [customermob, Setcustmermob] = useState(localStorage.getItem('customerdata'))
    const [customerdata, Setcustomerdata] = useState([])
    const [customerid, Setcustomerid] = useState()
    const [customername, Setcustomername] = useState()
    const [customermobile, Setcustomermobile] = useState()
    const [customeremail, Setcustomeremail] = useState('')
    const [customerflat, Setcustomerflat] = useState('')
    const [validation, Setvalidation] = useState([{
        custmsg: '',
        custmob: '',
        custemail: '',
        custpincode: '',
        custflat: '',
        custcity: '',
        custsoc: ''
    }]);
    const [allcity, Setallcity] = useState([])
    const [allsoc, Setallsociety] = useState([])
    const [searchsoc, setSerachSoc] = useState('');
    const [searchcity, setSerachCity] = useState('');
    const [customercity, Setcustomercity] = useState('')
    const [customersoc, Setcustomersociety] = useState('')
    const [customeruser, Setcustomeruser] = useState('')
    const [customerpass, Setcustomerpass] = useState('')
    const [customerpincode, Setcustomerpincode] = useState()
    const handleOnSearchSoc = (string, results) => {
        console.log("aaaa", string, results)
        setSerachSoc(string)

    }
    const handleOnFocus = () => {
        console.log('Focused')
    }

    const handleOnSelectsoc = (item) => {
        // the item selected
        console.log("society", item)
        Setcustomersociety(item.name)
    }

    const formatResult = (item) => {
        return item;
        // return (<p dangerouslySetInnerHTML={{__html: '<strong>'+item+'</strong>'}}></p>); //To format result as html
    }
    const handleOnHover = (result) => {
        // the item hovered
        console.log("onhover", result)
    }

    const handleOnSelectcity = (item) => {
        // the item selected
        console.log("city", item)
        Setcustomercity(item.name)
    }
    const handleOnSearchCity = (string, results) => {
        console.log("aaaa", string, results)
        setSerachCity(string)

    }
    const basicAuth = 'Token ' + token;

    const request = {
        method: 'GET',
        withcredential: true,
        credential: 'include',
        headers: {
            'authorization': basicAuth
        }
    }
    useEffect(() => {
        let apiurl = apihost + '/api/customers/checkregister/' + customermob;
        fetch(apiurl, request).then(result => result.json()).then((response) => {
            console.log(response);
            Setcustomerdata(response[0])
            Setcustomername(response[0]['name'])
            Setcustomermobile(response[0]['mobile'])
            Setcustomeremail(response[0]['email'])
            Setcustomerpincode(response[0]['pincode'])
            Setcustomerflat(response[0]['address'])
            Setcustomerid(response[0]['id'])
            Setcustomerpass(response[0]['password'])
            Setcustomeruser(response[0]['username'])

            apiurl = apihost + "/api/city/getcitybyid/" + response[0]['city'];
            fetch(apiurl, {
                method: 'GET',
                withcredential: true,
                credential: 'include',
                headers: {
                    'authorization': basicAuth
                }
            }).then(result => result.json()).then((data) => {
                console.log(data)
                Setcustomercity(data[0]['name'])
            }).catch((error) => {
                console.log(error)
            });

            apiurl = apihost + "/api/location/getsocietybyid/" + response[0]['society'];
            fetch(apiurl, {
                method: 'GET',
                withcredential: true,
                credential: 'include',
                headers: {
                    'authorization': basicAuth
                }
            }).then(result => result.json()).then((data) => {
                console.log(data)
                Setcustomersociety(data[0]['name'])
            }).catch((error) => {
                console.log(error)
            });


        }).catch((error) => {
            console.log(error);
        });

        apiurl = apihost + "/api/city/allcity/";
        fetch(apiurl, {
            method: 'GET',
            withcredential: true,
            credential: 'include',
            headers: {
                'authorization': basicAuth
            }
        }).then(result => result.json()).then((data) => {
            Setallcity(data)
        }).catch((error) => {
            console.log(error)
        });

        apiurl = apihost + "/api/location/allsociety/";
        fetch(apiurl, {
            method: 'GET',
            withcredential: true,
            credential: 'include',
            headers: {
                'authorization': basicAuth
            }
        }).then(result => result.json()).then((data) => {
            console.log(data)
            Setallsociety(data)
        }).catch((error) => {
            console.log(error)
        });
    }, [customermob]);
    const clearval = (name) => {
        let oldArr = [...validation]
        oldArr[0][name] = ''
        Setvalidation(oldArr)
    }
    const checkcustname = (e) => {
        Setcustomername(e.target.value);
        if (!e.target.value.match(letter)) {
            let oldarr = [...validation];
            oldarr[0]['custmsg'] = 'Please enter proper name'
            Setvalidation(oldarr)
        }
        else {
            clearval('custmsg')
        }
    }
    const checkcustuser = (e) => {
        Setcustomeruser(e.target.value);
        // if (!e.target.value.match(letter)) {
        //     let oldarr = [...validation];
        //     oldarr[0]['custmsg'] = 'Please enter proper name'
        //     Setvalidation(oldarr)
        // }
        // else {
        //     clearval('custmsg')
        // }
    }
    const checkcustpass = (e) => {
        Setcustomerpass(e.target.value);
        // if (!e.target.value.match(letter)) {
        //     let oldarr = [...validation];
        //     oldarr[0]['custmsg'] = 'Please enter proper name'
        //     Setvalidation(oldarr)
        // }
        // else {
        //     clearval('custmsg')
        // }
    }

    const checkpincode = (e) => {
        Setcustomerpincode(e.target.value);
        if (!e.target.value.match(number)) {
            let oldarr = [...validation];
            oldarr[0]['custpincode'] = 'Please enter proper pincode'
            Setvalidation(oldarr)
        }
        else {
            clearval('custpincode')
        }
    }

    const checkcustemail = (e) => {
        Setcustomeremail(e.target.value);
        if (!validateEmail(e.target.value)) {
            let oldarr = [...validation];
            oldarr[0]['custemail'] = 'Please enter proper email'
            Setvalidation(oldarr)
        }
        else {
            clearval('custemail')
        }
    }

    const checkcustmob = (e) => {
        Setcustomermobile(e.target.value);
        if (!e.target.value.match(number)) {
            let oldarr = [...validation];
            oldarr[0]['custmob'] = 'Please enter proper mobile'
            Setvalidation(oldarr)
        }
        else {
            clearval('custmob')
        }
        if (e.target.value.length === 10) {
            const apiurl = apihost + "/api/customers/checkmobile/" + e.target.value
            fetch(apiurl, {
                method: 'GET',
                withcredential: true,
                credential: 'include',
                headers: {
                    'authorization': basicAuth
                }
            }).then(result => result.json()).then((data) => {
                console.log(data)
                if (data.length === 1) {
                    confirmAlert({
                        closeOnClickOutside: true,
                        overlayClassName: '',
                        title: '',
                        message: 'Entered mobile number already register.Kindly change number or click yes to continue?',
                        buttons: [
                            {
                                label: 'Yes',
                                onClick: () => {

                                }
                            },
                            {
                                label: 'No',
                                onClick: () => {
                                    Setcustomermobile('');
                                }
                            }
                        ]
                    });

                }



            }).catch((error) => {
                console.log(error)
            });
        }
    }
    const submitcart = (e) => {
        e.preventDefault();
        if (customername === "" || customername === undefined) {
            let oldarr = [...validation];
            oldarr[0]['custmsg'] = 'Please enter name'
            Setvalidation(oldarr)
        }if(customermobile === "" || customermobile === undefined){
            let oldarr=[...validation];
            oldarr[0]['custmob']='Please enter mobile number'
             Setvalidation(oldarr)
        }if(customeremail === "" || customeremail === undefined){
            let oldarr=[...validation];
            oldarr[0]['custemail']='Please enter email'
             Setvalidation(oldarr)
        }if(customerpincode === "" || customerpincode === undefined){
            let oldarr=[...validation];
            oldarr[0]['custpincode']='Please enter pincode'
             Setvalidation(oldarr)
        }if(customerflat === "" || customerflat === undefined){
            let oldarr=[...validation];
            oldarr[0]['custflat']='Please enter flat/wing'
             Setvalidation(oldarr)
             
        }if(customercity === "" || customercity === undefined){
            let oldarr=[...validation];
            oldarr[0]['custcity']='Please select city'
             Setvalidation(oldarr)
             
        }if(customersoc === "" || customersoc === undefined){
            let oldarr=[...validation];
            oldarr[0]['custsoc']='Please select society'
             Setvalidation(oldarr)
             
        }else{
            const customerdetails={
                username: customeruser,
                password: customerpass,
                name:customername,
                mobile:customermobile,
                email:customeremail,
                pincode:customerpincode,
                city:customercity,
                society:customersoc,
                address:customerflat,
                update: '1',
                id: customerid,
            }
            
          console.log(customerdetails);
           const requestOptions = {
            method: 'POST',
            withCrdential:true,
            credential:'include',
            headers: { 'Content-Type': 'application/json' ,'Authorization': basicAuth},
            body: JSON.stringify(customerdetails)
        };

        fetch(apihost+"/api/customers/customerregisterwithuserpass/",requestOptions).then(result => result.json()).then((data)=>{
            console.log(data);
            
        });

        }
    }
    return (
        <>
            <div>
                <div class="row">
                    <div class="col-lg-3 sidebar-container">
                        <Sidebar />
                    </div>
                    <div class="collapsnavbar">
                        <CollapsNavBar />
                    </div>
                    <div class='col-lg-9'>
                        <h1>Edit Page</h1>
                        <form style={{ border: '' }}>
                        <div className="col-md-6">
                                <label for="Name"> Name   {validation[0].custuser ? <span className="text-danger" >{validation[0].custuser}</span> : ''}</label>
                                <input type="text" className="form-control" id="username" value={customeruser}
                                 onChange={checkcustuser} placeholder="Username" />
                            </div>
                            <div className="col-md-6">
                                <label for="mobile">Mobile {validation[0].custpass ? <span className="text-danger" >{validation[0].custpass}</span> : ''}</label>
                                <input type="text" className="form-control" id="password" value={customerpass} onChange={checkcustpass}
                                 placeholder="Password" />
                            </div>

                            <div className="col-md-6">
                                <label for="Name"> Name   {validation[0].custmsg ? <span className="text-danger" >{validation[0].custmsg}</span> : ''}</label>
                                <input type="text" className="form-control" id="Name" value={customername}
                                 onChange={checkcustname} placeholder="Name" />
                            </div>
                            <div className="col-md-6">
                                <label for="mobile">Mobile {validation[0].custmob ? <span className="text-danger" >{validation[0].custmob}</span> : ''}</label>
                                <input type="text" className="form-control" id="mobile" value={customermobile} onChange={checkcustmob} placeholder="Mobile" />
                            </div>

                            <div className="col-md-6">
                                <label for="email">Email {validation[0].custemail ? <span className="text-danger" >{validation[0].custemail}</span> : ''}</label>
                                <input type="text" className="form-control" id="email" value={customeremail} onChange={checkcustemail} placeholder="Email" />
                            </div>
                            <div className="col-md-6">
                                <label for="city">City {validation[0].custcity ? <span className="text-danger" >{validation[0].custcity}</span> : ''}</label>
                                <ReactSearchAutocomplete
                                    items={allcity}
                                    onSearch={handleOnSearchCity}
                                    onHover={handleOnHover}
                                    onSelect={handleOnSelectcity}
                                    onFocus={handleOnFocus}
                                    autoFocus
                                    placeholder={customercity}
                                    formatResult={formatResult}
                                    styling={{
                                        searchIconMargin: "10px 12px 0 11px",
                                        clearIconMargin: "10px 0 8px 0",
                                        borderRadius: "",
                                        boxShadow: "",
                                        height: "50px",
                                        marginTop: "100px",
                                    }}
                                />
                            </div>
                            <div className="col-md-6">
                                <label for="society" >Society {validation[0].custsoc ? <span className="text-danger" >{validation[0].custsoc}</span> : ''}</label>
                                <ReactSearchAutocomplete
                                    items={allsoc}
                                    onSearch={handleOnSearchSoc}
                                    onHover={handleOnHover}
                                    onSelect={handleOnSelectsoc}
                                    onFocus={handleOnFocus}
                                    placeholder={customersoc}
                                    // inputSearchString={handleinputSearchString}
                                    autoFocus
                                    formatResult={formatResult}
                                    styling={{
                                        searchIconMargin: "10px 12px 0 11px",
                                        clearIconMargin: "10px 0 8px 0",
                                        borderRadius: "",
                                        boxShadow: "",
                                        height: "50px",
                                        marginTop: "100px",
                                    }}
                                />
                            </div>

                            <div className="col-md-6">
                                <label for="pincode">Pincode {validation[0].custpincode ? <span className="text-danger" >{validation[0].custpincode}</span> : ''}</label>
                                <input type="text" className="form-control" id="pincode" onChange={checkpincode} value={customerpincode} placeholder="Pincode" />
                            </div>
                            <div className="col-md-6">
                                <label for="customerflat" >Flat/Wing {validation[0].custflat ? <span className="text-danger" >{validation[0].custflat}</span> : ''}</label>
                                <input type="text" name="customerflat" value={customerflat} onChange={(e) => Setcustomerflat(e.target.value)}
                                    placeholder="flat/wing" />
                            </div>
                            <div className="row pt-3 justify-content-md-center">
                                <div className="col-md-3">
                                    <button type="button" className="form-control" onClick={submitcart} style={{ backgroundColor: '#4a1821', color: 'white' }}>Submit</button>
                                </div>

                            </div>



                        </form>
                    </div>
                </div>
            </div>
        </>



    )
}

export default Editprofile;