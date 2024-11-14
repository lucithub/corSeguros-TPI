using corSeguros.Models;

namespace corSeguros.Repositories.Interfaces
{
    public interface ICotizacionesRepository
    {
        List<Cotizacione> getByIdCliente(int idCliente);
        int Create(Cotizacione cotizacione);
        int Delete(int idCotizacion);
    }
}