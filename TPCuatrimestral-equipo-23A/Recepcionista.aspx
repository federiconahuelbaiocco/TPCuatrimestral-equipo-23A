<%@ Page Title="Panel de Recepción" Language="C#" MasterPageFile="~/Recepcionista.Master" AutoEventWireup="true" CodeBehind="Recepcionista.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Recepcionista1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="admin-dashboard-layout">
        <div class="dashboard-main-content">
            <div class="mb-4">
                <h1 class="display-5 fw-bolder">Panel de Recepción</h1>
                <p class="text-secondary fs-5">Bienvenido, aquí puedes gestionar pacientes y turnos.</p>
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
                        <div class="stats-icon">
                            <i class="bi bi-people-fill"></i>
                        </div>
                        <h3>Pacientes</h3>
                        <p class="stats-number">
                            <asp:Label ID="lblPacienteCount" runat="server" Text="0"></asp:Label>
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card recep-card">
                        <div class="stats-icon">
                            <i class="bi bi-calendar-check"></i>
                        </div>
                        <h3>Turnos Hoy</h3>
                        <p class="stats-number">
                            <asp:Label ID="lblTurnosHoyCount" runat="server" Text="0"></asp:Label>
                        </p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="stats-card medico-card">
                        <div class="stats-icon">
                            <i class="bi bi-heart-pulse"></i>
                        </div>
                        <h3>Médicos Activos</h3>
                        <p class="stats-number">
                            <asp:Label ID="lblMedicoCount" runat="server" Text="0"></asp:Label>
                        </p>
                    </div>
                </div>
            </div>

            <div class="activity-section">
                <div class="activity-card">
                    <h2>
                        <i class="bi bi-people-fill"></i>
                        Lista de Pacientes
                    </h2>

                    <div class="card shadow-sm overflow-hidden mt-3">
                        <asp:GridView ID="gvPacientes" runat="server"
                            CssClass="table table-hover mb-0"
                            AutoGenerateColumns="False"
                            GridLines="None"
                            AllowPaging="true"
                            PageSize="5"
                            OnPageIndexChanging="gvPacientes_PageIndexChanging"
                            OnRowCommand="gvPacientes_RowCommand">
                            <HeaderStyle CssClass="bg-light text-secondary text-uppercase small" />
                            <Columns>
                                <asp:TemplateField HeaderText="Nombre Completo" HeaderStyle-CssClass="px-4 py-3">
                                    <ItemTemplate>
                                        <span class="fw-medium text-dark"><%# Eval("Apellido") %>, <%# Eval("Nombre") %></span>
                                    </ItemTemplate>
                                    <ItemStyle CssClass="px-4 py-3 align-middle" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="Dni" HeaderText="DNI" ItemStyle-CssClass="px-4 py-3 align-middle" HeaderStyle-CssClass="px-4 py-3" />
                                <asp:BoundField DataField="Email" HeaderText="Email" ItemStyle-CssClass="px-4 py-3 align-middle" HeaderStyle-CssClass="px-4 py-3" />
                                <asp:BoundField DataField="Telefono" HeaderText="Teléfono" ItemStyle-CssClass="px-4 py-3 align-middle" HeaderStyle-CssClass="px-4 py-3" />

                                <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="text-end px-4 py-3 align-middle" HeaderStyle-CssClass="text-end px-4 py-3">
                                    <ItemTemplate>
                                        <div class="d-inline-flex gap-2">
                                            <asp:LinkButton ID="btnEditar" runat="server"
                                                CssClass="btn btn-sm btn-outline-primary"
                                                CommandName="Editar"
                                                CommandArgument='<%# Eval("IdPersona") %>'
                                                ToolTip="Editar">
     <i class="bi bi-pencil-fill"></i>
                                            </asp:LinkButton>
                                        </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                <div class="text-center p-5">No hay pacientes registrados.</div>
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
                <asp:HyperLink ID="hlAgregarPaciente" runat="server" NavigateUrl="~/AgregarPaciente.aspx" CssClass="quick-access-link primary-link">
     <i class="bi bi-person-plus-fill"></i>
      <span>Agregar Paciente</span>
            <i class="bi bi-arrow-right"></i>
                </asp:HyperLink>

                <asp:HyperLink ID="hlGestionPacientes" runat="server" NavigateUrl="~/Gestion_de_Pacientes.aspx" CssClass="quick-access-link info-link">
                    <i class="bi bi-people-fill"></i>
     <span>Gestión de Pacientes</span>
         <i class="bi bi-arrow-right"></i>
                </asp:HyperLink>

                <asp:HyperLink ID="hlGestionTurnos" runat="server" NavigateUrl="~/Gestion_de_Turnos.aspx" CssClass="quick-access-link warning-link">
       <i class="bi bi-calendar-check-fill"></i>
         <span>Gestión de Turnos</span>
    <i class="bi bi-arrow-right"></i>
                </asp:HyperLink>

                <asp:HyperLink ID="hlListadoMedicos" runat="server" NavigateUrl="~/ListadoMedicos.aspx" CssClass="quick-access-link settings-link">
         <i class="bi bi-heart-pulse-fill"></i>
       <span>Listado de Médicos</span>
   <i class="bi bi-arrow-right"></i>
                </asp:HyperLink>
            </div>

            <div class="info-section">
                <h4>
                    <i class="bi bi-info-circle-fill"></i>
                    Tips
                </h4>
                <p>Usa estos accesos rápidos para gestionar pacientes, turnos y consultar médicos disponibles.</p>
            </div>
        </div>
    </aside>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
</asp:Content>
