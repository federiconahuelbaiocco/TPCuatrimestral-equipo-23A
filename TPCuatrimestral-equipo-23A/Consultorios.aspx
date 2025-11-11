<%@ Page Title="Gestión de Consultorios" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Consultorios.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Consultorios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="consultorio-layout">
        <div class="consultorio-main-content">
       <header class="mb-4">
      <h1 class="display-5 fw-bolder">Gestionar Consultorios</h1>
     </header>

   <div class="mb-4 p-4 bg-white rounded shadow-sm border">
     <h2 class="h5 fw-bold mb-3">Añadir Nuevo Consultorio</h2>
  
  <div class="row g-3 align-items-end">
   <div class="col-sm">
     <label for="<%= txtNombreConsultorio.ClientID %>" class="form-label fw-medium">Nombre del consultorio</label>
 <asp:TextBox ID="txtNombreConsultorio" runat="server" CssClass="form-control form-control-lg" placeholder="Ej. Sala de Rayos X"></asp:TextBox>
  </div>
   <div class="col-sm-auto">
   <asp:Button ID="btnAgregarConsultorio" runat="server" Text="➕ Agregar" CssClass="btn btn-primary btn-lg fw-bold px-4" OnClick="btnAgregarConsultorio_Click" />
   </div>
  </div>
  </div>
       
    <div>
        <h3 class="h5 fw-bold mb-3">Consultorios Actuales</h3>
  <div class="card shadow-sm overflow-hidden">
       
     <asp:GridView ID="gvConsultorios" runat="server" CssClass="table table-hover mb-0" AutoGenerateColumns="False" GridLines="None" DataKeyNames="IdConsultorio" OnRowCommand="gvConsultorios_RowCommand" OnRowDeleting="gvConsultorios_RowDeleting">
   <HeaderStyle CssClass="bg-light text-secondary text-uppercase small" />
     <Columns>
    <asp:BoundField DataField="IdConsultorio" HeaderText="ID" ItemStyle-CssClass="px-4 py-3 align-middle" HeaderStyle-CssClass="px-4 py-3"/>
  
    <asp:TemplateField HeaderText="Nombre del Consultorio" HeaderStyle-CssClass="px-4 py-3">
 <ItemTemplate>
        <span class="fw-medium text-dark"><%# Eval("Nombre") %></span>
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
  onclick='cargarConsultorio(<%# Eval("IdConsultorio") %>, "<%# Eval("Nombre") %>", <%# Eval("Activo").ToString().ToLower() %>)'
   title="Editar">
        <i class="bi bi-pencil-fill"></i>
             </button>
       <asp:LinkButton ID="btnEliminar" runat="server" CssClass="btn btn-sm btn-outline-danger" 
    CommandName="Eliminar" CommandArgument='<%# Eval("IdConsultorio") %>' 
         OnClientClick="return confirm('¿Está seguro de que quiere eliminar este consultorio?');" 
   ToolTip="Eliminar">
      <i class="bi bi-trash-fill"></i>
     </asp:LinkButton>
  </div>
   </ItemTemplate>
   </asp:TemplateField>
  </Columns>
  <EmptyDataTemplate>
<div class="text-center p-5">No hay consultorios cargados.</div>
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
      <span id="sidebarTitulo">Editar Consultorio</span>
     </h3>
</div>

   <div class="sidebar-panel-body">
  <asp:HiddenField ID="hfConsultorioId" runat="server" />

 <div id="estadoVacio" class="sidebar-empty-state">
    <i class="bi bi-arrow-left-circle" style="font-size: 4rem; color: #cbd5e0;"></i>
 <p class="text-muted mt-3 mb-0">Selecciona un consultorio de la lista para editarlo</p>
      </div>

     <div id="formularioEdicion" class="sidebar-form-edit" style="display: none;">
 <div class="sidebar-form-group">
<label class="sidebar-label">Nombre del Consultorio</label>
 <asp:TextBox ID="txtNombreEditar" runat="server" CssClass="sidebar-input" placeholder="Ej. Consultorio 1"></asp:TextBox>
     </div>

   <div class="sidebar-form-group">
   <label class="sidebar-label">Estado del Consultorio</label>
          <div class="toggle-switch-container">
 <div class="toggle-switch-wrapper">
          <span class="toggle-label" id="sidebarStatusText">Consultorio Activo</span>
     <label class="toggle-switch">
 <asp:CheckBox ID="chkActivoEditar" runat="server" onclick="actualizarEstadoSidebar(this)" />
      <span class="toggle-slider"></span>
      </label>
     </div>
        <div id="sidebarStatusMessage" class="sidebar-status-message text-muted">
         <i class="bi bi-info-circle"></i>
 <span id="sidebarStatusDescription">Un consultorio activo puede recibir turnos y asignaciones</span>
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
    <script type="text/javascript">
  function cargarConsultorio(id, nombre, activo) {
         document.getElementById('estadoVacio').style.display = 'none';
   document.getElementById('formularioEdicion').style.display = 'block';
     
  document.getElementById('<%= hfConsultorioId.ClientID %>').value = id;
  document.getElementById('<%= txtNombreEditar.ClientID %>').value = nombre;
      document.getElementById('<%= chkActivoEditar.ClientID %>').checked = activo;
   
 document.getElementById('sidebarTitulo').textContent = 'Editar: ' + nombre;
     
   actualizarEstadoSidebar(document.getElementById('<%= chkActivoEditar.ClientID %>'));

console.log('Consultorio cargado - ID:', id, 'Nombre:', nombre, 'Activo:', activo);
  }

    function limpiarFormulario() {
 document.getElementById('estadoVacio').style.display = 'flex';
       document.getElementById('formularioEdicion').style.display = 'none';
  
  document.getElementById('<%= hfConsultorioId.ClientID %>').value = '';
     document.getElementById('<%= txtNombreEditar.ClientID %>').value = '';
    document.getElementById('<%= chkActivoEditar.ClientID %>').checked = false;

     document.getElementById('sidebarTitulo').textContent = 'Editar Consultorio';
  
     console.log('Formulario limpiado');
    }

   function actualizarEstadoSidebar(checkbox) {
 var statusText = document.getElementById('sidebarStatusText');
     var statusDescription = document.getElementById('sidebarStatusDescription');
 var statusMessage = document.getElementById('sidebarStatusMessage');
  
 if (checkbox.checked) {
     statusText.textContent = 'Consultorio Activo';
statusDescription.textContent = 'Un consultorio activo puede recibir turnos y asignaciones';
   statusMessage.className = 'sidebar-status-message text-success';
       } else {
    statusText.textContent = 'Consultorio Inactivo';
  statusDescription.textContent = 'Un consultorio inactivo no recibirá turnos ni asignaciones';
   statusMessage.className = 'sidebar-status-message text-danger';
 }
     }
 </script>
</asp:Content>
