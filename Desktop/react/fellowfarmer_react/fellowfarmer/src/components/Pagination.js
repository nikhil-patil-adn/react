import {useState} from 'react';
import './Pagination.css';

const Pagination = ({paginate, previousPage, nextPage, PageNumbers, currentPage}) => {

    return (
        <>
        <nav>
            <ul className='pagination'>
                <li className={`${currentPage == 1 ? 'page-item disabled pagination-button' : 'page-item pagination-button'}`}>
                    <a className={`${currentPage == 1 ? 'page-link pagination-button' : 'page-link pagination-button'}`} href="#"  onClick={() => previousPage(1)}>Previous</a>
                </li>
                {PageNumbers.map(number => (
                    <>
                    <li key={number} className='page-item pagination-button'>
                        <a href='#' onClick={() => paginate(number)} className='page-link pagination-button'>
                            {number}
                        </a>
                    </li>
                    </>
                ))}
                <li className={`${currentPage == PageNumbers.length ? 'page-item disabled pagination-button' : 'page-item pagination-button'}`}>
                    <a className={`${currentPage == PageNumbers.length ? 'page-link pagination-button' : 'page-link pagination-button'}`} href="#" onClick={() => nextPage(1)}>Next</a>
                </li>
            </ul>
        </nav>
        </>
    )
}

export default Pagination;