using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.Rendering;
using Sistema_de_Compra_de_Tiquetes.Data;
using Sistema_de_Compra_de_Tiquetes.Models;

namespace Sistema_de_Compra_de_Tiquetes.Pages.Tickets
{
    public class CreateModel : PageModel
    {
        private readonly Sistema_de_Compra_de_Tiquetes.Data.Sistema_de_Compra_de_TiquetesContext _context;

        public CreateModel(Sistema_de_Compra_de_Tiquetes.Data.Sistema_de_Compra_de_TiquetesContext context)
        {
            _context = context;
        }

        public IActionResult OnGet()
        {
            return Page();
        }

        [BindProperty]
        public Ticket Ticket { get; set; } = default!;

        // For more information, see https://aka.ms/RazorPagesCRUD.
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            _context.Ticket.Add(Ticket);
            await _context.SaveChangesAsync();

            return RedirectToPage("./Index");
        }
    }
}
