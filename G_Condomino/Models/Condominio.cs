using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace G_Condomino.Models
{
    public class Condominio
    {
        public Condominio()
        {
            Endereco = new Endereco();
        }

        [Key]
        public string CondominioID { get; set; }

        [Display(Name = "Nome do Condominio: ")]
        [Required]
        public string Nome { get; set; }
        public Endereco Endereco { get; set; }

        [Display(Name = "Tipo Condômino: ")]
        [Required]
        public string TipoCondominio { get; set; }
        public string Excluido { get; set; }
    }
}