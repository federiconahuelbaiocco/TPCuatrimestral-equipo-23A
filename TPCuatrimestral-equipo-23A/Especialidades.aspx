<%@ Page Title="Gestión de Especialidades" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Especialidades.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Especialidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .admin-layout .main-content {
 margin-right: 480px !important;
     }

    .sidebar-panel-fixed {
       position: fixed !important;
   top: 0 !important;
     right: 0 !important;
  width: 480px !important;
      height: 100vh !important;
   z-index: 1000 !important;
            background: white;
  border-left: 1px solid #e2e8f0;
            box-shadow: -4px 0 20px rgba(0, 0, 0, 0.08);
  display: flex !important;
     flex-direction: column !important;
}

     .sidebar-panel-header {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    padding: 2rem 2rem;
            color: white;
   flex-shrink: 0;
 box-shadow: 0 4px 12px rgba(102, 126, 234, 0.2);
}

.sidebar-panel-header h3 {
    margin: 0;
         font-size: 1.4rem;
   font-weight: 700;
  display: flex;
      align-items: center;
        gap: 0.875rem;
    letter-spacing: -0.02em;
   }

        .sidebar-panel-header h3 i {
    font-size: 1.6rem;
       opacity: 0.95;
        }

        .sidebar-panel-body {
         padding: 2.5rem 2rem;
  overflow-y: auto;
     flex: 1;
background: #fafbfc;
 }

     .sidebar-empty-state {
    display: flex;
  flex-direction: column;
      align-items: center;
         justify-content: center;
      min-height: 350px;
     padding: 3rem 2rem;
     text-align: center;
   background: white;
       border-radius: 16px;
border: 2px dashed #e2e8f0;
      margin: 1rem 0;
        }

 .sidebar-empty-state i {
   animation: pulse 2s ease-in-out infinite;
     }

        @keyframes pulse {
          0%, 100% { opacity: 0.4; transform: scale(1); }
    50% { opacity: 0.7; transform: scale(1.05); }
     }

  .sidebar-empty-state p {
   font-size: 1rem;
    line-height: 1.6;
  color: #64748b;
      max-width: 280px;
  }

        .sidebar-form-edit {
        background: white;
border-radius: 16px;
  padding: 2rem;
   box-shadow: 0 2px 12px rgba(0, 0, 0, 0.04);
}

   .sidebar-form-group {
      margin-bottom: 2rem;
        }

      .sidebar-label {
            display: flex;
    align-items: center;
     gap: 0.5rem;
   font-weight: 700;
   color: #334155;
   margin-bottom: 0.875rem;
         font-size: 0.875rem;
       text-transform: uppercase;
  letter-spacing: 0.8px;
  }

      .sidebar-label i {
  font-size: 1.1rem;
       color: #667eea;
      }

     .sidebar-input {
    width: 100%;
         border: 2px solid #e2e8f0;
  border-radius: 12px;
     padding: 1rem 1.25rem;
     font-size: 1.05rem;
  transition: all 0.3s ease;
       background: #fafbfc;
 font-weight: 500;
   }

  .sidebar-input:hover {
 border-color: #cbd5e0;
     background: white;
  }

  .sidebar-input:focus {
            border-color: #667eea;
 outline: none;
        box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.12);
      background: white;
}

        .toggle-switch-container {
     background: linear-gradient(135deg, #f8fafc 0%, #eef2f6 100%);
  padding: 1.5rem;
    border-radius: 14px;
         border: 2px solid #e2e8f0;
      transition: all 0.3s ease;
   }

      .toggle-switch-container:hover {
       background: linear-gradient(135deg, #eef2f6 0%, #e2e8f0 100%);
     border-color: #cbd5e0;
 transform: translateY(-1px);
   box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
   }

  .toggle-switch-wrapper {
            display: flex;
        align-items: center;
     justify-content: space-between;
       margin-bottom: 1rem;
        }

        .toggle-label {
  font-weight: 600;
    color: #1e293b;
     font-size: 1.2rem;
      }

  .toggle-switch {
  position: relative;
  display: inline-block;
     width: 60px;
     height: 32px;
        }

   .toggle-switch input {
    opacity: 0;
      width: 0;
    height: 0;
 }

   .toggle-slider {
   position: absolute;
  cursor: pointer;
          top: 0;
    left: 0;
    right: 0;
       bottom: 0;
    background-color: #cbd5e1;
 transition: 0.4s;
      border-radius: 34px;
   }

   .toggle-slider:before {
    position: absolute;
  content: "";
  height: 24px;
 width: 24px;
   left: 4px;
        bottom: 4px;
      background-color: white;
transition: 0.4s;
          border-radius: 50%;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
}

     input:checked + .toggle-slider {
            background-color: #667eea;
      }

        input:checked + .toggle-slider:before {
     transform: translateX(28px);
        }

   .toggle-slider:hover {
      box-shadow: 0 0 8px rgba(102, 126, 234, 0.3);
        }

  .sidebar-status-message {
 margin-top: 0;
      padding: 1rem 1.25rem;
    font-size: 1.05rem;
     line-height: 1.6;
  transition: all 0.3s ease;
   border-radius: 10px;
   background: rgba(255, 255, 255, 0.5);
    }

  .sidebar-status-message i {
   font-size: 1.1rem;
     vertical-align: middle;
  margin-right: 0.5rem;
  }

   .sidebar-status-message.text-success {
         background: rgba(16, 185, 129, 0.15);
     color: #059669;
border-left: 4px solid #10b981;
         font-weight: 600;
    }

    .sidebar-status-message.text-danger {
    background: rgba(239, 68, 68, 0.15);
          color: #dc2626;
  border-left: 4px solid #ef4444;
         font-weight: 600;
        }

   .sidebar-actions {
    margin-top: 2.5rem;
        padding-top: 2rem;
          border-top: 2px solid #e5e7eb;
   display: flex;
     flex-direction: column;
       gap: 0.875rem;
        }

    .sidebar-btn-save {
         background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  border: none;
    border-radius: 12px;
   padding: 1.125rem 1.5rem;
      font-weight: 700;
    font-size: 1.05rem;
        color: white;
     cursor: pointer;
       transition: all 0.3s ease;
 box-shadow: 0 4px 14px rgba(102, 126, 234, 0.35);
      text-transform: uppercase;
     letter-spacing: 0.5px;
        }

        .sidebar-btn-save:hover {
transform: translateY(-3px);
     box-shadow: 0 8px 20px rgba(102, 126, 234, 0.45);
       background: linear-gradient(135deg, #7c8ff5 0%, #8b5cb8 100%);
     }

   .sidebar-btn-save:active {
   transform: translateY(-1px);
}

  .sidebar-btn-cancel {
      background: white;
 border: 2px solid #d1d5db;
 border-radius: 12px;
    padding: 1.125rem 1.5rem;
       font-weight: 600;
      font-size: 1.05rem;
       color: #6b7280;
      cursor: pointer;
      transition: all 0.3s ease;
            text-transform: uppercase;
      letter-spacing: 0.5px;
      }

        .sidebar-btn-cancel:hover {
  background: #f9fafb;
        border-color: #9ca3af;
        color: #374151;
  transform: translateY(-2px);
 box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
     }

   .sidebar-btn-cancel:active {
  transform: translateY(0);
  }

   .sidebar-panel-body::-webkit-scrollbar {
    width: 8px;
        }

.sidebar-panel-body::-webkit-scrollbar-track {
     background: #f1f5f9;
     }

      .sidebar-panel-body::-webkit-scrollbar-thumb {
     background: #cbd5e1;
    border-radius: 10px;
        }

        .sidebar-panel-body::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }

@media (max-width: 1399px) {
      .admin-layout .main-content {
  margin-right: 0 !important;
  }
 
      .sidebar-panel-fixed {
   position: relative !important;
   width: 100% !important;
          height: auto !important;
     margin-top: 2rem;
 }
        }
 </style>
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
<script type="text/javascript">
  function cargarEspecialidad(id, descripcion, activo) {
      document.getElementById('estadoVacio').style.display = 'none';
       document.getElementById('formularioEdicion').style.display = 'block';
          
   document.getElementById('<%= hfEspecialidadId.ClientID %>').value = id;
document.getElementById('<%= txtNombreEditar.ClientID %>').value = descripcion;
        document.getElementById('<%= chkActivoEditar.ClientID %>').checked = activo;
 
        document.getElementById('sidebarTitulo').textContent = 'Editar: ' + descripcion;
   
            actualizarEstadoSidebar(document.getElementById('<%= chkActivoEditar.ClientID %>'));

      console.log('Especialidad cargada - ID:', id, 'Descripción:', descripcion, 'Activo:', activo);
        }

   function limpiarFormulario() {
  document.getElementById('estadoVacio').style.display = 'flex';
       document.getElementById('formularioEdicion').style.display = 'none';
         
    document.getElementById('<%= hfEspecialidadId.ClientID %>').value = '';
     document.getElementById('<%= txtNombreEditar.ClientID %>').value = '';
            document.getElementById('<%= chkActivoEditar.ClientID %>').checked = false;

   document.getElementById('sidebarTitulo').textContent = 'Editar Especialidad';
   
       console.log('Formulario limpiado');
}

        function actualizarEstadoSidebar(checkbox) {
  var statusText = document.getElementById('sidebarStatusText');
var statusDescription = document.getElementById('sidebarStatusDescription');
   var statusMessage = document.getElementById('sidebarStatusMessage');
    
      if (checkbox.checked) {
    statusText.textContent = 'Especialidad Activa';
 statusDescription.textContent = 'Una especialidad activa puede ser asignada a médicos';
      statusMessage.className = 'sidebar-status-message text-success';
          } else {
    statusText.textContent = 'Especialidad Inactiva';
   statusDescription.textContent = 'Una especialidad inactiva no podrá ser asignada a médicos';
        statusMessage.className = 'sidebar-status-message text-danger';
   }
        }
 </script>
</asp:Content>
