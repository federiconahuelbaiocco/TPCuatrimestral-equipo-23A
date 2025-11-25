<%@ Page Title="Error" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Error.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Error" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <header class="mb-5">
        <h1 class="display-5 fw-bolder text-danger">Ha ocurrido un error</h1>
    </header>

    <div class="alert alert-danger">
        <strong>Se ha producido una excepción en el servidor.</strong>
    </div>

    <asp:Label ID="lblErrorTitulo" runat="server" CssClass="h5" Text="Mensaje de error:"></asp:Label>

    <div class="card bg-light p-3 mt-3">
        <code>
            <asp:Literal ID="litErrorDetalle" runat="server"></asp:Literal>
        </code>
    </div>

</asp:Content>
