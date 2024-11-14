using corSeguros.Models;

namespace corSeguros.Repositories.Interfaces
{
    public interface IVehiculosRepository
    {
        string Marca(int id);
        List<Modelo> getModelos(int idMarca);
        List<Versione> getVersiones(int idModelo);
        int getAnio(int idAnio);
        List<Seguro> getSeguros(int idVersion);
    }
}
