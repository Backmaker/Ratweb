const users = [
  { id: 1, login: 'Enzal', email: 'enzo@semifir.com', },
  { id: 2, login: 'JoDoe', email: 'jd@mail.fr', },
]

const deleteUser = event => {
  console.log(event.target.id)
}

const renderUsers = () => {
  const list = document.querySelector('#userList')
  for (user of users) {
      const li = document.createElement('li')
      const data = document.createTextNode(`Login : ${user.login}  Email: ${user.email}`)
      const button = document.createElement('button')
      button.setAttribute("id", user.id.toString())
      button.addEventListener('click', deleteUser)
      button.innerHTML = "Supprimer"
      li.appendChild(data)
      li.appendChild(button)
      list.appendChild(li)
  }
}

renderUsers()