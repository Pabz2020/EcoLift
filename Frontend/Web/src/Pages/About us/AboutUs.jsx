import React from 'react';
import './AboutUs.css'; // New stylesheet

const teamMembers = [
  {
    name: "Mr. Wasana Delpage",
    role: "Product Owner",
    bio: "Leading product strategy and development with a focus on innovative waste management solutions.",
    image: "/images/wasana.jpg"
  },
  {
    name: "Mr. Ishan Piyadigama",
    role: "Product Owner",
    bio: "Driving product vision and ensuring customer-centric development of our waste management platform.",
    image: "/images/Ishan Piyadigama.jpg"
  },
  {
    name: "Mr. Pabasara Jayawardhana",
    role: "Manager - EcoLift",
    bio: "Overseeing overall operations and strategic direction of EcoLift's waste management initiatives.",
    image: "/images/pabasara.jpeg"
  },
  {
    name: "Ms. Sasini Perera",
    role: "Manager - Product & Services",
    bio: "Managing product development and service delivery to ensure exceptional customer experience.",
    image: "/images/sasini.jpeg"
  },
  {
    name: "Mr. Ashan Munasinghe",
    role: "Technical Lead",
    bio: "Leading technical development and innovation in waste management technologies and systems.",
    image: "/images/ashan.jpeg"
  },
  {
    name: "Mr. Ishan Sachithra",
    role: "Human Resource Manager",
    bio: "Managing human resources and fostering a positive work environment for our dedicated team.",
    image: "/images/ishan.jpeg"
  }
];

export default function AboutUs() {
  return (
    <div className="about-us-page">
      <header className="about-us-header" data-aos="fade-in">
        <div className="header-content">
          <h1 className="about-us-title">About Eco LIFT</h1>
          <p className="about-us-subtitle">
            Your trusted partner in comprehensive waste management and environmental sustainability.
          </p>
        </div>
      </header>


      <section className="company-info-section">
        <div className="info-card" data-aos="fade-right">
          <h2>Our Mission</h2>
          <p>
            To provide convenient, reliable, and eco-friendly waste management services that empower communities to contribute to a cleaner, greener planet. We are committed to reducing landfill waste and promoting a circular economy through technology and education.
          </p>
        </div>
        <div className="info-card" data-aos="fade-left">
          <h2>Our Vision</h2>
          <p>
            To be a global leader in sustainable waste management, creating a world where waste is seen as a resource, and every individual is an active participant in building a zero-waste future for generations to come.
          </p>
        </div>
      </section>

      <section className="team-section" data-aos="fade-up">
        <h2 className="team-title">Meet Our Team</h2>
        <div className="team-grid">
          {teamMembers.map((member, index) => (
            <div key={index} className="team-member-card" data-aos="fade-up" data-aos-delay={index * 100}>
              <img src={member.image} alt={member.name} className="team-member-image" />
              <h3 className="team-member-name">{member.name}</h3>
              <p className="team-member-role">{member.role}</p>
              <p className="team-member-bio">{member.bio}</p>
            </div>
          ))}
        </div>
      </section>
    </div>
  );
}
