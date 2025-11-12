<%@ Page Title="" Language="C#" MasterPageFile="~/Recepcionista.Master" AutoEventWireup="true" CodeBehind="Gestion_de_Pacientes.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Gestion_de_Pacientes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid py-4">
        <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap">
            <div>
                <h1 class="h2 fw-bold">Gestión de Pacientes</h1>
                <p class="text-muted">Busca, añade y actualiza la información de los pacientes.</p>
            </div>
            <asp:LinkButton ID="btnNuevoPaciente" runat="server" OnClick="btnNuevoPaciente_Click" CssClass="btn btn-primary d-flex align-items-center gap-2">
                    <svg class="bi bi-plus-lg" fill="currentColor" height="16" viewBox="0 0 16 16" width="16" xmlns="http://www.w3.org/2000/svg">
                        <path d="M8 2a.5.5 0 0 1 .5.5v5h5a.5.5 0 0 1 0 1h-5v5a.5.5 0 0 1-1 0v-5h-5a.5.5 0 0 1 0-1h5v-5A.5.5 0 0 1 8 2" fill-rule="evenodd"></path>
                    </svg>
                    Añadir Nuevo Paciente
            </asp:LinkButton>
        </div>
        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <div class="input-group mb-3">
                    <span class="input-group-text" id="basic-addon1">
                        <svg class="bi bi-search" fill="currentColor" height="16" viewBox="0 0 16 16" width="16" xmlns="http://www.w3.org/2000/svg">
                            <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"></path>
                        </svg>
                    </span>
                    <input aria-describedby="basic-addon1" aria-label="Buscar paciente" class="form-control" placeholder="Buscar paciente por nombre o DNI..." type="text" />
                </div>
            </div>
        </div>
        <div class="card shadow-sm">
            <div class="table">
                <div class="card-body p-0">
                    <asp:GridView ID="dgvPacientes" AutoGenerateColumns="false" DataKeyNames="IdPersona" OnSelectedIndexChanged="dgvPacientes_SelectedIndexChanged" CssClass="table table-ligth table-striped" runat="server">
                        <Columns>
                            <asp:BoundField HeaderText="Apellido" DataField="Apellido" />
                            <asp:BoundField HeaderText="Nombre" DataField="Nombre" />
                            <asp:BoundField HeaderText="Contacto" DataField="Email" />
                            <asp:CommandField ShowSelectButton="true" SelectText="Ver Detalles" HeaderText="Accion" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
