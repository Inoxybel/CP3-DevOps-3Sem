using System.Web.Mvc;

namespace AppMvc.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Checkpoint 3 - DevOps";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "RM92900";

            return View();
        }
    }
}