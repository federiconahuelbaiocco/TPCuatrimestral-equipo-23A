<%@ Page Title="Mi Calendario" Language="C#" MasterPageFile="~/Medico.Master" AutoEventWireup="true" CodeBehind="CalendarioMaster.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.CalendarioMaster" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .turno-item { cursor: pointer; transition: all 0.2s; }
        .turno-item:hover { transform: scale(1.02); box-shadow: 0 4px 8px rgba(0,0,0,0.15); z-index: 10; position: relative; }
        .turno-cancelado { background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%); color: white; }
        .turno-pendiente { background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); color: white; }
        .turno-confirmado { background: linear-gradient(135deg, #10b981 0%, #059669 100%); color: white; }
        .turno-consulta { background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%); color: white; }
        .turno-no-disponible { background: linear-gradient(135deg, #6b7280 0%, #4b5563 100%); color: white; }
        
        .dia-actual { background: #eff6ff !important; }
        .calendar-table td { height: 140px; vertical-align: top; }
        .calendar-header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="admin-dashboard-layout">
        <div class="dashboard-main-content"> <div class="mb-4">
                <h1 class="display-5 fw-bolder">
                    <i class="bi bi-calendar3 me-2"></i>Mi Calendario
                </h1>
                <p class="text-secondary fs-5">Visualiza y gestiona tus turnos médicos</p>
            </div>

            <div class="card shadow border-0 mb-4 w-100">
                <div class="card-header py-3 bg-white border-bottom">
                    <div class="d-flex justify-content-between align-items-center">
                        <h5 class="mb-0 fw-bold text-primary">
                            <i class="bi bi-calendar-week me-2"></i>
                            <asp:Label ID="lblMesAnio" runat="server" Text="Mes Actual"></asp:Label>
                        </h5>
                        <div class="btn-group shadow-sm" role="group">
                            <button type="button" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-chevron-left"></i>
                            </button>
                            <button type="button" class="btn btn-primary btn-sm px-3">Hoy</button>
                            <button type="button" class="btn btn-outline-primary btn-sm">
                                <i class="bi bi-chevron-right"></i>
                            </button>
                        </div>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-bordered text-center mb-0 calendar-table w-100">
                            <thead class="bg-light text-secondary text-uppercase small">
                                <tr>
                                    <th class="py-3" style="width: 14.28%">Domingo</th>
                                    <th class="py-3" style="width: 14.28%">Lunes</th>
                                    <th class="py-3" style="width: 14.28%">Martes</th>
                                    <th class="py-3" style="width: 14.28%">Miércoles</th>
                                    <th class="py-3" style="width: 14.28%">Jueves</th>
                                    <th class="py-3" style="width: 14.28%">Viernes</th>
                                    <th class="py-3" style="width: 14.28%">Sábado</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptSemanas" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <asp:Repeater ID="rptDias" runat="server" DataSource='<%# Container.DataItem %>'>
                                                <ItemTemplate>
                                                    <td class='p-2 <%# EsHoy((DateTime)Eval("Fecha")) ? "dia-actual" : "" %>'>
                                                        <div class="fw-bold mb-2 small text-muted text-end">
                                                            <%# ((DateTime)Eval("Fecha")).Day %>
                                                        </div>
                                                        <div class="d-flex flex-column gap-1">
                                                            <asp:Repeater ID="rptTurnos" runat="server" DataSource='<%# Eval("Turnos") %>'>
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lnkTurno" runat="server"
                                                                        CommandName="SeleccionarTurno"
                                                                        CommandArgument='<%# Eval("IdTurno") %>'
                                                                        OnCommand="lnkTurno_Command"
                                                                        CssClass='<%# "turno-item rounded p-1 small text-decoration-none text-start lh-sm border-0 w-100 " + ObtenerClaseTurno(Eval("Estado").ToString()) %>'>
                                                                        <div class="d-flex justify-content-between">
                                                                            <strong><%# ((DateTime)Eval("FechaHora")).ToString("HH:mm") %></strong>
                                                                        </div>
                                                                        <div class="text-truncate" style="max-width: 100%;">
                                                                            <%# Eval("MotivoConsulta") ?? "Consulta" %>
                                                                        </div>
                                                                    </asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:Repeater>
                                                        </div>
                                                    </td>
                                                </ItemTemplate>
                                            </asp:Repeater>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="row g-3">
                <div class="col-md-6">
                    <button type="button" class="btn btn-primary btn-lg w-100 shadow-sm">
                        <i class="bi bi-plus-lg me-2"></i>Nuevo Turno
                    </button>
                </div>
                <div class="col-md-6">
                    <button type="button" class="btn btn-outline-secondary btn-lg w-100 shadow-sm">
                        <i class="bi bi-printer me-2"></i>Imprimir Calendario
                    </button>
                </div>
            </div>

        </div> </div> <aside class="quick-access-sidebar-fixed">
        <div class="quick-access-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
            <h3><i class="bi bi-info-circle-fill"></i> Gestión</h3>
        </div>

        <div class="quick-access-body">
            
            <asp:Panel ID="pnlDetallesTurno" runat="server" Visible="false">
                <div class="text-center mb-4 mt-3">
                    <div class="rounded-circle bg-primary d-inline-flex align-items-center justify-content-center shadow-sm" 
                         style="width: 80px; height: 80px;">
                        <i class="bi bi-person-circle text-white" style="font-size: 40px;"></i>
                    </div>
                    <h4 class="mt-3 mb-1 fw-bold text-dark">
                        <asp:Label ID="lblPacienteNombre" runat="server"></asp:Label>
                    </h4>
                    <p class="text-muted mb-0">
                        DNI: <asp:Label ID="lblPacienteDni" runat="server"></asp:Label>
                    </p>
                </div>

                <div class="card border-0 shadow-sm mb-3 bg-light">
                    <div class="card-body p-3">
                        <h6 class="fw-bold text-primary border-bottom pb-2 mb-3">
                            <i class="bi bi-calendar-check me-2"></i>Información
                        </h6>
                        
                        <div class="mb-2">
                            <small class="text-muted d-block">Fecha</small>
                            <asp:Label ID="lblTurnoFecha" runat="server" CssClass="fw-medium"></asp:Label>
                        </div>
                        <div class="mb-2">
                            <small class="text-muted d-block">Hora</small>
                            <asp:Label ID="lblTurnoHora" runat="server" CssClass="fw-medium"></asp:Label>
                        </div>
                        <div class="mb-2">
                            <small class="text-muted d-block">Tipo</small>
                            <asp:Label ID="lblTurnoTipo" runat="server" CssClass="fw-medium"></asp:Label>
                        </div>
                        <div>
                            <small class="text-muted d-block">Obra Social</small>
                            <asp:Label ID="lblTurnoObraSocial" runat="server" CssClass="fw-medium"></asp:Label>
                        </div>
                    </div>
                </div>

                <asp:Panel ID="pnlObservaciones" runat="server" Visible="false">
                    <div class="alert alert-warning border-0 shadow-sm mb-3">
                        <div class="fw-bold mb-1"><i class="bi bi-chat-left-text me-1"></i>Observaciones:</div>
                        <asp:Label ID="lblTurnoObservaciones" runat="server"></asp:Label>
                    </div>
                </asp:Panel>

                <div class="d-grid gap-2 mt-4 pb-4">
                    <asp:LinkButton ID="lnkVerHistorial" runat="server" CssClass="btn btn-primary shadow-sm" OnClick="lnkVerHistorial_Click">
                        <i class="bi bi-file-medical me-2"></i>Historial
                    </asp:LinkButton>

                    <asp:LinkButton ID="lnkAtender" runat="server" CssClass="btn btn-success shadow-sm" OnClick="lnkAtender_Click">
                        <i class="bi bi-check-circle me-2"></i>Atender
                    </asp:LinkButton>

                    <asp:LinkButton ID="lnkCancelar" runat="server" CssClass="btn btn-outline-danger" OnClick="lnkCancelar_Click">
                        <i class="bi bi-x-circle me-2"></i>Cancelar
                    </asp:LinkButton>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlSinSeleccion" runat="server" Visible="true">
                <div class="text-center py-5">
                    <i class="bi bi-cursor-fill text-muted mb-3" style="font-size: 3rem; opacity: 0.3;"></i>
                    <h5 class="fw-bold text-dark">Selecciona un Turno</h5>
                    <p class="text-muted small">Haz clic en cualquier turno del calendario para ver sus detalles.</p>
                </div>

                <div class="card border-0 shadow-sm mx-2">
                    <div class="card-body p-3">
                        <h6 class="fw-bold mb-3 text-secondary border-bottom pb-2">Referencias</h6>
                        <div class="d-flex align-items-center mb-2">
                            <div class="turno-confirmado rounded shadow-sm" style="width: 16px; height: 16px;"></div>
                            <span class="ms-2 small">Confirmado</span>
                        </div>
                        <div class="d-flex align-items-center mb-2">
                            <div class="turno-pendiente rounded shadow-sm" style="width: 16px; height: 16px;"></div>
                            <span class="ms-2 small">Pendiente</span>
                        </div>
                        <div class="d-flex align-items-center mb-2">
                            <div class="turno-cancelado rounded shadow-sm" style="width: 16px; height: 16px;"></div>
                            <span class="ms-2 small">Cancelado</span>
                        </div>
                        <div class="d-flex align-items-center">
                            <div class="turno-consulta rounded shadow-sm" style="width: 16px; height: 16px;"></div>
                            <span class="ms-2 small">Primera Consulta</span>
                        </div>
                    </div>
                </div>
            </asp:Panel>

        </div>
    </aside>

</asp:Content>