using corSeguros.Models;
using corSeguros.Services.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace corSeguros.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SegurosController : Controller
    {
        private readonly ISegurosService _clienteService;
        public SegurosController(ISegurosService clienteService)
        {
            _clienteService = clienteService;
        }
        [HttpPost("Cliente")]
        public IActionResult CreateCliente([FromBody] Cliente cliente)
        {
            try
            {
                var result = _clienteService.CreateCliente(cliente);
                if (result != 0)
                {
                    return Ok(result);
                }
                else
                {
                    return BadRequest();
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("{idCliente}")]
        public IActionResult getByIdCliente(int idCliente)
        {
            try
            {
                var result = _clienteService.getByIdCliente(idCliente);
                if (result != null)
                {
                    if (result.Count > 0)
                    {
                        return Ok(result);
                    }
                    else
                    {
                        return NotFound("No hay ninguna cotizacion con ese cliente");
                    }
                }
                else
                {
                    return NotFound("No hay ninguna cotizacion con ese cliente");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpPost("Cotizacion")]
        public IActionResult CreateCotizacion([FromBody] Cotizacione cotizacione)
        {
            try
            {
                var result = _clienteService.CreateCotizacion(cotizacione);
                if (result == 1)
                {
                    return Ok("La cotizacion se ha creado correctamente");
                }
                else
                {
                    return BadRequest("No se ha podido crear correctamente la cotizacion");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpDelete("{idCliente}")]
        public IActionResult DeleteCliente(int idCliente)
        {
            try
            {
                var result = _clienteService.DeleteCliente(idCliente);
                if (result == 1)
                {
                    return Ok("El cliente se ha eliminado correctamente");
                }
                else
                {
                    return BadRequest("No se ha podido eliminar correctamente el cliente");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpDelete("numCotizacion")]
        public IActionResult DeleteCotizacion(int idCotizacion)
        {
            try
            {
                var result = _clienteService.DeleteCotizacion(idCotizacion);
                if (result == 1)
                {
                    return Ok("La cotizacion se ha eliminado correctamente");
                }
                else
                {
                    return BadRequest("No se ha podido eliminar correctamente la cotizacion");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpPut("Cliente")]
        public IActionResult EditCliente([FromBody] Cliente cliente)
        {
            try
            {
                var result = _clienteService.EditCliente(cliente);
                if (result == 1)
                {
                    return Ok("El cliente se ha editado correctamente");
                }
                else
                {
                    return BadRequest("No se ha podido editar correctamente el cliente");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("login/{email}")]
        public IActionResult getClienteByEmail(string email)
        {
            try
            {
                var result = _clienteService.getClienteByEmail(email);
                if (result != null)
                {
                    return Ok(result);
                }
                else
                {
                    return NotFound("No hay ningun cliente con ese email");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("cliente/{idCliente}")]
        public IActionResult getClienteById(int idCliente)
        {
            try
            {
                var result = _clienteService.getClienteById(idCliente);
                if (result != null)
                {
                    return Ok(result);
                }
                else
                {
                    return NotFound("No hay ningun cliente con ese id");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("marca/{id}")]
        public IActionResult Marca(int id)
        {
            try
            {
                var result = _clienteService.Marca(id);
                if (result != null)
                {
                    return Ok(result);
                }
                else
                {
                    return NotFound("No hay ninguna marca con ese id");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("modelos/{idMarca}")]
        public IActionResult getModelos(int idMarca)
        {
            try
            {
                var result = _clienteService.getModelos(idMarca);
                if (result != null)
                {
                    if (result.Count > 0)
                    {
                        return Ok(result);
                    }
                    else
                    {
                        return NotFound("No hay ningun modelo con esa marca");
                    }
                }
                else
                {
                    return NotFound("No hay ningun modelo con esa marca");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("versiones/{idModelo}")]
        public IActionResult getVersiones(int idModelo)
        {
            try
            {
                var result = _clienteService.getVersiones(idModelo);
                if (result != null)
                {
                    if (result.Count > 0)
                    {
                        return Ok(result);
                    }
                    else
                    {
                        return NotFound("No hay ninguna version con ese modelo");
                    }
                }
                else
                {
                    return NotFound("No hay ninguna version con ese modelo");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("seguros/{idVersion}")]
        public IActionResult getSeguros(int idVersion)
        {
            try
            {
                var result = _clienteService.getSeguros(idVersion);
                if (result != null)
                {
                    if (result.Count > 0)
                    {
                        return Ok(result);
                    }
                    else
                    {
                        return NotFound("No hay ningun seguro con esa version");
                    }
                }
                else
                {
                    return NotFound("No hay ningun seguro con esa version");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
        [HttpGet("anio/{idAnio}")]
        public IActionResult getAnio(int idAnio)
        {
            try
            {
                var result = _clienteService.getAnio(idAnio);
                if (result != 0)
                {
                    return Ok(result);
                }
                else
                {
                    return NotFound("No hay ningun anio con ese id");
                }
            }
            catch (Exception ex)
            {
                return StatusCode(500, ex.Message);
            }
        }
    }
}