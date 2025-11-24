<%@ Page Title="Mi Perfil" Language="C#" MasterPageFile="~/Recepcionista.Master" AutoEventWireup="true" CodeBehind="PerfilRecepcionista.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.PerfilRecepcionista" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="~/styles/styles.css" rel="stylesheet" type="text/css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-3 mb-4"> 
        <h1 class="display-5 fw-bolder">Mi Perfil</h1>
    </div>
    <div class="card shadow-sm p-4 mb-4"> 
        <div class="row g-3 align-items-center">
            <div class="col-auto">
                <asp:Image ID="imgAvatarGrande" runat="server" CssClass="rounded-circle object-fit-cover" Width="96" Height="96" ImageUrl="https://cdn-icons-png.flaticon.com/512/149/149071.png" AlternateText="Avatar"/>
            </div>
            <div class="col">
                <h2 class="h5 fw-bold mb-1">
                    <asp:Label ID="lblNombreCompletoTitulo" runat="server" Text="Recepcionista"></asp:Label>
                </h2>
                <p class="text-primary mb-1">
                     <asp:Label ID="lblRolTitulo" runat="server" Text="Recepcionista"></asp:Label> 
                </p>
                <small class="text-muted d-block">
                    ID: <asp:Label ID="lblIdUsuarioTitulo" runat="server" Text=""></asp:Label>
                </small>
            </div>
        </div>
    </div>
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-light border-bottom">
            <h2 class="h5 fw-bold mb-0">Información Personal</h2>
        </div>
        <div class="card-body p-4">
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="<%= txtNombre.ClientID %>" class="form-label fw-medium">Nombre</label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label for="<%= txtApellido.ClientID %>" class="form-label fw-medium">Apellido</label>
                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label for="<%= txtDni.ClientID %>" class="form-label fw-medium">DNI</label>
                    <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" placeholder="Ingrese su DNI"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label for="<%= txtFechaNac.ClientID %>" class="form-label fw-medium">Fecha de Nacimiento</label>
                    <asp:TextBox ID="txtFechaNac" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                </div>
                <div class="col-md-6">
                     <label for="<%= txtTelefono.ClientID %>" class="form-label fw-medium">Teléfono</label>
                     <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ingrese su teléfono"></asp:TextBox>
                </div>

                <!-- Domicilio: campos separados para mapear al SP -->
                <div class="col-md-6">
                    <label for="<%= txtCalle.ClientID %>" class="form-label fw-medium">Calle</label>
                    <asp:TextBox ID="txtCalle" runat="server" CssClass="form-control" placeholder="Nombre de la calle"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label for="<%= txtAltura.ClientID %>" class="form-label fw-medium">Altura</label>
                    <asp:TextBox ID="txtAltura" runat="server" CssClass="form-control" placeholder="1234"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label for="<%= txtPiso.ClientID %>" class="form-label fw-medium">Piso</label>
                    <asp:TextBox ID="txtPiso" runat="server" CssClass="form-control" placeholder="P. / Nro"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label for="<%= txtDepartamento.ClientID %>" class="form-label fw-medium">Depto</label>
                    <asp:TextBox ID="txtDepartamento" runat="server" CssClass="form-control" placeholder="A / B"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label for="<%= txtLocalidad.ClientID %>" class="form-label fw-medium">Localidad</label>
                    <asp:TextBox ID="txtLocalidad" runat="server" CssClass="form-control" placeholder="Ciudad"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label for="<%= txtProvincia.ClientID %>" class="form-label fw-medium">Provincia</label>
                    <asp:TextBox ID="txtProvincia" runat="server" CssClass="form-control" placeholder="Provincia"></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <label for="<%= txtCodigoPostal.ClientID %>" class="form-label fw-medium">Código Postal</label>
                    <asp:TextBox ID="txtCodigoPostal" runat="server" CssClass="form-control" placeholder="CP"></asp:TextBox>
                </div>
            </div>
        </div>
        <div class="card-footer text-end bg-light">
            <asp:Button ID="btnGuardarInfoPersonal" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary fw-bold" OnClick="btnGuardarInfoPersonal_Click" />
        </div>
    </div>
    <div class="card shadow-sm mb-4">
         <div class="card-header bg-light border-bottom">
            <h2 class="h5 fw-bold mb-0">Seguridad y Acceso</h2>
        </div>
        <div class="card-body p-4 d-flex flex-column gap-3">
            <div class="d-md-flex justify-content-between align-items-center">
                <div>
                    <p class="fw-medium mb-0">Correo Electrónico (Login)</p>
                    <small class="text-muted d-block">
                        <asp:Label ID="lblEmailLogin" runat="server" Text=""></asp:Label> 
                    </small>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
</asp:Content>