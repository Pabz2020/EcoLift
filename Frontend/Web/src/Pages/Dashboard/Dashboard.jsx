import React, { useState } from 'react';
import {
    Box,
    Container,
    Typography,
    Paper,
    Grid,
    Card,
    CardContent,
    Button,
    Avatar,
    List,
    ListItem,
    ListItemAvatar,
    ListItemText,
    Divider
} from '@mui/material';
import { useNavigate } from 'react-router-dom';
import EventAvailableIcon from '@mui/icons-material/EventAvailable';
import CheckCircleIcon from '@mui/icons-material/CheckCircle';
import EmojiEventsIcon from '@mui/icons-material/EmojiEvents';
import NotificationsIcon from '@mui/icons-material/Notifications';
import HistoryIcon from '@mui/icons-material/History';
import PersonIcon from '@mui/icons-material/Person';
import AddCircleIcon from '@mui/icons-material/AddCircle';

const mockStats = {
    scheduled: 2,
    completed: 8,
    points: 120,
    notifications: 3
};

const mockRecentActivity = [
    { id: 1, action: 'Scheduled a pickup', date: '2024-06-10', status: 'Scheduled' },
    { id: 2, action: 'Pickup completed', date: '2024-06-08', status: 'Completed' },
    { id: 3, action: 'Earned 20 points', date: '2024-06-08', status: 'Points' },
    { id: 4, action: 'Received notification: Pickup reminder', date: '2024-06-07', status: 'Notification' },
];

const Dashboard = () => {
    const navigate = useNavigate();
    const userInfo = JSON.parse(localStorage.getItem('userInfo'));

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('userInfo');
        navigate('/login');
    };

    const handleSchedulePickup = () => {
        // Navigate to schedule pickup page (implement route as needed)
        alert('Navigate to schedule pickup page');
    };

    const handleViewHistory = () => {
        // Navigate to pickup history page (implement route as needed)
        alert('Navigate to pickup history page');
    };

    const handleEditProfile = () => {
        // Navigate to edit profile page (implement route as needed)
        alert('Navigate to edit profile page');
    };

    return (
        <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
            <Grid container spacing={3}>
                <Grid item xs={12}>
                    <Paper sx={{ p: 2, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <Typography variant="h4">Welcome, {userInfo?.firstName}</Typography>
                        <Button variant="contained" color="error" onClick={handleLogout}>
                            Logout
                        </Button>
                    </Paper>
                </Grid>
                {/* Stat Cards */}
                <Grid item xs={12}>
                    <Grid container spacing={2}>
                        <Grid item xs={12} sm={6} md={3}>
                            <Card sx={{ display: 'flex', alignItems: 'center', p: 2 }}>
                                <Avatar sx={{ bgcolor: 'primary.main', mr: 2 }}>
                                    <EventAvailableIcon />
                                </Avatar>
                                <Box>
                                    <Typography variant="h6">Scheduled</Typography>
                                    <Typography variant="h5">{mockStats.scheduled}</Typography>
                                </Box>
                            </Card>
                        </Grid>
                        <Grid item xs={12} sm={6} md={3}>
                            <Card sx={{ display: 'flex', alignItems: 'center', p: 2 }}>
                                <Avatar sx={{ bgcolor: 'success.main', mr: 2 }}>
                                    <CheckCircleIcon />
                                </Avatar>
                                <Box>
                                    <Typography variant="h6">Completed</Typography>
                                    <Typography variant="h5">{mockStats.completed}</Typography>
                                </Box>
                            </Card>
                        </Grid>
                        <Grid item xs={12} sm={6} md={3}>
                            <Card sx={{ display: 'flex', alignItems: 'center', p: 2 }}>
                                <Avatar sx={{ bgcolor: 'warning.main', mr: 2 }}>
                                    <EmojiEventsIcon />
                                </Avatar>
                                <Box>
                                    <Typography variant="h6">Points</Typography>
                                    <Typography variant="h5">{mockStats.points}</Typography>
                                </Box>
                            </Card>
                        </Grid>
                        <Grid item xs={12} sm={6} md={3}>
                            <Card sx={{ display: 'flex', alignItems: 'center', p: 2 }}>
                                <Avatar sx={{ bgcolor: 'info.main', mr: 2 }}>
                                    <NotificationsIcon />
                                </Avatar>
                                <Box>
                                    <Typography variant="h6">Notifications</Typography>
                                    <Typography variant="h5">{mockStats.notifications}</Typography>
                                </Box>
                            </Card>
                        </Grid>
                    </Grid>
                </Grid>
                {/* Quick Actions */}
                <Grid item xs={12} md={4}>
                    <Card>
                        <CardContent>
                            <Typography variant="h6" gutterBottom>Quick Actions</Typography>
                            <Button
                                fullWidth
                                variant="contained"
                                startIcon={<AddCircleIcon />}
                                sx={{ mb: 2 }}
                                onClick={handleSchedulePickup}
                            >
                                Schedule Pickup
                            </Button>
                            <Button
                                fullWidth
                                variant="outlined"
                                startIcon={<HistoryIcon />}
                                sx={{ mb: 2 }}
                                onClick={handleViewHistory}
                            >
                                View History
                            </Button>
                            <Button
                                fullWidth
                                variant="outlined"
                                startIcon={<PersonIcon />}
                                onClick={handleEditProfile}
                            >
                                Edit Profile
                            </Button>
                        </CardContent>
                    </Card>
                </Grid>
                {/* Recent Activity */}
                <Grid item xs={12} md={8}>
                    <Card>
                        <CardContent>
                            <Typography variant="h6" gutterBottom>Recent Activity</Typography>
                            <List>
                                {mockRecentActivity.map((activity, idx) => (
                                    <React.Fragment key={activity.id}>
                                        <ListItem>
                                            <ListItemAvatar>
                                                <Avatar>
                                                    {activity.status === 'Scheduled' && <EventAvailableIcon color="primary" />}
                                                    {activity.status === 'Completed' && <CheckCircleIcon color="success" />}
                                                    {activity.status === 'Points' && <EmojiEventsIcon color="warning" />}
                                                    {activity.status === 'Notification' && <NotificationsIcon color="info" />}
                                                </Avatar>
                                            </ListItemAvatar>
                                            <ListItemText
                                                primary={activity.action}
                                                secondary={activity.date}
                                            />
                                        </ListItem>
                                        {idx < mockRecentActivity.length - 1 && <Divider variant="inset" component="li" />}
                                    </React.Fragment>
                                ))}
                            </List>
                        </CardContent>
                    </Card>
                </Grid>
            </Grid>
        </Container>
    );
};

export default Dashboard;