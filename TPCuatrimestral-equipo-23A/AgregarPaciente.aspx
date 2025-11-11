<%@ Page Title="Agregar Nuevo Paciente" Language="C#" MasterPageFile="~/Recepcionista.Master" AutoEventWireup="true" CodeBehind="AgregarPaciente.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.AgregarPaciente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="d-flex flex-wrap justify-content-between gap-3 mb-5">
        <h1 class="display-5 fw-bolder">Agregar Nuevo Paciente</h1>
        <asp:HyperLink ID="hlVolver" runat="server" NavigateUrl="~/Gestion_de_Pacientes.aspx" CssClass="btn btn-outline-secondary align-self-start">
<i class="bi bi-arrow-left me-2"></i> Volver a Pacientes
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
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control form-control-sm" placeholder="Ingrese el nombre"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtApellido.ClientID %>" class="form-label fw-medium">Apellido</label>
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control form-control-sm" placeholder="Ingrese el apellido"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtDni.ClientID %>" class="form-label fw-medium">DNI</label>
                            <asp:TextBox ID="txtDni" runat="server" CssClass="form-control form-control-sm" placeholder="Ingrese DNI sin puntos"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtTelefono.ClientID %>" class="form-label fw-medium">Teléfono de Contacto</label>
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control form-control-sm" placeholder="Ingrese el número de teléfono" TextMode="Phone"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtEmailContacto.ClientID %>" class="form-label fw-medium">Email de Contacto</label>
                            <asp:TextBox ID="txtEmailContacto" runat="server" CssClass="form-control form-control-sm" placeholder="ejemplo@dominio.com" TextMode="Email"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtFechaNac.ClientID %>" class="form-label fw-medium">Fecha de Nacimiento</label>
                            <asp:TextBox ID="txtFechaNac" runat="server" TextMode="Date" CssClass="form-control form-control-sm"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="<%= ddlCoberturas.ClientID %>" class="form-label fw-medium">Cobertura</label>
                            <asp:DropDownList ID="ddlCoberturas" CssClass="form-select" runat="server"></asp:DropDownList>
                        </div>

                        <div>
                            <h2 class="h5 fw-bold pb-3 border-bottom mb-4">Domicilio</h2>
                            <div class="row g-3">
                                <div class="col-md-4">
                                    <label for="<%= txtCalle.ClientID %>" class="form-label fw-medium">Calle</label>
                                    <asp:TextBox ID="txtCalle" runat="server" CssClass="form-control form-control-sm" placeholder="Calle"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label for="<%= txtNumero.ClientID %>" class="form-label fw-medium">Numero</label>
                                    <asp:TextBox ID="txtNumero" runat="server" CssClass="form-control form-control-sm" placeholder="1111"></asp:TextBox>
                                </div>
                                <div class="col-md-2">
                                    <label for="<%= txtPiso.ClientID %>" class="form-label fw-medium">Piso</label>
                                    <asp:TextBox ID="txtPiso" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                </div>
                                <div class="col-md-2">
                                    <label for="<%= txtDepartamento.ClientID %>" class="form-label fw-medium">Departamento</label>
                                    <asp:TextBox ID="txtDepartamento" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label for="<%= txtLocalidad.ClientID %>" class="form-label fw-medium">Localidad</label>
                                    <asp:TextBox ID="txtLocalidad" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label for="<%= txtProvincia.ClientID %>" class="form-label fw-medium">Provincia</label>
                                    <asp:TextBox ID="txtProvincia" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                </div>
                                <div class="col-md-4">
                                    <label for="<%= txtCP.ClientID %>" class="form-label fw-medium">Codigo Postal</label>
                                    <asp:TextBox ID="txtCP" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
