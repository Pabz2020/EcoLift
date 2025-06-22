import React, { useState } from 'react';
import { useNavigate } from 'react-router';
import "./Navbar.css";

export default function SubNavBar() {
    const [isOpen, setIsOpen] = useState(false);
    const [active, setActive] = useState('/');
    const navigate = useNavigate();

    const toggleMenu = () => setIsOpen(!isOpen);

    const toHero = () => {
        setActive('/');
        navigate('/');
    };
    const toOurService = () => {
        setActive('/OurService');
        navigate('/OurService');
    };
    const toAboutUs = () => {
        setActive('/AboutUs');
        navigate('/AboutUs');
    };
    const toContact = () => {
        setActive('/Contact');
        navigate('/Contact');
    };
    const toLogin = () => {
        setActive('/Login');
        navigate('/Login');
    };

    return (
        <div>
            <nav className="navbar">
                <div className="logo" onClick={toHero}>ECO LIFT</div>
                <ul className={`nav-links ${isOpen ? 'open' : ''}`}>
                    <li><button className={active === '/' ? 'active' : ''} onClick={toHero}>Home</button></li>
                    <li><button className={active === '/OurService' ? 'active' : ''} onClick={toOurService}>Our Services</button></li>
                    <li><button className={active === '/AboutUs' ? 'active' : ''} onClick={toAboutUs}>About Us</button></li>
                    <li><button className={active === '/Contact' ? 'active' : ''} onClick={toContact}>Contact Us</button></li>
                    <li><button className={active === '/Login' ? 'active' : ''} onClick={toLogin}>Login</button></li>
                </ul>
                <div className="menu-icon" onClick={toggleMenu}>
                    <span className="bar"></span>
                    <span className="bar"></span>
                    <span className="bar"></span>
                </div>
            </nav>
        </div>
    );
}



