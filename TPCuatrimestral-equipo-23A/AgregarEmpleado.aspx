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
                    <asp:Literal ID="litTitulo" runat="server" Text="Agregar Nuevo Empleado"></asp:Literal>
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
                            <label for="<%= ddlSexo.ClientID %>" class="form-label">Sexo</label>
                            <asp:DropDownList ID="ddlSexo" CssClass="form-select cyan-focus" runat="server">
                                <asp:ListItem Value="">Seleccione</asp:ListItem>
                                <asp:ListItem Value="Masculino">Masculino</asp:ListItem>
                                <asp:ListItem Value="Femenino">Femenino</asp:ListItem>
                                <asp:ListItem Value="No especificado">No especificado</asp:ListItem>
                            </asp:DropDownList>
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
                        <i class="bi bi-geo-alt cyan-icon"></i>
                        Domicilio
                    </h2>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label for="<%= txtCalle.ClientID %>" class="form-label">Calle</label>
                            <asp:TextBox ID="txtCalle" runat="server" CssClass="form-control cyan-focus" placeholder="Nombre de la calle"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <label for="<%= txtNumero.ClientID %>" class="form-label">Número</label>
                            <asp:TextBox ID="txtNumero" runat="server" CssClass="form-control cyan-focus" placeholder="1234"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label for="<%= txtPiso.ClientID %>" class="form-label">Piso</label>
                            <asp:TextBox ID="txtPiso" runat="server" CssClass="form-control cyan-focus" placeholder="5"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label for="<%= txtDepartamento.ClientID %>" class="form-label">Depto</label>
                            <asp:TextBox ID="txtDepartamento" runat="server" CssClass="form-control cyan-focus" placeholder="B"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label for="<%= txtCP.ClientID %>" class="form-label">Código Postal</label>
                            <asp:TextBox ID="txtCP" runat="server" CssClass="form-control cyan-focus" placeholder="1234"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtLocalidad.ClientID %>" class="form-label">Localidad</label>
                            <asp:TextBox ID="txtLocalidad" runat="server" CssClass="form-control cyan-focus" placeholder="Ciudad"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="<%= txtProvincia.ClientID %>" class="form-label">Provincia</label>
                            <asp:TextBox ID="txtProvincia" runat="server" CssClass="form-control cyan-focus" placeholder="Buenos Aires"></asp:TextBox>
                        </div>
                    </div>
                </div>

                <asp:UpdatePanel ID="updPanelLaboral" runat="server">
                    <ContentTemplate>

                        <div class="form-section">
                            <h2>
                                <i class="bi bi-briefcase"></i>
                                Información Laboral
                            </h2>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label for="<%= ddlRol.ClientID %>" class="form-label">Rol en el Sistema</label>
                                    <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select" 
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlRol_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <asp:Panel ID="Panel1" runat="server" Visible="false">
                            <div class="form-section">
                                <h2>
                                    <i class="bi bi-briefcase"></i>
                                    Datos del Médico
                                </h2>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label for="<%=txtMatricula.ClientID %>" class="form-label">Matricula</label>
                                        <asp:TextBox ID="txtMatricula" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label">Especialidad</label>
                                        <asp:CheckBoxList ID="chkEspecialidades" runat="server" CssClass="table table-borderless"
                                            RepeatDirection="Horizontal"
                                            RepeatLayout="Table"
                                            RepeatColumns="3">
                                        </asp:CheckBoxList>
                                    </div>
                                    <hr />
                                    <div class="form-group">
                                        <label class="form-label">Horario de trabajo</label>
                                        <div class="row g-3">
                                            <div class="col-md-4">
                                                <asp:Label Text="Día:" runat="server" />
                                                <asp:DropDownList ID="ddlDia" runat="server" CssClass="form-select">
                                                    <asp:ListItem Text="Lunes" Value="1" />
                                                    <asp:ListItem Text="Martes" Value="2" />
                                                    <asp:ListItem Text="Miercoles" Value="3" />
                                                    <asp:ListItem Text="Jueves" Value="4" />
                                                    <asp:ListItem Text="Viernes" Value="5" />
                                                    <asp:ListItem Text="Sabado" Value="6" />
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-md-4">
                                                <asp:Label Text="Desde:" runat="server" />
                                                <asp:DropDownList ID="ddlDesde" runat="server" CssClass="form-select"></asp:DropDownList>
                                            </div>
                                            <div class="col-md-4">
                                                <asp:Label Text="Hasta:" runat="server" />
                                                <asp:DropDownList ID="ddlHasta" runat="server" CssClass="form-select"></asp:DropDownList>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="d-flex justify-content-end">
                                            <asp:Button ID="btnAgregarHorario" runat="server"
                                                Text="Agregar Horario"
                                                CssClass="btn btn-secondary" OnClick="btnAgregarHorario_Click" />
                                        </div>
                                        <asp:Label ID="lblErrorHorario" runat="server" ForeColor="Red" />
                                    </div>
                                    <hr />
                                    <h5>Horarios de Trabajo Cargados</h5>
                                    <asp:GridView ID="gvHorarios" runat="server" AutoGenerateColumns="true"
                                        EmptyDataText="Aún no se han agregado horarios para este médico."
                                        CssClass="table table-bordered" />
                                    <br />
                                </div>
                            </div>
                        </asp:Panel>

                    </ContentTemplate>
                </asp:UpdatePanel>
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
                            <asp:Label ID="lblAvisoClave" runat="server" CssClass="form-text" Text="Dejar en blanco para no modificar la contraseña actual." Visible="false"></asp:Label>
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
