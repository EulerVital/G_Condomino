using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(G_Condomino.Startup))]
namespace G_Condomino
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
