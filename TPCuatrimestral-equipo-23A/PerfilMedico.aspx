<%@ Page Title="Mi Perfil" Language="C#" MasterPageFile="~/Medico.Master" AutoEventWireup="true" CodeBehind="PerfilMedico.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.PerfilMedico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .profile-header-card {
            background: white;
            border-radius: 12px;
            border: 1px solid #f3f4f6;
            transition: all 0.3s ease;
        }
        .profile-header-card:hover {
            box-shadow: 0 10px 20px rgba(0,0,0,0.05);
            transform: translateY(-2px);
        }
        .section-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #4b5563;
            border-bottom: 2px solid #e5e7eb;
            padding-bottom: 0.75rem;
            margin-bottom: 1.5rem;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="admin-dashboard-layout">
        <div class="dashboard-main-content w-100" style="max-width: none;">
            
            <div class="mb-4">
                <h1 class="display-5 fw-bolder">
                    <i class="bi bi-person-circle me-2"></i>Mi Perfil
                </h1>
                <p class="text-secondary fs-5">Gestiona tu información personal y profesional</p>
            </div>

            <div class="card mb-4 shadow-sm border-0 profile-header-card">
                <div class="card-body p-4">
                    <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                        <div class="d-flex align-items-center flex-grow-1">
                            <div class="rounded-circle bg-gradient d-flex align-items-center justify-content-center me-4 shadow-sm" 
                                 style="width: 90px; height: 90px; min-width:90px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                                <i class="bi bi-person-circle text-white" style="font-size: 60px;"></i>
                            </div>
                            <div class="flex-grow-1">
                                <h3 class="mb-1 fw-bold text-dark text-truncate" style="max-width:100%;">
                                    <asp:Label ID="lblNombreCompleto" runat="server"></asp:Label>
                                </h3>
                                <p class="text-muted mb-1 text-truncate" style="max-width:100%;">
                                    <i class="bi bi-star-fill me-1 text-warning"></i>
                                    <asp:Label ID="lblEspecialidades" runat="server"></asp:Label>
                                </p>
                                <p class="text-muted mb-0 small text-uppercase fw-bold text-truncate" style="max-width:100%;">
                                    <i class="bi bi-award me-1"></i>
                                    <asp:Label ID="lblMatricula" runat="server"></asp:Label>
                                </p>
                            </div>
                        </div>
                        <div>
                            <asp:Label ID="lblMensaje" runat="server" CssClass="alert alert-success d-block mb-2 shadow-sm border-0" Visible="false"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card mb-4 shadow-sm border-0">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4 section-title">
                        <span class="text-primary"><i class="bi bi-person-vcard me-2"></i>Información Personal</span>
                        <asp:Button ID="btnEditarPersonal" runat="server" Text="Editar" 
                            CssClass="btn btn-outline-primary btn-sm px-3" OnClick="btnEditarPersonal_Click" />
                    </div>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">NOMBRE</label>
                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control bg-light" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">APELLIDO</label>
                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control bg-light" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold small text-secondary">DNI</label>
                            <asp:TextBox ID="txtDni" runat="server" CssClass="form-control bg-light" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold small text-secondary">SEXO</label>
                            <asp:TextBox ID="txtSexo" runat="server" CssClass="form-control bg-light" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label fw-bold small text-secondary">FECHA DE NACIMIENTO</label>
                            <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control bg-light" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">TELÉFONO *</label>
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono"
                                 ErrorMessage="Teléfono requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PersonalGroup" />
                            <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono"
                                 ErrorMessage="Teléfono inválido." CssClass="text-danger small" Display="Dynamic" ValidationExpression="^[0-9+()\- ]{6,20}$" ValidationGroup="PersonalGroup" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">EMAIL *</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" Enabled="false"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtEmail"
                                 ErrorMessage="Email requerido." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PersonalGroup" />
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail"
                                 ErrorMessage="Email inválido." CssClass="text-danger small" Display="Dynamic"
                                 ValidationExpression="^[\w\.-]+@[\w\.-]+\.[a-zA-Z]{2,6}$" ValidationGroup="PersonalGroup" />
                        </div>
                        
                        <div class="col-12 mt-4">
                            <h6 class="fw-bold text-secondary border-bottom pb-2 mb-3">
                                <i class="bi bi-geo-alt me-1"></i>Dirección
                            </h6>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">CALLE *</label>
                            <asp:TextBox ID="txtCalle" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCalle" runat="server" ControlToValidate="txtCalle"
                                 ErrorMessage="Calle requerida." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PersonalGroup" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">ALTURA *</label>
                            <asp:TextBox ID="txtAltura" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvAltura" runat="server" ControlToValidate="txtAltura"
                                 ErrorMessage="Altura requerida." CssClass="text-danger small" Display="Dynamic" ValidationGroup="PersonalGroup" />
                            <asp:RegularExpressionValidator ID="revAltura" runat="server" ControlToValidate="txtAltura"
                                 ErrorMessage="Altura inválida (solo números)." CssClass="text-danger small" Display="Dynamic" ValidationExpression="^\d+$" ValidationGroup="PersonalGroup" />
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-bold small text-secondary">PISO</label>
                            <asp:TextBox ID="txtPiso" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="col-md-3">
                            <label class="form-label fw-bold small text-secondary">DEPTO</label>
                            <asp:TextBox ID="txtDepartamento" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">LOCALIDAD *</label>
                            <asp:TextBox ID="txtLocalidad" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">PROVINCIA</label>
                            <asp:TextBox ID="txtProvincia" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">CÓDIGO POSTAL</label>
                            <asp:TextBox ID="txtCodigoPostal" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>

                        <asp:Panel ID="pnlBotonesPersonal" runat="server" CssClass="col-12 text-end mt-4" Visible="false">
                            <asp:ValidationSummary ID="vsPersonal" runat="server" CssClass="text-danger mb-2" ValidationGroup="PersonalGroup" ShowMessageBox="false" ShowSummary="true" />
                            <asp:Button ID="btnCancelarPersonal" runat="server" Text="Cancelar" 
                                CssClass="btn btn-light border me-2" OnClick="btnCancelarPersonal_Click" CausesValidation="false" />
                            <asp:Button ID="btnGuardarPersonal" runat="server" Text="Guardar Cambios" 
                                CssClass="btn btn-primary px-4" OnClick="btnGuardarPersonal_Click" ValidationGroup="PersonalGroup" />
                        </asp:Panel>
                    </div>
                </div>
            </div>

            <div class="card mb-4 shadow-sm border-0">
                <div class="card-body p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4 section-title">
                        <span class="text-success"><i class="bi bi-briefcase me-2"></i>Información Profesional</span>
                        <asp:Button ID="btnEditarProfesional" runat="server" Text="Editar" 
                            CssClass="btn btn-outline-success btn-sm px-3" OnClick="btnEditarProfesional_Click" />
                    </div>

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">MATRÍCULA *</label>
                            <asp:TextBox ID="txtMatriculaProfesional" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvMatricula" runat="server" ControlToValidate="txtMatriculaProfesional"
                                ErrorMessage="Matrícula requerida." CssClass="text-danger small" Display="Dynamic" ValidationGroup="ProfesionalGroup" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">ESPECIALIDAD</label>
                            <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select" Enabled="false">
                            </asp:DropDownList>
                        </div>
 
                        <asp:Panel ID="pnlBotonesProfesional" runat="server" CssClass="col-12 text-end mt-4" Visible="false">
                            <asp:ValidationSummary ID="vsProfesional" runat="server" CssClass="text-danger mb-2" ValidationGroup="ProfesionalGroup" ShowMessageBox="false" ShowSummary="true" />
                            <asp:Button ID="btnCancelarProfesional" runat="server" Text="Cancelar" 
                                CssClass="btn btn-light border me-2" OnClick="btnCancelarProfesional_Click" CausesValidation="false" />
                            <asp:Button ID="btnGuardarProfesional" runat="server" Text="Guardar Cambios" 
                                CssClass="btn btn-success px-4" OnClick="btnGuardarProfesional_Click" ValidationGroup="ProfesionalGroup" />
                        </asp:Panel>
                    </div>
                </div>
            </div>

            <div class="card mb-4 shadow-sm border-0">
                <div class="card-body p-4">
                    <div class="mb-4 section-title">
                        <span class="text-dark"><i class="bi bi-shield-lock me-2"></i>Seguridad de la Cuenta</span>
                    </div>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">USUARIO DE ACCESO</label>
                            <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control bg-light" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">CONTRASEÑA</label>
                            <div class="input-group">
                                <input type="password" class="form-control bg-light" value="••••••••" disabled />
                                <button class="btn btn-outline-secondary" type="button" disabled>
                                    <i class="bi bi-key"></i> Cambiar
                                </button>
                            </div>
                        </div>
                        <div class="col-12 mt-2">
                            <div class="alert alert-light border d-flex align-items-center">
                                <i class="bi bi-info-circle-fill text-info me-2 fs-5"></i>
                                <div>Para cambiar tu contraseña, contacta al administrador del sistema.</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <aside class="quick-access-sidebar-fixed">
        <div class="quick-access-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
            <h3>
                <i class="bi bi-clock-history"></i>
                Turnos de Trabajo
            </h3>
        </div>

        <div class="quick-access-body p-0 overflow-auto" style="max-height: calc(100vh - 140px);">
            <div class="p-3">
                <div class="card border-0 shadow-sm mb-3 bg-white">
                    <div class="card-body p-3">
                        <h6 class="fw-bold text-primary mb-2">Agregar Turno de Trabajo</h6>
                        <div class="mb-2">
                            <label class="form-label small mb-1">Día de la semana</label>
                            <asp:DropDownList ID="ddlDiaSemana" runat="server" CssClass="form-select form-select-sm"></asp:DropDownList>
                        </div>
                        <div class="mb-2 d-flex gap-2">
                            <div class="flex-grow-1">
                                <label class="form-label small mb-1">Hora entrada</label>
                                <asp:DropDownList ID="ddlHoraEntrada" runat="server" CssClass="form-select form-select-sm"></asp:DropDownList>
                            </div>
                            <div class="flex-grow-1">
                                <label class="form-label small mb-1">Hora salida</label>
                                <asp:DropDownList ID="ddlHoraSalida" runat="server" CssClass="form-select form-select-sm"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="d-grid">
                            <asp:Button ID="btnAgregarTurno" runat="server" Text="Agregar Turno" CssClass="btn btn-sm btn-primary" OnClick="btnAgregarTurno_Click" />
                        </div>
                    </div>
                </div>

                <div class="card border-0 shadow-sm bg-white">
                    <div class="card-body p-3">
                        <h6 class="fw-bold text-secondary mb-2">Turnos configurados</h6>
                        <asp:Repeater ID="rptTurnosTrabajo" runat="server" OnItemCommand="rptTurnosTrabajo_ItemCommand">
                            <ItemTemplate>
                                <div class="d-flex justify-content-between align-items-center mb-2 p-2 bg-light border rounded">
                                    <div>
                                        <div class="fw-bold"><%# Eval("NombreDia") %></div>
                                        <div class="small text-muted"><%# Eval("HoraEntrada") %> - <%# Eval("HoraSalida") %></div>
                                    </div>
                                    <div>
                                        <asp:LinkButton ID="lnkEliminarTurno" runat="server" CssClass="btn btn-sm btn-outline-danger" CommandName="Eliminar" CommandArgument='<%# Eval("IdTurnoTrabajo") %>'>Eliminar</asp:LinkButton>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
            </div>
         </div>
     </aside>

     <style>
         .hover-effect { transition: transform 0.2s, box-shadow 0.2s; }
         .hover-effect:hover { transform: translateY(-2px); box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
     </style>
 </asp:Content>