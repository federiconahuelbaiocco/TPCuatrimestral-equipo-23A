<%@ Page Title="" Language="C#" MasterPageFile="~/Recepcionista.Master" AutoEventWireup="true" CodeBehind="Gestion_de_Turnos.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.GestionDeTurnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-4">
        <div class="mb-4">
            <h1 class="display-5 fw-bolder">Gestión de Turnos</h1>
            <p class="text-secondary fs-5">Administra los turnos médicos de tu centro de salud.</p>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-white py-3">
                <div class="row g-3 align-items-center">
                    <div class="col-md-3">
                        <label class="form-label visually-hidden" for="dateFilter">Fecha</label>
                        <input class="form-control" id="dateFilter" type="date" value="2024-10-16" />
                    </div>
                    <div class="col-md-3">
                        <label class="form-label visually-hidden" for="doctorFilter">Médico</label>
                        <select class="form-select" id="doctorFilter">
                            <option selected="">Todos los médicos</option>
                            <option>Dr. Pérez</option>
                            <option>Dr. García</option>
                            <option>Dr. Sánchez</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label visually-hidden" for="statusFilter">Estado</label>
                        <select class="form-select" id="statusFilter">
                            <option selected="">Todos los estados</option>
                            <option>Confirmado</option>
                            <option>Llegada</option>
                            <option>En espera</option>
                            <option>Cancelado</option>
                        </select>
                    </div>
                    <div class="col-md-3 text-end">
                        <button class="btn btn-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal" type="button">
                            <i class="bi bi-plus-lg me-2"></i>Programar Turno
                        </button>
                    </div>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="bg-light text-secondary text-uppercase small">
                            <tr>
                                <th scope="col" class="px-4 py-3">Hora</th>
                                <th scope="col" class="px-4 py-3">Paciente</th>
                                <th scope="col" class="px-4 py-3">Médico</th>
                                <th scope="col" class="px-4 py-3">Tipo de Cita</th>
                                <th scope="col" class="px-4 py-3">Estado</th>
                                <th scope="col" class="px-4 py-3 text-end">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="px-4 py-3 align-middle">09:00</td>
                                <td class="px-4 py-3 align-middle"><span class="fw-medium text-dark">Carlos Rodriguez</span></td>
                                <td class="px-4 py-3 align-middle">Dr. Pérez</td>
                                <td class="px-4 py-3 align-middle">Control</td>
                                <td class="px-4 py-3 align-middle"><span class="badge rounded-pill text-bg-success">Llegada</span></td>
                                <td class="px-4 py-3 align-middle text-end">
                                    <div class="d-inline-flex gap-2">
                                        <button class="btn btn-sm btn-outline-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal" title="Editar">
                                            <i class="bi bi-pencil-fill"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" title="Cancelar">
                                            <i class="bi bi-x-circle-fill"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="px-4 py-3 align-middle">09:30</td>
                                <td class="px-4 py-3 align-middle"><span class="fw-medium text-dark">Martina Torres</span></td>
                                <td class="px-4 py-3 align-middle">Dr. Sánchez</td>
                                <td class="px-4 py-3 align-middle">Control</td>
                                <td class="px-4 py-3 align-middle"><span class="badge rounded-pill text-bg-primary">Confirmado</span></td>
                                <td class="px-4 py-3 align-middle text-end">
                                    <div class="d-inline-flex gap-2">
                                        <button class="btn btn-sm btn-outline-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal" title="Editar">
                                            <i class="bi bi-pencil-fill"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" title="Cancelar">
                                            <i class="bi bi-x-circle-fill"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="px-4 py-3 align-middle">10:30</td>
                                <td class="px-4 py-3 align-middle"><span class="fw-medium text-dark">Ana Gómez</span></td>
                                <td class="px-4 py-3 align-middle">Dr. Pérez</td>
                                <td class="px-4 py-3 align-middle">Primera Vez</td>
                                <td class="px-4 py-3 align-middle"><span class="badge rounded-pill text-bg-warning">En espera</span></td>
                                <td class="px-4 py-3 align-middle text-end">
                                    <div class="d-inline-flex gap-2">
                                        <button class="btn btn-sm btn-outline-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal" title="Editar">
                                            <i class="bi bi-pencil-fill"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" title="Cancelar">
                                            <i class="bi bi-x-circle-fill"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="px-4 py-3 align-middle">11:00</td>
                                <td class="px-4 py-3 align-middle"><span class="fw-medium text-dark">Luis Fernández</span></td>
                                <td class="px-4 py-3 align-middle">Dr. García</td>
                                <td class="px-4 py-3 align-middle">Urgencia</td>
                                <td class="px-4 py-3 align-middle"><span class="badge rounded-pill text-bg-danger">Cancelado</span></td>
                                <td class="px-4 py-3 align-middle text-end">
                                    <div class="d-inline-flex gap-2">
                                        <button class="btn btn-sm btn-outline-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal" title="Editar">
                                            <i class="bi bi-pencil-fill"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" title="Cancelar">
                                            <i class="bi bi-x-circle-fill"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="px-4 py-3 align-middle">14:00</td>
                                <td class="px-4 py-3 align-middle"><span class="fw-medium text-dark">Juan Navarro</span></td>
                                <td class="px-4 py-3 align-middle">Dr. Sánchez</td>
                                <td class="px-4 py-3 align-middle">Control</td>
                                <td class="px-4 py-3 align-middle"><span class="badge rounded-pill text-bg-primary">Confirmado</span></td>
                                <td class="px-4 py-3 align-middle text-end">
                                    <div class="d-inline-flex gap-2">
                                        <button class="btn btn-sm btn-outline-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal" title="Editar">
                                            <i class="bi bi-pencil-fill"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" title="Cancelar">
                                            <i class="bi bi-x-circle-fill"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                            <tr>
                                <td class="px-4 py-3 align-middle">16:00</td>
                                <td class="px-4 py-3 align-middle"><span class="fw-medium text-dark">Pedro Molina</span></td>
                                <td class="px-4 py-3 align-middle">Dr. García</td>
                                <td class="px-4 py-3 align-middle">Seguimiento</td>
                                <td class="px-4 py-3 align-middle"><span class="badge rounded-pill text-bg-primary">Confirmado</span></td>
                                <td class="px-4 py-3 align-middle text-end">
                                    <div class="d-inline-flex gap-2">
                                        <button class="btn btn-sm btn-outline-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal" title="Editar">
                                            <i class="bi bi-pencil-fill"></i>
                                        </button>
                                        <button class="btn btn-sm btn-outline-danger" title="Cancelar">
                                            <i class="bi bi-x-circle-fill"></i>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <div aria-hidden="true" aria-labelledby="scheduleModalLabel" class="modal fade" id="scheduleModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title fw-bold" id="scheduleModalLabel">Programar / Modificar Turno</h5>
                    <button aria-label="Close" class="btn-close" data-bs-dismiss="modal" type="button"></button>
                </div>
                <div class="modal-body">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label class="form-label fw-medium" for="patientSearch">Buscar Paciente (Nombre o DNI)</label>
                            <input class="form-control" id="patientSearch" placeholder="Ej: Martina Torres" type="text" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-medium" for="appointmentDate">Fecha</label>
                            <input class="form-control" id="appointmentDate" type="date" value="2024-10-16" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-medium" for="appointmentTime">Hora</label>
                            <input class="form-control" id="appointmentTime" type="time" value="09:30" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-medium" for="doctorSelect">Médico</label>
                            <select class="form-select" id="doctorSelect">
                                <option>Dr. Pérez</option>
                                <option>Dr. García</option>
                                <option selected="">Dr. Sánchez</option>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-medium" for="appointmentType">Tipo de Cita</label>
                            <select class="form-select" id="appointmentType">
                                <option selected="">Control</option>
                                <option>Primera Vez</option>
                                <option>Seguimiento</option>
                                <option>Urgencia</option>
                            </select>
                        </div>
                        <div class="col-12">
                            <label class="form-label fw-medium" for="appointmentNotes">Notas</label>
                            <textarea class="form-control" id="appointmentNotes" rows="3">El paciente refiere dolor de cabeza persistente. Traer estudios anteriores.</textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" data-bs-dismiss="modal" type="button">Cerrar</button>
                    <button class="btn btn-danger" type="button">Cancelar Turno</button>
                    <button class="btn btn-primary" type="button">Guardar Cambios</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
