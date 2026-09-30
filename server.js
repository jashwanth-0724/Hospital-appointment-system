// Supporting Experiment: Node.js (Exp 9), Express + REST + CRUD (Exp 10), JWT (Exp 11)
const express = require('express');
const jwt = require('jsonwebtoken');

const app = express();
app.use(express.json());

const SECRET_KEY = 'super_secret_academic_key';

// In-memory data for CRUD
let departments = [
    { id: 1, name: 'Cardiology', description: 'Heart care' },
    { id: 2, name: 'Neurology', description: 'Brain care' }
];

// --- EXP 11: JWT Authentication ---
app.post('/api/login', (req, res) => {
    const { username, password } = req.body;
    // Dummy check
    if (username === 'admin' && password === 'admin123') {
        const token = jwt.sign({ username, role: 'ADMIN' }, SECRET_KEY, { expiresIn: '1h' });
        return res.json({ token });
    }
    return res.status(401).json({ message: 'Invalid credentials' });
});

// Middleware for JWT validation
const authenticateJWT = (req, res, next) => {
    const authHeader = req.headers.authorization;
    if (authHeader) {
        const token = authHeader.split(' ')[1];
        jwt.verify(token, SECRET_KEY, (err, user) => {
            if (err) return res.sendStatus(403);
            req.user = user;
            next();
        });
    } else {
        res.sendStatus(401);
    }
};

// --- EXP 10: Express + REST + CRUD ---
// GET all departments
app.get('/api/departments', (req, res) => {
    res.json(departments);
});

// GET single department
app.get('/api/departments/:id', (req, res) => {
    const dept = departments.find(d => d.id === parseInt(req.params.id));
    if (!dept) return res.status(404).json({ message: 'Not found' });
    res.json(dept);
});

// POST new department (Protected by JWT)
app.post('/api/departments', authenticateJWT, (req, res) => {
    const newDept = {
        id: departments.length + 1,
        name: req.body.name,
        description: req.body.description
    };
    departments.push(newDept);
    res.status(201).json(newDept);
});

// PUT update department (Protected by JWT)
app.put('/api/departments/:id', authenticateJWT, (req, res) => {
    const dept = departments.find(d => d.id === parseInt(req.params.id));
    if (!dept) return res.status(404).json({ message: 'Not found' });
    
    dept.name = req.body.name || dept.name;
    dept.description = req.body.description || dept.description;
    res.json(dept);
});

// DELETE department (Protected by JWT)
app.delete('/api/departments/:id', authenticateJWT, (req, res) => {
    departments = departments.filter(d => d.id !== parseInt(req.params.id));
    res.json({ message: 'Deleted successfully' });
});

// --- EXP 9: Node.js basic server ---
const PORT = 3000;
app.listen(PORT, () => {
    console.log(`Supporting Express API running on http://localhost:${PORT}`);
    console.log(`This fulfills Experiments 9 (Node), 10 (Express CRUD), and 11 (JWT)`);
});
