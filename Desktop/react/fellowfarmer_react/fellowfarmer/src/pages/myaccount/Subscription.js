import {useState, useEffect} from 'react';
import apihost, {token} from '../../constants'

import Sidebar from './../../components/sidebar';
import Pagination from './../../components/Pagination';
import {useHistory} from "react-router-dom";
import './SidebarSec.css';
import './table.css';


const Subscription = () => {
    const history = useHistory()
    const [subscription, setSubscription] = useState([])
    const [customerid, Setcustmerid] = useState(localStorage.getItem('customerid'))
    const basicAuth = 'Token ' + token;
    const requestOptions = {
        method: 'GET',
        withCrdential:true,
        credential:'include',
        headers: { 'Content-Type': 'application/json' ,'Authorization': basicAuth},
    };

    useEffect(() => {
        getsubdata();

    }, []);

    const getsubdata=()=>{
        fetch(apihost + '/api/subscriptions/fetchsubscriptionbycustomer/'+customerid, requestOptions)
        .then(response => response.json())
        .then((data) => {
            if(data.length > 0){
                setSubscription(data)
            }

        });

    }

    // Update Subscription status
    const[postId, setPostId] = useState([])
    const UpdateSubsription = (id, status) => {
        console.log('Update Subscription called')
        let sendstatus='';
        if(status == 'active'){
             sendstatus='stop'
        }else{
             sendstatus='resume'
        }
        const apireq = `/api/subscriptions/stopsubscription/${(id).toString()}/${sendstatus}`
        fetch(apihost + apireq, requestOptions)
        .then(response => response.json())
        .then((data) => {
            console.log(data)
            if(data.length > 0){
               alert("You "+sendstatus+ " your subscription")
               
                getsubdata();
                
                //setPostId(data)
        }});
    };

    const datefunc = (date_arg) => {
        const date = new Date(date_arg);
        const months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
        const returndate = months[date.getMonth()] + ' ' + date.getDate() + ', ' + date.getFullYear()
        return returndate
    }

    // Pagination
    const numberOfPostPerPage = 10;
    const [currentPage, setCurrentPage] = useState(1);
    const [postsPerPage] = useState(numberOfPostPerPage);
    const indexOfLastPost = currentPage * postsPerPage;
    const indexOfFirstPost = indexOfLastPost - postsPerPage;
    const currentPosts = subscription.slice(indexOfFirstPost, indexOfLastPost);

    const PageNumbers = [];
    for(let i=1; i <= Math.ceil((subscription.length) / postsPerPage); i++){
        PageNumbers.push(i)
    }

    // Change Page
    const paginate = (pageNumber) => setCurrentPage(pageNumber);
    const previousPage = (previousPage) => {if ((currentPage - previousPage) !== 0 ){
                                            setCurrentPage(currentPage - previousPage);
                                            }}
    const nextPage = (nextPage) => {if ((currentPage + nextPage) <= (PageNumbers.length)){
                                            setCurrentPage(currentPage + nextPage);
                                           }}

    const subButton = (status) => {
        if(status=='inactive'){
            return {
                backgroundColor: '#4a1821',
                borderRadius : '30px',
                border: 'none',
                boxShadow: '0 0 0 0rem',
        }}else{
            return {
                backgroundColor: '#4a1821',
                borderRadius : '30px',
                border: 'none',
                boxShadow: '0 0 0 0rem',
        }}
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
                        <h5> Subscriptions </h5>
                        <div className='table-responsive-sm'>
                            <table className="table table-hover">
                                <thead>
                                <tr>
                                <th scope="col">Subscription Id</th>
                                    <th scope="col">Product</th>
                                    <th scope="col">Start Date</th>
                                    <th scope="col">End Date</th>
                                    <th scope="col">Frequency Type</th>
                                    <th scope="col">Subscription Type</th>
                                    <th scope="col">Status</th>
                                    <th></th>
                                </tr>
                                </thead>
                                {
                                    currentPosts.map((subs) => {
                                        return(
                                            <>
                                            <tbody>
                                            <tr scope="row">
                                            <td>{subs.id}</td>
                                                <td>{subs.product.name}</td>
                                                <td>{datefunc(subs.subscription_date)}</td>
                                                <td>{datefunc(subs.subscription_end)}</td>
                                                <td>{subs.frequency_type}</td>
                                                <td style={{textAlign : 'center'}}>{subs.subscription_type}</td>
                                                <td style={{textAlign : 'center'}}>{subs.status}</td>
                                                <td><button href='' onClick={() => UpdateSubsription(subs.id, subs.status)} class="btn btn-primary btn-sm" style={subButton(subs.status)} role="button">{`${subs.status == 'active' ? 'Stop' : 'Resume'}`}</button></td>
                                            </tr>
                                            </tbody>
                                            </>
                                        )
                                    })
                                }
                            </table>
                        </div>
                        <p style={{float: 'right'}}> Page {currentPage} </p>
                        <Pagination paginate={paginate} previousPage={previousPage} nextPage={nextPage} PageNumbers={PageNumbers} currentPage={currentPage}/>
                    </div>
                </div>
            </div>
        </div>
        </>
    );
}

export default Subscription;