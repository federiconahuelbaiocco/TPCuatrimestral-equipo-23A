<%@ Page Title="Mi Calendario" Language="C#" MasterPageFile="~/Medico.Master" AutoEventWireup="true" CodeBehind="CalendarioMaster.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.CalendarioMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="px-4 py-4" style="max-width: 100%; margin: 0 auto;">
<div class="mb-4">
 <h1 class="display-5 fw-bolder">Mi Calendario</h1>
    <p class="text-secondary fs-5">Visualiza y gestiona tus turnos médicos.</p>
     </div>

        <div class="row g-4">
      <div class="col-lg-8">
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-white py-3">
     <div class="d-flex justify-content-between align-items-center">
   <h5 class="mb-0 fw-bold">
  <i class="bi bi-calendar3 me-2"></i>Octubre 2025
          </h5>
   <div class="btn-group" role="group">
     <button class="btn btn-outline-primary btn-sm active">Hoy</button>
             <button class="btn btn-outline-primary btn-sm">Mes</button>
    <button class="btn btn-outline-primary btn-sm">Semana</button>
   <button class="btn btn-outline-primary btn-sm">Día</button>
   </div>
   </div>
   </div>
      <div class="card-body p-0">
     <div class="table-responsive">
   <table class="table table-bordered text-center align-middle mb-0">
     <thead class="bg-light text-secondary text-uppercase small">
   <tr>
       <th class="px-3 py-3">Dom 20</th>
    <th class="px-3 py-3">Lun 21</th>
 <th class="px-3 py-3">Mar 22</th>
           <th class="px-3 py-3 bg-primary text-white">Mié 23</th>
     <th class="px-3 py-3">Jue 24</th>
         <th class="px-3 py-3">Vie 25</th>
 <th class="px-3 py-3">Sáb 26</th>
    </tr>
         </thead>
      <tbody>
 <tr style="height: 150px;">
   <td class="align-top p-2"></td>
     <td class="align-top p-2">
      <div class="bg-danger text-white rounded p-2 small mb-2">
        <strong>10:00</strong><br />
   Turno Cancelado<br />
    <small>Juan Pérez</small>
     </div>
   </td>
      <td class="align-top p-2">
   <div class="bg-warning rounded p-2 small mb-2">
   <strong>11:30</strong><br />
   Pendiente<br />
 <small>Sofía Gómez</small>
      </div>
 </td>
      <td class="align-top p-2 bg-light">
 <div class="bg-success text-white rounded p-2 small mb-2">
        <strong>09:00</strong><br />
   Control<br />
    <small>Carlos Sánchez</small>
     </div>
       <div class="border border-primary text-primary rounded p-2 small mb-2">
 <strong>10:30</strong><br />
 Primera Consulta<br />
 <small>Ana Martínez</small>
   </div>
  <div class="bg-secondary text-white rounded p-2 small">
    <strong>12:00 - 13:00</strong><br />
   No disponible
 </div>
</td>
       <td class="align-top p-2"></td>
     <td class="align-top p-2"></td>
    <td class="align-top p-2"></td>
   </tr>
    </tbody>
    </table>
    </div>
   </div>
  </div>
    <button class="btn btn-primary btn-lg">
   <i class="bi bi-plus-lg me-2"></i>Nuevo Turno
 </button>
  </div>
            <div class="col-lg-4">
    <div class="card shadow-sm">
   <div class="card-header bg-white py-3">
   <h5 class="mb-0 fw-bold">
<i class="bi bi-info-circle me-2"></i>Detalles del Turno
  </h5>
      </div>
           <div class="card-body">
    <div class="text-center mb-4">
  <img src="https://cdn-icons-png.flaticon.com/512/4322/4322991.png" 
     alt="Paciente" 
    class="rounded-circle mb-3" 
          style="width: 100px; height: 100px; object-fit: cover; border: 3px solid #0d6efd;" />
   <h5 class="mb-1 fw-bold">Ana Martínez</h5>
   <p class="text-muted small mb-0">
     <i class="bi bi-credit-card me-1"></i>DNI: 12.345.678
      </p>
    </div>

       <hr />

       <div class="mb-3">
      <h6 class="text-secondary text-uppercase small mb-3 fw-bold">Información del Turno</h6>
           <p class="mb-2">
     <i class="bi bi-calendar-date text-primary me-2"></i>
     <strong>Fecha:</strong> Miércoles, 23 de Octubre
      </p>
    <p class="mb-2">
        <i class="bi bi-clock text-primary me-2"></i>
          <strong>Hora:</strong> 10:30 AM
  </p>
    <p class="mb-2">
 <i class="bi bi-file-medical text-primary me-2"></i>
         <strong>Tipo:</strong> Primera Consulta
   </p>
  <p class="mb-2">
      <i class="bi bi-shield-plus text-primary me-2"></i>
      <strong>Obra Social:</strong> OSDE 310
        </p>
           <p class="mb-0">
         <i class="bi bi-check-circle text-primary me-2"></i>
        <strong>Estado:</strong> 
       <span class="badge bg-success ms-1">Confirmado</span>
        </p>
       </div>

 <div class="d-grid gap-2">
 <button class="btn btn-primary">
   <i class="bi bi-file-medical me-2"></i>Ver Historial Clínico
     </button>
       <div class="row g-2">
      <div class="col-6">
         <button class="btn btn-outline-secondary w-100">
    <i class="bi bi-calendar-x me-1"></i>Reprogramar
       </button>
    </div>
      <div class="col-6">
  <button class="btn btn-outline-danger w-100">
     <i class="bi bi-x-circle me-1"></i>Cancelar
    </button>
     </div>
   </div>
      <button class="btn btn-success">
    <i class="bi bi-check-lg me-2"></i>Marcar como Atendido
      </button>
   </div>
  </div>
        </div>
    </div>
        </div>
    </div>
</asp:Content>
