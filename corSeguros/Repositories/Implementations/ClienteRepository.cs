using corSeguros.Models;
using corSeguros.Repositories.Interfaces;

namespace corSeguros.Repositories.Implementations
{
    public class ClienteRepository : IClienteRepository
    {
        private readonly BBDDAseguradoraContext _context;
        public ClienteRepository(BBDDAseguradoraContext context)
        {
            _context = context;   
        }
        public int Create(Cliente cliente)
        {
            if (cliente.Apellido != null && cliente.Telefono != null && cliente.Nombre != null && cliente.Mail != null)
            {
                _context.Clientes.Add(cliente);
                _context.SaveChanges();
                return cliente.IdCliente;
            }
            else
            {
                return 0;
            }
            
        }
        public int Delete(int idCliente)
        {
            if (idCliente != null)
            {
                Cliente cliente = _context.Clientes.Find(idCliente);
                if (cliente != null)
                {
                    _context.Clientes.Remove(cliente);
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
        public int Update(Cliente cliente)
        {
            if (cliente.Apellido != null && cliente.Telefono != null && cliente.Nombre != null && cliente.Mail != null)
            {
                Cliente clienteToUpdate = _context.Clientes.Find(cliente.IdCliente);
                if (clienteToUpdate != null)
                {
                    clienteToUpdate.Apellido = cliente.Apellido;
                    clienteToUpdate.Nombre = cliente.Nombre;
                    clienteToUpdate.Telefono = cliente.Telefono;
                    clienteToUpdate.Mail = cliente.Mail;
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
        public Cliente getByEmail(string email)
        {
            Cliente cliente = _context.Clientes.Where(c => c.Mail == email).First();
            Cliente clientef = _context.Clientes.Find(cliente.IdCliente);
            if (clientef != null)
            {
                return clientef;
            }
            else
            {
                return null;
            }
        }
        public Cliente getById(int idCliente)
        {
            Cliente cliente = _context.Clientes.Find(idCliente);
            if (cliente != null)
            {
                return cliente;
            }
            else
            {
                return null;
            }
        }
    }
}
