import React from 'react';
import "./Hero.css";
import { IoLogoGooglePlaystore } from "react-icons/io5";

export default function Hero() {
  return (
    <div className="hero-wrapper">
      <section id="home" className="hero">
        <div className="hero-image animate-fade-right">
          <img src="/images/123.jpg" alt="Recycling Truck" className="floating" />
        </div>
        <div className="hero-content animate-fade-left">
          <h1 className="gradient-text">Eco LIFT</h1>
          <p className="tagline">Be Green, Be Smart</p>
          <button className="read-more pulse" aria-label="Learn more about Eco Lift">
            Read More
          </button>
        </div>
      </section>

      <section id="download" className="playstore-section" data-aos="fade-up">
        <div className="playstore-content">
          <h2 className="gradient-text">Download Our App</h2>
          <p>Get the Eco LIFT app and make your green journey smarter.</p>
          <div className="app-buttons">
            <a href="https://www.apple.com/app-store/" target="_blank" rel="noopener noreferrer" className="app-store-button hover-effect">
              <div className="button-content">
                <span className="text-top">Download on the</span>
                <span className="text-bottom">
                  <img width="48" height="48" src="https://img.icons8.com/color/48/mac-os--v1.png" alt="app store" />
                  App Store
                </span>
              </div>
            </a>
            <a href="https://play.google.com/" target="_blank" rel="noopener noreferrer" className="google-play-button hover-effect">
              <div className="button-content">
                <span className="text-top">Get it on</span>
                <span className="text-bottom">
                  <img width="48" height="48" src="https://img.icons8.com/color/48/google-play.png" alt="google play" />
                  Google Play
                </span>
              </div>
            </a>
          </div>
        </div>
      </section>
    </div>
  );
}
