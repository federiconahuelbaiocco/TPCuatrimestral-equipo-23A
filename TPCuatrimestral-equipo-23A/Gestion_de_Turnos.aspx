<%@ Page Title="" Language="C#" MasterPageFile="~/Recepcionista.Master" AutoEventWireup="true" CodeBehind="Gestion_de_Turnos.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Gestion_de_Turnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main class="flex-grow-1 p-4">
        <div class="card">
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
                        <button class="btn btn-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal" type="button">Programar Turno</button>
                    </div>
                </div>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th scope="col">Hora</th>
                                <th scope="col">Paciente</th>
                                <th scope="col">Médico</th>
                                <th scope="col">Tipo de Cita</th>
                                <th scope="col">Estado</th>
                                <th scope="col">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>09:00</td>
                                <td>Carlos Rodriguez</td>
                                <td>Dr. Pérez</td>
                                <td>Control</td>
                                <td><span class="badge rounded-pill text-bg-success">Llegada</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal"><span class="material-symbols-outlined" style="font-size: 1rem;">edit</span></button>
                                    <button class="btn btn-sm btn-outline-danger"><span class="material-symbols-outlined" style="font-size: 1rem;">cancel</span></button>
                                </td>
                            </tr>
                            <tr>
                                <td>09:30</td>
                                <td>Martina Torres</td>
                                <td>Dr. Sánchez</td>
                                <td>Control</td>
                                <td><span class="badge rounded-pill text-bg-primary">Confirmado</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal"><span class="material-symbols-outlined" style="font-size: 1rem;">edit</span></button>
                                    <button class="btn btn-sm btn-outline-danger"><span class="material-symbols-outlined" style="font-size: 1rem;">cancel</span></button>
                                </td>
                            </tr>
                            <tr>
                                <td>10:30</td>
                                <td>Ana Gómez</td>
                                <td>Dr. Pérez</td>
                                <td>Primera Vez</td>
                                <td><span class="badge rounded-pill badge-espera">En espera</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal"><span class="material-symbols-outlined" style="font-size: 1rem;">edit</span></button>
                                    <button class="btn btn-sm btn-outline-danger"><span class="material-symbols-outlined" style="font-size: 1rem;">cancel</span></button>
                                </td>
                            </tr>
                            <tr>
                                <td>11:00</td>
                                <td>Luis Fernández</td>
                                <td>Dr. García</td>
                                <td>Urgencia</td>
                                <td><span class="badge rounded-pill text-bg-danger">Cancelado</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal"><span class="material-symbols-outlined" style="font-size: 1rem;">edit</span></button>
                                    <button class="btn btn-sm btn-outline-danger"><span class="material-symbols-outlined" style="font-size: 1rem;">cancel</span></button>
                                </td>
                            </tr>
                            <tr>
                                <td>14:00</td>
                                <td>Juan Navarro</td>
                                <td>Dr. Sánchez</td>
                                <td>Control</td>
                                <td><span class="badge rounded-pill text-bg-primary">Confirmado</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal"><span class="material-symbols-outlined" style="font-size: 1rem;">edit</span></button>
                                    <button class="btn btn-sm btn-outline-danger"><span class="material-symbols-outlined" style="font-size: 1rem;">cancel</span></button>
                                </td>
                            </tr>
                            <tr>
                                <td>16:00</td>
                                <td>Pedro Molina</td>
                                <td>Dr. García</td>
                                <td>Seguimiento</td>
                                <td><span class="badge rounded-pill text-bg-primary">Confirmado</span></td>
                                <td>
                                    <button class="btn btn-sm btn-outline-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal"><span class="material-symbols-outlined" style="font-size: 1rem;">edit</span></button>
                                    <button class="btn btn-sm btn-outline-danger"><span class="material-symbols-outlined" style="font-size: 1rem;">cancel</span></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
  
    <div aria-hidden="true" aria-labelledby="scheduleModalLabel" class="modal fade" id="scheduleModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="scheduleModalLabel">Programar / Modificar Turno</h5>
                    <button aria-label="Close" class="btn-close" data-bs-dismiss="modal" type="button"></button>
                </div>
                <div class="modal-body">
                    
                        <div class="row g-3">
                            <div class="col-md-12">
                                <label class="form-label" for="patientSearch">Buscar Paciente (Nombre o DNI)</label>
                                <input class="form-control" id="patientSearch" placeholder="Ej: Martina Torres" type="text" />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" for="appointmentDate">Fecha</label>
                                <input class="form-control" id="appointmentDate" type="date" value="2024-10-16" />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" for="appointmentTime">Hora</label>
                                <input class="form-control" id="appointmentTime" type="time" value="09:30" />
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" for="doctorSelect">Médico</label>
                                <select class="form-select" id="doctorSelect">
                                    <option>Dr. Pérez</option>
                                    <option>Dr. García</option>
                                    <option selected="">Dr. Sánchez</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label" for="appointmentType">Tipo de Cita</label>
                                <select class="form-select" id="appointmentType">
                                    <option selected="">Control</option>
                                    <option>Primera Vez</option>
                                    <option>Seguimiento</option>
                                    <option>Urgencia</option>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label" for="appointmentNotes">Notas</label>
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
