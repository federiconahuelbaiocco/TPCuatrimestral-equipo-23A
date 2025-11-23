<%@ Page Title="Panel Médico" Language="C#" MasterPageFile="~/Medico.Master" AutoEventWireup="true" CodeBehind="Medico.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Medico1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="admin-dashboard-layout">
        <div class="dashboard-main-content">
            
            <div class="mb-4">
                <h1 class="display-5 fw-bolder">Panel Médico</h1>
                <p class="text-secondary fs-5">
                    <asp:Label ID="lblBienvenida" runat="server" Text="Bienvenido al sistema"></asp:Label>
                </p>
            </div>

            <div class="row">
                <div class="col-12">
                    <asp:Literal ID="litToast" runat="server"></asp:Literal>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <asp:Panel ID="panelHorarioFijo" runat="server" CssClass="alert alert-info text-center mt-3 mb-3" Visible="false">
                        <asp:Label ID="lblHorarioFijo" runat="server"></asp:Label>
                    </asp:Panel>
                </div>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-4">
                    <div class="stats-card admin-card">
                        <div class="stats-icon"><i class="bi bi-calendar-check"></i></div>
                        <h3>Turnos Hoy</h3>
                        <p class="stats-number"><asp:Label ID="lblTurnosHoy" runat="server" Text="0"></asp:Label></p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card recep-card">
                        <div class="stats-icon"><i class="bi bi-people-fill"></i></div>
                        <h3>Mis Pacientes</h3>
                        <p class="stats-number"><asp:Label ID="lblTotalPacientes" runat="server" Text="0"></asp:Label></p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card medico-card">
                        <div class="stats-icon"><i class="bi bi-clock-history"></i></div>
                        <h3>Pendientes</h3>
                        <p class="stats-number"><asp:Label ID="lblTurnosPendientes" runat="server" Text="0"></asp:Label></p>
                    </div>
                </div>
            </div>

            <div class="activity-section">
                <div class="activity-card">
                    <h2><i class="bi bi-calendar3"></i> Próximos Turnos del Día</h2>
                    <div class="card shadow-sm overflow-hidden mt-3">
                        <asp:GridView ID="dgvTurnosDelDia" runat="server" CssClass="table table-hover mb-0" AutoGenerateColumns="False" GridLines="None" ShowHeader="True">
                            <HeaderStyle CssClass="bg-light text-secondary text-uppercase small" />
                            <Columns>
                                <asp:BoundField DataField="HoraFormateada" HeaderText="Hora" ItemStyle-CssClass="px-4 py-3 align-middle fw-bold text-primary" HeaderStyle-CssClass="px-4 py-3" />
                                <asp:TemplateField HeaderText="Paciente" HeaderStyle-CssClass="px-4 py-3">
                                    <ItemTemplate><span class="fw-medium text-dark"><%# Eval("NombreCompletoPaciente") %></span></ItemTemplate>
                                    <ItemStyle CssClass="px-4 py-3 align-middle" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="TipoConsulta" HeaderText="Tipo" ItemStyle-CssClass="px-4 py-3 align-middle text-muted" HeaderStyle-CssClass="px-4 py-3" />
                                <asp:TemplateField HeaderText="Estado" HeaderStyle-CssClass="px-4 py-3">
                                    <ItemTemplate>
                                        <span class='<%# GetEstadoBadgeClass(Eval("Estado").ToString()) %>'><%# Eval("Estado") %></span>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="px-4 py-3 align-middle" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Acciones" HeaderStyle-CssClass="px-4 py-3 text-end">
                                    <ItemTemplate>
                                        <div class="d-inline-flex gap-2">
                                            <asp:HyperLink ID="hlVerHistorial" runat="server" CssClass="btn btn-sm btn-outline-primary" NavigateUrl='<%# Eval("Dni", "~/HistorialesClinico.aspx?dni={0}") %>'><i class="bi bi-file-medical"></i></asp:HyperLink>
                                            <asp:LinkButton ID="btnAtender" runat="server" CssClass="btn btn-sm btn-success text-white" CommandName="Atender" CommandArgument='<%# Eval("IdTurno") %>'><i class="bi bi-check-lg"></i></asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="px-4 py-3 align-middle text-end" />
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="text-center py-5"><p class="text-muted mt-3">No hay turnos programados para hoy.</p></div>
                            </EmptyDataTemplate>
                        </asp:GridView>
                    </div>
                </div>
            </div>

        </div> </div> <aside class="quick-access-sidebar-fixed">
        <div class="quick-access-header">
            <h3><i class="bi bi-lightning-charge-fill"></i> Accesos Rápidos</h3>
        </div>
        <div class="quick-access-body">
            <div class="quick-access-links">
                <asp:HyperLink ID="hlQuickCalendario" runat="server" NavigateUrl="~/CalendarioMaster.aspx" CssClass="quick-access-link primary-link">
                    <i class="bi bi-calendar3-fill"></i><span>Mi Calendario</span><i class="bi bi-arrow-right"></i>
                </asp:HyperLink>
                <asp:HyperLink ID="hlQuickPacientes" runat="server" NavigateUrl="#" CssClass="quick-access-link info-link">
                    <i class="bi bi-people-fill"></i><span>Mis Pacientes</span><i class="bi bi-arrow-right"></i>
                </asp:HyperLink>
                <asp:HyperLink ID="hlQuickHistoriales" runat="server" NavigateUrl="~/HistorialesClinico.aspx" CssClass="quick-access-link warning-link">
                    <i class="bi bi-file-medical-fill"></i><span>Historiales</span><i class="bi bi-arrow-right"></i>
                </asp:HyperLink>
                <asp:HyperLink ID="hlQuickPerfil" runat="server" NavigateUrl="~/PerfilMedico.aspx" CssClass="quick-access-link settings-link">
                    <i class="bi bi-person-circle"></i><span>Mi Perfil</span><i class="bi bi-arrow-right"></i>
                </asp:HyperLink>
            </div>
            <div class="info-section">
                <h4><i class="bi bi-info-circle-fill"></i> Tips</h4>
                <p>Usa estos accesos rápidos para gestionar tus consultas eficientemente.</p>
            </div>
        </div>
    </aside>

</asp:Content>