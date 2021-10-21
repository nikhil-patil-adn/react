import {useState, useEffect} from 'react';
import apihost, {token} from './../../constants'

import Sidebar from './../../components/sidebar';
import CollapsNavBar from './../../components/CollapsNavBar';
import Pagination from './../../components/Pagination';
import './SidebarSec.css';
import './RegOrdTable.css';

const RegularOrder = () => {
    const [regularlist, setregularlist] = useState([])
    const basicAuth = 'Token ' + token;
    const requestOptions = {
        method: 'GET',
        withCrdential:true,
        credential:'include',
        headers: { 'Content-Type': 'application/json' ,'Authorization': basicAuth},
    };

    useEffect(() => {
        fetch(apihost + '/api/orders/fetchbuynowbycustomer/14', requestOptions)
        .then(response => response.json())
        .then((data) => {
            if(data.length > 0){
                console.log(data)
                setregularlist(data)
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
    const [currentPage, setCurrentPage] = useState(1);
    const [postsPerPage] = useState(10);
    const indexOfLastPost = currentPage * postsPerPage;
    const indexOfFirstPost = indexOfLastPost - postsPerPage;
    const currentPosts = regularlist.slice(indexOfFirstPost, indexOfLastPost);

    const PageNumbers = [];
    for(let i=1; i <= Math.ceil((regularlist.length) / postsPerPage); i++){
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
                <div class="collapsnavbar">
                    <CollapsNavBar/>
                </div>
                <div class='col-lg-9'>
                    <div className='container table-container'>
                        <h6> Current Page {currentPage} </h6>
                        <div className='table-responsive-sm'>
                            <table className="table table-hover">
                                <thead>
                                <tr>
                                    <th scope="col">Product</th>
                                    <th scope="col">Order Date</th>
                                    <th scope="col">Delivery Date</th>
                                    <th scope="col">Order Status</th>
                                    <th scope="col">Payment Status</th>
                                    <th scope="col">Order Amount</th>
                                </tr>
                                </thead>
                                {
                                    currentPosts.map((regord) => {
                                        return(
                                            <>
                                            <tbody>
                                            <tr scope="row">
                                                <td>{regord.product}</td>
                                                <td>{datefunc(regord.order_date)}</td>
                                                <td>{datefunc(regord.schedule_delivery_date)}</td>
                                                <td>{regord.order_status}</td>
                                                <td style={{textAlign : 'center'}}>{regord.payment_status}</td>
                                                <td style={{textAlign : 'center'}}>{regord.order_amount}</td>
                                            </tr>
                                            </tbody>
                                            </>
                                        )
                                    })
                                }
                            </table>
                        </div>
                        <Pagination paginate={paginate} previousPage={previousPage} nextPage={nextPage} PageNumbers={PageNumbers} currentPage={currentPage}/>
                    </div>
                </div>
            </div>
        </div>
        </>
    );
}

export default RegularOrder;