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
                        <div class="d-flex align-items-center">
                            <div class="rounded-circle bg-gradient d-flex align-items-center justify-content-center me-4 shadow-sm" 
                                 style="width: 90px; height: 90px; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                                <i class="bi bi-person-circle text-white" style="font-size: 60px;"></i>
                            </div>
                            <div>
                                <h3 class="mb-1 fw-bold text-dark">
                                    <asp:Label ID="lblNombreCompleto" runat="server"></asp:Label>
                                </h3>
                                <p class="text-muted mb-1">
                                    <i class="bi bi-star-fill me-1 text-warning"></i>
                                    <asp:Label ID="lblEspecialidades" runat="server"></asp:Label>
                                </p>
                                <p class="text-muted mb-0 small text-uppercase fw-bold">
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
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">EMAIL *</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" Enabled="false"></asp:TextBox>
                        </div>
                        
                        <div class="col-12 mt-4">
                            <h6 class="fw-bold text-secondary border-bottom pb-2 mb-3">
                                <i class="bi bi-geo-alt me-1"></i>Dirección
                            </h6>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">CALLE *</label>
                            <asp:TextBox ID="txtCalle" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">ALTURA *</label>
                            <asp:TextBox ID="txtAltura" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
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
                            <asp:Button ID="btnCancelarPersonal" runat="server" Text="Cancelar" 
                                CssClass="btn btn-light border me-2" OnClick="btnCancelarPersonal_Click" CausesValidation="false" />
                            <asp:Button ID="btnGuardarPersonal" runat="server" Text="Guardar Cambios" 
                                CssClass="btn btn-primary px-4" OnClick="btnGuardarPersonal_Click" />
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
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold small text-secondary">ESPECIALIDAD</label>
                            <asp:DropDownList ID="ddlEspecialidad" runat="server" CssClass="form-select" Enabled="false">
                            </asp:DropDownList>
                        </div>

                        <asp:Panel ID="pnlBotonesProfesional" runat="server" CssClass="col-12 text-end mt-4" Visible="false">
                            <asp:Button ID="btnCancelarProfesional" runat="server" Text="Cancelar" 
                                CssClass="btn btn-light border me-2" OnClick="btnCancelarProfesional_Click" CausesValidation="false" />
                            <asp:Button ID="btnGuardarProfesional" runat="server" Text="Guardar Cambios" 
                                CssClass="btn btn-success px-4" OnClick="btnGuardarProfesional_Click" />
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
                <i class="bi bi-speedometer2"></i>
                Panel Rápido
            </h3>
        </div>

        <div class="quick-access-body">
            
            <div class="card border-0 shadow-sm mb-4 bg-light">
                <div class="card-body p-3">
                    <h6 class="fw-bold text-primary mb-3 border-bottom pb-2">
                        <i class="bi bi-graph-up me-2"></i>Mis Estadísticas
                    </h6>
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="text-secondary">Turnos Hoy</span>
                        <span class="badge bg-primary fs-6 rounded-pill">
                            <asp:Label ID="lblStatTurnosHoy" runat="server" Text="0"></asp:Label>
                        </span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <span class="text-secondary">Pendientes</span>
                        <span class="badge bg-warning text-dark fs-6 rounded-pill">
                            <asp:Label ID="lblStatPendientes" runat="server" Text="0"></asp:Label>
                        </span>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <span class="text-secondary">Total Pacientes</span>
                        <span class="badge bg-success fs-6 rounded-pill">
                            <asp:Label ID="lblStatPacientes" runat="server" Text="0"></asp:Label>
                        </span>
                    </div>
                </div>
            </div>

            <div class="d-grid gap-3">
                <a href="Medico.aspx" class="text-decoration-none p-3 bg-white border rounded shadow-sm d-flex justify-content-between align-items-center hover-effect">
                    <span class="fw-bold text-dark"><i class="bi bi-house-door-fill me-2 text-primary"></i>Ir al Inicio</span>
                    <i class="bi bi-chevron-right text-muted"></i>
                </a>

                <a href="CalendarioMaster.aspx" class="text-decoration-none p-3 bg-white border rounded shadow-sm d-flex justify-content-between align-items-center hover-effect">
                    <span class="fw-bold text-dark"><i class="bi bi-calendar3-fill me-2 text-info"></i>Mi Calendario</span>
                    <i class="bi bi-chevron-right text-muted"></i>
                </a>

                <a href="HistorialesClinico.aspx" class="text-decoration-none p-3 bg-white border rounded shadow-sm d-flex justify-content-between align-items-center hover-effect">
                    <span class="fw-bold text-dark"><i class="bi bi-file-medical-fill me-2 text-warning"></i>Historiales</span>
                    <i class="bi bi-chevron-right text-muted"></i>
                </a>
            </div>

        </div>
    </aside>

    <style>
        .hover-effect { transition: transform 0.2s, box-shadow 0.2s; }
        .hover-effect:hover { transform: translateY(-2px); box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
    </style>
</asp:Content>