<%@ Page Title="Agenda Semanal" Language="C#" MasterPageFile="~/Medico.Master" AutoEventWireup="true" CodeBehind="CalendarioMaster.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.CalendarioMaster" MaintainScrollPositionOnPostback="true" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .agenda-container { height: calc(100vh - 180px); overflow-y: auto; position: relative; }
        .tabla-agenda { width: 100%; border-collapse: separate; border-spacing: 0; table-layout: fixed; }
        
        .tabla-agenda thead th {
            position: sticky; top: 0; z-index: 10;
            background: #f8f9fa; border-bottom: 2px solid #dee2e6;
            text-align: center; padding: 10px;
            box-shadow: 0 2px 2px -1px rgba(0,0,0,0.1);
        }
        
        .tabla-agenda td:first-child, .tabla-agenda th:first-child {
            position: sticky; left: 0; z-index: 11;
            background: #ffffff; border-right: 2px solid #dee2e6;
            width: 60px; text-align: center; color: #6c757d; font-weight: bold; font-size: 0.85rem;
        }
        .tabla-agenda thead th:first-child { z-index: 12; background: #f8f9fa; }

        .tabla-agenda td {
            height: 60px; border-bottom: 1px solid #e9ecef; border-right: 1px solid #e9ecef;
            padding: 2px; vertical-align: top; transition: background 0.2s;
        }
        .tabla-agenda td:hover { background-color: #f8f9fa; }

        .columna-hoy { background-color: #eff6ff !important; }

        .turno-card {
            display: block; width: 100%; height: 100%;
            padding: 4px; border-radius: 4px;
            font-size: 0.75rem; text-decoration: none; overflow: hidden;
            transition: transform 0.1s; border: 0; text-align: left;
        }
        .turno-card:hover { transform: scale(1.02); opacity: 0.9; cursor: pointer; }
        
        .quick-access-sidebar-fixed { z-index: 100; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <asp:UpdatePanel ID="updPanelCalendario" runat="server">
        <ContentTemplate>

            <div class="admin-dashboard-layout h-100 d-flex flex-column">
                <div class="dashboard-main-content flex-grow-1 p-0 d-flex flex-column" style="max-width: none;">
                    
                    <div class="p-4 pb-2">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <div>
                                <h2 class="fw-bold mb-0"><i class="bi bi-calendar-week me-2"></i>Agenda Médica</h2>
                                <p class="text-muted mb-0"><asp:Label ID="lblRangoFechas" runat="server"></asp:Label></p>
                            </div>
                            
                            <div class="btn-group shadow-sm">
                                <asp:LinkButton ID="btnAnterior" runat="server" CssClass="btn btn-outline-secondary" OnClick="btnAnterior_Click">
                                    <i class="bi bi-chevron-left"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnHoy" runat="server" CssClass="btn btn-white text-primary fw-bold border-secondary border-start-0 border-end-0" OnClick="btnHoy_Click">
                                    Hoy
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnSiguiente" runat="server" CssClass="btn btn-outline-secondary" OnClick="btnSiguiente_Click">
                                    <i class="bi bi-chevron-right"></i>
                                </asp:LinkButton>
                            </div>
                        </div>
                    </div>

                    <div class="agenda-container bg-white border-top">
                        <table class="tabla-agenda">
                            <thead>
                                <tr>
                                    <th>Hora</th>
                                    <asp:Repeater ID="rptCabeceraDias" runat="server">
                                        <ItemTemplate>
                                            <th><%# Container.DataItem %></th>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptCuerpoCalendario" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td>
                                                <div class="mt-2"><%# Eval("HoraLegible") %></div>
                                            </td>

                                            <asp:Repeater ID="rptCeldas" runat="server" DataSource='<%# Eval("Celdas") %>'>
                                                <ItemTemplate>
                                                    <td class='<%# (bool)Eval("EsHoy") ? "columna-hoy" : "" %>'>
                                                        <asp:Panel ID="pnlTurno" runat="server" Visible='<%# Eval("TurnoAsignado") != null %>'>
                                                            <asp:LinkButton ID="btnVerTurno" runat="server" 
                                                                CssClass='<%# "turno-card " + ObtenerClaseCssTurno((dominio.Turno)Eval("TurnoAsignado")) %>'
                                                                CommandName="VerTurno"
                                                                CommandArgument='<%# Eval("TurnoAsignado.IdTurno") %>'
                                                                OnCommand="lnkTurno_Command">
                                                                <div class="fw-bold text-truncate">
                                                                    <%# Eval("TurnoAsignado.Paciente.Apellido") %>
                                                                </div>
                                                                <div class="small opacity-75">
                                                                    <%# Eval("TurnoAsignado.MotivoConsulta") ?? "Consulta" %>
                                                                </div>
                                                            </asp:LinkButton>
                                                        </asp:Panel>
                                                        
                                                        <asp:Panel ID="pnlVacio" runat="server" Visible='<%# Eval("TurnoAsignado") == null %>'>
                                                        </asp:Panel>
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

            <aside class="quick-access-sidebar-fixed">
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

        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>