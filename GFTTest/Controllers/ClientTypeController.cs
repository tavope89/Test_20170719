using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using GFTTest.Models;

namespace GFTTest.Controllers
{
    public class ClientTypeController : Controller
    {
        private GFTTestEntities db = new GFTTestEntities();

        // GET: ClientType
        public ActionResult Index()
        {
            return View(db.Client_Type.ToList());
        }

        // GET: ClientType/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Client_Type client_Type = db.Client_Type.Find(id);
            if (client_Type == null)
            {
                return HttpNotFound();
            }
            return View(client_Type);
        }

        // GET: ClientType/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: ClientType/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id_Client_Type,Type_Name")] Client_Type client_Type)
        {
            if (ModelState.IsValid)
            {
                db.Client_Type.Add(client_Type);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(client_Type);
        }

        // GET: ClientType/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Client_Type client_Type = db.Client_Type.Find(id);
            if (client_Type == null)
            {
                return HttpNotFound();
            }
            return View(client_Type);
        }

        // POST: ClientType/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id_Client_Type,Type_Name")] Client_Type client_Type)
        {
            if (ModelState.IsValid)
            {
                db.Entry(client_Type).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(client_Type);
        }

        // GET: ClientType/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Client_Type client_Type = db.Client_Type.Find(id);
            if (client_Type == null)
            {
                return HttpNotFound();
            }
            return View(client_Type);
        }

        // POST: ClientType/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Client_Type client_Type = db.Client_Type.Find(id);
            db.Client_Type.Remove(client_Type);
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
