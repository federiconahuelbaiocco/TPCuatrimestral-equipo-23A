<%@ Page Title="" Language="C#" MasterPageFile="~/Recepcionista.Master" AutoEventWireup="true" CodeBehind="Gestion_de_Pacientes.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Gestion_de_Pacientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid py-4">
  <div class="mb-4">
            <h1 class="display-5 fw-bolder">Gestión de Pacientes</h1>
       <p class="text-secondary fs-5">Busca, añade y actualiza la información de los pacientes.</p>
   </div>

        <div class="card shadow-sm mb-4">
    <div class="card-body">
                <div class="input-group">
       <span class="input-group-text">
            <i class="bi bi-search"></i>
</span>
    <input aria-label="Buscar paciente" class="form-control" placeholder="Buscar paciente por nombre o DNI..." type="text" />
                </div>
        </div>
        </div>

        <div class="card shadow-sm">
          <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
     <h5 class="mb-0 fw-bold">
        <i class="bi bi-people-fill me-2"></i>Lista de Pacientes
    </h5>
          <asp:LinkButton ID="btnNuevoPaciente" runat="server" OnClick="btnNuevoPaciente_Click" CssClass="btn btn-primary d-flex align-items-center gap-2">
      <i class="bi bi-plus-lg"></i>
          Añadir Nuevo Paciente
      </asp:LinkButton>
  </div>
  <div class="card-body p-0">
   <asp:GridView ID="dgvPacientes" runat="server"
             AutoGenerateColumns="false" 
      DataKeyNames="IdPersona" 
        OnSelectedIndexChanged="dgvPacientes_SelectedIndexChanged" 
        CssClass="table table-hover mb-0"
       GridLines="None">
          <HeaderStyle CssClass="bg-light text-secondary text-uppercase small" />
     <Columns>
        <asp:TemplateField HeaderText="Apellido" HeaderStyle-CssClass="px-4 py-3">
           <ItemTemplate>
           <span class="fw-medium text-dark"><%# Eval("Apellido") %></span>
           </ItemTemplate>
           <ItemStyle CssClass="px-4 py-3 align-middle" />
    </asp:TemplateField>
           
    <asp:TemplateField HeaderText="Nombre" HeaderStyle-CssClass="px-4 py-3">
      <ItemTemplate>
         <span class="fw-medium text-dark"><%# Eval("Nombre") %></span>
  </ItemTemplate>
          <ItemStyle CssClass="px-4 py-3 align-middle" />
         </asp:TemplateField>
           
            <asp:BoundField HeaderText="Contacto" DataField="Email" 
 ItemStyle-CssClass="px-4 py-3 align-middle" 
        HeaderStyle-CssClass="px-4 py-3" />
     
        <asp:TemplateField HeaderText="Acción" HeaderStyle-CssClass="px-4 py-3 text-end" ItemStyle-CssClass="px-4 py-3 align-middle text-end">
       <ItemTemplate>
      <asp:LinkButton ID="btnVerDetalles" runat="server" 
        CommandName="Select" 
       CssClass="btn btn-sm btn-outline-primary"
          ToolTip="Ver Detalles">
        <i class="bi bi-eye-fill me-1"></i>Ver Detalles
   </asp:LinkButton>
          </ItemTemplate>
             </asp:TemplateField>
           </Columns>
         <EmptyDataTemplate>
         <div class="text-center p-5 text-muted">
        <i class="bi bi-inbox" style="font-size: 3rem;"></i>
      <p class="mt-3">No hay pacientes registrados.</p>
  </div>
          </EmptyDataTemplate>
     </asp:GridView>
     </div>
</div>
    </div>

</asp:Content>
