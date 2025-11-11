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
                        
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link" href="#">Configuración</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Cerrar Sesión</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">Pacientes</a></li>
                    <li aria-current="page" class="breadcrumb-item active">Juan Pérez</li>
                </ol>
            </nav>
        </header>
        <main>
            <div class="card shadow-sm mb-4">
                <div class="card-body p-4">
                    <div class="d-flex flex-column flex-md-row align-items-center">
                        <div class="d-flex align-items-center flex-grow-1 mb-3 mb-md-0">
                            <div class="profile-img rounded-circle me-4"></div>
                            <div>
                                <h1 class="h4 fw-bold mb-0">Juan Pérez</h1>
                                <p class="text-muted mb-0">DNI: 12.345.678</p>
                                <p class="text-muted mb-0">Edad: 45 años</p>
                            </div>
                        </div>
                        <div class="d-flex gap-2">
                            <button class="btn btn-secondary" type="button">Cancelar</button>
                            <button class="btn btn-primary" type="button">Guardar Cambios</button>
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
                                    <button class="btn btn-sm btn-outline-primary">Editar</button>
                                </div>
                                <div class="card-body">
                                    <class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label" for="fullName">Nombre Completo</label>
                                            <input class="form-control" id="fullName" type="text" value="Juan Pérez" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label" for="dni">DNI</label>
                                            <input class="form-control" id="dni" type="text" value="12.345.678" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label" for="birthDate">Fecha de Nacimiento</label>
                                            <input class="form-control" id="birthDate" type="date" value="1979-05-15" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label" for="gender">Género</label>
                                            <select class="form-select" id="gender">
                                                <option selected="">Masculino</option>
                                                <option>Femenino</option>
                                                <option>Otro</option>
                                            </select>
                                        </div>
                                    </>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="card h-100 shadow-sm">
                                <div class="card-header d-flex justify-content-between align-items-center">
                                    <h5 class="card-title mb-0">Información de Contacto</h5>
                                    <button class="btn btn-sm btn-outline-primary">Editar</button>
                                </div>
                                <div class="card-body">
                                    <class="row g-3">
                                        <div class="col-md-6">
                                            <label class="form-label" for="phone">Teléfono</label>
                                            <input class="form-control" id="phone" type="tel" value="+54 9 11 1234-5678" />
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label" for="email">Email</label>
                                            <input class="form-control" id="email" type="email" value="juan.perez@example.com" />
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label" for="address">Dirección</label>
                                            <input class="form-control" id="address" type="text" value="Av. Corrientes 1234, CABA, Argentina" />
                                        </div>
                                    </>
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
