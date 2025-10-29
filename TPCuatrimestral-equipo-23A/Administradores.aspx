<%@ Page Title="Panel de Administración" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeBehind="Administradores.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Administradores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <div class="mb-5">
 <h1 class="display-5 fw-bolder">Panel de Administración</h1>
 <p class="text-secondary fs-5">Bienvenido, aquí puedes gestionar tu sistema.</p>
 </div>

 <div class="row g-4 mb-5">
 <div class="col-lg-8">
 <div class="row g-4">
 <div class="col-sm-4">
 <div class="card shadow-sm h-100">
 <div class="card-body">
 <h3 class="card-subtitle mb-2 text-muted">Administradores</h3>
 <p class="card-text fs-2 fw-bold mt-2">
 <asp:Label ID="lblAdminCount" runat="server" Text="0"></asp:Label>
 </p>
 </div>
 </div>
 </div>
 <div class="col-sm-4">
 <div class="card shadow-sm h-100">
 <div class="card-body">
 <h3 class="card-subtitle mb-2 text-muted">Recepcionistas</h3>
 <p class="card-text fs-2 fw-bold mt-2">
 <asp:Label ID="lblRecepCount" runat="server" Text="0"></asp:Label>
 </p>
 </div>
 </div>
 </div>
 <div class="col-sm-4">
 <div class="card shadow-sm h-100">
 <div class="card-body">
 <h3 class="card-subtitle mb-2 text-muted">Médicos</h3>
 <p class="card-text fs-2 fw-bold mt-2">
 <asp:Label ID="lblMedicoCount" runat="server" Text="0"></asp:Label>
 </p>
 </div>
 </div>
 </div>
 </div>
 </div>

 <div class="col-lg-4">
 <div class="card shadow-sm h-100">
 <div class="card-body d-flex flex-column justify-content-center">
 <h3 class="card-title fw-bold mb-4">Accesos Rápidos</h3>
 <div class="d-grid gap-3">
 <asp:HyperLink ID="hlNuevoEmpleado" runat="server" NavigateUrl="~/AgregarEmpleado.aspx" CssClass="btn btn-primary fw-semibold py-3">Nuevo Empleado</asp:HyperLink>
 <asp:HyperLink ID="hlEspecialidades" runat="server" NavigateUrl="~/Especialidades.aspx" CssClass="btn btn-info fw-semibold py-3">Añadir Especialidad</asp:HyperLink>
 </div>
 </div>
 </div>
 </div>
 </div>

 <div>
 <h2 class="h4 fw-bold mb-4">Actividad Reciente</h2>
 <div class="card shadow-sm overflow-hidden">
 <div class="text-center p-5">No hay actividad reciente para mostrar.</div>
 </div>
 </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
</asp:Content>