using corSeguros.Models;
using corSeguros.Repositories.Interfaces;

namespace corSeguros.Repositories.Implementations
{
    public class CotizacionesRepository : ICotizacionesRepository
    {
        private readonly BBDDAseguradoraContext _context;
        public CotizacionesRepository(BBDDAseguradoraContext context)
        {
            _context = context;
        }
        public List<Cotizacione> getByIdCliente(int idCliente)
        {
            if (idCliente != null)
            {
                return _context.Cotizaciones.Where(c => c.IdCliente == idCliente).ToList();
            }
            else
            {
                return null;
            }
            
        }
        public int Create(Cotizacione cotizacione)
        {
            if (cotizacione.FechaEmision != null && cotizacione.FechaVenc != null && cotizacione.IdCliente != null && cotizacione.IdCodPostal != null && cotizacione.IdSeguro != null & cotizacione.IdSucursal != null && cotizacione.Precio != null)
            {
                if (cotizacione.FechaEmision >= DateTime.Today && cotizacione.FechaVenc > DateTime.Today && cotizacione.FechaVenc > cotizacione.FechaEmision)
                {
                    _context.Cotizaciones.Add(cotizacione);
                    _context.SaveChanges();
                    return 1;
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return 0;
            }
        }
        public int Delete(int idCotizacion)
        {
            if (idCotizacion != null)
            {
                Cotizacione cotizacione = _context.Cotizaciones.Find(idCotizacion);
                if (cotizacione != null)
                {
                    _context.Cotizaciones.Remove(cotizacione);
                    _context.SaveChanges();
                    return 1;
                }
                else
                {
                    return 0;
                }
            }
            else
            {
                return 0;
            }
        }
    }
}
