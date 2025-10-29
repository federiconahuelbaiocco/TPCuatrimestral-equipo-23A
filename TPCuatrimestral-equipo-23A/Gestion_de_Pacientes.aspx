<%@ Page Title="" Language="C#" MasterPageFile="~/Recepcionista.Master" AutoEventWireup="true" CodeBehind="Gestion_de_Pacientes.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Gestion_de_Pacientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
        <div class="container-fluid py-4">
            <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
                <div>
                    <h1 class="h2 fw-bold">Gestión de Pacientes</h1>
                    <p class="text-muted">Busca, añade y actualiza la información de los pacientes.</p>
                </div>
                <button class="btn btn-primary d-flex align-items-center gap-2">
                    <svg class="bi bi-plus-lg" fill="currentColor" height="16" viewBox="0 0 16 16" width="16" xmlns="http://www.w3.org/2000/svg">
                        <path d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2" fill-rule="evenodd"></path>
                    </svg>
                    Añadir Nuevo Paciente
                </button>
            </div>
            <div class="card shadow-sm mb-4">
                <div class="card-body">
                    <div class="input-group mb-3">
                        <span class="input-group-text" id="basic-addon1">
                            <svg class="bi bi-search" fill="currentColor" height="16" viewBox="0 0 16 16" width="16" xmlns="http://www.w3.org/2000/svg">
                                <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"></path>
                            </svg>
                        </span>
                        <input aria-describedby="basic-addon1" aria-label="Buscar paciente" class="form-control" placeholder="Buscar paciente por nombre, contacto o DNI..." type="text" />
                    </div>
                </div>
            </div>
            <div class="card shadow-sm">
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover table-striped mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="px-4 py-3" scope="col">Nombre Completo</th>
                                    <th class="px-4 py-3" scope="col">Contacto</th>
                                    <th class="px-4 py-3 text-end" scope="col">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td class="align-middle px-4 py-3">Juan Pérez</td>
                                    <td class="align-middle px-4 py-3 text-muted">juan.perez@example.com</td>
                                    <td class="align-middle px-4 py-3 text-end">
                                        <a href="DetallePaciente.aspx" class="btn btn-outline-primary btn-sm me-2">Ver Detalle</a>
                                        <a href="DetallePaciente.aspx" class="btn btn-secondary btn-sm">Editar</a>
                                    </td>
                                </tr>
                                <tr class="table-primary">
                                    <td class="align-middle px-4 py-3">Ana Gómez</td>
                                    <td class="align-middle px-4 py-3">ana.gomez@example.com</td>
                                    <td class="align-middle px-4 py-3 text-end">
                                        <button class="btn btn-outline-primary btn-sm me-2">Ver Detalle</button>
                                        <button class="btn btn-secondary btn-sm">Editar</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-middle px-4 py-3">Carlos Rodriguez</td>
                                    <td class="align-middle px-4 py-3 text-muted">carlos.r@example.com</td>
                                    <td class="align-middle px-4 py-3 text-end">
                                        <button class="btn btn-outline-primary btn-sm me-2">Ver Detalle</button>
                                        <button class="btn btn-secondary btn-sm">Editar</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-middle px-4 py-3">Maria Lopez</td>
                                    <td class="align-middle px-4 py-3 text-muted">maria.lopez@example.com</td>
                                    <td class="align-middle px-4 py-3 text-end">
                                        <button class="btn btn-outline-primary btn-sm me-2">Ver Detalle</button>
                                        <button class="btn btn-secondary btn-sm">Editar</button>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="align-middle px-4 py-3">Luis Martínez</td>
                                    <td class="align-middle px-4 py-3 text-muted">luis.martinez@example.com</td>
                                    <td class="align-middle px-4 py-3 text-end">
                                        <button class="btn btn-outline-primary btn-sm me-2">Ver Detalle</button>
                                        <button class="btn btn-secondary btn-sm">Editar</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    
</asp:Content>
