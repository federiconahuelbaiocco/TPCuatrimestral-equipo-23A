<%@ Page Title="Mi Perfil" Language="C#" MasterPageFile="~/Medico.Master" AutoEventWireup="true" CodeBehind="PerfilMedico.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.PerfilMedico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-4 perfil-medico">
        <div class="mb-4">
            <h1 class="display-5 fw-bolder">Mi Perfil</h1>
            <p class="text-secondary fs-5">Gestiona tu información personal y profesional.</p>
        </div>

        <div class="card mb-4 shadow-sm">
            <div class="card-body d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <div class="rounded-circle bg-light d-flex align-items-center justify-content-center me-3" 
                         style="width: 100px; height: 100px;">
                        <i class="bi bi-person-circle text-secondary" style="font-size: 80px;"></i>
                    </div>
                    <div>
                        <asp:Label ID="lblNombreCompleto" runat="server" CssClass="h4 mb-1 fw-bold d-block"></asp:Label>
                        <asp:Label ID="lblEspecialidad" runat="server" CssClass="text-muted mb-1 d-block"></asp:Label>
                        <small class="text-secondary">
                            <i class="bi bi-award me-1"></i>
                            <asp:Label ID="lblMatricula" runat="server"></asp:Label>
                        </small>
                    </div>
                </div>
                <button type="button" class="btn btn-outline-primary">
                    <i class="bi bi-camera"></i> Cambiar Foto
                </button>
            </div>
        </div>

        <div class="row g-4">
            <div class="col-lg-6">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 fw-bold">
                            <i class="bi bi-person-vcard me-2"></i>Información Personal
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-medium">Nombre</label>
                                <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium">Apellido</label>
                                <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium">DNI</label>
                                <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium">Sexo</label>
                                <asp:TextBox ID="txtSexo" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium">Teléfono</label>
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium">Email</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" TextMode="Email" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-medium">Dirección</label>
                                <asp:TextBox ID="txtDireccion" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="col-12 text-end">
                                <button type="button" class="btn btn-primary" disabled>
                                    <i class="bi bi-save me-1"></i> Guardar Cambios
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 fw-bold">
                            <i class="bi bi-briefcase me-2"></i>Información Profesional
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-medium">Especialidad</label>
                                <asp:TextBox ID="txtEspecialidadProfesional" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-medium">Número de Matrícula</label>
                                <asp:TextBox ID="txtMatriculaProfesional" runat="server" CssClass="form-control" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="col-12 text-end">
                                <button type="button" class="btn btn-primary" disabled>
                                    <i class="bi bi-save me-1"></i> Guardar Cambios
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 fw-bold">
                            <i class="bi bi-shield-lock me-2"></i>Seguridad y Acceso
                        </h5>
                    </div>
                    <div class="card-body">
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label fw-medium">Correo Electrónico</label>
                                <asp:TextBox ID="txtEmailSeguridad" runat="server" CssClass="form-control" TextMode="Email" Enabled="false"></asp:TextBox>
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-medium">Contraseña</label>
                                <input type="password" class="form-control" value="********" disabled />
                            </div>
                            <div class="col-12 text-end">
                                <button type="button" class="btn btn-secondary" disabled>
                                    <i class="bi bi-key me-1"></i> Cambiar Contraseña
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm mt-4">
            <div class="card-header bg-white py-3">
                <h5 class="mb-0 fw-bold">
                    <i class="bi bi-gear me-2"></i>Preferencias
                </h5>
            </div>
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-4">
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="notifEmail" checked disabled />
                            <label class="form-check-label" for="notifEmail">
                                Recibir notificaciones por correo
                            </label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-check form-switch">
                            <input class="form-check-input" type="checkbox" id="darkMode" disabled />
                            <label class="form-check-label" for="darkMode">
                                Activar tema oscuro
                            </label>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label fw-medium">Idioma</label>
                        <select class="form-select" disabled>
                            <option selected>Español</option>
                            <option>Inglés</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
