<%@ Page Title="" Language="C#" MasterPageFile="~/Medico.Master" AutoEventWireup="true" CodeBehind="PerfilMedico.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.PerfilMedico" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-4">

        <h2 class="mb-4">Mi Perfil</h2>

        <!-- Tarjeta superior con datos del médico -->
        <div class="card mb-4 shadow-sm">
            <div class="card-body d-flex align-items-center justify-content-between">
                <div class="d-flex align-items-center">
                    <img src="https://tn.com.ar/resizer/v2/el-personaje-principal-de-dr-house-fue-interpretado-por-hugh-laurie-LVF5W4HM6PT3TXAMIKX6QOD7GQ.jpg?auth=87f2ec18b0a61e2febc986cb3c6780799f76f48eb42f8fd61dd67bd8ba6b03b8&width=1440" 
                         alt="Foto de perfil" class="rounded-circle me-3" width="80" height="80" />
                    <div>
                        <h5 class="mb-0">Dr. Gregory House</h5>
                        <p class="text-muted mb-0">Médico nefrólogo</p>
                        <small>Matricula: MN12345</small>
                    </div>
                </div>
                <asp:Button runat="server" CssClass="btn btn-primary" Text="Cambiar Foto" />
            </div>
        </div>

        <!-- Información personal -->
        <div class="card mb-4 shadow-sm">
            <div class="card-header fw-bold">Información Personal</div>
            <div class="card-body row g-3">
                <div class="col-md-6">
                    <label class="form-label">Nombre</label>
                    <input type="text" class="form-control" value="Gregory" disabled />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Apellido</label>
                    <input type="text" class="form-control" value="House" disabled />
                </div>
                <div class="col-md-6">
                    <label class="form-label">DNI</label>
                    <input type="text" class="form-control" value="12345678" disabled />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Fecha de Nacimiento</label>
                    <input type="date" class="form-control" value="1985-06-10" disabled />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Teléfono</label>
                    <input type="text" class="form-control" value="1122334455" disabled />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Dirección</label>
                    <input type="text" class="form-control" value="Av. Siempre Viva 742" disabled />
                </div>
                <div class="col-12 text-end">
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Guardar Cambios" />
                </div>
            </div>
        </div>

        <!-- Información profesional -->
        <div class="card mb-4 shadow-sm">
            <div class="card-header fw-bold">Información Profesional</div>
            <div class="card-body row g-3">
                <div class="col-md-6">
                    <label class="form-label">Especialidad</label>
                    <input type="text" class="form-control" value="Nefrología" disabled />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Número de Matrícula</label>
                    <input type="text" class="form-control" value="MN 12345" disabled />
                </div>
                <div class="col-12 text-end">
                    <asp:Button runat="server" CssClass="btn btn-primary" Text="Guardar Cambios" />
                </div>
            </div>
        </div>

        <!-- Seguridad y acceso -->
        <div class="card mb-4 shadow-sm">
            <div class="card-header fw-bold">Seguridad y Acceso</div>
            <div class="card-body row g-3">
                <div class="col-md-6">
                    <label class="form-label">Correo Electrónico</label>
                    <input type="email" class="form-control" value="juan.perez@example.com" disabled />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Contraseña</label>
                    <input type="password" class="form-control" value="********" disabled />
                </div>
                <div class="col-12 text-end">
                    <asp:Button runat="server" CssClass="btn btn-secondary" Text="Cambiar Contraseña" />
                </div>
            </div>
        </div>

        <!-- Preferencias -->
        <div class="card mb-4 shadow-sm">
            <div class="card-header fw-bold">Preferencias</div>
            <div class="card-body row g-3">
                <div class="col-md-6">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" checked disabled>
                        <label class="form-check-label">Recibir notificaciones por correo</label>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-check form-switch">
                        <input class="form-check-input" type="checkbox" disabled>
                        <label class="form-check-label">Activar tema oscuro</label>
                    </div>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Idioma</label>
                    <select class="form-select" disabled>
                        <option selected>Español</option>
                        <option>Inglés</option>
                    </select>
                </div>
            </div>
        </div>

    </div>
</asp:Content>
