import Sidebar from './../../components/sidebar';
import './SidebarSec.css';


const MyAccount = () => {
    return (
        <>
        <div>
            <div class="row">
                <div class="col-3 sidebar-container">
                    <Sidebar/>
                </div>
                <div class='col-9'>
                    <p>My Account Content</p>
                </div>
            </div>
        </div>
        </>
    );
}

export default MyAccount;