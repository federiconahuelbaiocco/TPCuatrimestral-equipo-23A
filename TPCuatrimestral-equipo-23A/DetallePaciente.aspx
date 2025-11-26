<%@ Page Title="" Language="C#" MasterPageFile="~/Recepcionista.Master" AutoEventWireup="true" CodeBehind="DetallePaciente.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.DetallePaciente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="~/styles/styles.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid p-4">
        <header class="mb-4">
            <nav class="navbar navbar-expand-lg navbar-light bg-light rounded-3 mb-3">
                <div class="container-fluid">
                    <a class="navbar-brand fw-bold" href="#">MedApp</a>
                    <button aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation" class="navbar-toggler" data-bs-target="#navbarNav" data-bs-toggle="collapse" type="button">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                    </div>
                </div>
            </nav>
            <nav aria-label="breadcrumb">
            </nav>
        </header>
        <main>
            <div class="card shadow-sm mb-4">
                <div class="card-body p-4">
                    <div class="d-flex flex-column flex-md-row align-items-center">
                        <div class="d-flex align-items-center flex-grow-1 mb-3 mb-md-0">
                            <div class="profile-img rounded-circle me-4"></div>
                            <div class="d-flex flex-column">
                                <asp:Label ID="lblNombreCompleto" runat="server" CssClass="h4 fw-bold mb-0"></asp:Label>
                                <asp:Label ID="lblEdad" runat="server" CssClass="text-muted"></asp:Label>
                            </div>

                        </div>
                        <div class="d-flex gap-2">
                            <asp:Button ID="btnCancelar" OnClick="btnCancelar_Click" CssClass="btn btn-secondary" runat="server" type="button" Text="Cancelar"></asp:Button>
                            <asp:Button ID="btnGuardarCambios" OnClick="btnGuardarCambios_Click" CssClass="btn btn-save-custom" runat="server" Text="Guardar Cambios" ValidationGroup="EdicionPaciente"></asp:Button>
                        </div>
                    </div>
                </div>
            </div>
            <ul class="nav nav-tabs mb-4" id="patientTab" role="tablist">
                <li class="nav-item" role="presentation">
                    <button aria-controls="personal-data" aria-selected="true" class="nav-link active" data-bs-target="#personal-data" data-bs-toggle="tab" id="personal-data-tab" role="tab" type="button">Datos Personales y Contacto</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button aria-controls="medical-history" aria-selected="false" class="nav-link" data-bs-target="#medical-history" data-bs-toggle="tab" id="medical-history-tab" role="tab" type="button">Historial Médico</button>
                </li>
                <li class="nav-item" role="presentation">
                    <button aria-controls="appointments" aria-selected="false" class="nav-link" data-bs-target="#appointments" data-bs-toggle="tab" id="appointments-tab" role="tab" type="button">Turnos Asociados</button>
                </li>
            </ul>
            <div class="tab-content" id="patientTabContent">
                <div aria-labelledby="personal-data-tab" class="tab-pane fade show active" id="personal-data" role="tabpanel">
                    <div class="row g-4">
                        <div class="col-lg-6">
                            <div class="card h-100 shadow-sm">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="card-title mb-0">Datos Personales</h5>
                                </div>
                                <div class="card-body">
                                    <class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label" for="Name">Nombre</label>
                                            <asp:TextBox ID="txtNombre" runat="server" CssClass="form-control" ValidationGroup="EdicionPaciente" />
                                            <asp:RequiredFieldValidator ID="rfvNombre" runat="server" ControlToValidate="txtNombre" ErrorMessage="El nombre es requerido" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label" for="Apellido">Apellido</label>
                                            <asp:TextBox ID="txtApellido" runat="server" CssClass="form-control" ValidationGroup="EdicionPaciente" />
                                            <asp:RequiredFieldValidator ID="rfvApellido" runat="server" ControlToValidate="txtApellido" ErrorMessage="El apellido es requerido" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label" for="dni">DNI</label>
                                            <asp:TextBox ID="txtDni" runat="server" CssClass="form-control" ValidationGroup="EdicionPaciente" />
                                            <asp:RequiredFieldValidator ID="rfvDni" runat="server" ControlToValidate="txtDni" ErrorMessage="El DNI es requerido" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                            <asp:RegularExpressionValidator ID="revDni" runat="server" ControlToValidate="txtDni" ErrorMessage="Ingrese solo números" ValidationExpression="^\d+$" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label" for="birthDate">Fecha de Nacimiento</label>
                                            <asp:TextBox ID="txtFechaNac" runat="server" CssClass="form-control" TextMode="Date" ValidationGroup="EdicionPaciente" />
                                            <asp:RequiredFieldValidator ID="rfvFechaNac" runat="server" ControlToValidate="txtFechaNac" ErrorMessage="La fecha de nacimiento es requerida" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                            <asp:RangeValidator ID="rvFechaNac" runat="server" ControlToValidate="txtFechaNac" ErrorMessage="La fecha de nacimiento es inválida" Type="Date" MinimumValue="1900-01-01" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label" for="gender">Género</label>
                                            <asp:DropDownList ID="ddlSexo" CssClass="form-select cyan-focus" runat="server">
                                                <asp:ListItem Value="Seleccione">Seleccione</asp:ListItem>
                                                <asp:ListItem Value="Masculino">Masculino</asp:ListItem>
                                                <asp:ListItem Value="Femenino">Femenino</asp:ListItem>
                                                <asp:ListItem Value="No especificado">No especificado</asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvSexo" runat="server" ControlToValidate="ddlSexo" ErrorMessage="Debe seleccionar un sexo" InitialValue="Seleccione" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Cobertura Médica</label>
                                            <asp:DropDownList ID="ddlCoberturas" CssClass="form-select cyan-focus" runat="server"></asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvCobertura" runat="server" ControlToValidate="ddlCoberturas" ErrorMessage="Seleccione una cobertura" InitialValue="0" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                        </div>
                                    </>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="card h-100 shadow-sm">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="card-title mb-0">Información de Contacto</h5>
                                </div>
                                <div class="card-body">
                                    <class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label" for="phone">Teléfono</label>
                                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" ValidationGroup="EdicionPaciente" />
                                            <asp:RequiredFieldValidator ID="rfvTelefono" runat="server" ControlToValidate="txtTelefono" ErrorMessage="Teléfono requerido" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                            <asp:RegularExpressionValidator ID="revTelefono" runat="server" ControlToValidate="txtTelefono" ErrorMessage="Solo números válidos" ValidationExpression="^[0-9\-\s]{7,15}$" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label" for="email">Email</label>
                                            <asp:TextBox ID="txtMail" runat="server" CssClass="form-control" TextMode="Email" ValidationGroup="EdicionPaciente" />
                                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ControlToValidate="txtMail" ErrorMessage="El email es requerido" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtMail" ErrorMessage="Formato inválido" ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                        </div>
                                        <div class="col-12 mt-3">
                                            <h6 class="fw-bold text-secondary border-bottom pb-2">Dirección</h6>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label">Calle</label>
                                            <asp:TextBox ID="txtCalle" runat="server" CssClass="form-control" ValidationGroup="EdicionPaciente" />
                                            <asp:RequiredFieldValidator ID="rfvCalle" runat="server" ControlToValidate="txtCalle" ErrorMessage="La calle es requerida" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label">Altura</label>
                                            <asp:TextBox ID="txtAltura" runat="server" CssClass="form-control" ValidationGroup="EdicionPaciente" />
                                            <asp:RequiredFieldValidator ID="rfvAltura" runat="server" ControlToValidate="txtAltura" ErrorMessage="Requerida" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                            <asp:RegularExpressionValidator ID="revAltura" runat="server" ControlToValidate="txtAltura" ErrorMessage="Solo números" ValidationExpression="^\d+$" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label">Piso</label>
                                            <asp:TextBox ID="txtPiso" runat="server" CssClass="form-control" ValidationGroup="EdicionPaciente" />
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label">Departamento</label>
                                            <asp:TextBox ID="txtDepartamento" runat="server" CssClass="form-control" ValidationGroup="EdicionPaciente" />
                                        </div>
                                        <div class="col-md-8">
                                            <label class="form-label">Localidad</label>
                                            <asp:TextBox ID="txtLocalidad" runat="server" CssClass="form-control" ValidationGroup="EdicionPaciente" />
                                            <asp:RequiredFieldValidator ID="rfvLocalidad" runat="server" ControlToValidate="txtLocalidad" ErrorMessage="La localidad es requerida" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                        </div>
                                        <div class="col-md-4">
                                            <label class="form-label">Código Postal</label>
                                            <asp:TextBox ID="txtCodigoPostal" runat="server" CssClass="form-control" ValidationGroup="EdicionPaciente" />
                                            <asp:RequiredFieldValidator ID="rfvCP" runat="server" ControlToValidate="txtCodigoPostal" ErrorMessage="Requerido" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                            <asp:RegularExpressionValidator ID="revCP" runat="server" ControlToValidate="txtCodigoPostal" ErrorMessage="Solo números" ValidationExpression="^\d+$" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label">Provincia</label>
                                            <asp:TextBox ID="txtProvincia" runat="server" CssClass="form-control" ValidationGroup="EdicionPaciente" />
                                            <asp:RequiredFieldValidator ID="rfvProvincia" runat="server" ControlToValidate="txtProvincia" ErrorMessage="La provincia es requerida" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                            <asp:RegularExpressionValidator ID="revProvincia" runat="server" ControlToValidate="txtProvincia" ErrorMessage="La provincia solo puede contener letras" ValidationExpression="^[a-zA-ZñÑáéíóúÁÉÍÓÚ\s.]+$" CssClass="text-danger small" Display="Dynamic" ValidationGroup="EdicionPaciente" />
                                        </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div aria-labelledby="medical-history-tab" class="tab-pane fade" id="medical-history" role="tabpanel">
                    <div class="card shadow-sm">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Resumen de Historial Médico</h5>
                        </div>
                        <div class="card-body">
                            <p class="card-text"><strong>Condiciones Preexistentes:</strong> Hipertensión arterial.</p>
                            <p class="card-text"><strong>Alergias:</strong> Penicilina.</p>
                            <p class="card-text"><strong>Medicamentos Actuales:</strong> Enalapril 10mg/día.</p>
                            <p class="card-text"><strong>Observaciones:</strong> Paciente refiere seguimiento cardiológico anual. Último control en Enero.</p>
                            <a class="btn btn-primary" href="#">Ver Historial Completo</a>
                        </div>
                    </div>
                </div>
                <div aria-labelledby="appointments-tab" class="tab-pane fade" id="appointments" role="tabpanel">
                    <div class="card shadow-sm">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Turnos</h5>
                        </div>
                        <div class="card-body">
                            <h6 class="card-subtitle mb-2 text-muted">Próximos Turnos</h6>
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col">Fecha</th>
                                        <th scope="col">Hora</th>
                                        <th scope="col">Profesional</th>
                                        <th scope="col">Especialidad</th>
                                        <th scope="col">Estado</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>25/07/2024</td>
                                        <td>10:30</td>
                                        <td>Dr. Carlos Gómez</td>
                                        <td>Cardiología</td>
                                        <td><span class="badge bg-success">Confirmado</span></td>
                                    </tr>
                                </tbody>
                            </table>
                            <hr />
                            <h6 class="card-subtitle mt-4 mb-2 text-muted">Turnos Pasados</h6>
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th scope="col">Fecha</th>
                                        <th scope="col">Profesional</th>
                                        <th scope="col">Especialidad</th>
                                        <th scope="col">Estado</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>15/01/2024</td>
                                        <td>Dr. Carlos Gómez</td>
                                        <td>Cardiología</td>
                                        <td><span class="badge bg-secondary">Realizado</span></td>
                                    </tr>
                                    <tr>
                                        <td>02/11/2023</td>
                                        <td>Dra. Ana López</td>
                                        <td>Clínica Médica</td>
                                        <td><span class="badge bg-secondary">Realizado</span></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    <script crossorigin="anonymous" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</asp:Content>
