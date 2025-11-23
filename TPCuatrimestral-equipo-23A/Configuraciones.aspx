<%@ Page Title="Configuración del Sistema" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeBehind="Configuraciones.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Configuraciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="mb-5">
        <h1 class="display-5 fw-bolder">Configuración del Sistema</h1>
        <p class="text-secondary fs-5 mt-2">Gestiona las configuraciones globales del sistema.</p>
    </div>
    <div class="row g-4">
        <div class="col-12">
            <div class="card shadow-sm overflow-hidden">
                <div class="card-body p-4">
                    <h2 class="card-title h5 fw-bold mb-1">Horarios Predeterminados</h2>
                    <p class="card-subtitle text-muted mb-4">Establece los días laborables, horarios y duración de los turnos para la clínica.</p>

                    <div class="row g-4">
                        <div class="col-md-6">
                            <p class="fw-medium mb-3">Días Laborables</p>
                            <div class="d-flex flex-column">
                                <asp:CheckBoxList ID="cblDiasLaborables" runat="server" RepeatLayout="Flow" CssClass="d-flex flex-column gap-1">
                                    <asp:ListItem Text=" Lunes" Value="Monday" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text=" Martes" Value="Tuesday" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text=" Miércoles" Value="Wednesday" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text=" Jueves" Value="Thursday" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text=" Viernes" Value="Friday" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text=" Sábado" Value="Saturday"></asp:ListItem>
                                    <asp:ListItem Text=" Domingo" Value="Sunday"></asp:ListItem>
                                </asp:CheckBoxList>
                            </div>
                        </div>
                        <div class="col-md-6 d-flex flex-column gap-4">
                             <div>
                                <label for="<%= txtHoraApertura.ClientID %>" class="form-label fw-medium">Hora de Apertura</label>
                                <asp:TextBox ID="txtHoraApertura" runat="server" CssClass="form-control" TextMode="Time" Text="09:00"></asp:TextBox>
                            </div>
                            <div>
                                <label for="<%= txtHoraCierre.ClientID %>" class="form-label fw-medium">Hora de Cierre</label>
                                <asp:TextBox ID="txtHoraCierre" runat="server" CssClass="form-control" TextMode="Time" Text="18:00"></asp:TextBox>
                            </div>
                             <div>
                                <label for="<%= txtDuracionTurno.ClientID %>" class="form-label fw-medium">Duración del Turno (minutos)</label>
                                <asp:TextBox ID="txtDuracionTurno" runat="server" CssClass="form-control" TextMode="Number" Text="30"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-footer text-end bg-light">
                    <asp:Button ID="btnGuardarHorarios" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary" OnClick="btnGuardarHorarios_Click" />
                </div>
            </div>
        </div>
        <div class="col-12">
             <div class="card shadow-sm overflow-hidden">
                 <div class="card-body p-4">
                    <h2 class="card-title h5 fw-bold mb-1">Mensaje Interno Global</h2>
                    <p class="card-subtitle text-muted mb-4">Envía un mensaje interno a médicos, recepcionistas o a un usuario específico.</p>
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label for="txtMensajeInterno" class="form-label fw-medium">Mensaje</label>
                            <asp:TextBox ID="txtMensajeInterno" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" MaxLength="250" placeholder="Escribe el mensaje interno..."></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label for="ddlDestinatarioRol" class="form-label fw-medium">Destinatario (Rol)</label>
                            <asp:DropDownList ID="ddlDestinatarioRol" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Todos" Value="Todos" />
                                <asp:ListItem Text="Médicos" Value="Medico" />
                                <asp:ListItem Text="Recepcionistas" Value="Recepcionista" />
                            </asp:DropDownList>
                        </div>
                    </div>
                </div>
                <div class="card-footer text-end bg-light">
                    <asp:Button ID="btnGuardarMensajeInterno" runat="server" Text="Guardar Mensaje" CssClass="btn btn-primary" OnClick="btnGuardarMensajeInterno_Click" />
                </div>
            </div>
        </div>
     </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
</asp:Content>