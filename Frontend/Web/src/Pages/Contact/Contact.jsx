import React from 'react'

export default function Contact() {
  return (
    <div>
      <section id="contact" className="contact-section">
        <div className="contact-form">
          <h2>Say Hi!</h2>
          <p>We'd like to talk with you.</p>
          <form>
            <input type="text" placeholder="Full Name" name="name" required aria-label="Full Name" />
            <input type="text" placeholder="What you love" name="interest" required />
            <textarea placeholder="I want to say that..." name="message" required></textarea>
            <button type="submit" className="send-message">Send Message</button>
          </form>
        </div>

        



        <div className="contact-info">
          <h3>Contact Information</h3>
          <p>Fill up the form and our Team will get back to you within 24 hours.</p>
          <p><strong>Phone:</strong> (+40) 772 100 200</p>
          <p><strong>Email:</strong> hello@creative-team.com</p>
          <p><strong>Address:</strong> Dyonise Wolf Bucharest, RO 014058</p>
        </div>
      </section>
      
   
    </div>
    
  )
}
