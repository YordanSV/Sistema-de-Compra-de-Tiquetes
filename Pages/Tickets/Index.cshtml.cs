using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using Sistema_de_Compra_de_Tiquetes.Data;
using Sistema_de_Compra_de_Tiquetes.Models;

namespace Sistema_de_Compra_de_Tiquetes.Pages.Tickets
{
    public class IndexModel : PageModel
    {
        private readonly Sistema_de_Compra_de_Tiquetes.Data.Sistema_de_Compra_de_TiquetesContext _context;

        public IndexModel(Sistema_de_Compra_de_Tiquetes.Data.Sistema_de_Compra_de_TiquetesContext context)
        {
            _context = context;
        }

        public IList<Ticket> Ticket { get;set; } = default!;

        public async Task OnGetAsync()
        {
            Ticket = await _context.Ticket.ToListAsync();
        }
    }
}
