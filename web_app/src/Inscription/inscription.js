const send = (event) => {
    event.preventDefault();
    console.log(event)
    const user = {}
    const form = event.target
    for(input of form) {
        if (input.id !==" ") {
            user [input.id] = input.value
        }
    }

    console.log(user)
fetch('http://127.0.0.1:5000/register', {
    method:"POST",
    body:JSON.stringify(user),
    headers:{'Content-Type': 'application/json'}
})

.then (resp=>resp.json())
.then (json=>console.log(json))

}

document.querySelector("#RegisterUserForm").addEventListener('submit', send);
console.log(document.querySelector("#RegisterUserForm"))