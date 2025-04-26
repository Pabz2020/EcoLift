import React from 'react';
import { useNavigate } from 'react-router-dom';
import "./OurService.css";
import { servicesData } from './servicesData';

export default function OurService() {
  const navigate = useNavigate();

  // Take only the first 6 services
  const displayedServices = servicesData.slice(0, 6);

  const handleServiceClick = (path) => {
    navigate(path);
  };

  return (
    <div>
      <section id="services" className="services-section">
        <h2>Our Services</h2>
        <div className="services-grid">
          {displayedServices.map((service) => (
            <div key={service.id} className="service-card">
              <img src={service.image} alt={service.title} />
              <h3>{service.title}</h3>
              <button 
                onClick={() => handleServiceClick(service.path)}
                className="learn-more"
              >
                Know More →
              </button>
            </div>
          ))}
        </div>
        <button 
          onClick={() => navigate('/services/all')} 
          className="view-more"
        >
          More →
        </button>
      </section>
    </div>
  );
}
