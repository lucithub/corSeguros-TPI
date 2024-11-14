using corSeguros.Models;
using corSeguros.Repositories.Interfaces;

namespace corSeguros.Repositories.Implementations
{
    public class VehiculosRepository : IVehiculosRepository
    {
        private readonly BBDDAseguradoraContext _context;

        public VehiculosRepository(BBDDAseguradoraContext context)
        {
            _context = context;
        }

        public int getAnio(int idAnio)
        {
            var anio = _context.Anios.Find(idAnio);
            if (anio != null)
            {
                return anio.Año;
            }
            return 0;
        }

        public List<Modelo> getModelos(int idMarca)
        {
            var modelos = _context.Modelos
                .Where(m => m.IdMarca == idMarca)
                .ToList();
            return modelos;
        }

        public List<Seguro> getSeguros(int idVersion)
        {
            var seguros = _context.Seguros
                .Where(s => s.IdVersion == idVersion)
                .ToList();
            return seguros;
        }

        public List<Versione> getVersiones(int idModelo)
        {
            var versiones = _context.Versiones
                .Where(v => v.IdModelo == idModelo)
                .ToList();
            return versiones;
        }

        public string Marca(int id)
        {
            var marca = _context.Marcas.Find(id);
            return marca.Nombre;
        }
    }
}
