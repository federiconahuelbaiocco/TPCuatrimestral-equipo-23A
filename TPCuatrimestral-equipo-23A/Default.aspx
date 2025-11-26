<%@ Page Title="Inicio de Sesión" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row justify-content-center align-items-center" style="min-height: 90vh;">
            <div class="col-md-7 col-lg-6">

                <div class="card login-card shadow-lg border-0 mb-4">
                    <div class="card-header login-header text-center text-white bg-primary">
                        <h4 class="mb-0">
                            <i class="bi bi-heart-pulse-fill me-2"></i>UTN SALUD
                        </h4>
                    </div>
                    <div class="card-body">
                        <div class="login-motivational-row text-center mb-4">
                            <i class="bi bi-person-circle login-hero-icon" style="font-size: 3rem; color: #0d6efd;"></i>
                            <div class="login-motivational mt-2">
                                Bienvenido al sistema de gestión médica.<br>
                                Por favor, inicia sesión para continuar.
                            </div>
                        </div>

                        <asp:Panel runat="server" DefaultButton="btnLogin">
                            <div class="mb-3">
                                <label for="txtUsuario" class="form-label">Usuario</label>
                                <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" placeholder="Ingrese su usuario" />
                                <asp:RequiredFieldValidator ID="rfvUsuario" runat="server"
                                    ControlToValidate="txtUsuario"
                                    ErrorMessage="El usuario es requerido"
                                    CssClass="text-danger small"
                                    Display="Dynamic"
                                    ValidationGroup="Login" />
                            </div>

                            <div class="mb-3">
                                <label for="txtClave" class="form-label">Contraseña</label>
                                <asp:TextBox ID="txtClave" runat="server" TextMode="Password" CssClass="form-control" placeholder="Ingrese su contraseña" />
                                <asp:RequiredFieldValidator ID="rfvClave" runat="server"
                                    ControlToValidate="txtClave"
                                    ErrorMessage="La contraseña es requerida"
                                    CssClass="text-danger small"
                                    Display="Dynamic"
                                    ValidationGroup="Login" />
                            </div>

                            <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger d-block mb-3 p-2 small" Visible="false"></asp:Label>

                            <div class="d-grid gap-2">
                                <asp:Button ID="btnLogin" runat="server" Text="Iniciar Sesión" CssClass="btn btn-primary" OnClick="btnLogin_Click" ValidationGroup="Login" />
                            </div>
                        </asp:Panel>
                    </div>
                </div>

                <div class="card shadow-sm border-0">
                    <div class="card-header bg-light">
                        <h6 class="card-title mb-0">¿Olvidaste tu contraseña?</h6>
                    </div>
                    <div class="card-body">
                        <p class="small text-muted">Ingresa tu correo electrónico registrado y te enviaremos tus credenciales.</p>

                        <asp:Panel runat="server" DefaultButton="btnRecuperar">
                            <div class="mb-3">
                                <label for="txtEmail" class="form-label">Correo Electrónico</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="ejemplo@correo.com" TextMode="Email" />

                                <asp:RequiredFieldValidator ID="rfvEmail" runat="server"
                                    ControlToValidate="txtEmail"
                                    ErrorMessage="El email es requerido."
                                    CssClass="text-danger small"
                                    Display="Dynamic"
                                    ValidationGroup="Recuperar" />

                                <asp:RegularExpressionValidator ID="revEmail" runat="server"
                                    ControlToValidate="txtEmail"
                                    ErrorMessage="Ingrese un formato de email válido."
                                    ValidationExpression="^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"
                                    CssClass="text-danger small"
                                    Display="Dynamic"
                                    ValidationGroup="Recuperar" />
                            </div>

                            <div class="d-grid gap-2">
                                <asp:Button ID="btnRecuperar" runat="server" Text="Enviar mis datos" CssClass="btn btn-outline-secondary" OnClick="btnRecuperar_Click" ValidationGroup="Recuperar" />
                            </div>

                            <div class="mt-2">
                                <asp:Label ID="lblRecuperarMensaje" runat="server" CssClass="small fw-bold" Visible="false"></asp:Label>
                            </div>
                        </asp:Panel>
                    </div>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
