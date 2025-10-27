<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 <div class="container">
     <div class="row justify-content-center">
         <div class="col-4">
             <div class="card">

                 
                     <div class="card-header text-center">
                         <p class="text-primary-emphasis">UTN SALUD</p>
                     </div>
                 
                 <div class="card-body">

                     <p>Inicia sesion para ingresar al sistema</p>
                     <label for="inputPassword5" class="form-label">Correo Electronico</label>
                     <input type="email" class="form-control" id="exampleFormControlInput1" placeholder="name@example.com">
                     <label for="inputPassword5" class="form-label">Contraseña</label>
                     <input type="password" id="contra" class="form-control" aria-describedby="passwordHelpBlock">
                     <div id="passwordHelpBlock" class="form-text">
                         <div class="text-center">
                             <br />
                             <button type="button" class="btn btn-primary btn-sm">Iniciar sesion</button>
                             <br />
                             <a href="" >¿Olvidaste tu contraseña?</a>
                             <p>¿No tenes cuenta? <a href="" > Registrate</a></p> 
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </div>
 </div>

</asp:Content>
