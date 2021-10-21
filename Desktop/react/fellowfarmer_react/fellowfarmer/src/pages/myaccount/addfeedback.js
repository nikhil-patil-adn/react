import {useState, useEffect} from 'react';
import apihost, {token} from '../../constants';
import {useHistory} from "react-router-dom";

import Sidebar from './../../components/sidebar';
import './SidebarSec.css';
import './addfeedback.css';
import './table.css';


const AddFeedback = () => {
    const history = useHistory()
    const [feedback, setFeedback] = useState([])
    const [questions, setQuestions] = useState([])
    const [custData, setCustData] = useState([])
    const [customermob, Setcustmermob] = useState(localStorage.getItem('customerdata'))
    const basicAuth = 'Token ' + token;
    const requestOptions = {
        method: 'GET',
        withCrdential:true,
        credential:'include',
        headers: { 'Content-Type': 'application/json' ,'Authorization': basicAuth},
    };


    useEffect(() => {
        fetch(apihost + '/api/feedbacks/fetchquestions/', requestOptions)
        .then(response => response.json())
        .then((data) => {
            if(data.length > 0){
                setQuestions(data)
            }
        });

    }, []);

    useEffect(() => {
        fetch(apihost + '/api/customers/checkregister/'+customermob, requestOptions)
        .then(response => response.json())
        .then((data) => {
            if(data.length > 0){
                setCustData(data[0])
            }
        });

    }, []);
    

    const [formData, setFormData] = useState({question : '', email : '', mobile : '', comment : ''});

    const handleChange = (event) => {
        const name = event.target.name
        const value = event.target.value
        setFormData({...formData, [name] : value})

    }

    const handleSubmit = (event) => {
        if (formData.question == ""){
            alert('Select Feedback Type');
            event.preventDefault();
        }
        else if(formData.comment == ""){
            alert('Enter Comment');
            event.preventDefault();
        }else{
            formData.email = custData.email;
            formData.mobile = custData.mobile;
    
            alert('Feedback Added Successfully');
            event.preventDefault();

            const feedbackdetails={
                type: formData.question,
                email: formData.email,
                mobile: formData.mobile,
                comment: formData.comment,
            }

            const requestOptions = {
                method: 'POST',
                withCrdential:true,
                credential:'include',
                headers: { 'Content-Type': 'application/json' ,'Authorization': basicAuth},
                body: JSON.stringify(feedbackdetails)
            }

            fetch(apihost + "/api/feedbacks/insertfeedback/", requestOptions)
            .then(result => result.json())
            .then((data)=>{
                console.log(data);
                history.push({
                    pathname:"/myfeedback",
                })
            });
        }

    }

    return (
        <>
        <div>
            <div class="row">
                <div class="col-lg-3 sidebar-container">
                    <Sidebar/>
                </div>
                <div class='col-lg-9'>
                    <div className='container table-container'>
                        <h5> Add Feedback </h5>
                        <div class='col-lg-9 addfeedbackform'>
                            <form style={{border:'0px'}} onSubmit = {handleSubmit}>
                                <div class="form-group row formfield">
                                    <label for="questionselect" class="col-sm-3 col-form-label formfieldlabel">Feedback Type</label>
                                    <div class="col-sm-9">
                                        <select name="question" onChange={handleChange} class="form-control" id="questionselect">
                                        <option value=''>Select Type</option>
                                            {
                                                questions.map((question) => {
                                                    return (
                                                        <>
                                                        <option value={(question.question)}>{question.question}</option>
                                                        </>
                                                    )
                                                })
                                            };
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group row formfield">
                                    <label for="emailid" class="col-sm-3 col-form-label formfieldlabel">Email</label>
                                    <div class="col-sm-9">
                                    <input type="email" name="email" class="form-control" id="emailid" value={custData.email} placeholder="Email" readOnly></input>
                                    </div>
                                </div>
                                <div class="form-group row formfield">
                                    <label for="mobilenum" class="col-sm-3 col-form-label formfieldlabel">Mobile</label>
                                    <div class="col-sm-9">
                                    <input type="tel" name="mobile" class="form-control" id="mobilenum" value={custData.mobile} placeholder="Mobile" readOnly/>
                                    </div>
                                </div>
                                <div class="form-group row formfield">
                                    <label for="textarea" class="col-sm-3 col-form-label formfieldlabel">Comment</label>
                                    <div class="col-sm-9">
                                    <textarea class="form-control" name="comment" value={formData.comment} onChange={handleChange} id="textarea" rows="3"></textarea>
                                    </div>
                                </div>
                                <input type="submit" style={{ backgroundColor: '#4a1821', color: 'white' }} value="Submit" class="btn btn-primary submit-btn"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </>
    );
}

export default AddFeedback;