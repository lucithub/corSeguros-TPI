using corSeguros.Models;
using Microsoft.EntityFrameworkCore.Metadata;

namespace corSeguros.Services.Repositories
{
    public interface ISegurosService
    {
        int CreateCliente(Cliente cliente);
        List<Cotizacione> getByIdCliente(int idCliente);
        int CreateCotizacion(Cotizacione cotizacione);
        int DeleteCliente(int idCliente);
        int DeleteCotizacion(int idCotizacion);
        int EditCliente(Cliente cliente);
        Cliente getClienteByEmail(string email);
        Cliente getClienteById(int idCliente);
        string Marca(int id);
        List<Modelo> getModelos(int idMarca);
        List<Versione> getVersiones(int idModelo);
        List<Seguro> getSeguros(int idVersion);
        int getAnio(int idAnio);
    }
}
