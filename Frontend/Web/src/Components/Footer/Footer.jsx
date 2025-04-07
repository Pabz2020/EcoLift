import React from "react";
import { 
  Container, 
  Grid, 
  Typography, 
  IconButton, 
  Box, 
  List, 
  ListItem, 
  ListItemText,
  Link 
} from '@mui/material';
import {
  Facebook,
  Twitter,
  LinkedIn,
  Instagram,
  YouTube,
  Email,
  Phone,
  LocationOn
} from '@mui/icons-material';

const Footer = () => {
  const services = [
    "Waste Management",
    "E-Waste EPR",
    "Plastic Waste EPR",
    "Recycling Consultation"
  ];

  const quickLinks = [
    { title: "About Us", path: "/about" },
    { title: "Careers", path: "/careers" },
    { title: "Privacy Policy", path: "/privacy-policy" },
    { title: "Terms of Service", path: "/terms" }
  ];

  const socialLinks = [
    { icon: <Facebook />, url: "https://facebook.com", name: "Facebook" },
    { icon: <Twitter />, url: "https://twitter.com", name: "Twitter" },
    { icon: <LinkedIn />, url: "https://linkedin.com", name: "LinkedIn" },
    { icon: <Instagram />, url: "https://instagram.com", name: "Instagram" },
    { icon: <YouTube />, url: "https://youtube.com", name: "YouTube" }
  ];

  return (
    <Box component="footer" sx={{ bgcolor: 'primary.main', color: 'white', py: 6, mt: 'auto' }}>
      <Container maxWidth="lg">
        <Grid container spacing={4}>
          {/* Services Section */}
          <Grid item xs={12} sm={6} md={3}>
            <Typography variant="h6" gutterBottom>
              Services
            </Typography>
            <List>
              {services.map((service, index) => (
                <ListItem key={index} sx={{ py: 0.5 }}>
                  <ListItemText primary={service} />
                </ListItem>
              ))}
            </List>
          </Grid>

          {/* Quick Links Section */}
          <Grid item xs={12} sm={6} md={3}>
            <Typography variant="h6" gutterBottom>
              Quick Links
            </Typography>
            <List>
              {quickLinks.map((link, index) => (
                <ListItem key={index} sx={{ py: 0.5 }}>
                  <Link
                    href={link.path}
                    color="inherit"
                    underline="hover"
                    sx={{ '&:hover': { color: 'secondary.main' } }}
                  >
                    {link.title}
                  </Link>
                </ListItem>
              ))}
            </List>
          </Grid>

          {/* Contact Section */}
          <Grid item xs={12} sm={6} md={3}>
            <Typography variant="h6" gutterBottom>
              Contact Us
            </Typography>
            <List>
              <ListItem sx={{ py: 0.5 }}>
                <Phone sx={{ mr: 1 }} />
                <ListItemText primary="+123 456 7890" />
              </ListItem>
              <ListItem sx={{ py: 0.5 }}>
                <Email sx={{ mr: 1 }} />
                <ListItemText primary="ecolift@gmail.com" />
              </ListItem>
              <ListItem sx={{ py: 0.5 }}>
                <LocationOn sx={{ mr: 1 }} />
                <ListItemText primary="Hapugala, Galle" />
              </ListItem>
            </List>
          </Grid>

          {/* Social Media Section */}
          <Grid item xs={12} sm={6} md={3}>
            <Typography variant="h6" gutterBottom>
              Follow Us
            </Typography>
            <Box sx={{ display: 'flex', gap: 1 }}>
              {socialLinks.map((social, index) => (
                <IconButton
                  key={index}
                  href={social.url}
                  target="_blank"
                  rel="noopener noreferrer"
                  sx={{
                    color: 'white',
                    '&:hover': { color: 'secondary.main' }
                  }}
                  aria-label={social.name}
                >
                  {social.icon}
                </IconButton>
              ))}
            </Box>
          </Grid>
        </Grid>

        {/* Footer Bottom */}
        <Box sx={{ mt: 4, pt: 2, borderTop: '1px solid rgba(255, 255, 255, 0.1)' }}>
          <Typography variant="body2" align="center">
            © {new Date().getFullYear()} Your Company. All Rights Reserved.
          </Typography>
        </Box>
      </Container>
    </Box>
  );
};

export default Footer;
