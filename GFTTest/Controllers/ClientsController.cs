using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using GFTTest.Models;
using PagedList;

namespace GFTTest.Controllers
{
    public class ClientsController : Controller
    {
        private GFTTestEntities db = new GFTTestEntities();

        // GET: Clients
        public ActionResult Index( string currentFilter, string searchString, int? page, int? IdClientTypeFilter)
        {

            var tempLis = new List<Client_Type>() {new Client_Type() {}};
            tempLis.AddRange(db.Client_Type);
            ViewBag.IdClientTypeFilter = new SelectList(tempLis, "Id_Client_Type", "Type_Name");
            
            if (searchString != null)
            {
                page = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            ViewBag.CurrentFilter = searchString;
            IQueryable<Client> pacientes;
            if (!String.IsNullOrEmpty(searchString) && IdClientTypeFilter>0)
            {
                pacientes = db.Clients.Where(s => s.Name.Contains(searchString) && s.Id_Client_Type == IdClientTypeFilter).OrderBy(o => o.Id_Client);
            }
            else if (!String.IsNullOrEmpty(searchString))
            {
                pacientes = db.Clients.Where(s => s.Name.Contains(searchString) ).OrderBy(o => o.Id_Client);
            }
            else if ( IdClientTypeFilter >0)
            {
                pacientes = db.Clients.Where(s => s.Id_Client_Type == IdClientTypeFilter).OrderBy(o => o.Id_Client);
            }

            else
            {
                pacientes = db.Clients.OrderBy(o => o.Id_Client);
            }

            int pageSize = 20;
            int pageNumber = (page ?? 1);
            return View(pacientes.ToPagedList(pageNumber, pageSize));

        }

        // GET: Clients/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Client client = db.Clients.Find(id);
            if (client == null)
            {
                return HttpNotFound();
            }
            return View(client);
        }

        // GET: Clients/Create
        public ActionResult Create()
        {
            ViewBag.Id_Client_Type = new SelectList(db.Client_Type, "Id_Client_Type", "Type_Name");
            return View();
        }

        // POST: Clients/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id_Client,Name,Email,Birth_Date,Id_Client_Type")] Client client)
        {
            if (ModelState.IsValid)
            {
                db.Clients.Add(client);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Id_Client_Type = new SelectList(db.Client_Type, "Id_Client_Type", "Type_Name", client.Id_Client_Type);
            return View(client);
        }

        // GET: Clients/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Client client = db.Clients.Find(id);
            if (client == null)
            {
                return HttpNotFound();
            }
            ViewBag.Id_Client_Type = new SelectList(db.Client_Type, "Id_Client_Type", "Type_Name", client.Id_Client_Type);
            return View(client);
        }

        // POST: Clients/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id_Client,Name,Email,Birth_Date,Id_Client_Type")] Client client)
        {
            if (ModelState.IsValid)
            {
                db.Entry(client).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Id_Client_Type = new SelectList(db.Client_Type, "Id_Client_Type", "Type_Name", client.Id_Client_Type);
            return View(client);
        }

        // GET: Clients/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Client client = db.Clients.Find(id);
            if (client == null)
            {
                return HttpNotFound();
            }
            return View(client);
        }

        // POST: Clients/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Client client = db.Clients.Find(id);
            db.Clients.Remove(client);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
