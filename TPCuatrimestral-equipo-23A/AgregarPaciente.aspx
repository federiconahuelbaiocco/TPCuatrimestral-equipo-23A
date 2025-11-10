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
                        <div class="col-md-6">
                            <label for="<%= txtEmailContacto.ClientID %>" class="form-label fw-medium">Email de Contacto</label>
                            <asp:TextBox ID="txtEmailContacto" runat="server" CssClass="form-control form-control-lg" placeholder="ejemplo@dominio.com" TextMode="Email"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtFechaNac.ClientID %>" class="form-label fw-medium">Fecha de Nacimiento</label>
                            <asp:TextBox ID="txtFechaNac" runat="server" CssClass="form-control form-control-lg" placeholder="1/1/2000" onfocus="mostrarCalendario();"></asp:TextBox>
                            <asp:Calendar ID="Calendar1" runat="server" style="display:none;" onselectionchanged="Calendar1_SelectionChanged"></asp:Calendar>

                            <script type="text/javascript">
                                function mostrarCalendario() {
                                    document.getElementById("<%= Calendar1.ClientID %>").style.display = "block";
                                }
                            </script>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
