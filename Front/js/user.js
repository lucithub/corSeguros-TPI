function fechaHoy(){
    const hoy = new Date();
    const dia = String(hoy.getDate()).padStart(2, '0');
    const mes = String(hoy.getMonth() + 1).padStart(2, '0'); // Meses empiezan en 0
    const anio = hoy.getFullYear();
    
    const fechaFormateada = `${dia}-${mes}-${anio}`;
    
    // Asignar la fecha formateada al campo de texto
    document.getElementById('fechaE').value = fechaFormateada;
}
function registrarUsuario(){
    const apellido = document.getElementById('apellido').value;
    const nombre = document.getElementById('nombre').value;
    const mail = document.getElementById('email').value;
    const telefono = document.getElementById('telefono').value;
    const contrasena = document.getElementById('password').value;
    if(nombre === '' || apellido === '' || mail === '' || telefono === ''){
        alert('Todos los campos son obligatorios');
        return;
    }
    const usuario = {
        apellido,
        nombre,
        telefono,
        mail
    };
    fetch('https://localhost:7018/api/Seguros/Cliente', {
        method: 'POST',
        body: JSON.stringify(usuario),
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => response.json())
    .then(data => {
        alert('Usuario registrado con éxito');
        let idUser = data;
        window.location.href = '/pages/index/indexLogueado.html?id='+idUser+'&nombre='+nombre+'&apellido='+apellido;
    })
    .catch(error => console.error('Error:', error));
}
function logIn(){
    const mail = document.getElementById('email').value;
    const contrasena = document.getElementById('password').value;
    if(mail === '' || contrasena === ''){
        alert('Todos los campos son obligatorios');
        return;
    }
    fetch('https://localhost:7018/api/Seguros/login/'+mail, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'}
    })
    .then(response => response.json())
    .then(data => {
        alert('Usuario logueado con éxito');
        let idUser = data.idCliente;
        let nombre = data.nombre;
        let apellido = data.apellido;
        window.location.href = '/pages/index/indexLogueado.html?id='+idUser+'&nombre='+nombre+'&apellido='+apellido;
    })
    .catch(error => {
        console.error('Error:', error);
        alert('Usuario no encontrado');
    } )
}
function editarPerfil(usuarioId){
    const id = usuarioId
    const apellido = document.getElementById('apellido').value;
    const nombre = document.getElementById('nombre').value;
    const mail = document.getElementById('email').value;
    const telefono = document.getElementById('telefono').value;
    if(nombre === '' || apellido === '' || mail === '' || telefono === ''){
        alert('Todos los campos son obligatorios');
        return;
    }
    const usuario = {
        id,
        apellido,
        nombre,
        telefono,
        mail
    };
    fetch('https://localhost:7018/api/Seguros/Cliente', {
        method: 'PUT',
        body: JSON.stringify(usuario)
    })
    .then(response => response.json())
    .then(data => {
        alert('Usuario actualizado con éxito');
        window.location.href = '/pages/index/indexLogueado.html?id='+id+'&nombre='+nombre+'&apellido='+apellido;
    })
    .catch(error => console.error('Error:', error));
}
function cerrarSesion(){
    alert("Esperamos verte pronto :(");
    window.location.href = '/pages/index/index.html';
}
function solicitudGrua(){
    const urlParams = new URLSearchParams(window.location.search);
    const usuarioId = urlParams.get('id');
    const nombre = urlParams.get('nombre');
    const apellido = urlParams.get('apellido');
    const ubicacion = document.getElementById('ubicacion').value
    alert("Perfecto. Enviaremos una grúa a "+ubicacion+" lo mas pronto posible.");
    window.location.href = '/pages/index/indexLogueado.html?id='+usuarioId+'&nombre='+nombre+'&apellido='+apellido;
}