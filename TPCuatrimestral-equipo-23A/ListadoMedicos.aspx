<%@ Page Title="Listado de Médicos" Language="C#" MasterPageFile="~/Recepcionista.Master" AutoEventWireup="true" CodeBehind="ListadoMedicos.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.ListadoMedicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-4">
        <div class="mb-4">
            <h1 class="display-5 fw-bolder">Listado de Médicos</h1>
            <p class="text-secondary fs-5">Consulte los profesionales disponibles y sus especialidades.</p>
        </div>

        <div class="card shadow-sm border-0">
            <div class="card-body p-0">
                <div class="table-responsive">
                    <asp:GridView ID="dgvMedicos" runat="server"
                        CssClass="table table-hover align-middle mb-0"
                        AutoGenerateColumns="false"
                        GridLines="None">

                        <HeaderStyle CssClass="bg-light text-secondary text-uppercase small border-bottom" />

                        <Columns>
                            <asp:TemplateField HeaderText="Médico" HeaderStyle-CssClass="px-4 py-3">
                                <ItemTemplate>
                                    <span class="fw-medium text-dark"><%# Eval("Nombre") %></span>
                                </ItemTemplate>
                                <ItemStyle CssClass="px-4 py-3" />
                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Especialidad" HeaderStyle-CssClass="px-4 py-3">
                                <ItemTemplate>
                                    <span class="badge bg-info text-dark bg-opacity-10 border border-info border-opacity-25">
                                        <%# Eval("Especialidad") %>
                                    </span>
                                </ItemTemplate>
                                <ItemStyle CssClass="px-4 py-3" />
                            </asp:TemplateField>
                        </Columns>

                        <EmptyDataTemplate>
                            <div class="text-center p-5">
                                <i class="bi bi-people text-muted mb-3" style="font-size: 2.5rem; opacity: 0.5;"></i>
                                <p class="text-muted mb-0">No se encontraron médicos registrados con especialidades.</p>
                            </div>
                        </EmptyDataTemplate>

                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
