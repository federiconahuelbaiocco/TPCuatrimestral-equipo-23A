<%@ Page Title="" Language="C#" MasterPageFile="~/Recepcionista.Master" AutoEventWireup="true" CodeBehind="Gestion_de_Turnos.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.GestionDeTurnos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid py-4">
        <div class="mb-4">
            <h1 class="display-5 fw-bolder">Gestión de Turnos</h1>
            <p class="text-secondary fs-5">Administra los turnos médicos de tu centro de salud.</p>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-white py-3">
                
                    <div class="col-md-3 text-end">
                        <button class="btn btn-primary" data-bs-target="#scheduleModal" data-bs-toggle="modal" type="button">
                            <i class="bi bi-plus-lg me-2"></i>Programar Turno
                        </button>
                    </div>
                </div>
           
            <h2>Listado de Turnos</h2>

            <asp:GridView ID="gvTurnos" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                EmptyDataText="No hay turnos registrados." OnRowCommand="gvTurnos_RowCommand" DataKeyNames="IdTurno">

                <Columns>

                    <asp:BoundField DataField="PacienteNombreCompleto" HeaderText="Paciente" />
                    <asp:BoundField DataField="MedicoNombreCompleto" HeaderText="Médico" />
                    <asp:BoundField DataField="FechaHora" HeaderText="Fecha y Hora"
                        DataFormatString="{0:dd/MM/yyyy HH:mm}" />
                    <asp:BoundField DataField="MotivoConsulta" HeaderText="Motivo" />
                    <asp:BoundField DataField="Observaciones" HeaderText="Observaciones" />
                    <asp:BoundField DataField="Estado" HeaderText="Estado" />
                    

                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="btnCancelar" runat="server"
                                Text="Cancelar"
                                CommandName="CancelarTurno"
                                CommandArgument='<%# Eval("IdTurno") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

            </asp:GridView>


        </div>
    </div>

    <div class="modal fade" id="scheduleModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title">Programar Nuevo Turno</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <asp:UpdatePanel ID="updTurno" runat="server">
                        <ContentTemplate>

                            <!-- DNI DEL PACIENTE -->
                            <div class="mb-3">
                                <label class="form-label">DNI del Paciente</label>
                                <div class="input-group">
                                    <asp:TextBox ID="txtDniPaciente" CssClass="form-control" runat="server"></asp:TextBox>

                                    <asp:Button ID="btnBuscarPaciente" runat="server"
                                        Text="Buscar" CssClass="btn btn-secondary"
                                        OnClick="btnBuscarPaciente_Click" />
                                </div>
                            </div>

                            <!-- NOMBRE DEL PACIENTE (solo lectura) -->
                            <div class="mb-3">
                                <label class="form-label">Nombre del Paciente</label>
                                <asp:TextBox ID="txtNombrePaciente" CssClass="form-control"
                                    runat="server" ReadOnly="true"></asp:TextBox>
                                <asp:HiddenField ID="hfIdPaciente" runat="server" />
                            </div>

                            <!-- ESPECIALIDAD -->
                            <div class="row g-3">
                                <div class="col mb-6">
                                    <label class="form-label">Especialidad</label>
                                    <asp:DropDownList ID="ddlEspecialidad" CssClass="form-select"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlEspecialidad_SelectedIndexChanged"
                                        runat="server">
                                    </asp:DropDownList>
                                </div>

                                <!-- MÉDICO -->
                                <div class="col mb-6">
                                    <label class="form-label">Médico</label>
                                    <asp:DropDownList ID="ddlMedico" CssClass="form-select"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlMedico_SelectedIndexChanged"
                                        runat="server">
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <!-- FECHA -->
                            <div class="mb-3">
                                <label class="form-label">Fecha disponible</label>
                                <asp:DropDownList ID="ddlFecha" CssClass="form-select"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlFecha_SelectedIndexChanged"
                                    runat="server">
                                </asp:DropDownList>
                            </div>

                            <!-- HORARIO -->
                            <div class="mb-3">
                                <label class="form-label">Horarios disponibles</label>
                                <asp:DropDownList ID="ddlHorario" CssClass="form-select" runat="server">
                                </asp:DropDownList>
                            </div>
                            <div>
                                <label>Motivo de la consulta:</label>
                                <asp:TextBox ID="txtMotivo" runat="server" TextMode="MultiLine" CssClass="form-control" />
                            </div>

                            <div>
                                <label>Observaciones:</label>
                                <asp:TextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" CssClass="form-control" />
                            </div>


                            <!-- CONSULTORIO -->


                            <div class="modal-footer">
                                <asp:Button ID="btnGuardarTurno" runat="server" Text="Guardar Turno"
                                    CssClass="btn btn-success" OnClick="btnGuardarTurno_Click" />
                            </div>
                            <asp:Label ID="lblMensaje" runat="server" Visible="false" CssClass="fw-bold"></asp:Label>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
</div>
                <div class="modal fade" id="modalModificar" tabindex="-1" role="dialog">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">

                            <div class="modal-header">
                                <h5 class="modal-title">Modificar Turno</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span>&times;</span>
                                </button>
                            </div>

                            <div class="modal-body">
                                Paciente:
        <asp:TextBox ID="txtPacienteMod" runat="server" CssClass="form-control" ReadOnly="true" />

                                Médico:
        <asp:TextBox ID="txtMedicoMod" runat="server" CssClass="form-control" ReadOnly="true" />

                                Fecha:
        <asp:TextBox ID="txtFechaMod" runat="server" CssClass="form-control" ReadOnly="true" />

                                Horario:
        <asp:DropDownList ID="ddlHorariosModificar" runat="server" CssClass="form-control"></asp:DropDownList>

                            </div>

                            <div class="modal-footer">
                                <asp:Button ID="btnGuardarModificacion" runat="server" Text="Guardar"
                                    CssClass="btn btn-primary" OnClick="btnGuardarModificacion_Click" />

                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancelar</button>
                            </div>

                        </div>
                    </div>
                </div>
                <script type="text/javascript">
                    function abrirModalModificar() {
                        document.getElementById("modalModificar").style.display = "block";
                    }

                    function cerrarModalModificar() {
                        document.getElementById("modalModificar").style.display = "none";
                    }
                </script>

            </div>
        
    </div>
</asp:Content>
