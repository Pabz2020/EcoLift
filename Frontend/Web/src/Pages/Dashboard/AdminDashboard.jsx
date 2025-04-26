import React, { useState, useEffect } from 'react';
import {
    Container,
    Typography,
    Paper,
    Grid,
    Button,
    Table,
    TableBody,
    TableCell,
    TableContainer,
    TableHead,
    TableRow,
    IconButton,
    Alert,
    CircularProgress
} from '@mui/material';
import DeleteIcon from '@mui/icons-material/Delete';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';

const AdminDashboard = () => {
    const navigate = useNavigate();
    const [users, setUsers] = useState([]);
    const [error, setError] = useState('');
    const [loading, setLoading] = useState(true);
    const token = localStorage.getItem('token');

    // Add debugging for token
    useEffect(() => {
        console.log('Current token:', token);
        if (!token) {
            navigate('/login');
            return;
        }
        fetchUsers();
    }, [token, navigate]);

    const fetchUsers = async () => {
        try {
            setLoading(true);
            const response = await axios.get('http://localhost:4000/api/users/users', {
                headers: { Authorization: `Bearer ${token}` }
            });
            
            // Add console.log to debug response
            console.log('API Response:', response);
            
            // Check if response.data exists before setting users
            if (response.data) {
                setUsers(Array.isArray(response.data) ? response.data : response.data.data || []);
            } else {
                setUsers([]);
                setError('No data received from server');
            }
        } catch (error) {
            console.error('Fetch error:', error);
            setError('Failed to fetch users: ' + (error.response?.data?.message || error.message));
            setUsers([]);
        } finally {
            setLoading(false);
        }
    };

    const handleDelete = async (userId) => {
        try {
            await axios.delete(`http://localhost:4000/api/users/user/${userId}`, {
                headers: { Authorization: `Bearer ${token}` }
            });
            fetchUsers();
        } catch (error) {
            setError('Failed to delete user: ' + (error.response?.data?.message || error.message));
        }
    };

    const handleLogout = () => {
        localStorage.removeItem('token');
        localStorage.removeItem('userInfo');
        navigate('/login');
    };

    return (
        <Container maxWidth="lg" sx={{ mt: 4, mb: 4 }}>
            <Grid container spacing={3}>
                <Grid item xs={12}>
                    <Paper sx={{ p: 2, display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                        <Typography variant="h4">Admin Dashboard</Typography>
                        <Button variant="contained" color="error" onClick={handleLogout}>
                            Logout
                        </Button>
                    </Paper>
                </Grid>

                {error && (
                    <Grid item xs={12}>
                        <Alert severity="error" onClose={() => setError('')}>{error}</Alert>
                    </Grid>
                )}

                <Grid item xs={12}>
                    <TableContainer component={Paper}>
                        <Table>
                            <TableHead>
                                <TableRow>
                                    <TableCell>Name</TableCell>
                                    <TableCell>Email</TableCell>
                                    <TableCell>Role</TableCell>
                                    <TableCell>Actions</TableCell>
                                </TableRow>
                            </TableHead>
                            <TableBody>
                                {loading ? (
                                    <TableRow>
                                        <TableCell colSpan={4} align="center">
                                            <CircularProgress />
                                        </TableCell>
                                    </TableRow>
                                ) : users.length === 0 ? (
                                    <TableRow>
                                        <TableCell colSpan={4} align="center">
                                            No users found
                                        </TableCell>
                                    </TableRow>
                                ) : (
                                    users.map((user) => (
                                        <TableRow key={user._id}>
                                            <TableCell>{`${user.firstName} ${user.lastName}`}</TableCell>
                                            <TableCell>{user.email}</TableCell>
                                            <TableCell>{user.role}</TableCell>
                                            <TableCell>
                                                <IconButton 
                                                    color="error" 
                                                    onClick={() => handleDelete(user._id)}
                                                    disabled={user.role === 'admin'}
                                                >
                                                    <DeleteIcon />
                                                </IconButton>
                                            </TableCell>
                                        </TableRow>
                                    ))
                                )}
                            </TableBody>
                        </Table>
                    </TableContainer>
                </Grid>
            </Grid>
        </Container>
    );
};

export default AdminDashboard;