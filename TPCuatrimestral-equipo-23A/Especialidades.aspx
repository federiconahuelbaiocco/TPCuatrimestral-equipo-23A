<%@ Page Title="Gestión de Especialidades" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Especialidades.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Especialidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="especialidad-layout">
<div class="especialidad-main-content">
      <header class="mb-4">
   <h1 class="display-5 fw-bolder">Gestionar Especialidades</h1>
    </header>

<div class="mb-4 p-4 bg-white rounded shadow-sm border">
         <h2 class="h5 fw-bold mb-3">Añadir Nueva Especialidad</h2>
   
    <div class="row g-3 align-items-end">
   <div class="col-sm">
 <label for="<%= txtNombreEspecialidad.ClientID %>" class="form-label fw-medium">Nombre de la especialidad</label>
<asp:TextBox ID="txtNombreEspecialidad" runat="server" CssClass="form-control form-control-lg" placeholder="Ej. Cardiología"></asp:TextBox>
     </div>
   <div class="col-sm-auto">
      <asp:Button ID="btnAgregarEspecialidad" runat="server" Text="➕ Agregar" CssClass="btn btn-primary btn-lg fw-bold px-4" OnClick="btnAgregarEspecialidad_Click" />
   </div>
 </div>
  </div>
   
     <div>
          <h3 class="h5 fw-bold mb-3">Especialidades Actuales</h3>
   <div class="card shadow-sm overflow-hidden">
  
 <asp:GridView ID="gvEspecialidades" runat="server" 
CssClass="table table-hover mb-0" 
 AutoGenerateColumns="False" 
        GridLines="None"
  DataKeyNames="IdEspecialidad"
    OnRowCommand="gvEspecialidades_RowCommand"
      OnRowDeleting="gvEspecialidades_RowDeleting">
      <HeaderStyle CssClass="bg-light text-secondary text-uppercase small" />
  <Columns>
      <asp:BoundField DataField="IdEspecialidad" HeaderText="ID" ItemStyle-CssClass="px-4 py-3 align-middle" HeaderStyle-CssClass="px-4 py-3"/>
    
   <asp:TemplateField HeaderText="Nombre de la Especialidad" HeaderStyle-CssClass="px-4 py-3">
     <ItemTemplate>
     <span class="fw-medium text-dark"><%# Eval("Descripcion") %></span>
       </ItemTemplate>
           <ItemStyle CssClass="px-4 py-3 align-middle" />
   </asp:TemplateField>

     <asp:TemplateField HeaderText="Estado" HeaderStyle-CssClass="px-4 py-3">
      <ItemTemplate>
    <%# (bool)Eval("Activo") ? "<span class='badge bg-success'>Activo</span>" : "<span class='badge bg-secondary'>Inactivo</span>" %>
    </ItemTemplate>
  <ItemStyle CssClass="px-4 py-3 align-middle" />
  </asp:TemplateField>

     <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="text-end px-4 py-3 align-middle" HeaderStyle-CssClass="text-end px-4 py-3">
 <ItemTemplate>
     <div class="d-inline-flex gap-2">
   <button type="button" class="btn btn-sm btn-outline-primary" 
       onclick='cargarEspecialidad(<%# Eval("IdEspecialidad") %>, "<%# Eval("Descripcion") %>", <%# Eval("Activo").ToString().ToLower() %>)'
       title="Editar">
   <i class="bi bi-pencil-fill"></i>
</button>
     <asp:LinkButton ID="btnEliminar" runat="server" 
  CssClass="btn btn-sm btn-outline-danger" 
     CommandName="EliminarEsp" 
     CommandArgument='<%# Eval("IdEspecialidad") %>'
     OnClientClick="return confirm('¿Estás seguro de que quieres eliminar esta especialidad?');"
 ToolTip="Eliminar">
      <i class="bi bi-trash-fill"></i>
    </asp:LinkButton>
     </div>
    </ItemTemplate>
    </asp:TemplateField>
   </Columns>
      <EmptyDataTemplate>
     <div class="text-center p-5">No hay especialidades cargadas.</div>
 </EmptyDataTemplate>
</asp:GridView>
    </div>
    </div>
     </div>
    </div>

    <div class="sidebar-panel-fixed">
 <div class="sidebar-panel-header">
 <h3>
        <i class="bi bi-pencil-square"></i>
<span id="sidebarTitulo">Editar Especialidad</span>
  </h3>
        </div>

   <div class="sidebar-panel-body">
    <asp:HiddenField ID="hfEspecialidadId" runat="server" />

   <div id="estadoVacio" class="sidebar-empty-state">
      <i class="bi bi-arrow-left-circle" style="font-size: 4rem; color: #cbd5e0;"></i>
    <p class="text-muted mt-3 mb-0">Selecciona una especialidad de la lista para editarla</p>
     </div>

   <div id="formularioEdicion" class="sidebar-form-edit" style="display: none;">
  <div class="sidebar-form-group">
 <label class="sidebar-label">Nombre de la Especialidad </label>
  <asp:TextBox ID="txtNombreEditar" runat="server" CssClass="sidebar-input" placeholder="Ej. Cardiología"></asp:TextBox>
   </div>

 <div class="sidebar-form-group">
  <label class="sidebar-label">Estado de la Especialidad</label>
  <div class="toggle-switch-container">
     <div class="toggle-switch-wrapper">
     <span class="toggle-label" id="sidebarStatusText">Especialidad Activa</span>
         <label class="toggle-switch">
         <asp:CheckBox ID="chkActivoEditar" runat="server" onclick="actualizarEstadoSidebar(this)" />
   <span class="toggle-slider"></span>
   </label>
       </div>
        <div id="sidebarStatusMessage" class="sidebar-status-message text-muted">
  <i class="bi bi-info-circle"></i>
    <span id="sidebarStatusDescription">Una especialidad activa puede ser asignada a médicos</span>
</div>
</div>
        </div>

    <div class="sidebar-actions">
<asp:Button ID="btnGuardarEdicion" runat="server" Text=" GUARDAR CAMBIOS" CssClass="sidebar-btn-save w-100 mb-2" OnClick="btnGuardarEdicion_Click" />
         <button type="button" class="sidebar-btn-cancel w-100" onclick="limpiarFormulario()"> LIMPIAR</button>
    </div>
   </div>
  </div>
 </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
    <script src="~/scripts_js/especialidades.js"  rel="stylesheet" type="text/javascript"></script>
    <script src="~/scripts_js/consultorios.js"  rel="stylesheet" type="text/javascript"></script>
</asp:Content>
