<%@ Page Title="Agregar Nuevo Empleado" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeBehind="AgregarEmpleado.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.AgregarEmpleado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

 <div class="d-flex flex-wrap justify-content-between gap-3 mb-5">
 <h1 class="display-5 fw-bolder">Agregar Nuevo Empleado</h1>
 <asp:HyperLink ID="hlVolver" runat="server" NavigateUrl="~/Administradores.aspx" CssClass="btn btn-outline-secondary align-self-start">
 <i class="bi bi-arrow-left me-2"></i> Volver a Administradores
 </asp:HyperLink>
 </div>

 <div class="card shadow-sm border-0">
 <div class="card-body p-4 p-lg-5">
 <div class="vstack gap-5">
 <div>
 <h2 class="h5 fw-bold pb-3 border-bottom mb-4">Información Personal</h2>
 <div class="row g-3">
 <div class="col-md-6">
 <label for="<%= txtNombre.ClientID %>" class="form-label fw-medium">Nombre</label>
 <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control form-control-lg" placeholder="Ingrese el nombre"></asp:TextBox>
 </div>
 <div class="col-md-6">
 <label for="<%= txtApellido.ClientID %>" class="form-label fw-medium">Apellido</label>
 <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control form-control-lg" placeholder="Ingrese el apellido"></asp:TextBox>
 </div>
 <div class="col-md-6">
 <label for="<%= txtDni.ClientID %>" class="form-label fw-medium">DNI</label>
 <asp:TextBox ID="txtDni" runat="server" CssClass="form-control form-control-lg" placeholder="Ingrese DNI sin puntos"></asp:TextBox>
 </div>
 <div class="col-md-6">
 <label for="<%= txtTelefono.ClientID %>" class="form-label fw-medium">Teléfono de Contacto</label>
 <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control form-control-lg" placeholder="Ingrese el número de teléfono" TextMode="Phone"></asp:TextBox>
 </div>
 <div class="col-12">
 <label for="<%= txtEmailContacto.ClientID %>" class="form-label fw-medium">Email de Contacto</label>
 <asp:TextBox ID="txtEmailContacto" runat="server" CssClass="form-control form-control-lg" placeholder="ejemplo@dominio.com" TextMode="Email"></asp:TextBox>
 </div>
 </div>
 </div>

 <div>
 <h2 class="h5 fw-bold pb-3 border-bottom mb-4">Información Laboral y Rol</h2>
 <div class="row g-3">
 <div class="col-md-6">
 <label for="<%= txtLegajo.ClientID %>" class="form-label fw-medium">Legajo / ID Empleado</label>
 <asp:TextBox ID="txtLegajo" runat="server" CssClass="form-control form-control-lg" placeholder="Ingrese el legajo"></asp:TextBox>
 </div>
 <div class="col-md-6">
 <label for="<%= ddlRol.ClientID %>" class="form-label fw-medium">Rol en el Sistema</label>
 <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select form-select-lg">
 <asp:ListItem Text="-- Seleccione Rol --" Value="0" />
 <asp:ListItem Text="Administrador" Value="1" />
 <asp:ListItem Text="Recepcionista" Value="2" />
 <asp:ListItem Text="Médico" Value="3" />
 </asp:DropDownList>
 </div>
 </div>
 </div>

 <div>
 <h2 class="h5 fw-bold pb-3 border-bottom mb-4">Credenciales de Acceso al Sistema</h2>
 <div class="row g-3">
 <div class="col-md-6">
 <label for="<%= txtEmailLogin.ClientID %>" class="form-label fw-medium">Correo Electrónico (Login)</label>
 <asp:TextBox ID="txtEmailLogin" runat="server" CssClass="form-control form-control-lg" placeholder="ejemplo@clinic.com" TextMode="Email"></asp:TextBox>
 </div>
 <div class="col-md-6">
 <label for="<%= txtContrasena.ClientID %>" class="form-label fw-medium">Contraseña</label>
 <asp:TextBox ID="txtContrasena" runat="server" CssClass="form-control form-control-lg" placeholder="Crear una contraseña segura" TextMode="Password"></asp:TextBox>
 </div>
 </div>
 </div>

 </div> 
 <div class="d-flex justify-content-end gap-3 mt-5 pt-4 border-top">
 <a href="~/Administradores.aspx" class="btn btn-secondary btn-lg">Cancelar</a>
 <a href="~/Administradores.aspx" class="btn btn-primary btn-lg fw-bold">Guardar Empleado</a>
 </div>

 </div>
 </div> 

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
</asp:Content>
