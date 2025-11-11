<%@ Page Title="Panel de Administración" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeBehind="Administradores.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Administradores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <div class="admin-dashboard-layout">
  <div class="dashboard-main-content">
   <div class="mb-4">
  <h1 class="display-5 fw-bolder">Panel de Administración</h1>
          <p class="text-secondary fs-5">Bienvenido, aquí puedes gestionar tu sistema.</p>
      </div>

  <div class="row g-4 mb-4">
    <div class="col-md-4">
    <div class="stats-card admin-card">
  <div class="stats-icon">
 <i class="bi bi-shield-check"></i>
  </div>
     <h3>Administradores</h3>
 <p class="stats-number">
  <asp:Label ID="lblAdminCount" runat="server" Text="0"></asp:Label>
      </p>
 </div>
   </div>
  <div class="col-md-4">
  <div class="stats-card recep-card">
   <div class="stats-icon">
   <i class="bi bi-person-badge"></i>
    </div>
       <h3>Recepcionistas</h3>
<p class="stats-number">
     <asp:Label ID="lblRecepCount" runat="server" Text="0"></asp:Label>
   </p>
  </div>
     </div>
<div class="col-md-4">
       <div class="stats-card medico-card">
     <div class="stats-icon">
 <i class="bi bi-heart-pulse"></i>
        </div>
<h3>Médicos</h3>
 <p class="stats-number">
    <asp:Label ID="lblMedicoCount" runat="server" Text="0"></asp:Label>
    </p>
</div>
    </div>
 </div>

<div class="activity-section">
            <div class="activity-card">
                <h2>
                    <i class="bi bi-people-fill"></i>
                    Lista de Usuarios
                </h2>

                <div class="row g-3 p-3 align-items-end">
                    <div class="col-md-4">
                        <label for="<%= ddlRoles.ClientID %>" class="form-label fw-medium">Filtrar por Rol</label>
                        <asp:DropDownList ID="ddlRoles" runat="server" 
                            CssClass="form-select form-select-lg"
                            AutoPostBack="true" 
                            OnSelectedIndexChanged="ddlRoles_SelectedIndexChanged">
                        </asp:DropDownList>
                    </div>
                </div>

                <div class="card shadow-sm overflow-hidden mt-3">
                    <asp:GridView ID="gvUsuariosRol" runat="server"
                    CssClass="table table-hover mb-0"
                    AutoGenerateColumns="False"
                    GridLines="None"
                    DataKeyNames="Usuario.IdUsuario"
                    OnRowCommand="gvUsuariosRol_RowCommand"
                    >
                    <HeaderStyle CssClass="bg-light text-secondary text-uppercase small" />
                    <Columns>
                        <asp:TemplateField HeaderText="Nombre Completo" HeaderStyle-CssClass="px-4 py-3">
                            <ItemTemplate>
                                <span class="fw-medium text-dark"><%# Eval("Apellido") %>, <%# Eval("Nombre") %></span>
                            </ItemTemplate>
                            <ItemStyle CssClass="px-4 py-3 align-middle" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Dni" HeaderText="DNI" ItemStyle-CssClass="px-4 py-3 align-middle" HeaderStyle-CssClass="px-4 py-3"/>
                        
                        <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="text-end px-4 py-3 align-middle" HeaderStyle-CssClass="text-end px-4 py-3">
                            <ItemTemplate>
                                <div class="d-inline-flex gap-2">
                                    <asp:LinkButton ID="btnEditar" runat="server"
                                        CssClass="btn btn-sm btn-outline-primary"
                                        CommandName="Editar"
                                        CommandArgument='<%# Eval("Usuario.IdUsuario") %>'
                                        ToolTip="Editar">
                                        <i class="bi bi-pencil-fill"></i>
                                    </asp:LinkButton>
                                    <asp:LinkButton ID="btnEliminar" runat="server"
                                        CssClass="btn btn-sm btn-outline-danger"
                                        CommandName="Eliminar"
                                        CommandArgument='<%# Eval("Usuario.IdUsuario") %>'
                                        OnClientClick="return confirm('¿Está seguro de que quiere eliminar este usuario?');"
                                        ToolTip="Eliminar">
                                        <i class="bi bi-trash-fill"></i>
                                    </asp:LinkButton>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <div class="text-center p-5">No hay usuarios para el rol seleccionado.</div>
                    </EmptyDataTemplate>
                </asp:GridView>
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
 <asp:HyperLink ID="hlNuevoEmpleado" runat="server" NavigateUrl="~/AgregarEmpleado.aspx" CssClass="quick-access-link primary-link">
   <i class="bi bi-person-plus-fill"></i>
   <span>Nuevo Empleado</span>
   <i class="bi bi-arrow-right"></i>
      </asp:HyperLink>
  
    <asp:HyperLink ID="hlEspecialidades" runat="server" NavigateUrl="~/Especialidades.aspx" CssClass="quick-access-link info-link">
        <i class="bi bi-star-fill"></i>
    <span>Añadir Especialidad</span>
  <i class="bi bi-arrow-right"></i>
 </asp:HyperLink>
         
     <asp:HyperLink ID="hlConsultorios" runat="server" NavigateUrl="~/Consultorios.aspx" CssClass="quick-access-link warning-link">
      <i class="bi bi-building"></i>
    <span>Gestionar Consultorios</span>
      <i class="bi bi-arrow-right"></i>
      </asp:HyperLink>
   
  <asp:HyperLink ID="hlConfiguracion" runat="server" NavigateUrl="~/Configuraciones.aspx" CssClass="quick-access-link settings-link">
   <i class="bi bi-gear-fill"></i>
 <span>Configuración</span>
 <i class="bi bi-arrow-right"></i>
 </asp:HyperLink>
     </div>

     <div class="info-section">
    <h4>
     <i class="bi bi-info-circle-fill"></i>
   Tips
     </h4>
 <p>Usa estos accesos rápidos para gestionar las áreas principales del sistema de forma eficiente.</p>
       </div>
        </div>
    </aside>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
</asp:Content>
