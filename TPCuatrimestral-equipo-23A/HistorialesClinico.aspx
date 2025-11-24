<%@ Page Title="Historiales Clínicos" Language="C#" MasterPageFile="~/Medico.Master" AutoEventWireup="true" CodeBehind="HistorialesClinico.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.HistorialesClinico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .historial-entrada {
            border-left: 4px solid #667eea;
            padding: 1.5rem;
            margin-bottom: 1.25rem;
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            transition: all 0.2s;
            border: 1px solid #f3f4f6;
        }

        .historial-entrada:hover {
            box-shadow: 0 8px 15px rgba(0,0,0,0.08);
            transform: translateY(-2px);
        }

        .historial-fecha {
            color: #667eea;
            font-weight: 700;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .historial-medico {
            font-weight: 600;
            color: #1f2937;
            font-size: 1.05rem;
        }

        .historial-especialidad {
            color: #6b7280;
            font-size: 0.85rem;
            font-style: italic;
        }

        .historial-diagnostico {
            background: #f8fafc;
            padding: 1rem;
            border-radius: 8px;
            margin-top: 0.75rem;
            border-left: 3px solid #667eea;
        }

        .historial-diagnostico-label {
            font-weight: 600;
            color: #667eea;
            font-size: 0.85rem;
            text-transform: uppercase;
            margin-bottom: 0.25rem;
        }

        .historial-observaciones {
            background: #fffbeb;
            padding: 1rem;
            border-radius: 8px;
            margin-top: 0.5rem;
            border-left: 3px solid #f59e0b;
        }

        .historial-observaciones-label {
            font-weight: 600;
            color: #d97706;
            font-size: 0.85rem;
            text-transform: uppercase;
            margin-bottom: 0.25rem;
        }

        .paciente-link {
            display: flex;
            align-items: center;
            padding: 1rem;
            background: white;
            border: 1px solid #e5e7eb;
            border-radius: 10px;
            text-decoration: none;
            color: #1f2937;
            transition: all 0.2s ease;
            margin-bottom: 0.75rem;
        }

        .paciente-link:hover {
            background: #f0f9ff;
            border-color: #667eea;
            transform: translateX(5px);
            color: #667eea;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="admin-dashboard-layout">
        <div class="dashboard-main-content w-100" style="max-width: none;">
            
            <div class="mb-4 d-flex flex-wrap align-items-center justify-content-between gap-2">
                <div>
                    <h1 class="display-5 fw-bolder mb-0">
                        <i class="bi bi-file-medical-fill me-2"></i>Historiales
                    </h1>
                    <span class="text-secondary fs-5">Gestiona la historia clínica de tus pacientes</span>
                </div>
                <div>
                    <div class="input-group shadow-sm">
                        <asp:TextBox ID="txtBuscarDni" runat="server" CssClass="form-control" placeholder="Buscar por DNI" Style="width: 200px;" />
                        <asp:Button ID="btnBuscarDni" runat="server" Text="Buscar" CssClass="btn btn-primary" OnClick="btnBuscarDni_Click" />
                    </div>
                </div>
            </div>

            <asp:Panel ID="pnlPacienteInfo" runat="server" Visible="false">
                <div class="card shadow-sm mb-4 border-0 bg-white">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center flex-wrap gap-3">
                            <div class="rounded-circle bg-light d-flex align-items-center justify-content-center shadow-sm"
                                style="width: 70px; height: 70px;">
                                <i class="bi bi-person-fill text-primary" style="font-size: 35px;"></i>
                            </div>
                            <div class="flex-grow-1">
                                <h4 class="mb-1 fw-bold text-dark">
                                    <asp:Label ID="lblNombrePaciente" runat="server"></asp:Label>
                                </h4>
                                <p class="text-muted mb-0">
                                    <span class="badge bg-light text-dark border me-2">
                                        <i class="bi bi-card-text me-1"></i>DNI:
                                        <asp:Label ID="lblDniPaciente" runat="server"></asp:Label>
                                    </span>
                                    <span class="text-secondary">
                                        <i class="bi bi-envelope me-1"></i>
                                        <asp:Label ID="lblEmailPaciente" runat="server"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div>
                                <asp:Button ID="btnNuevaEntrada" runat="server" Text="Nueva Entrada"
                                    CssClass="btn btn-success shadow-sm px-4 fw-bold" OnClick="btnNuevaEntrada_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlFormulario" runat="server" Visible="false">
                <div class="card shadow mb-4 border-0">
                    <div class="card-header text-white py-3" style="background: linear-gradient(135deg, #10b981 0%, #059669 100%);">
                        <h5 class="mb-0 fw-bold">
                            <i class="bi bi-plus-circle-fill me-2"></i>Nueva Consulta
                        </h5>
                    </div>
                    <div class="card-body p-4">
                        <div class="row g-3">
                            <div class="col-12">
                                <label class="form-label fw-bold small text-secondary">DIAGNÓSTICO *</label>
                                <asp:TextBox ID="txtDiagnostico" runat="server" CssClass="form-control"
                                    TextMode="MultiLine" Rows="3" placeholder="Escriba el diagnóstico del paciente..." />
                                <asp:RequiredFieldValidator ID="rfvDiagnostico" runat="server"
                                    ControlToValidate="txtDiagnostico"
                                    ErrorMessage="El diagnóstico es requerido"
                                    CssClass="text-danger small fw-bold mt-1 d-block" Display="Dynamic" />
                            </div>
                            <div class="col-12">
                                <label class="form-label fw-bold small text-secondary">OBSERVACIONES</label>
                                <asp:TextBox ID="txtObservaciones" runat="server" CssClass="form-control"
                                    TextMode="MultiLine" Rows="4" placeholder="Notas adicionales (opcional)..." />
                            </div>
                            <div class="col-12 text-end pt-2">
                                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar"
                                    CssClass="btn btn-light border me-2" OnClick="btnCancelar_Click" CausesValidation="false" />
                                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Entrada"
                                    CssClass="btn btn-success px-4" OnClick="btnGuardar_Click" />
                            </div>
                        </div>
                    </div>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlHistorial" runat="server" Visible="false">
                <div class="activity-section">
                    <div class="d-flex align-items-center mb-4 pb-2 border-bottom">
                        <h4 class="mb-0 fw-bold text-dark">
                            <i class="bi bi-clock-history me-2 text-primary"></i>Historial de Consultas
                        </h4>
                    </div>

                    <asp:Repeater ID="rptHistorial" runat="server">
                        <ItemTemplate>
                            <div class="historial-entrada">
                                <div class="d-flex justify-content-between align-items-start mb-3">
                                    <div class="flex-grow-1">
                                        <div class="d-flex align-items-center mb-2">
                                            <div class="historial-fecha me-3">
                                                <i class="bi bi-calendar-check me-1"></i>
                                                <%# ((DateTime)Eval("Fecha")).ToString("dd/MM/yyyy") %>
                                            </div>
                                            <div class="text-muted small">
                                                <i class="bi bi-clock me-1"></i>
                                                <%# ((DateTime)Eval("Fecha")).ToString("HH:mm") %> hs
                                            </div>
                                        </div>

                                        <div class="d-flex align-items-center gap-2 mb-1">
                                            <div class="bg-light rounded-circle p-1 d-flex align-items-center justify-content-center" style="width: 32px; height: 32px;">
                                                <i class="bi bi-person-badge text-secondary"></i>
                                            </div>
                                            <div>
                                                <div class="historial-medico">
                                                    Dr/a. <%# Eval("MedicoTratante.Apellido") %>, <%# Eval("MedicoTratante.Nombre") %>
                                                </div>
                                                <div class="historial-especialidad small">
                                                    Mat: <%# Eval("MedicoTratante.Matricula") %>
                                                    <%# Eval("MedicoTratante.Especialidades") != null && 
                                                        ((System.Collections.Generic.List<dominio.Especialidad>)Eval("MedicoTratante.Especialidades")).Count > 0 
                                                        ? " • " + ((System.Collections.Generic.List<dominio.Especialidad>)Eval("MedicoTratante.Especialidades"))[0].Descripcion 
                                                        : "" %>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="historial-diagnostico">
                                    <div class="historial-diagnostico-label">
                                        <i class="bi bi-clipboard-pulse me-1"></i>Diagnóstico
                                    </div>
                                    <div class="text-dark"><%# Eval("Diagnostico") %></div>
                                </div>

                                <%# !string.IsNullOrWhiteSpace(Eval("Observaciones")?.ToString()) 
                                    ? "<div class='historial-observaciones'><div class='historial-observaciones-label'><i class='bi bi-journal-text me-1'></i>Observaciones</div><div class='text-dark'>" + Eval("Observaciones") + "</div></div>" 
                                    : "" %>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                    <asp:Label ID="lblSinHistorial" runat="server" Visible="false" CssClass="text-center text-muted d-block py-5 bg-white rounded border border-dashed">
                        <i class="bi bi-inbox" style="font-size: 3rem; opacity: 0.5;"></i><br />
                        <span class="mt-2 d-block">No hay entradas en el historial de este paciente.</span>
                    </asp:Label>
                </div>
            </asp:Panel>

            <asp:Panel ID="pnlBusqueda" runat="server" Visible="true">
                <div class="card border-0 shadow-sm py-5 text-center bg-white">
                    <div class="card-body">
                        <div class="mb-3">
                            <i class="bi bi-person-bounding-box text-secondary" style="font-size: 4rem; opacity: 0.3;"></i>
                        </div>
                        <h3 class="fw-bold text-dark">Selecciona un Paciente</h3>
                        <p class="text-muted mx-auto" style="max-width: 400px;">
                            Utiliza el panel derecho "Mis Pacientes" para seleccionar a quien deseas consultar o cargar una nueva historia clínica.
                        </p>
                        <i class="bi bi-arrow-right-circle text-primary fs-2 d-lg-none"></i>
                        <i class="bi bi-arrow-right-circle text-primary fs-2 d-none d-lg-inline-block animation-pulse"></i>
                    </div>
                </div>
            </asp:Panel>
        </div>
    </div>

    <aside class="quick-access-sidebar-fixed">
        <div class="quick-access-header" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
            <h3>
                <i class="bi bi-people-fill"></i>
                Mis Pacientes
            </h3>
        </div>

        <div class="quick-access-body p-0 overflow-auto" style="max-height: calc(100vh - 140px);">
            <div class="p-3">
                <asp:Repeater ID="rptPacientes" runat="server" OnItemCommand="rptPacientes_ItemCommand">
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkPaciente" runat="server"
                            CommandName="SeleccionarPaciente"
                            CommandArgument='<%# Eval("Dni") %>'
                            CssClass="paciente-link shadow-sm w-100 text-start border-0">
                            <div class="rounded-circle bg-primary bg-opacity-10 p-2 me-3 text-primary">
                                <i class="bi bi-person-circle fs-4"></i>
                            </div>
                            <div class="flex-grow-1 overflow-hidden">
                                <div class="fw-bold text-truncate"><%# Eval("Apellido") %>, <%# Eval("Nombre") %></div>
                                <div class="small text-muted">DNI: <%# Eval("Dni") %></div>
                            </div>
                            <i class="bi bi-chevron-right text-muted ms-2"></i>
                        </asp:LinkButton>
                    </ItemTemplate>
                </asp:Repeater>

                <asp:Panel ID="pnlSinPacientes" runat="server" Visible="false">
                    <div class="text-center py-4 text-muted">
                        <i class="bi bi-people text-secondary mb-2" style="font-size: 2rem; opacity: 0.5;"></i>
                        <p class="small mb-0">No tienes pacientes asignados.</p>
                    </div>
                </asp:Panel>
            </div>
        </div>
    </aside>

</asp:Content>