import React, { useState, useEffect } from 'react';
import "./Hero.css";
import { IoLogoGooglePlaystore } from "react-icons/io5";
import Testimonials from '../../Components/Testimonials/Testimonials';

export default function Hero() {
  const [currentImageIndex, setCurrentImageIndex] = useState(0);

  // Array of 4 images for the carousel - Green theme
  const heroImages = [
    {
      src: "/images/carousel/leaves.jpeg",
      alt: "Close-up of fresh green leaves with sparkling water droplets, representing life and nature's purity."
    },
    {
      src: "/images/carousel/sprout.jpeg",
      alt: "Hands gently holding a small green sprout, symbolizing new growth and environmental stewardship."
    },
    {
      src: "/images/carousel/wind-turbines.jpeg",
      alt: "Wind turbines in a vast green field, showcasing renewable energy and a sustainable future."
    }
  ];

  // Auto-advance carousel every 4 seconds
  useEffect(() => {
    const interval = setInterval(() => {
      setCurrentImageIndex((prevIndex) => (prevIndex + 1) % heroImages.length);
    }, 4000);

    return () => clearInterval(interval);
  }, [heroImages.length]);

  // Manual navigation functions
  const goToNext = () => {
    setCurrentImageIndex((prevIndex) => (prevIndex + 1) % heroImages.length);
  };

  const goToPrevious = () => {
    setCurrentImageIndex((prevIndex) => 
      prevIndex === 0 ? heroImages.length - 1 : prevIndex - 1
    );
  };

  const goToImage = (index) => {
    setCurrentImageIndex(index);
  };

  const handleReadMoreClick = () => {
    const aboutSection = document.getElementById('about-ecolift');
    if (aboutSection) {
      aboutSection.scrollIntoView({ behavior: 'smooth' });
    }
  };

  return (
    <div className="hero-wrapper">
      <section id="home" className="hero">
        <div className="hero-image animate-fade-right">
          <div className="image-carousel">
            {heroImages.map((image, index) => (
              <img 
                key={index}
                src={image.src}
                alt={image.alt}
                className={`carousel-image ${index === currentImageIndex ? 'active' : ''}`}
              />
            ))}
            
            {/* Navigation Arrows */}
            <button 
              className="carousel-nav prev" 
              onClick={goToPrevious}
              aria-label="Previous image"
            >
              ‹
            </button>
            <button 
              className="carousel-nav next" 
              onClick={goToNext}
              aria-label="Next image"
            >
              ›
            </button>

            {/* Dots Indicator */}
            <div className="carousel-dots">
              {heroImages.map((_, index) => (
                <button
                  key={index}
                  className={`dot ${index === currentImageIndex ? 'active' : ''}`}
                  onClick={() => goToImage(index)}
                  aria-label={`Go to image ${index + 1}`}
                />
              ))}
            </div>
          </div>
        </div>
        <div className="hero-content animate-fade-left">
          <h1 className="gradient-text">Eco LIFT</h1>
          <p className="tagline">Be Green, Be Smart</p>
          <p>
            Eco LIFT is your partner in building a sustainable future. We provide innovative and convenient solutions for waste management, helping individuals and businesses reduce their environmental impact. Join us in making a difference, one pickup at a time.
          </p>
          <button 
            className="read-more pulse" 
            aria-label="Learn more about Eco Lift"
            onClick={handleReadMoreClick}
          >
            Read More
          </button>
        </div>
      </section>


      <Testimonials />

      <section id="download" className="playstore-section" data-aos="fade-up">
        <div className="playstore-content">
          <h2 className="gradient-text">Download Our App</h2>
          <p>Get the Eco LIFT app and make your green journey smarter and more convenient.</p>
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
