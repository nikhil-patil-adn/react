
import Menu from './components/header/Menu'
import {BrowserRouter as Router, Switch,Route,} from 'react-router-dom';
import About from './components/about';
import ProductList from './pages/productlist';
import ProductDetail from './pages/productdetail';
import Login from './pages/login';
import CartPage from './pages/cartpage';
import Home from './pages/home';
import Productreview from './pages/review';




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
    <Route  path="/" >
      <Home/>
      </Route>
          
     
            
     </Switch>
     </Router>
    
     
    </div>
  );
}

export default App;
