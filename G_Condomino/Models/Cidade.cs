using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace G_Condomino.Models
{
    public class Cidade
    {
        public Cidade()
        {
            Estado = new Estado();
        }

        public string CidadeID { get; set; }
        public string Nome { get; set; }
        public Estado Estado { get; set; }
    }
}