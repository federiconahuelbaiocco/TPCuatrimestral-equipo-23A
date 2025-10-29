<%@ Page Title="Configuración del Sistema" Language="C#" MasterPageFile="~/Admin.master" AutoEventWireup="true" CodeBehind="Configuraciones.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Configuraciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-switch { position: relative; display: inline-block; width:44px; height:24px; vertical-align: middle;}
        .form-switch input { opacity:0; width:0; height:0; }
        .slider { position: absolute; cursor: pointer; top:0; left:0; right:0; bottom:0; background-color: #ccc; transition: .4s; border-radius:24px; }
        .slider:before { position: absolute; content: ""; height:18px; width:18px; left:3px; bottom:3px; background-color: white; transition: .4s; border-radius:50%; }
        .form-switch input[type=checkbox]:checked + .slider { background-color: #0d6efd; }
        .form-switch input[type=checkbox]:checked + .slider:before { transform: translateX(20px); }
    </style>
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
                    <h2 class="card-title h5 fw-bold mb-1">Notificaciones Automáticas</h2>
                    <p class="card-subtitle text-muted mb-4">Activa y personaliza las notificaciones por email y SMS para los pacientes.</p>

                    <div class="d-flex flex-column gap-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="fw-medium mb-0">Notificaciones por Email</p>
                                <small class="text-muted d-block">Enviar confirmaciones y recordatorios por email.</small>
                            </div>
                            <label class="form-switch">
                                <asp:CheckBox ID="chkNotifEmail" runat="server" CssClass="opacity-0 w-0 h-0" Checked="true"/>
                                <span class="slider"></span>
                            </label>
                        </div>
                         <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <p class="fw-medium mb-0">Notificaciones por SMS</p>
                                <small class="text-muted d-block">Enviar confirmaciones y recordatorios por SMS.</small>
                            </div>
                            <label class="form-switch">
                                 <asp:CheckBox ID="chkNotifSms" runat="server" CssClass="opacity-0 w-0 h-0"/>
                                 <span class="slider"></span>
                             </label>
                        </div>
                    </div>
                 </div>
                 <div class="card-footer text-end bg-light">
                    <asp:Button ID="btnGuardarNotificaciones" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary" OnClick="btnGuardarNotificaciones_Click" />
                </div>
            </div>
        </div>
        <div class="col-12">
             <div class="card shadow-sm overflow-hidden">
                 <div class="card-body p-4">
                    <h2 class="card-title h5 fw-bold mb-1">Integraciones de Terceros</h2>
                    <p class="card-subtitle text-muted mb-4">Conecta con servicios externos.</p>
                     <div class="d-flex flex-column gap-4">
                         <div>
                            <label for="<%= txtGoogleApiKey.ClientID %>" class="form-label fw-medium">Google Calendar API Key</label>
                            <asp:TextBox ID="txtGoogleApiKey" runat="server" CssClass="form-control" placeholder="Ingresa tu clave de API"></asp:TextBox>
                        </div>
                        <div>
                             <label for="<%= txtStripeApiKey.ClientID %>" class="form-label fw-medium">Stripe API Key</label>
                            <asp:TextBox ID="txtStripeApiKey" runat="server" CssClass="form-control" placeholder="Ingresa tu clave secreta" TextMode="Password"></asp:TextBox>
                        </div>
                    </div>
                 </div>
                  <div class="card-footer text-end bg-light">
                    <asp:Button ID="btnGuardarIntegraciones" runat="server" Text="Guardar Cambios" CssClass="btn btn-primary" OnClick="btnGuardarIntegraciones_Click" />
                </div>
            </div>
        </div>
     </div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ScriptsPlaceHolder" runat="server">
</asp:Content>