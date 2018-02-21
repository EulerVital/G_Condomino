using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace G_Condomino.Models
{
    public class Endereco
    {
        public Endereco()
        {
            Cidade = new Cidade();
        }

        [Key]
        public string EnderecoID { get; set; }

        [Display(Name = "Logradouro: ")]
        [Required(ErrorMessage = "Preencha o campo Logradouro.")]
        public string Logradouro { get; set; }

        [Display(Name = "Cep: ")]
        [Required(ErrorMessage = "Preencha o campo CEP.")]
        public string Cep { get; set; }

        [Display(Name = "Descrição: ")]
        public string Descricao { get; set; }
        public Cidade Cidade { get; set; }
        public bool Excluido { get; set; }
    }
}