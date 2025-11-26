<%@ Page Title="Mi Perfil" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeBehind="Usuarios.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Usuarios" %>

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
                <asp:Image ID="imgAvatarGrande" runat="server" CssClass="rounded-circle object-fit-cover" Width="96" Height="96" ImageUrl="https://cdn-icons-png.flaticon.com/512/149/149071.png" AlternateText="Avatar" />
            </div>
            <div class="col">
                <h2 class="h5 fw-bold mb-1">
                    <asp:Label ID="lblNombreCompletoTitulo" runat="server" Text="Usuario"></asp:Label>
                </h2>
                <p class="text-primary mb-1">
                    <asp:Label ID="lblRolTitulo" runat="server" Text="Rol"></asp:Label>
                </p>
                <small class="text-muted d-block">ID:
                    <asp:Label ID="lblIdUsuarioTitulo" runat="server" Text=""></asp:Label>
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
                    <div>
                        <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="El nombre es requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                        <asp:RegularExpressionValidator ID="revNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="Solo letras." ValidationExpression="^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$" CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                    </div>
                </div>

                <div class="col-md-6">
                    <label for="<%= txtApellido.ClientID %>" class="form-label fw-medium">Apellido</label>
                    <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control"></asp:TextBox>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido" ErrorMessage="El apellido es requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                        <asp:RegularExpressionValidator ID="revApellido" runat="server" ControlToValidate="txtApellido" ErrorMessage="Solo letras." ValidationExpression="^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$" CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                    </div>
                </div>

                <div class="col-md-6">
                    <label for="<%= txtDni.ClientID %>" class="form-label fw-medium">DNI</label>
                    <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" placeholder="Ingrese su DNI"></asp:TextBox>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvDni" runat="server" ControlToValidate="txtDni" ErrorMessage="El DNI es requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                        <asp:RegularExpressionValidator ID="revDni" runat="server" ControlToValidate="txtDni" ErrorMessage="DNI inválido (7 u 8 dígitos)." ValidationExpression="^\d{7,8}$" CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                    </div>
                </div>

                <div class="col-md-6">
                    <label for="<%= txtFechaNac.ClientID %>" class="form-label fw-medium">Fecha de Nacimiento</label>
                    <asp:TextBox ID="txtFechaNac" runat="server" CssClass="form-control" type="date"></asp:TextBox>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvFechaNac" runat="server" ControlToValidate="txtFechaNac" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                        <asp:CustomValidator ID="cvMayorEdadPerfil" runat="server" ControlToValidate="txtFechaNac" ErrorMessage="Debe ser mayor de 18 años." CssClass="text-danger small" Display="Dynamic" OnServerValidate="cvMayorEdadPerfil_ServerValidate" ValidationGroup="DatosPersonales" />
                    </div>
                </div>

                <div class="col-md-6">
                    <label for="<%= txtTelefono.ClientID %>" class="form-label fw-medium">Teléfono</label>
                    <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ingrese su teléfono"></asp:TextBox>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" ErrorMessage="El teléfono es requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                        <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono" ErrorMessage="Formato inválido (solo números y guiones)." ValidationExpression="^[0-9\-\s]{7,15}$" CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                    </div>
                </div>

                <div class="col-md-6">
                    <label for="<%= ddlSexo.ClientID %>" class="form-label fw-medium">Sexo</label>
                    <asp:DropDownList ID="ddlSexo" runat="server" CssClass="form-select">
                        <asp:ListItem Text="No especificado" Value="No especificado"></asp:ListItem>
                        <asp:ListItem Text="Masculino" Value="Masculino"></asp:ListItem>
                        <asp:ListItem Text="Femenino" Value="Femenino"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-12 mt-2">
                    <h6 class="fw-bold text-secondary border-bottom pb-2">Detalle de Dirección</h6>
                </div>

                <div class="col-md-4">
                    <label for="<%= txtCalle.ClientID %>" class="form-label fw-medium">Calle</label>
                    <asp:TextBox ID="txtCalle" runat="server" CssClass="form-control" placeholder="Calle"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCalle" runat="server" ControlToValidate="txtCalle" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                </div>

                <div class="col-md-2">
                    <label for="<%= txtAltura.ClientID %>" class="form-label fw-medium">Altura</label>
                    <asp:TextBox ID="txtAltura" runat="server" CssClass="form-control" placeholder="Altura"></asp:TextBox>
                    <div>
                        <asp:RequiredFieldValidator ID="rfvAltura" runat="server" ControlToValidate="txtAltura" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                        <asp:RegularExpressionValidator ID="revAltura" runat="server" ControlToValidate="txtAltura" ErrorMessage="Numérico." ValidationExpression="^\d+$" CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                    </div>
                </div>

                <div class="col-md-2">
                    <label for="<%= txtPiso.ClientID %>" class="form-label fw-medium">Piso</label>
                    <asp:TextBox ID="txtPiso" runat="server" CssClass="form-control" placeholder="Piso"></asp:TextBox>
                </div>
                <div class="col-md-2">
                    <label for="<%= txtDepartamento.ClientID %>" class="form-label fw-medium">Depto</label>
                    <asp:TextBox ID="txtDepartamento" runat="server" CssClass="form-control" placeholder="Depto"></asp:TextBox>
                </div>

                <div class="col-md-4">
                    <label for="<%= txtLocalidad.ClientID %>" class="form-label fw-medium">Localidad</label>
                    <asp:TextBox ID="txtLocalidad" runat="server" CssClass="form-control" placeholder="Localidad"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvLocalidad" runat="server" ControlToValidate="txtLocalidad" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                </div>

                <div class="col-md-4">
                    <label for="<%= txtProvincia.ClientID %>" class="form-label fw-medium">Provincia</label>
                    <asp:TextBox ID="txtProvincia" runat="server" CssClass="form-control" placeholder="Provincia"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvProvincia" runat="server" ControlToValidate="txtProvincia" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                </div>

                <div class="col-md-4">
                    <label for="<%= txtCodigoPostal.ClientID %>" class="form-label fw-medium">Código Postal</label>
                    <asp:TextBox ID="txtCodigoPostal" runat="server" CssClass="form-control" placeholder="CP"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvCP" runat="server" ControlToValidate="txtCodigoPostal" ErrorMessage="Requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="DatosPersonales" />
                </div>
            </div>
        </div>

        <div class="card-footer text-end bg-light">
            <asp:Button ID="btnGuardarInfoPersonal" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary fw-bold" OnClick="btnGuardarInfoPersonal_Click" ValidationGroup="DatosPersonales" />
        </div>
    </div>

    <asp:Panel ID="pnlInfoProfesional" runat="server" Visible="false">
        <div class="card shadow-sm mb-4">
            <div class="card-header bg-light border-bottom">
                <h2 class="h5 fw-bold mb-0">Información Profesional</h2>
            </div>
            <div class="card-body p-4">
                <div class="row g-3">
                    <div class="col-md-6">
                        <label for="<%= txtEspecialidad.ClientID %>" class="form-label fw-medium">Especialidad Principal</label>
                        <asp:TextBox ID="txtEspecialidad" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="col-md-6">
                        <label for="<%= txtMatricula.ClientID %>" class="form-label fw-medium">Número de Matrícula</label>
                        <asp:TextBox ID="txtMatricula" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>
            <div class="card-footer text-end bg-light">
                <asp:Button ID="btnGuardarInfoProfesional" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary fw-bold" />
            </div>
        </div>
    </asp:Panel>

</asp:Content>