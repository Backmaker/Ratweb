// const users = [ 
//     { lastname:'Marsy', firstname:'Arthur', birth:'12/10/1991', phone:'0659408306', mail:'arthurmarsy@outlook.fr' },
//     { lastname:'Ysera', firstname:'Dragon', birth:'12/12/1212', phone:'0606060606', mail:'ysera@dragon.fr'},
// ]
const renderUsers = () => {
    const table = document.querySelector('#userTable')
    for (user of users) {
        const tr = table.insertRow()
        for (key in user) {
            let cell = tr.insertCell()
            cell.innerHTML = user[key]
        }
    }

}

const send = (event) => {
    event.preventDefault();

    fetch('http://127.0.0.1:5000/Inscription')
    .then(function(response) {
        response.json()
            .then(function(value) {
                renderUsers(value);
            })
    })
}
document.querySelector("#formrecherche").addEventListener('submit', send)