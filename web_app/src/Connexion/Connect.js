const login = (event) => {
    event.preventDefault()
    const loginInfo = {}
    const form = event.target
    for (input of form) {
        if (input.id !== "") {
            loginInfo[input.id] = input.value
        }
    }
    console.log(loginInfo)
}

document.querySelector('#loginForm').addEventListener('submit', login)