<%@ Page Title="Gestión de Consultorios" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Consultorios.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Consultorios" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <header class="mb-5">
        <h1 class="display-5 fw-bolder">Gestionar Consultorios</h1>
    </header>

    <div class="mb-5 p-4 bg-white rounded shadow-sm border">
        <h2 class="h5 fw-bold mb-4">Añadir Nuevo Consultorio</h2>
        
        <div class="row g-3 align-items-end">
            <div class="col-sm">
                <label for="<%= txtNombreConsultorio.ClientID %>" class="form-label fw-medium">Nombre del consultorio</label>
                <asp:TextBox ID="txtNombreConsultorio" runat="server" CssClass="form-control form-control-lg" placeholder="Ej. Sala de Rayos X"></asp:TextBox>
            </div>
            <div class="col-sm-auto">
                <asp:Button ID="btnAgregarConsultorio" runat="server" Text="Agregar Consultorio" CssClass="btn btn-primary btn-lg fw-bold px-4" OnClick="btnAgregarConsultorio_Click">
                </asp:Button>
            </div>
        </div>
    </div>
    
    <div>
        <h3 class="h5 fw-bold mb-4">Consultorios Actuales</h3>
        <div class="card shadow-sm overflow-hidden">
            
            <asp:GridView ID="gvConsultorios" runat="server"
                CssClass="table table-hover mb-0"
                AutoGenerateColumns="False"
                GridLines="None"
                DataKeyNames="IdConsultorio"
                OnRowCommand="gvConsultorios_RowCommand"
                OnRowDeleting="gvConsultorios_RowDeleting"
                >
                <HeaderStyle CssClass="bg-light text-secondary text-uppercase small" />
                <Columns>
                    <asp:BoundField DataField="IdConsultorio" HeaderText="ID" ItemStyle-CssClass="px-4 py-3 align-middle" HeaderStyle-CssClass="px-4 py-3"/>
                    
                    <asp:TemplateField HeaderText="Nombre del Consultorio" HeaderStyle-CssClass="px-4 py-3">
                        <ItemTemplate>
                            <span class="fw-medium text-dark"><%# Eval("Nombre") %></span>
                        </ItemTemplate>
                         <ItemStyle CssClass="px-4 py-3 align-middle" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Estado" HeaderStyle-CssClass="px-4 py-3">
                        <ItemTemplate>
                            <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                        </ItemTemplate>
                        <ItemStyle CssClass="px-4 py-3 align-middle" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="text-end px-4 py-3 align-middle" HeaderStyle-CssClass="text-end px-4 py-3">
                        <ItemTemplate>
                            <div class="d-inline-flex gap-2">
                                <asp:LinkButton ID="btnEditar" runat="server"
                                    CssClass="btn btn-sm btn-outline-primary"
                                    CommandName="Editar"
                                    CommandArgument='<%# Eval("IdConsultorio") %>'
                                    ToolTip="Editar">
                                    <i class="bi bi-pencil-fill"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnEliminar" runat="server"
                                    CssClass="btn btn-sm btn-outline-danger"
                                    CommandName="Eliminar"
                                    CommandArgument='<%# Eval("IdConsultorio") %>'
                                    OnClientClick="return confirm('¿Está seguro de que quiere eliminar este consultorio?');"
                                    ToolTip="Eliminar">
                                    <i class="bi bi-trash-fill"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="text-center p-5">No hay consultorios cargados.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

</asp:Content>