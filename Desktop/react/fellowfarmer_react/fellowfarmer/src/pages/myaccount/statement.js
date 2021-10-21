import Sidebar from '../../components/sidebar';
import React,{useEffect,useState} from 'react'
import apihost, {token} from '../../constants'
import Pagination from './../../components/Pagination';

const Statement = () => {
    const [paymentlog, setpaymentlog] = useState([])
    const [customerid, Setcustmerid] = useState(localStorage.getItem('customerid'))
    const basicAuth = 'Token ' + token;
    const requestOptions = {
        method: 'GET',
        withCrdential:true,
        credential:'include',
        headers: { 'Content-Type': 'application/json' ,'Authorization': basicAuth},
    };

    const datefunc = (date_arg) => {
        const date = new Date(date_arg);
        const months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
        const returndate = months[date.getMonth()] + ' ' + date.getDate() + ', ' + date.getFullYear()
        return returndate
    }
    useEffect(()=>{
        fetch(apihost + '/api/paymentlogs/fetchlogsbycustomer/'+customerid, requestOptions)
        .then(response => response.json())
        .then((data) => {
            if(data.length > 0){
                console.log(data)
                setpaymentlog(data)
            }
        });

    },[])
     // Pagination
     const numberOfPostPerPage = 10;
     const [currentPage, setCurrentPage] = useState(1);
     const [postsPerPage] = useState(numberOfPostPerPage);
     const indexOfLastPost = currentPage * postsPerPage;
     const indexOfFirstPost = indexOfLastPost - postsPerPage;
     const currentPosts = paymentlog.slice(indexOfFirstPost, indexOfLastPost);
 
     const PageNumbers = [];
     for(let i=1; i <= Math.ceil((paymentlog.length) / postsPerPage); i++){
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
    ///api/paymentlogs/fetchlogsbycustomer/" + id.toString();
    return (<>
        <div>
            <div class="row">
                <div class="col-lg-3 sidebar-container">
                    <Sidebar />
                </div>
                <div class='col-lg-9'>

                    <div className='container table-container'>
                        <h5>Payment Statement</h5>

                        
                        
                        <div className='table-responsive-sm'>
                            <table className="table table-hover">
                                <thead>
                                <tr>
                                <th scope="col">Order Type</th>
                                    <th scope="col">Transaction Id</th>
                                    <th scope="col">Payment Date</th>
                                    <th scope="col">Price</th>
                                </tr>
                                </thead>
                                {
                                    currentPosts.map((paymentlog,index) => {
                                        return(
                                            <>
                                            <tbody>
                                            <tr scope="row" key={index}>
                                            <td>{paymentlog.order_type}</td>
                                                <td>{paymentlog.transaction_id}</td>
                                                <td>{datefunc(paymentlog.paymentdate)}</td>
                                                <td>{paymentlog.price}</td>
                                                
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
    </>)
}
export default Statement;