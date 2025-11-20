<%@ Page Title="Panel Médico" Language="C#" MasterPageFile="~/Medico.Master" AutoEventWireup="true" CodeBehind="Medico.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Medico1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-dashboard-layout">
        <div class="dashboard-main-content">
            <div class="mb-4">
                <h1 class="display-5 fw-bolder">Panel Médico</h1>
                <asp:Label ID="lblBienvenida" runat="server" CssClass="text-secondary fs-5"></asp:Label>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="stats-card admin-card">
                        <div class="stats-icon">
                            <i class="bi bi-calendar-check"></i>
                        </div>
                        <h3>Turnos Hoy</h3>
                        <asp:Label ID="lblTurnosHoy" runat="server" CssClass="stats-number"></asp:Label>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card recep-card">
                        <div class="stats-icon">
                            <i class="bi bi-people-fill"></i>
                        </div>
                        <h3>Mis Pacientes</h3>
                        <asp:Label ID="lblTotalPacientes" runat="server" CssClass="stats-number"></asp:Label>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card medico-card">
                        <div class="stats-icon">
                            <i class="bi bi-clock-history"></i>
                        </div>
                        <h3>Turnos Pendientes</h3>
                        <asp:Label ID="lblTurnosPendientes" runat="server" CssClass="stats-number"></asp:Label>
                    </div>
                </div>
            </div>

            <div class="activity-section">
                <div class="activity-card">
                    <h2>
                        <i class="bi bi-calendar3"></i>
                        Próximos Turnos del Día
                    </h2>

                    <div class="card shadow-sm overflow-hidden mt-3">
                        <asp:GridView ID="dgvTurnosDelDia" runat="server" 
                            CssClass="table table-hover mb-0"
                            AutoGenerateColumns="False"
                            GridLines="None"
                            ShowHeader="True">
                            <HeaderStyle CssClass="bg-light text-secondary text-uppercase small" />
                            <Columns>
                                <asp:BoundField DataField="HoraFormateada" HeaderText="Hora" 
                                    ItemStyle-CssClass="px-4 py-3 align-middle" 
                                    HeaderStyle-CssClass="px-4 py-3" />
                                <asp:TemplateField HeaderText="Paciente" HeaderStyle-CssClass="px-4 py-3">
                                    <ItemTemplate>
                                        <span class="fw-medium text-dark"><%# Eval("NombreCompletoPaciente") %></span>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="px-4 py-3 align-middle" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="TipoConsulta" HeaderText="Tipo de Consulta" 
                                    ItemStyle-CssClass="px-4 py-3 align-middle" 
                                    HeaderStyle-CssClass="px-4 py-3" />
                                <asp:TemplateField HeaderText="Estado" HeaderStyle-CssClass="px-4 py-3">
                                    <ItemTemplate>
                                        <span class='<%# GetEstadoBadgeClass(Eval("Estado").ToString()) %>'>
                                            <%# Eval("Estado") %>
                                        </span>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="px-4 py-3 align-middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Acciones" HeaderStyle-CssClass="px-4 py-3 text-end">
                                    <ItemTemplate>
                                        <div class="d-inline-flex gap-2">
                                            <button class="btn btn-sm btn-outline-primary" type="button" title="Ver Historial">
                                                <i class="bi bi-file-medical"></i>
                                            </button>
                                            <button class="btn btn-sm btn-outline-success" type="button" title="Atender">
                                                <i class="bi bi-check-circle"></i>
                                            </button>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="px-4 py-3 align-middle text-end" />
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="text-center py-5">
                                    <i class="bi bi-calendar-x text-muted" style="font-size: 3rem;"></i>
                                    <p class="text-muted mt-3">No hay turnos programados para hoy.</p>
                                </div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <aside class="quick-access-sidebar-fixed">
        <div class="quick-access-header">
            <h3>
                <i class="bi bi-lightning-charge-fill"></i>
                Accesos Rápidos
            </h3>
        </div>

        <div class="quick-access-body">
            <div class="quick-access-links">
                <asp:HyperLink ID="hlCalendario" runat="server" NavigateUrl="~/CalendarioMaster.aspx" CssClass="quick-access-link primary-link">
                    <i class="bi bi-calendar3-fill"></i>
                    <span>Mi Calendario</span>
                    <i class="bi bi-arrow-right"></i>
                </asp:HyperLink>

                <asp:HyperLink ID="hlMisPacientes" runat="server" NavigateUrl="#" CssClass="quick-access-link info-link">
                    <i class="bi bi-people-fill"></i>
                    <span>Mis Pacientes</span>
                    <i class="bi bi-arrow-right"></i>
                </asp:HyperLink>

                <asp:HyperLink ID="hlHistoriales" runat="server" NavigateUrl="#" CssClass="quick-access-link warning-link">
                    <i class="bi bi-file-medical-fill"></i>
                    <span>Historiales Clínicos</span>
                    <i class="bi bi-arrow-right"></i>
                </asp:HyperLink>

                <asp:HyperLink ID="hlPerfil" runat="server" NavigateUrl="~/PerfilMedico.aspx" CssClass="quick-access-link settings-link">
                    <i class="bi bi-person-circle"></i>
                    <span>Mi Perfil</span>
                    <i class="bi bi-arrow-right"></i>
                </asp:HyperLink>
            </div>

            <div class="info-section">
                <h4>
                    <i class="bi bi-info-circle-fill"></i>
                    Tips
                </h4>
                <p>Usa estos accesos rápidos para gestionar tus consultas, pacientes e historiales clínicos de forma eficiente.</p>
            </div>
        </div>
    </aside>
</asp:Content>
