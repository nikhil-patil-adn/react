import {NavLink} from 'react-router-dom'
import './Sidebar.css';


const Sidebar = () => {
    return  (
        <>
        <div className='Sidebar'>
            <div className='container side-container'>
            <p className='Sidebar-Head'>Welcome</p>
            {/* <p><NavLink exact to = '' activeClassName='active-class'>Delivery Person</NavLink></p> */}
            {/* <p><NavLink exact to = '' activeClassName='active-class'>Home</NavLink></p> */}
            {/* <p><NavLink exact to = '' activeClassName='active-class'>Logout</NavLink></p> */}
            <p><NavLink exact to = '/editprofile' activeClassName='active-class'>Edit Profile</NavLink></p>
            <p><NavLink exact to = '/addfeedback' activeClassName='active-class'>Add Feedback</NavLink></p>
            <p><NavLink exact to = '/myfeedback' activeClassName='active-class'>My Feedback</NavLink></p>
            <p><NavLink exact to = '/mycalender' activeClassName='active-class'>My Calender</NavLink></p>
            <p><NavLink exact to = '/planholiday' activeClassName='active-class'>Plan Holiday</NavLink></p>
            <p><NavLink exact to = '/subscription' activeClassName='active-class'>My Subscription</NavLink></p>
            <p><NavLink exact to = '/regularorder' activeClassName='active-class'>My Regular Order</NavLink></p>
            <p><NavLink exact to = '/statement' activeClassName='active-class'>Statement</NavLink></p>
            </div>
        </div>
        </>
    );

}

export default Sidebar;