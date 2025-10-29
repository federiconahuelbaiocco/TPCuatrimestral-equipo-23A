<%@ Page Title="Gestión de Especialidades" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Especialidades.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Especialidades" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <header class="mb-5">
        <h1 class="display-5 fw-bolder">Gestionar Especialidades</h1>
    </header>


    <div class="mb-5 p-4 bg-white rounded shadow-sm border">
        <h2 class="h5 fw-bold mb-4">Añadir Nueva Especialidad</h2>
        
        <div class="row g-3 align-items-end">
            <div class="col-sm">
                <label for="<%= txtNombreEspecialidad.ClientID %>" class="form-label fw-medium">Nombre de la especialidad</label>
                <asp:TextBox ID="txtNombreEspecialidad" runat="server" CssClass="form-control form-control-lg" placeholder="Ej. Cardiología"></asp:TextBox>
            </div>
            <div class="col-sm-auto"> 
                <asp:Button ID="btnAgregarEspecialidad" runat="server" Text="Agregar Especialidad" CssClass="btn btn-primary btn-lg fw-bold px-4" OnClick="btnAgregarEspecialidad_Click">
                </asp:Button>
            </div>
        </div>
    </div>
    <div>
        <h3 class="h5 fw-bold mb-4">Especialidades Actuales</h3>
        <div class="card shadow-sm overflow-hidden">
            
            <asp:GridView ID="gvEspecialidades" runat="server" 
                CssClass="table table-hover mb-0" 
                AutoGenerateColumns="False" 
                GridLines="None"
                DataKeyNames="IdEspecialidad"
                OnRowCommand="gvEspecialidades_RowCommand"
                OnRowDeleting="gvEspecialidades_RowDeleting"
                >
                <HeaderStyle CssClass="bg-light text-secondary text-uppercase small" />
                <Columns>
                    <asp:BoundField DataField="IdEspecialidad" HeaderText="ID" ItemStyle-CssClass="px-4 py-3 align-middle" HeaderStyle-CssClass="px-4 py-3"/>
                    
                    <asp:TemplateField HeaderText="Nombre de la Especialidad" HeaderStyle-CssClass="px-4 py-3">
                        <ItemTemplate>
                           <span class="fw-medium text-dark"><%# Eval("Descripcion") %></span> 
                        </ItemTemplate>
                         <ItemStyle CssClass="px-4 py-3 align-middle" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Acciones" ItemStyle-CssClass="text-end px-4 py-3 align-middle" HeaderStyle-CssClass="text-end px-4 py-3">
                        <ItemTemplate>
                            <div class="d-inline-flex gap-2">
                                <asp:LinkButton ID="btnEditar" runat="server" 
                                    CssClass="btn btn-sm btn-outline-primary" 
                                    CommandName="EditarEsp" 
                                    CommandArgument='<%# Eval("IdEspecialidad") %>'
                                    ToolTip="Editar">
                                    <i class="bi bi-pencil-fill"></i>
                                </asp:LinkButton>
                                <asp:LinkButton ID="btnEliminar" runat="server" 
                                    CssClass="btn btn-sm btn-outline-danger" 
                                    CommandName="EliminarEsp" 
                                    CommandArgument='<%# Eval("IdEspecialidad") %>'
                                    OnClientClick="return confirm('¿Estás seguro de que quieres eliminar esta especialidad?');"
                                    ToolTip="Eliminar">
                                    <i class="bi bi-trash-fill"></i>
                                </asp:LinkButton>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataTemplate>
                    <div class="text-center p-5">No hay especialidades cargadas.</div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>

</asp:Content>
