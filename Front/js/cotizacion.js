function cargarCotizacion(usuarioId){
    fetch('https://localhost:7018/api/Seguros/'+usuarioId, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => response.json())
    .then(data => {
        array.forEach(element => {
            
        });;
    })
    .catch(error => console.error('Error:', error));
}
function getModelos(){
    const selectItem = document.getElementById('marcas');
    const idMarca = selectItem.value;
    fetch('https://localhost:7018/api/Seguros/modelos/'+idMarca, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => response.json())
    .then(data => {
        let select = document.getElementById('modelos');
        data.forEach(element => {
            let option = document.createElement('option');
            option.value = element.idModelo;
            option.text = element.nombre;
            select.appendChild(option);
        });
    })
    .catch(error => console.error('Error:', error));
}
function getVersiones() {
    const selectItem = document.getElementById('modelos');
    const idModelo = selectItem.value;

    fetch('https://localhost:7018/api/Seguros/versiones/' + idModelo, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => response.json())
    .then(data => {
        let select = document.getElementById('versiones');
        data.forEach(element => {
            // Realizar el segundo fetch para obtener el año
            fetch('https://localhost:7018/api/Seguros/anio/' + element.idAnio, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(anioData => {
                let option = document.createElement('option');
                option.value = element.idVersion;
                option.text = element.descripcion + ' ' + anioData; // Utilizar el año aquí
                select.appendChild(option);
            })
            .catch(error => console.error('Error en el segundo fetch:', error));
        });
    })
    .catch(error => console.error('Error en el primer fetch:', error));
}
function getSeguros(){
    const selectItem = document.getElementById('versiones');
    const idVersion = selectItem.value;
    fetch('https://localhost:7018/api/Seguros/seguros/'+idVersion, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => response.json())
    .then(data => {
        let select = document.getElementById('seguros');
        data.forEach(element => {
            let option = document.createElement('option');
            option.value = element.idSeguro;
            let version;
            if (element.idTipoSeg === 1) {
                version = 'Terceros Completo Básica';
            } else if (element.idTipoSeg === 2) {
                version = 'Terceros Completo Plus';
            } else if (element.idTipoSeg === 3) {
                version = 'Todo Riesgo con Franquicia';
            } else  if (element.idTipoSeg === 4) {
                version = 'Cobertura Limitada con Franquicia';
            }
            option.text = version+' - '+'$'+element.precio;
            select.appendChild(option);
        });
    })
    .catch(error => console.error('Error:', error));
}
function createCotizacion(){
    const seguro = document.getElementById('seguros');
    const idSeguros = seguro.value;
    const precios = document.getElementById('seguros').innerText;
    const precioValue = precios.split('$');
    const precioFinal = precioValue[1];
    const fechaEmision = new Date();  // Crea una instancia de la fecha actual
    // Crea una nueva fecha para fechaVenc copiando fechaEmision y sumándole 14 días
    const fechaVenc = new Date(fechaEmision);  // Clona la fecha actual
    fechaVenc.setDate(fechaEmision.getDate() + 14);  // Suma 14 días
    const urlParams = new URLSearchParams(window.location.search);
    const usuarioId = urlParams.get('id');
    const nombre = urlParams.get('nombre');
    const apellido = urlParams.get('apellido');
    const userResponse = confirm("¿Estás seguro de que quieres continuar?");
    if (userResponse) {
        const cotizacion = {
            idCliente: usuarioId,
            fechaEmision: fechaEmision.toISOString(),
            fechaVenc: fechaVenc.toISOString(),
            idCodPostal: 1,
            idSeguro: idSeguros,
            precio: parseFloat(precioFinal),
            aprobada: true,
            idSucursal: 1
        };
        console.log(cotizacion.precio);
        fetch('https://localhost:7018/api/Seguros/cotizacion', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(cotizacion),
        })
        .then(response => {
            console.log(response);
            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }
            else{
                alert('Cotizacion agregada, le estaremos enviando un mail con los detalles de la cotizacion');
                window.location.href = '/pages/index/indexLogueado.html?id='+usuarioId+'&nombre='+nombre+'&apellido='+apellido;
            }
        })
        .catch(error => {
            console.error('Error en el POST:', error);
            alert('Error al agregar la cotizacion');
        });
    } else {
    alert('Operación cancelada');
    window.location.href = '/pages/cotizaciones/crearcotizacion.html?id='+usuarioId+'&nombre='+nombre+'&apellido='+apellido;
    }
}
function consultarCotizacion(){
    const urlParams = new URLSearchParams(window.location.search);
    const usuarioId = urlParams.get('id');
    const nombre = urlParams.get('nombre');
    const apellido = urlParams.get('apellido');
    fetch('https://localhost:7018/api/Seguros/'+usuarioId, {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json'
        }
    })
    .then(response => response.json())
    .then(data => {
        let tabla = document.getElementById('tablaCotizaciones');
        data.forEach(element => {
            let row = tabla.insertRow();
            let cell1 = row.insertCell(0);
            let cell2 = row.insertCell(1);
            let cell3 = row.insertCell(2);
            let cell4 = row.insertCell(3);
            let cell5 = row.insertCell(4);
            cell1.innerHTML = element.idCotizacion;
            let fechaBien = element.fechaEmision.split('T');
            cell2.innerHTML = fechaBien[0];
            let fechaVencBien = element.fechaVenc.split('T');
            cell3.innerHTML = fechaVencBien[0];
            cell4.innerHTML = element.precio;
            // Quiero traer la marca del auto
            fetch('https://localhost:7018/api/Seguros/versiones/'+element.idSeguro, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                fetch('https://localhost:7018/api/Seguros/modelos/'+data[0].idModelo, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json'
                    }
                })
                .then(response => response.json())
                .then(data => {
                    fetch('https://localhost:7018/api/Seguros/marcas/'+data[0].idMarca, {
                        method: 'GET',
                        headers: {
                            'Content-Type': 'application/json'
                        }
                    })
                    .then(response => response.json())
                    .then(data => {
                        console.log(data);
                        cell5.innerHTML = data;
                    })
                })
                cell5.innerHTML = cell5.innerHTML+ ' ' +data[0].descripcion;
            })
            //traeme el anio
            fetch('https://localhost:7018/api/Seguros/anio/'+element.idSeguro, {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => response.json())
            .then(data => {
                    cell5.innerHTML = cell5.innerHTML + ' ' + data;
            })
        });
    })
    .catch(error => console.error('Error:', error));
}