using corSeguros.Models;

namespace corSeguros.Repositories.Interfaces
{
    public interface IClienteRepository
    {
        int Create(Cliente cliente);
        int Delete(int idCliente);
        int Update(Cliente cliente);
        Cliente getByEmail(string email);
        Cliente getById(int idCliente);
    }
}
