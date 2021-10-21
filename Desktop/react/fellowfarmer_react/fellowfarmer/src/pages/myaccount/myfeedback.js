import {useState, useEffect} from 'react';
import apihost, {token} from '../../constants'

import Sidebar from './../../components/sidebar';
import Pagination from './../../components/Pagination';
import './SidebarSec.css';
import './table.css';


const MyFeedback = () => {
    const [feedback, setFeedback] = useState([])
    const [customerid, Setcustmerid] = useState(localStorage.getItem('customerid'))
    const basicAuth = 'Token ' + token;
    const requestOptions = {
        method: 'GET',
        withCrdential:true,
        credential:'include',
        headers: { 'Content-Type': 'application/json' ,'Authorization': basicAuth},
    };

    useEffect(() => {
        fetch(apihost + '/api/feedbacks/fetchfeedbackbycustomer/'+customerid, requestOptions)
        .then(response => response.json())
        .then((data) => {
            if(data.length > 0){
                console.log(data)
                setFeedback(data)
            }
        });

    }, []);

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
    const currentPosts = feedback.slice(indexOfFirstPost, indexOfLastPost);

    const PageNumbers = [];
    for(let i=1; i <= Math.ceil((feedback.length) / postsPerPage); i++){
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

    return (
        <>
        <div>
            <div class="row">
                <div class="col-lg-3 sidebar-container">
                    <Sidebar/>
                </div>
                <div class='col-lg-9'>
                    <div className='container table-container'>
                        <h5> My Feedback </h5>
                        <div className='table-responsive-sm'>
                            <table className="table table-hover">
                                <thead>
                                <tr>
                                    <th scope="col">Date</th>
                                    <th scope="col">Type</th>
                                    <th scope="col">Comment</th>
                                    <th scope="col">Status</th>
                                </tr>
                                </thead>
                                {
                                    currentPosts.map((feedback) => {
                                        return(
                                            <>
                                            <tbody>
                                            <tr scope="row">
                                                <td>{datefunc(feedback.feedback_date)}</td>
                                                <td>{feedback.type}</td>
                                                <td>{feedback.details}</td>
                                                <td>{feedback.status}</td>
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

export default MyFeedback;