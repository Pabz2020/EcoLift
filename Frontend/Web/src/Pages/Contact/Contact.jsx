import React, { useState, useRef } from 'react';
import emailjs from '@emailjs/browser';
import './Contact.css';
import { FaPhone, FaEnvelope, FaMapMarkerAlt, FaClock, FaHeadset, FaGlobe } from 'react-icons/fa';

export default function Contact() {
  const form = useRef();
  const [formData, setFormData] = useState({
    user_name: '',
    user_email: '',
    user_phone: '',
    service_type: '',
    message: ''
  });
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [submitStatus, setSubmitStatus] = useState(null);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleSubmit = (e) => {
    e.preventDefault();
    setIsSubmitting(true);
    setSubmitStatus(null);

    // EmailJS configuration
    const serviceId = 'YOUR_EMAILJS_SERVICE_ID'; // Replace with your EmailJS service ID
    const templateId = 'YOUR_EMAILJS_TEMPLATE_ID'; // Replace with your EmailJS template ID
    const publicKey = 'YOUR_EMAILJS_PUBLIC_KEY'; // Replace with your EmailJS public key
    
    // Add recipient email to form data
    const formDataWithRecipient = {
      ...formData,
      to_email: 'ishankendawela@gmail.com'
    };

    emailjs.sendForm(serviceId, templateId, form.current, publicKey)
      .then((result) => {
        console.log('SUCCESS!', result.text);
        setSubmitStatus('success');
        setFormData({
          user_name: '',
          user_email: '',
          user_phone: '',
          service_type: '',
          message: ''
        });
      }, (error) => {
        console.log('FAILED...', error.text);
        setSubmitStatus('error');
      })
      .finally(() => {
        setIsSubmitting(false);
      });
  };

  return (
    <div className="contact-page">
      <header className="contact-header" data-aos="fade-in">
        <div className="header-content">
          <h1 className="contact-title">Get in Touch</h1>
          <p className="contact-subtitle">
            We're here to help and answer any question you might have. We look forward to hearing from you.
          </p>
        </div>
      </header>

      <div className="contact-body">
        <div className="contact-details" data-aos="fade-right">
          <h2>Contact Information</h2>
          <p className="contact-intro">
            Ready to start your eco-friendly journey? Fill up the form and our dedicated team will get back to you within 24 hours.
          </p>
          
          <div className="contact-info-grid">
            <div className="contact-info-item">
              <div className="contact-icon-wrapper">
                <FaPhone className="contact-icon" />
              </div>
              <div className="contact-info-content">
                <h3>Phone Number</h3>
                <p>+94 764948887</p>
                <span className="contact-note">Call us anytime</span>
              </div>
            </div>

            <div className="contact-info-item">
              <div className="contact-icon-wrapper">
                <FaEnvelope className="contact-icon" />
              </div>
              <div className="contact-info-content">
                <h3>Email Address</h3>
                <p>ecolift@gmail.com</p>
                <span className="contact-note">We'll respond quickly</span>
              </div>
            </div>

            <div className="contact-info-item">
              <div className="contact-icon-wrapper">
                <FaMapMarkerAlt className="contact-icon" />
              </div>
              <div className="contact-info-content">
                <h3>Office Location</h3>
                <p>Hapugala, Galle, Sri Lanka</p>
                <span className="contact-note">Visit our headquarters</span>
              </div>
            </div>

            <div className="contact-info-item">
              <div className="contact-icon-wrapper">
                <FaClock className="contact-icon" />
              </div>
              <div className="contact-info-content">
                <h3>Business Hours</h3>
                <p>Mon - Fri: 8:00 AM - 6:00 PM</p>
                <span className="contact-note">Sat: 9:00 AM - 4:00 PM</span>
              </div>
            </div>
          </div>
        </div>

      </div>

      <div className="map-container" data-aos="fade-up">
        <h2>Find Us</h2>
        <p>Visit our office in Hapugala, Galle, Sri Lanka</p>
        <iframe
          src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3967.2345678901234!2d80.218569314789!3d6.053516995585!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3ae173d78c000001%3A0x23c9a2a7b6a0a0e!2sHapugala%2C%20Galle%2C%20Sri%20Lanka!5e0!3m2!1sen!2slk!4v1620912185569!5m2!1sen!2slk"
          width="100%"
          height="450"
          style={{ border: 0 }}
          allowFullScreen=""
          loading="lazy"
          title="Google Maps Location of Hapugala, Galle, Sri Lanka"
        ></iframe>
      </div>
    </div>
  );
}
