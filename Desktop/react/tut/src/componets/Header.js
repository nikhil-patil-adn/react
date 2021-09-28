import Navbar from './Navbar'

const Header= (props) => {
    console.log(props)
    return (
        <>
        <Navbar page={props.pagenamekey}/>
        <h1>this is {props.pagenamekey} page</h1>
        </>
    )
}

export default Header;