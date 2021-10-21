import loader from './../assests/images/loader.gif'

const Loader = () =>{

    return (
        <>
       
        <div  className="d-flex justify-content-center " style={{marginTop:"200px"}} >
        <img src={loader}  width="25px" height="25px"/>
        </div>
        </>
    );
}

export default Loader;