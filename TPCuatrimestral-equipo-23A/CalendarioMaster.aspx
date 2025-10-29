<%@ Page Title="" Language="C#" MasterPageFile="~/Medico.Master" AutoEventWireup="true" CodeBehind="CalendarioMaster.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.CalendarioMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="row">
            <!-- Encabezado -->
            <div class="col-12 mb-4">
                <h2 class="fw-semibold">Mi Calendario</h2>
            </div>
        </div>

        <div class="row">
            <!-- Calendario (lado izquierdo) -->
            <div class="col-lg-8">
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h5 class="mb-0">Octubre 2025</h5>
                            <div>
                                <button class="btn btn-outline-secondary btn-sm">Hoy</button>
                                <button class="btn btn-outline-secondary btn-sm">Mes</button>
                                <button class="btn btn-outline-secondary btn-sm">Semana</button>
                                <button class="btn btn-outline-secondary btn-sm">Día</button>
                            </div>
                        </div>

                        <!-- Mockup del calendario -->
                        <table class="table table-bordered text-center align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Dom 20</th>
                                    <th>Lun 21</th>
                                    <th>Mar 22</th>
                                    <th class="bg-primary text-white">Mié 23</th>
                                    <th>Jue 24</th>
                                    <th>Vie 25</th>
                                    <th>Sáb 26</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr style="height: 120px;">
                                    <td></td>
                                    <td>
                                        <div class="bg-danger text-white rounded p-2 small">
                                            10:00 - Turno Cancelado<br />
                                            <strong>Juan Pérez</strong>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="bg-warning rounded p-2 small">
                                            11:30 - Pendiente<br />
                                            <strong>Sofía Gómez</strong>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="bg-success text-white rounded p-2 small mb-2">
                                            09:00 - Control<br />
                                            <strong>Carlos Sánchez</strong>
                                        </div>
                                        <div class="border border-primary text-primary rounded p-2 small mb-2">
                                            10:30 - Primera Consulta<br />
                                            <strong>Ana Martínez</strong>
                                        </div>
                                        <div class="bg-secondary text-white rounded p-2 small">
                                            12:00 - 13:00<br />
                                            No disponible
                                        </div>
                                    </td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <button class="btn btn-primary">
                    + Nuevo Turno
                </button>
            </div>

            <!-- Panel derecho con detalles del turno -->
            <div class="col-lg-4">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <div class="text-center mb-3">
                            <img src="https://cdn-icons-png.flaticon.com/512/4322/4322991.png" alt="Paciente" width="90" height="90" class="rounded-circle mb-2" />
                            <h5 class="mb-0">Ana Martínez</h5>
                            <p class="text-muted small mb-0">DNI: 12.345.678</p>
                        </div>

                        <hr />

                        <h6 class="fw-bold mb-3">Detalles del Turno</h6>
                        <p class="mb-1"><strong>Fecha:</strong> Miércoles, 23 de Octubre</p>
                        <p class="mb-1"><strong>Hora:</strong> 10:30 AM</p>
                        <p class="mb-1"><strong>Tipo:</strong> Primera Consulta</p>
                        <p class="mb-1"><strong>Obra Social:</strong> OSDE 310</p>
                        <p><strong>Estado:</strong> 
                            <span class="badge bg-success">Confirmado</span>
                        </p>

                        <div class="d-grid gap-2 mt-3">
                            <button class="btn btn-primary">Ver Historial Clínico</button>
                            <div class="d-flex justify-content-between">
                                <button class="btn btn-outline-secondary btn-sm flex-grow-1 me-1">Reprogramar</button>
                                <button class="btn btn-outline-danger btn-sm flex-grow-1 ms-1">Cancelar Turno</button>
                            </div>
                            <button class="btn btn-secondary">Marcar como Atendido</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
