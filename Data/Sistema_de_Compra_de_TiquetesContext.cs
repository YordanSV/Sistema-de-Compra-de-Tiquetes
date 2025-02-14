using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Sistema_de_Compra_de_Tiquetes.Models;

namespace Sistema_de_Compra_de_Tiquetes.Data
{
    public class Sistema_de_Compra_de_TiquetesContext : DbContext
    {
        public Sistema_de_Compra_de_TiquetesContext (DbContextOptions<Sistema_de_Compra_de_TiquetesContext> options)
            : base(options)
        {
        }

        public DbSet<Sistema_de_Compra_de_Tiquetes.Models.Ticket> Ticket { get; set; } = default!;
    }
}
