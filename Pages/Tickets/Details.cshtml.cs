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
    public class DetailsModel : PageModel
    {
        private readonly Sistema_de_Compra_de_Tiquetes.Data.Sistema_de_Compra_de_TiquetesContext _context;

        public DetailsModel(Sistema_de_Compra_de_Tiquetes.Data.Sistema_de_Compra_de_TiquetesContext context)
        {
            _context = context;
        }

        public Ticket Ticket { get; set; } = default!;

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var ticket = await _context.Ticket.FirstOrDefaultAsync(m => m.Id == id);

            if (ticket is not null)
            {
                Ticket = ticket;

                return Page();
            }

            return NotFound();
        }
    }
}
