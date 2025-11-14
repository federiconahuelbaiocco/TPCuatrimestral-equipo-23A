<%@ Page Title="Panel Médico" Language="C#" MasterPageFile="~/Medico.Master" AutoEventWireup="true" CodeBehind="Medico.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Medico1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-dashboard-layout">
        <div class="dashboard-main-content">
            <div class="mb-4">
    <h1 class="display-5 fw-bolder">Panel Médico</h1>
                <p class="text-secondary fs-5">Bienvenido, Dr. Gregory House. Aquí puedes gestionar tus consultas y pacientes.</p>
    </div>

         <div class="row g-4 mb-4">
        <div class="col-md-4">
  <div class="stats-card admin-card">
            <div class="stats-icon">
   <i class="bi bi-calendar-check"></i>
        </div>
            <h3>Turnos Hoy</h3>
    <p class="stats-number">8</p>
          </div>
   </div>
       <div class="col-md-4">
        <div class="stats-card recep-card">
           <div class="stats-icon">
     <i class="bi bi-people-fill"></i>
         </div>
          <h3>Mis Pacientes</h3>
                   <p class="stats-number">142</p>
       </div>
        </div>
                <div class="col-md-4">
      <div class="stats-card medico-card">
    <div class="stats-icon">
    <i class="bi bi-clock-history"></i>
  </div>
         <h3>Turnos Pendientes</h3>
        <p class="stats-number">3</p>
 </div>
        </div>
     </div>

            <div class="activity-section">
     <div class="activity-card">
            <h2>
   <i class="bi bi-calendar3"></i>
      Próximos Turnos del Día
         </h2>

            <div class="card shadow-sm overflow-hidden mt-3">
             <table class="table table-hover mb-0">
  <thead class="bg-light text-secondary text-uppercase small">
     <tr>
             <th class="px-4 py-3">Hora</th>
 <th class="px-4 py-3">Paciente</th>
    <th class="px-4 py-3">Tipo de Consulta</th>
        <th class="px-4 py-3">Estado</th>
     <th class="px-4 py-3 text-end">Acciones</th>
    </tr>
           </thead>
       <tbody>
          <tr>
    <td class="px-4 py-3 align-middle">09:00</td>
             <td class="px-4 py-3 align-middle">
          <span class="fw-medium text-dark">Carlos Sánchez</span>
               </td>
      <td class="px-4 py-3 align-middle">Control</td>
           <td class="px-4 py-3 align-middle">
     <span class="badge rounded-pill text-bg-success">Confirmado</span>
       </td>
   <td class="px-4 py-3 align-middle text-end">
          <div class="d-inline-flex gap-2">
         <button class="btn btn-sm btn-outline-primary" title="Ver Historial">
      <i class="bi bi-file-medical"></i>
              </button>
   <button class="btn btn-sm btn-outline-success" title="Atender">
        <i class="bi bi-check-circle"></i>
      </button>
           </div>
       </td>
         </tr>
  <tr>
             <td class="px-4 py-3 align-middle">10:30</td>
        <td class="px-4 py-3 align-middle">
   <span class="fw-medium text-dark">Ana Martínez</span>
      </td>
     <td class="px-4 py-3 align-middle">Primera Consulta</td>
        <td class="px-4 py-3 align-middle">
           <span class="badge rounded-pill text-bg-primary">Confirmado</span>
     </td>
           <td class="px-4 py-3 align-middle text-end">
          <div class="d-inline-flex gap-2">
 <button class="btn btn-sm btn-outline-primary" title="Ver Historial">
     <i class="bi bi-file-medical"></i>
 </button>
     <button class="btn btn-sm btn-outline-success" title="Atender">
    <i class="bi bi-check-circle"></i>
           </button>
        </div>
         </td>
       </tr>
                <tr>
      <td class="px-4 py-3 align-middle">14:00</td>
      <td class="px-4 py-3 align-middle">
   <span class="fw-medium text-dark">Luis Fernández</span>
       </td>
     <td class="px-4 py-3 align-middle">Seguimiento</td>
           <td class="px-4 py-3 align-middle">
     <span class="badge rounded-pill text-bg-warning">Pendiente</span>
      </td>
         <td class="px-4 py-3 align-middle text-end">
       <div class="d-inline-flex gap-2">
           <button class="btn btn-sm btn-outline-primary" title="Ver Historial">
          <i class="bi bi-file-medical"></i>
  </button>
            <button class="btn btn-sm btn-outline-success" title="Atender">
         <i class="bi bi-check-circle"></i>
          </button>
         </div>
      </td>
              </tr>
        </tbody>
                 </table>
    </div>
             </div>
            </div>
    </div>
    </div>

    <aside class="quick-access-sidebar-fixed">
   <div class="quick-access-header">
        <h3>
       <i class="bi bi-lightning-charge-fill"></i>
        Accesos Rápidos
       </h3>
        </div>

     <div class="quick-access-body">
          <div class="quick-access-links">
    <asp:HyperLink ID="hlCalendario" runat="server" NavigateUrl="~/CalendarioMaster.aspx" CssClass="quick-access-link primary-link">
         <i class="bi bi-calendar3-fill"></i>
      <span>Mi Calendario</span>
          <i class="bi bi-arrow-right"></i>
       </asp:HyperLink>

        <asp:HyperLink ID="hlMisPacientes" runat="server" NavigateUrl="#" CssClass="quick-access-link info-link">
        <i class="bi bi-people-fill"></i>
            <span>Mis Pacientes</span>
  <i class="bi bi-arrow-right"></i>
       </asp:HyperLink>

          <asp:HyperLink ID="hlHistoriales" runat="server" NavigateUrl="#" CssClass="quick-access-link warning-link">
       <i class="bi bi-file-medical-fill"></i>
            <span>Historiales Clínicos</span>
         <i class="bi bi-arrow-right"></i>
             </asp:HyperLink>

  <asp:HyperLink ID="hlPerfil" runat="server" NavigateUrl="~/PerfilMedico.aspx" CssClass="quick-access-link settings-link">
       <i class="bi bi-person-circle"></i>
        <span>Mi Perfil</span>
        <i class="bi bi-arrow-right"></i>
    </asp:HyperLink>
            </div>

  <div class="info-section">
<h4>
      <i class="bi bi-info-circle-fill"></i>
   Tips
    </h4>
     <p>Usa estos accesos rápidos para gestionar tus consultas, pacientes e historiales clínicos de forma eficiente.</p>
            </div>
        </div>
    </aside>
</asp:Content>
