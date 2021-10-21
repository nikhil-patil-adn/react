
import Menu from './components/header/Menu'
import Footer from './components/footer/footer'
import {BrowserRouter as Router, Switch,Route,} from 'react-router-dom';
import About from './components/about';
import ProductList from './pages/productlist';
import ProductDetail from './pages/productdetail';
import Login from './pages/login';
import CartPage from './pages/cartpage';
import Home from './pages/home';
import Productreview from './pages/review';
import ConfirmOrder from './pages/confirmOrder';
import Order from './pages/Order';
import MyAccount from './pages/myaccount/myaccount'
import RegularOrder from './pages/myaccount/regularorder'
import Mycalender from './pages/myaccount/mycalender'
import Editprofile from './pages/myaccount/editprofile'
import Signup from './pages/myaccount/signup'
import MyFeedback from './pages/myaccount/myfeedback';
import AddFeedback from './pages/myaccount/addfeedback';
import Planholiday from './pages/myaccount/planholiday';
import Myholidaylist from './pages/myaccount/myplanholidaylist';
import Subscription from './pages/myaccount/Subscription';
import Statement from './pages/myaccount/statement';
import DeliveryPerson from './pages/deliveryperson';
import MyDelivery from './pages/mydelivery';




function App() {
  //nikhil
  
  return (
    <div className="container">
     
     <Router>
     <Menu/>
     
     
       <Switch>
       <Route exact path="/about" >
      <About/> </Route>
       <Route exact path="/products">
      <ProductList/>
 </Route>
 <Route exact path="/review"><Productreview/></Route>
       <Route exact path="/detail" >
      <ProductDetail/> </Route>
       <Route exact path="/login" >
      <Login/>
       </Route>
      <Route exact path="/cartpage" > <CartPage/> </Route>
      <Route exact path="/confirm" > <ConfirmOrder/> </Route>
      <Route exact path="/order" > <Order/> </Route>
      <Route exact path="/myaccount" > <MyAccount/> </Route>
      <Route exact path="/regularorder" > <RegularOrder/> </Route>
      <Route exact path="/mycalender" > <Mycalender/> </Route>
      <Route exact path="/editprofile" > <Editprofile/> </Route>
      <Route exact path="/signup" > <Signup/> </Route>
      <Route exact path='/myfeedback' component={MyFeedback}/>
       <Route exact path='/addfeedback' component={AddFeedback}/>
       <Route exact path="/planholiday" > <Planholiday/> </Route>
       <Route exact path="/myholidaylist" > <Myholidaylist/> </Route>
       <Route exact path="/subscription" > <Subscription/> </Route>
       <Route exact path="/statement" > <Statement/> </Route>
       <Route exact path='/deliveryperson' component={DeliveryPerson}/>
       <Route exact path='/mydelivery' component={MyDelivery}/>
       
       
      
    <Route  path="/" >
      <Home/>
      </Route>
          
     
            
     </Switch>
     </Router>
     <Footer/>
     
    </div>
  );
}

export default App;
