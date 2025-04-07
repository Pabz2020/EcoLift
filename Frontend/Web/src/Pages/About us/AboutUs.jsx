import React from 'react'

export default function AboutUs() {
  return (
    <div>
      <div className="App">
      <section id="about" className="about">
        <h1>About Us</h1>
        <p className="subtext">Subtext Subtext Subtext Subtext Subtext Subtext Subtext Subtext Subtext Subtext Subtext Subtext</p>
        <div className="social-icons">
          <a href="#">🔗</a>
          <a href="#">🔗</a>
          <a href="#">🔗</a>
        </div>
      </section>

      <section className="executive-team">
        <h2>The Executive Team</h2>
        <p>There’s nothing I really wanted to do in life that I wasn’t able to get good at. That’s my skill.</p>

        <div className="team-container">
          <div className="team-member">
            <img src="/images/pabasara.jpeg" alt="Pabasara Jayawardhana" />
            <h3>Pabasara Jayawardhana</h3>
            <p>Chairman</p>
            <p>An artist is someone engaged in an activity deemed to be art.</p>
          </div>

          <div className="team-member">
            <img src="/images/sasini.jpeg" alt="Sasini Perera" />
            <h3>Sasini Perera</h3>
            <p>Boss</p>
            <p>An artist is someone engaged in an activity deemed to be art.</p>
          </div>

          <div className="team-member">
            <img src="/images/ashan.jpeg" alt="Ashan Munasinghe" />
            <h3>Ashan Munasinghe</h3>
            <p>UI/UX Designer</p>
            <p>An artist is someone engaged in an activity deemed to be art.</p>
          </div>

          <div className="team-member">
            <img src="/images/ishan.jpeg" alt="Ishan Kendawela" />
            <h3>Ishan Kendawela</h3>
            <p>Artist</p>
            <p>An artist is someone engaged in an activity deemed to be art.</p>
          </div>
        </div>
      </section>

      <section className="stats">
        <h2>5,234</h2>
        <p>Number of Clients</p>
        <p>Text Text Text Text Text Text</p>
      </section>

      <section className="newsletter">
        <h3>Be the first to see the news</h3>
        <p>Your company may not be in the software business, but eventually, a software company will be in your business.</p>
        <form>
          <input type="email" placeholder="Enter your email" />
          <button type="submit">Subscribe</button>
        </form>
      </section>
    </div>
    </div>
  )
}
