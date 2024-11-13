
const labels = [
    'Semana 1',
    'Semana 2',
    'Semana 3',
    'Semana 4',
];

const data = {
    labels: labels,
    datasets: [{
        label: 'Total de ocupação semanal',
        backgroundColor: '#F46200',
        borderColor: 'black',
        data: [500, 320, 430, 140],
    },

    ]

};

const config = {
    type: 'bar',
    data: data,
    options: {}
};

const labels2 = [
    '08/10/24',
    '09/10/24',
    '10/10/24',
    '11/10/24',
];

const data2 = {
    labels: labels2,
    datasets: [{
        label: 'Vagas ocupadas',
        backgroundColor: 'white',
        borderColor: '#f5f5f5',
        data: [60, 80, 91, 30, 145],
    },

    {
        label: 'Vagas livres',
        backgroundColor: '#F46200',
        borderColor: '#F46200',
        data: [90, 70, 59, 120, 0],
    }
    ]

};

const config2 = {
    type: 'line',
    data: data2,
    options: {}
};

const myChart = new Chart(
    document.getElementById('myChart'),
    config
);

const myChart2 = new Chart(
    document.getElementById('myChart2'),
    config2
);