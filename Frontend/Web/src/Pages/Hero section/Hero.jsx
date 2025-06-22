import React from 'react'
import "./Hero.css";
import { IoLogoGooglePlaystore } from "react-icons/io5";

export default function Hero() {
  return (
    <div>
       <section id="home" className="hero">
        <div className="hero-image">
          <img src="/images/123.jpg" alt="Recycling Truck" />
        </div>
        <div className="hero-content">
          <h1>Eco LIFT</h1>
          <p>Be Green, Be Smart</p>
          <button className="read-more" aria-label="Learn more about Eco Lift">Read More</button>
        </div>
      </section>

      <section id="download" className="playstore-section">
        <div className="playstore-content">
          <h2>Download Our App</h2>
          <p>Get the Eco LIFT app and make your green journey smarter.</p>
          <a href="https://play.google.com" target="_blank" rel="noopener noreferrer" className="playstore-button">
          
          </a>
        </div>
      

      <div class="app-buttons">
  <a href="https://www.apple.com/app-store/" target="_blank" class="app-store-button">
    <div class="button-content">
      <span class="text-top">Download on the</span>
      <span class="text-bottom"><img width="48" height="48" src="https://img.icons8.com/color/48/mac-os--v1.png" alt="mac-os--v1"/>App Store</span>
    </div>
  </a>
  <a href="https://play.google.com/" target="_blank" class="google-play-button">
    <div class="button-content">
      <span class="text-top">Get it on</span>
      
      <span class="text-bottom"><img width="48" height="48" src="https://img.icons8.com/color/48/google-play.png" alt="google-play"/>Google Play</span>
    </div>
  </a>
</div>
 </section>
    </div>   
  )
};
