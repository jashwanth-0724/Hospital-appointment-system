// ES6 + Client-side validation

document.addEventListener('DOMContentLoaded', () => {
    // Form Validation (Bootstrap style)
    const forms = document.querySelectorAll('form[novalidate]');
    
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });

    // Date of birth max date (cannot be in the future)
    const dobInput = document.getElementById('dobInput');
    if (dobInput) {
        const today = new Date().toISOString().split('T')[0];
        dobInput.setAttribute('max', today);
    }
    
    // Appointment date min date (cannot be in the past)
    const apptDateInput = document.getElementById('appointmentDate');
    if (apptDateInput) {
        const today = new Date().toISOString().split('T')[0];
        apptDateInput.setAttribute('min', today);
    }
    
    // If we have chart canvas, fetch data and render
    const chartCanvas = document.getElementById('analyticsChart');
    if (chartCanvas) {
        renderCharts();
    }
});

// Fetch Analytics (ES6 Async/Await + Fetch API)
const renderCharts = async () => {
    try {
        const response = await fetch(`${window.location.origin}/hospital-appointment-system/api/analytics/appointments`);
        if (!response.ok) throw new Error('Network response was not ok');
        
        const data = await response.json();
        
        // Ensure Chart.js is loaded
        if (typeof Chart !== 'undefined') {
            const ctx = document.getElementById('analyticsChart').getContext('2d');
            
            const labels = Object.keys(data.byDepartment);
            const counts = Object.values(data.byDepartment);
            
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Appointments by Department',
                        data: counts,
                        backgroundColor: '#4f46e5',
                        borderRadius: 5
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: { beginAtZero: true, ticks: { stepSize: 1 } }
                    }
                }
            });
            
            // Second chart for Status
            const ctxStatus = document.getElementById('statusChart').getContext('2d');
            new Chart(ctxStatus, {
                type: 'doughnut',
                data: {
                    labels: Object.keys(data.byStatus),
                    datasets: [{
                        data: Object.values(data.byStatus),
                        backgroundColor: ['#059669', '#d97706', '#dc2626', '#4338ca', '#6b7280']
                    }]
                },
                options: { responsive: true }
            });
            
        }
    } catch (error) {
        console.error('Failed to fetch analytics:', error);
    }
};
