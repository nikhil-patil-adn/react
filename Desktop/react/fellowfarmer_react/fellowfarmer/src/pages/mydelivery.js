import {useState, useEffect} from 'react';
import apihost, {token} from './../constants';

import Pagination from './../components/Pagination';



const MyDelivery = () => {
    const [myDelivery, setMyDelivery] = useState([])
    const [deliveryguyid] = useState(localStorage.getItem("deliverypersonid"))
    const basicAuth = 'Token ' + token;
    const requestOptions = {
        method: 'GET',
        withCrdential:true,
        credential:'include',
        headers: { 'Content-Type': 'application/json' ,'Authorization': basicAuth},
    };
    
    const getList = () => {
        const apidelivery = `/api/orders/deliveryguyorders/${(deliveryguyid).toString()}`
        fetch(apihost + apidelivery, requestOptions)
        .then(response => response.json())
        .then((data) => {
            if(data.length > 0){
                setMyDelivery(data)
            }
        });
    }

    useEffect(() => {
        getList()
    }, []);

    // Update Delivery Status
    const[postId, setPostId] = useState([])
    const UpdateDeliveryStatus = (id) => {
        const apireq = `/api/orders/updatestatus/${(id).toString()}/delivered`
        fetch(apihost + apireq, requestOptions)
        .then(response => response.json())
        .then((data) => {
            if(data.length > 0){
                setPostId(data)
                getList()
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
    const currentPosts = myDelivery.slice(indexOfFirstPost, indexOfLastPost);

    const PageNumbers = [];
    for(let i=1; i <= Math.ceil((myDelivery.length) / postsPerPage); i++){
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
    // Delivery Completed button
    const deliveredButton = (status) => {
        if (status == 'delivered'){
            return true
        }else{
            return false
        }
    }
    // Status 
    const  status = (status) => {
        if (status == 'delivery_scheduled'){
            return 'delivery scheduled'
        }else{
            return status
        }
    }

    //Search Field
    const [searchData, setSearchData] = useState('');

    const handleChange = (event) => {
        const search = event.target.value
        const filterlist = myDelivery.filter( filter => {
            return filter.customer.name.indexOf(search) > -1 | filter.delivery_address.indexOf(search) > -1
          })
        console.log(filterlist)
        if (filterlist.length >= 1){
            setMyDelivery(filterlist)
        }
        if (search.length == 0){
            getList()
        }
        setSearchData(search)
    }

    return (
        <>
        <div>
            <div class="row">
                <div class='col-lg-9'>
                    <div className='container table-container'>
                        <h5> My Delivery </h5>
                        <div className='table-responsive-md'>
                            <div className='col-md-7'>
                                <input name="search" value={searchData} class="form-control" onChange={handleChange} placeholder="Search.." style={{padding: '5px 10px 5px 10px'}} autocomplete="off"/>
                            </div>
                            <table className="table table-hover">
                                <thead>
                                <tr>
                                    <th scope="col">Customer</th>
                                    <th scope="col">Delivery Address</th>
                                    <th scope="col">Product</th>
                                    <th scope="col">Delivery Date</th>
                                    <th scope="col">Quantity</th>
                                    <th scope="col">Status</th>
                                    <th scope="col"></th>
                                </tr>
                                </thead>
                                {
                                    currentPosts.map((mydelivery) => {
                                        return(
                                            <>
                                            <tbody>
                                            <tr scope="row">
                                                <td>{mydelivery.customer.name}</td>
                                                <td>{mydelivery.delivery_address}</td>
                                                <td>{mydelivery.product}</td>
                                                <td>{datefunc(mydelivery.schedule_delivery_date)}</td>
                                                <td>{mydelivery.quantity}</td>
                                                <td>{status(mydelivery.order_status)}{}</td>
                                                <td><button href='' onClick={() => UpdateDeliveryStatus(mydelivery.id)} class="btn btn-primary btn-sm" role="button" disabled={deliveredButton(mydelivery.order_status)}>{`${mydelivery.order_status == 'delivered' ? 'Delivered' : 'Done'}`}</button></td>
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

export default MyDelivery;