using corSeguros.Models;
using corSeguros.Repositories.Interfaces;
using corSeguros.Services.Repositories;
using System.Runtime.InteropServices;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace corSeguros.Services.Implementations
{
    public class SegurosService : ISegurosService
    {
        private readonly IClienteRepository _clienteRepository;
        private readonly ICotizacionesRepository _cotizacionesRepository;
        private readonly IVehiculosRepository _vehiculosRepository;
        public SegurosService(IClienteRepository clienteRepository, ICotizacionesRepository cotizacionesRepository, IVehiculosRepository vehiculosRepository)
        {
            _clienteRepository = clienteRepository;
            _cotizacionesRepository = cotizacionesRepository;
            _vehiculosRepository = vehiculosRepository;
        }
        public int CreateCliente(Cliente cliente)
        {
            return _clienteRepository.Create(cliente);
        }

        public List<Cotizacione> getByIdCliente(int idCliente)
        {
            return _cotizacionesRepository.getByIdCliente(idCliente);
        }
        public int CreateCotizacion(Cotizacione cotizacione)
        {
            return _cotizacionesRepository.Create(cotizacione);
        }
        public int DeleteCliente(int idCliente)
        {
            return _clienteRepository.Delete(idCliente);
        }
        public int DeleteCotizacion(int idCotizacion)
        {
            return _cotizacionesRepository.Delete(idCotizacion);
        }
        public int EditCliente(Cliente cliente)
        {
            return _clienteRepository.Update(cliente);
        }
        public Cliente getClienteByEmail(string email)
        {
            return _clienteRepository.getByEmail(email);
        }
        public Cliente getClienteById(int idCliente)
        {
            return _clienteRepository.getById(idCliente);
        }
        public string Marca(int id)
        {
            return _vehiculosRepository.Marca(id);
        }
        public List<Modelo> getModelos(int idMarca)
        {
            return _vehiculosRepository.getModelos(idMarca);
        }
        public List<Versione> getVersiones(int idModelo)
        {
            return _vehiculosRepository.getVersiones(idModelo);
        }
        public List<Seguro> getSeguros(int idVersion)
        {
            return _vehiculosRepository.getSeguros(idVersion);
        }
        public int getAnio(int idAnio)
        {
            return _vehiculosRepository.getAnio(idAnio);
        }
    }
}
