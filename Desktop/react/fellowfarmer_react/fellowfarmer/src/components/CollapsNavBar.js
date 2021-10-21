import {NavLink} from 'react-router-dom';
//import './CollapsNavBar.css';


const CollapsNavBar = () => {
    return  (
        <>
        <div className=''>
            <nav class="navbar bg-dark navbar-dark">
                <p class="navbar-brand" style={{margin:"0px 16px 0px 15px"}}>My Account</p>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="collapsibleNavbar">
                    <ul class="navbar-nav">
                        <p style={{marginTop:"20px"}}>
                            <NavLink exact to = '' activeClassName='active-class'>Delivery Person</NavLink>
                        </p>
                        <p>
                            <NavLink exact to = '' activeClassName='active-class'>Home</NavLink>
                        </p>
                        <p>
                            <NavLink exact to = '' activeClassName='active-class'>Logout</NavLink>
                        </p>
                        <p>
                            <NavLink exact to = '' activeClassName='active-class'>Edit Profile</NavLink>
                        </p>
                        <p>
                            <NavLink exact to = '' activeClassName='active-class'>Add Feedback</NavLink>
                        </p>
                        <p>
                            <NavLink exact to = '' activeClassName='active-class'>My Feedback</NavLink>
                        </p>
                        <p>
                            <NavLink exact to = '' activeClassName='active-class'>My Calender</NavLink>
                        </p>
                        <p>
                            <NavLink exact to = '' activeClassName='active-class'>My Plan</NavLink>
                        </p>    
                        <p>
                            <NavLink exact to = '' activeClassName='active-class'>My Subscription</NavLink>
                        </p>
                        <p>
                            <NavLink exact to = '/regularorder' activeClassName='active-class'>My Regular Order</NavLink>
                        </p>
                        <p style={{marginBottom:"20px"}}>
                            <NavLink exact to = '' activeClassName='active-class'>Statement</NavLink>
                        </p>
                    </ul>
                </div>  
            </nav>
        </div>
        </>
    );

}

export default CollapsNavBar;