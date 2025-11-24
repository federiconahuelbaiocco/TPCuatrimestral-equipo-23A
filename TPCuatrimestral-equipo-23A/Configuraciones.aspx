<%@ Page Title="Configuración del Sistema" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeBehind="Configuraciones.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Configuraciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            -webkit-transition: .4s;
            transition: .4s;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 16px;
            width: 16px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            -webkit-transition: .4s;
            transition: .4s;
        }

        input:checked + .slider {
            background-color: #2196F3;
        }

        input:focus + .slider {
            box-shadow: 0 0 1px #2196F3;
        }

        input:checked + .slider:before {
            -webkit-transform: translateX(26px);
            -ms-transform: translateX(26px);
            transform: translateX(26px);
        }

        .slider.round {
            border-radius: 34px;
        }

        .slider.round:before {
            border-radius: 50%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-dashboard-layout">
        <div class="dashboard-main-content">
            <div class="mb-4">
                <h1 class="display-5 fw-bolder">Configuración del Sistema</h1>
                <p class="text-secondary fs-5 mt-2">Gestiona las configuraciones globales del sistema.</p>
            </div>

            <div class="card shadow-sm mb-4">
                <div class="card-header bg-light border-bottom">
                    <h2 class="h5 fw-bold mb-0">Gestión de Usuarios</h2>
                </div>
                <div class="card-body p-4">
                    <asp:GridView ID="gvUsuarios" runat="server" AutoGenerateColumns="False"
                        CssClass="table table-hover align-middle"
                        DataKeyNames="IdUsuario" OnRowDataBound="gvUsuarios_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="Persona.IdPersona" HeaderText="ID Persona" />
                            <asp:BoundField DataField="Persona.Nombre" HeaderText="Nombre" />
                            <asp:BoundField DataField="Persona.Apellido" HeaderText="Apellido" />
                            <asp:BoundField DataField="Persona.Dni" HeaderText="DNI" />
                            <asp:BoundField DataField="Rol.Nombre" HeaderText="Rol" />
                            <asp:TemplateField HeaderText="Estado">
                                <ItemTemplate>
                                    <asp:Label ID="lblEstado" runat="server"
                                        CssClass='<%# (bool)Eval("Activo") ? "badge bg-success" : "badge bg-danger" %>'
                                        Text='<%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Act/Desact">
                                <ItemTemplate>
                                    <label class="switch">
                                        <asp:CheckBox ID="chkActivo" runat="server" />
                                        <span class="slider round"></span>
                                    </label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
                <div class="card-footer text-end bg-light">
                    <asp:Button ID="btnGuardarEstadosUsuarios" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary" OnClick="btnGuardarEstadosUsuarios_Click" ValidationGroup="Usuarios" />
                </div>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-12">
                    <div class="card shadow-sm overflow-hidden">
                        <div class="card-body p-4">
                            <h2 class="card-title h5 fw-bold mb-1">Horarios Predeterminados</h2>
                            <p class="card-subtitle text-muted mb-4">Establece los días laborables, horarios y duración de los turnos para la clínica.</p>

                            <div class="row g-4">
                                <div class="col-md-6">
                                    <p class="fw-medium mb-3">Días Laborables</p>
                                    <div class="d-flex flex-column">
                                        <asp:CheckBoxList ID="cblDiasLaborables" runat="server" RepeatLayout="Flow" CssClass="d-flex flex-column gap-1">
                                            <asp:ListItem Text=" Lunes" Value="Monday" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text=" Martes" Value="Tuesday" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text=" Miércoles" Value="Wednesday" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text=" Jueves" Value="Thursday" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text=" Viernes" Value="Friday" Selected="True"></asp:ListItem>
                                            <asp:ListItem Text=" Sábado" Value="Saturday"></asp:ListItem>
                                            <asp:ListItem Text=" Domingo" Value="Sunday"></asp:ListItem>
                                        </asp:CheckBoxList>
                                    </div>
                                </div>
                                <div class="col-md-6 d-flex flex-column gap-4">
                                     <div>
                                        <label for="<%= txtHoraApertura.ClientID %>" class="form-label fw-medium">Hora de Apertura</label>
                                        <asp:TextBox ID="txtHoraApertura" runat="server" CssClass="form-control" TextMode="Time" Text="09:00"></asp:TextBox>
                                    </div>
                                    <div>
                                        <label for="<%= txtHoraCierre.ClientID %>" class="form-label fw-medium">Hora de Cierre</label>
                                        <asp:TextBox ID="txtHoraCierre" runat="server" CssClass="form-control" TextMode="Time" Text="18:00"></asp:TextBox>
                                    </div>
                                     <div>
                                        <label for="<%= txtDuracionTurno.ClientID %>" class="form-label fw-medium">Duración del Turno (minutos)</label>
                                        <asp:TextBox ID="txtDuracionTurno" runat="server" CssClass="form-control" TextMode="Number" Text="30"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer text-end bg-light">
                            <asp:Button ID="btnGuardarHorarios" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary" OnClick="btnGuardarHorarios_Click" ValidationGroup="Horarios" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <aside class="quick-access-sidebar-fixed">
            <div class="quick-access-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                <h3>
                    <i class="bi bi-gear-fill"></i>
                    Configuración Rápida
                </h3>
            </div>

            <div class="quick-access-body p-3 overflow-auto" style="max-height: calc(100vh - 140px);">
                <div class="card border-0 shadow-sm mb-3 bg-white">
                    <div class="card-body p-3">
                        <h6 class="fw-bold text-primary mb-2">Administrar Credenciales</h6>
                        <div class="mb-2">
                            <label class="form-label small mb-1">Usuario</label>
                            <asp:DropDownList ID="ddlUsuariosCred" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlUsuariosCred_SelectedIndexChanged"></asp:DropDownList>
                        </div>
                        <div class="mb-2">
                            <label class="form-label small mb-1">Nombre de acceso</label>
                            <asp:TextBox ID="txtNombreUsuarioCred" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNombreUsuarioCred" runat="server" ControlToValidate="txtNombreUsuarioCred" ErrorMessage="Nombre de usuario requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="Credenciales" />
                        </div>
                        <div class="mb-2">
                            <label class="form-label small mb-1">Contraseña (nueva)</label>
                            <asp:TextBox ID="txtClaveCred" runat="server" CssClass="form-control" TextMode="SingleLine"></asp:TextBox>
                        </div>
                        <div class="d-grid">
                            <asp:Button ID="btnGuardarCredenciales" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardarCredenciales_Click" ValidationGroup="Credenciales" />
                        </div>
                    </div>
                </div>

                <div class="card border-0 shadow-sm bg-white">
                    <div class="card-body p-3">
                        <h6 class="fw-bold text-primary mb-2">Mensaje Interno Global</h6>
                        <div class="mb-2">
                            <label class="form-label small mb-1">Mensaje</label>
                            <asp:TextBox ID="txtMensajeInterno" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" MaxLength="250"></asp:TextBox>
                        </div>
                        <div class="mb-2">
                            <label class="form-label small mb-1">Destinatario (Rol)</label>
                            <asp:DropDownList ID="ddlDestinatarioRol" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Todos" Value="Todos" />
                                <asp:ListItem Text="Médicos" Value="Medico" />
                                <asp:ListItem Text="Recepcionistas" Value="Recepcionista" />
                            </asp:DropDownList>
                        </div>
                        <div class="d-grid">
                            <asp:Button ID="btnGuardarMensajeInterno" runat="server" Text="Guardar Mensaje" CssClass="btn btn-primary" OnClick="btnGuardarMensajeInterno_Click" ValidationGroup="Mensaje" />
                        </div>
                    </div>
                </div>
            </div>
        </aside>
    </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
</asp:Content>