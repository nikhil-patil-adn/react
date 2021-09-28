import Header from './componets/Header'
import Footer from './componets/Footer'



const App = () =>{

  const pagename="nikhil";
  return (
    <>
     <Header pagenamekey={pagename}  />
    <h1>Hello</h1>
    <Footer/>
    </>
  );
}






export default App;


