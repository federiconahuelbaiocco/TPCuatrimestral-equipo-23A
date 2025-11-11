<%@ Page Title="Agregar Nuevo Empleado" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeBehind="AgregarEmpleado.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.AgregarEmpleado" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-container">
        <div class="mb-4">
            <asp:HyperLink ID="hlVolver" runat="server" NavigateUrl="~/Administradores.aspx" CssClass="btn-back">
                <i class="bi bi-arrow-left"></i> Volver
            </asp:HyperLink>
        </div>

        <div class="card border-0 shadow-lg">
            <div class="form-header">
                <h1>
                    <i class="bi bi-person-plus-fill"></i>
                    Agregar Nuevo Empleado
                </h1>
                <p class="mb-0 mt-2 opacity-90">Complete el formulario para registrar un nuevo empleado en el sistema</p>
            </div>

            <div class="p-4">
                <div class="form-section">
                    <h2>
                        <i class="bi bi-person-vcard"></i>
                        Información Personal
                    </h2>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="<%= txtNombre.ClientID %>" class="form-label">Nombre</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" placeholder="Ingrese el nombre"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtApellido.ClientID %>" class="form-label">Apellido</label>
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" placeholder="Ingrese el apellido"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtDni.ClientID %>" class="form-label">DNI</label>
                            <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" placeholder="Ingrese DNI sin puntos"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtTelefono.ClientID %>" class="form-label">Teléfono</label>
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ingrese el teléfono" TextMode="Phone"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label for="<%= txtEmailContacto.ClientID %>" class="form-label">Email de Contacto</label>
                            <asp:TextBox ID="txtEmailContacto" runat="server" CssClass="form-control" placeholder="ejemplo@dominio.com" TextMode="Email"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <h2>
                        <i class="bi bi-briefcase"></i>
                        Información Laboral
                    </h2>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="<%= ddlRol.ClientID %>" class="form-label">Rol en el Sistema</label>
                            <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select">
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <h2>
                        <i class="bi bi-shield-lock"></i>
                        Credenciales de Acceso
                    </h2>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="<%= txtNombreUsuario.ClientID %>" class="form-label">Nombre de Usuario (Login)</label>
                            <asp:TextBox ID="txtNombreUsuario" runat="server" CssClass="form-control" placeholder="ej. jperez"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtContrasena.ClientID %>" class="form-label">Contraseña</label>
                            <asp:TextBox ID="txtContrasena" runat="server" CssClass="form-control" placeholder="Crear una contraseña segura" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <asp:HyperLink runat="server" NavigateUrl="~/Administradores.aspx" CssClass="btn-cancel">
                    <i class="bi bi-x-circle me-2"></i>Cancelar
                </asp:HyperLink>
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Empleado" CssClass="btn-save" OnClick="btnGuardar_Click" />
            </div>
        </div>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
</asp:Content>