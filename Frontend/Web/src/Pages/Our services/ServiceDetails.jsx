import React from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { servicesData } from './servicesData';
import {
  Container,
  Typography,
  Paper,
  Button,
  Box
} from '@mui/material';
import ArrowBackIcon from '@mui/icons-material/ArrowBack';
import './ServiceDetails.css';

const ServiceDetails = () => {
  const { serviceId } = useParams();
  const navigate = useNavigate();
  
  const service = servicesData.find(s => s.path === `/services/${serviceId}`);

  const handleBack = () => {
    navigate('/services');  // Navigate back to services page
  };

  if (!service) {
    return (
      <Container className="service-details-container">
        <Paper className="service-details-paper">
          <Typography variant="h4">Service not found</Typography>
          <Button 
            onClick={handleBack}
            startIcon={<ArrowBackIcon />}
            className="back-button"
          >
            Back to Services
          </Button>
        </Paper>
      </Container>
    );
  }

  return (
    <Container className="service-details-container">
      <Paper className="service-details-paper">
        <Button 
          onClick={handleBack}
          startIcon={<ArrowBackIcon />}
          className="back-button"
        >
          Back to Services
        </Button>
        
        <Box className="service-image-container">
          <img 
            src={service.image} 
            alt={service.title}
            className="service-detail-image"
          />
        </Box>
        
        <Typography variant="h4" className="service-title">
          {service.title}
        </Typography>
        
        <Typography variant="body1" className="service-description">
          {service.description}
        </Typography>
      </Paper>
    </Container>
  );
};

export default ServiceDetails;