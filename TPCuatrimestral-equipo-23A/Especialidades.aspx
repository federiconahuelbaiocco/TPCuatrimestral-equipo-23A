<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Especialidades.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.Especialidades" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>Especialidades</h1>
    <p>Listado de todas las especialidades actuales:</p>
    <asp:GridView ID="gvEspecialidades" runat="server" AutoGenerateColumns="true" CssClass="table table-striped table-bordered"> </asp:GridView>
</asp:Content>
