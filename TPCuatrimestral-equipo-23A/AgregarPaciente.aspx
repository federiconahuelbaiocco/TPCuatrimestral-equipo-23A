<%@ Page Title="Agregar Nuevo Paciente" Language="C#" MasterPageFile="~/Recepcionista.Master" AutoEventWireup="true" CodeBehind="AgregarPaciente.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.AgregarPaciente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="main-container">
        <div class="mb-4">
            <asp:HyperLink ID="hlVolver" runat="server" NavigateUrl="~/Gestion_de_Pacientes.aspx" CssClass="btn-back">
    <i class="bi bi-arrow-left"></i> Volver
            </asp:HyperLink>
        </div>

        <div class="card border-0 shadow-lg">
            <div class="form-header cyan-gradient">
                <h1>
                    <i class="bi bi-person-plus-fill"></i>
                    Agregar o Editar Paciente
                </h1>
                <p class="mb-0 mt-2 opacity-90">Complete el formulario para registrar un nuevo paciente en el sistema o editar un paciente registrado</p>
            </div>

            <div class="p-4">
                <div class="form-section">
                    <h2>
                        <i class="bi bi-person-vcard cyan-icon"></i>
                        Información Personal
                    </h2>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="<%= txtNombre.ClientID %>" class="form-label">Nombre</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control cyan-focus" placeholder="Ingrese el nombre"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="El nombre es requerido." CssClass="text-danger small" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="revNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="El nombre solo puede contener letras." ValidationExpression="^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$" CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtApellido.ClientID %>" class="form-label">Apellido</label>
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control cyan-focus" placeholder="Ingrese el apellido"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido" ErrorMessage="El apellido es requerido." CssClass="text-danger small" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="revApellido" runat="server" ControlToValidate="txtApellido" ErrorMessage="El apellido solo puede contener letras." ValidationExpression="^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s]+$" CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtDni.ClientID %>" class="form-label">DNI</label>
                            <asp:TextBox ID="txtDni" runat="server" CssClass="form-control cyan-focus" placeholder="Ingrese DNI sin puntos"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvDni" runat="server" ControlToValidate="txtDni" ErrorMessage="El DNI es requerido." CssClass="text-danger small" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="revDni" runat="server" ControlToValidate="txtDni" ErrorMessage="Ingrese solo números." ValidationExpression="^\d+$" CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <label for="<%= ddlSexo %>" class="form-label">Sexo</label>
                            <asp:DropDownList ID="ddlSexo" CssClass="form-select cyan-focus" runat="server">
                                 <asp:ListItem Value="">Seleccione</asp:ListItem>
                                 <asp:ListItem Value="Masculino">Masculino</asp:ListItem>
                                 <asp:ListItem Value="Femenino">Femenino</asp:ListItem>
                                <asp:ListItem Value="No especificado">No especificado</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvSexo" runat="server" ControlToValidate="ddlSexo" ErrorMessage="Debe seleccionar un sexo." InitialValue="" CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtFechaNac.ClientID %>" class="form-label">Fecha de Nacimiento</label>
                            <asp:TextBox ID="txtFechaNac" runat="server" TextMode="Date" CssClass="form-control cyan-focus"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFechaNac" runat="server" ControlToValidate="txtFechaNac" ErrorMessage="La fecha de nacimiento es requerida." CssClass="text-danger small" Display="Dynamic" />
                            <asp:RangeValidator ID="rvFechaNac" runat="server" ControlToValidate="txtFechaNac" ErrorMessage="Fecha inválida." Type="Date" CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtTelefono.ClientID %>" class="form-label">Teléfono</label>
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control cyan-focus" placeholder="Ingrese el teléfono" TextMode="Phone"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" ErrorMessage="El teléfono es requerido." CssClass="text-danger small" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono" ErrorMessage="Ingrese un teléfono válido (solo números)." ValidationExpression="^[0-9\-\s]{7,15}$" CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtEmailContacto.ClientID %>" class="form-label">Email</label>
                            <asp:TextBox ID="txtEmailContacto" runat="server" CssClass="form-control cyan-focus" placeholder="ejemplo@dominio.com" TextMode="Email"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmailContacto" ErrorMessage="El email es requerido." CssClass="text-danger small" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmailContacto" ErrorMessage="Formato de email inválido." ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-6">
                            <label for="<%= ddlCoberturas.ClientID %>" class="form-label">Cobertura Médica</label>
                            <asp:DropDownList ID="ddlCoberturas" CssClass="form-select cyan-focus" runat="server"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvCobertura" runat="server" ControlToValidate="ddlCoberturas" ErrorMessage="Debe seleccionar una cobertura." InitialValue="0" CssClass="text-danger small" Display="Dynamic" />
                        </div>
                    </div>
                </div>

                <div class="form-section">
                    <h2>
                        <i class="bi bi-geo-alt cyan-icon"></i>
                        Domicilio
                    </h2>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="<%= txtCalle.ClientID %>" class="form-label">Calle</label>
                            <asp:TextBox ID="txtCalle" runat="server" CssClass="form-control cyan-focus" placeholder="Nombre de la calle"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCalle" runat="server" ControlToValidate="txtCalle" ErrorMessage="La calle es requerida." CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-3">
                            <label for="<%= txtNumero.ClientID %>" class="form-label">Número</label>
                            <asp:TextBox ID="txtNumero" runat="server" CssClass="form-control cyan-focus" placeholder="1234"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNumero" runat="server" ControlToValidate="txtNumero" ErrorMessage="El número es requerido." CssClass="text-danger small" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="revNumero" runat="server" ControlToValidate="txtNumero" ErrorMessage="Solo números." ValidationExpression="^\d+$" CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-1-5">
                            <label for="<%= txtPiso.ClientID %>" class="form-label">Piso</label>
                            <asp:TextBox ID="txtPiso" runat="server" CssClass="form-control cyan-focus" placeholder="5"></asp:TextBox>
                        </div>
                        <div class="col-md-1-5">
                            <label for="<%= txtDepartamento.ClientID %>" class="form-label">Depto</label>
                            <asp:TextBox ID="txtDepartamento" runat="server" CssClass="form-control cyan-focus" placeholder="B"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label for="<%= txtLocalidad.ClientID %>" class="form-label">Localidad</label>
                            <asp:TextBox ID="txtLocalidad" runat="server" CssClass="form-control cyan-focus" placeholder="Ciudad"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLocalidad" runat="server" ControlToValidate="txtLocalidad" ErrorMessage="La localidad es requerida." CssClass="text-danger small" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="revLocalidad" runat="server" ControlToValidate="txtLocalidad" ErrorMessage="La localidad solo puede contener letras." ValidationExpression="^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s.]+$" CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-4">
                            <label for="<%= txtProvincia.ClientID %>" class="form-label">Provincia</label>
                            <asp:TextBox ID="txtProvincia" runat="server" CssClass="form-control cyan-focus" placeholder="Buenos Aires"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvProvincia" runat="server" ControlToValidate="txtProvincia" ErrorMessage="La provincia es requerida." CssClass="text-danger small" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="revProvincia" runat="server" ControlToValidate="txtProvincia" ErrorMessage="La provincia solo puede contener letras." ValidationExpression="^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s.]+$" CssClass="text-danger small" Display="Dynamic" />
                        </div>
                        <div class="col-md-4">
                            <label for="<%= txtCP.ClientID %>" class="form-label">Código Postal</label>
                            <asp:TextBox ID="txtCP" runat="server" CssClass="form-control cyan-focus" placeholder="1234"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCP" runat="server" ControlToValidate="txtCP" ErrorMessage="El CP es requerido." CssClass="text-danger small" Display="Dynamic" />
                            <asp:RegularExpressionValidator ID="revCP" runat="server" ControlToValidate="txtCP" ErrorMessage="Solo números." ValidationExpression="^\d+$" CssClass="text-danger small" Display="Dynamic" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-actions">
                <asp:HyperLink runat="server" NavigateUrl="~/Gestion_de_Pacientes.aspx" CssClass="btn-cancel">
  <i class="bi bi-x-circle me-2"></i>Cancelar
                </asp:HyperLink>
                <asp:Button ID="btnGuardar" OnClick="btnGuardar_Click" runat="server" Text="Guardar Paciente" CssClass="btn-save cyan-gradient" />
            </div>
        </div>
    </div>
</asp:Content>
