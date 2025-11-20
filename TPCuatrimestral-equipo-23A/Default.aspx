<%@ Page Title="Inicio de Sesión" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row justify-content-center mt-5">
            <div class="col-md-4">
                <div class="card shadow">
                    <div class="card-header text-center bg-primary text-white">
                        <h4 class="mb-0">
                            <i class="bi bi-heart-pulse-fill"></i> UTN SALUD
                        </h4>
                    </div>
                    <div class="card-body">
                        <p class="text-center text-muted mb-4">Inicia sesión para ingresar al sistema</p>
                        
                        <asp:Panel runat="server" DefaultButton="btnLogin">
                            <div class="mb-3">
                                <label for="txtUsuario" class="form-label">Usuario</label>
                                <asp:TextBox ID="txtUsuario" runat="server" CssClass="form-control" 
                                    placeholder="Ingrese su usuario" />
                                <asp:RequiredFieldValidator ID="rfvUsuario" runat="server" 
                                    ControlToValidate="txtUsuario" 
                                    ErrorMessage="El usuario es requerido" 
                                    CssClass="text-danger small" 
                                    Display="Dynamic" />
                            </div>
                            
                            <div class="mb-3">
                                <label for="txtClave" class="form-label">Contraseña</label>
                                <asp:TextBox ID="txtClave" runat="server" TextMode="Password" 
                                    CssClass="form-control" 
                                    placeholder="Ingrese su contraseña" />
                                <asp:RequiredFieldValidator ID="rfvClave" runat="server" 
                                    ControlToValidate="txtClave" 
                                    ErrorMessage="La contraseña es requerida" 
                                    CssClass="text-danger small" 
                                    Display="Dynamic" />
                            </div>

                            <asp:Label ID="lblError" runat="server" CssClass="text-danger small d-block mb-3" 
                                Visible="false"></asp:Label>

                            <div class="d-grid gap-2">
                                <asp:Button ID="btnLogin" runat="server" Text="Iniciar Sesión" 
                                    CssClass="btn btn-primary" OnClick="btnLogin_Click" />
                            </div>

                            <div class="text-center mt-3">
                                <a href="#" class="text-decoration-none small">¿Olvidaste tu contraseña?</a>
                            </div>
                        </asp:Panel>
                    </div>
                </div>

                <div class="card mt-3 shadow-sm">
                    <div class="card-body">
                        <h6 class="card-title">Usuarios de Prueba:</h6>
                        <small class="text-muted">
                            <strong>Administrador:</strong> admin_gonzalez / clave123<br />
                            <strong>Recepcionista:</strong> recep_diaz / clave123<br />
                            <strong>Médico:</strong> ltorres / clave123
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
