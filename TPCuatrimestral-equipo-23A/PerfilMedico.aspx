<%@ Page Title="Mi Perfil" Language="C#" MasterPageFile="~/Medico.Master" AutoEventWireup="true" CodeBehind="PerfilMedico.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.PerfilMedico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-4 perfil-medico">
        <div class="mb-4">
        <h1 class="display-5 fw-bolder">Mi Perfil</h1>
<p class="text-secondary fs-5">Gestiona tu información personal y profesional.</p>
   </div>

        <div class="card mb-4 shadow-sm">
            <div class="card-body d-flex align-items-center justify-content-between">
      <div class="d-flex align-items-center">
           <img src="https://tn.com.ar/resizer/v2/el-personaje-principal-de-dr-house-fue-interpretado-por-hugh-laurie-LVF5W4HM6PT3TXAMIKX6QOD7GQ.jpg?auth=87f2ec18b0a61e2febc986cb3c6780799f76f48eb42f8fd61dd67bd8ba6b03b8&width=1440" 
           alt="Foto de perfil" class="rounded-circle me-3" style="width: 100px; height: 100px; object-fit: cover;" />
  <div>
            <h4 class="mb-1 fw-bold">Dr. Gregory House</h4>
          <p class="text-muted mb-1">Médico Nefrólogo</p>
        <small class="text-secondary"><i class="bi bi-award me-1"></i>Matrícula: MN12345</small>
        </div>
         </div>
                <button type="button" class="btn btn-outline-primary">
           <i class="bi bi-camera"></i> Cambiar Foto
   </button>
            </div>
        </div>

 <div class="row g-4">
            <div class="col-lg-6">
                <div class="card shadow-sm h-100">
        <div class="card-header bg-white py-3">
               <h5 class="mb-0 fw-bold">
            <i class="bi bi-person-vcard me-2"></i>Información Personal
      </h5>
        </div>
   <div class="card-body">
         <div class="row g-3">
    <div class="col-md-6">
 <label class="form-label fw-medium">Nombre</label>
               <input type="text" class="form-control" value="Gregory" disabled />
          </div>
<div class="col-md-6">
   <label class="form-label fw-medium">Apellido</label>
         <input type="text" class="form-control" value="House" disabled />
        </div>
           <div class="col-md-6">
   <label class="form-label fw-medium">DNI</label>
    <input type="text" class="form-control" value="12345678" disabled />
          </div>
       <div class="col-md-6">
         <label class="form-label fw-medium">Fecha de Nacimiento</label>
    <input type="date" class="form-control" value="1985-06-10" disabled />
       </div>
            <div class="col-md-6">
    <label class="form-label fw-medium">Teléfono</label>
       <input type="text" class="form-control" value="1122334455" disabled />
      </div>
        <div class="col-md-6">
             <label class="form-label fw-medium">Email</label>
       <input type="email" class="form-control" value="g.house@hospital.com" disabled />
    </div>
 <div class="col-12">
      <label class="form-label fw-medium">Dirección</label>
      <input type="text" class="form-control" value="Av. Siempre Viva 742" disabled />
      </div>
    <div class="col-12 text-end">
          <button type="button" class="btn btn-primary">
     <i class="bi bi-save me-1"></i> Guardar Cambios
          </button>
 </div>
      </div>
            </div>
   </div>
            </div>

   <div class="col-lg-6">
            <div class="card shadow-sm mb-4">
            <div class="card-header bg-white py-3">
                <h5 class="mb-0 fw-bold">
         <i class="bi bi-briefcase me-2"></i>Información Profesional
         </h5>
           </div>
   <div class="card-body">
              <div class="row g-3">
     <div class="col-md-6">
    <label class="form-label fw-medium">Especialidad</label>
       <input type="text" class="form-control" value="Nefrología" disabled />
     </div>
        <div class="col-md-6">
             <label class="form-label fw-medium">Número de Matrícula</label>
       <input type="text" class="form-control" value="MN 12345" disabled />
 </div>
               <div class="col-12 text-end">
       <button type="button" class="btn btn-primary">
           <i class="bi bi-save me-1"></i> Guardar Cambios
     </button>
         </div>
       </div>
      </div>
          </div>

       <div class="card shadow-sm">
            <div class="card-header bg-white py-3">
          <h5 class="mb-0 fw-bold">
   <i class="bi bi-shield-lock me-2"></i>Seguridad y Acceso
              </h5>
          </div>
          <div class="card-body">
          <div class="row g-3">
   <div class="col-12">
            <label class="form-label fw-medium">Correo Electrónico</label>
            <input type="email" class="form-control" value="g.house@hospital.com" disabled />
           </div>
          <div class="col-12">
         <label class="form-label fw-medium">Contraseña</label>
           <input type="password" class="form-control" value="********" disabled />
         </div>
                     <div class="col-12 text-end">
      <button type="button" class="btn btn-secondary">
    <i class="bi bi-key me-1"></i> Cambiar Contraseña
      </button>
         </div>
  </div>
      </div>
            </div>
  </div>
        </div>

    <div class="card shadow-sm mt-4">
            <div class="card-header bg-white py-3">
        <h5 class="mb-0 fw-bold">
  <i class="bi bi-gear me-2"></i>Preferencias
         </h5>
    </div>
      <div class="card-body">
  <div class="row g-3">
      <div class="col-md-4">
      <div class="form-check form-switch">
 <input class="form-check-input" type="checkbox" id="notifEmail" checked disabled />
        <label class="form-check-label" for="notifEmail">
            Recibir notificaciones por correo
                </label>
                 </div>
         </div>
        <div class="col-md-4">
               <div class="form-check form-switch">
           <input class="form-check-input" type="checkbox" id="darkMode" disabled />
         <label class="form-check-label" for="darkMode">
              Activar tema oscuro
   </label>
            </div>
          </div>
   <div class="col-md-4">
          <label class="form-label fw-medium">Idioma</label>
 <select class="form-select" disabled>
       <option selected>Español</option>
               <option>Inglés</option>
    </select>
           </div>
         </div>
   </div>
        </div>
    </div>
</asp:Content>
