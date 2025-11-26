<%@ Page Title="" Language="C#" MasterPageFile="~/Recepcionista.Master" AutoEventWireup="true" CodeBehind="ListadoMedicos.aspx.cs" Inherits="TPCuatrimestral_equipo_23A.ListadoMedicos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="~/styles/styles.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!DOCTYPE html>

    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <meta charset="utf-8" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#1193d4",
                        "background-light": "#f6f7f8",
                        "background-dark": "#101c22",
                    },
                    fontFamily: {
                        "display": ["Inter", "sans-serif"]
                    },
                    borderRadius: { "DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px" },
                },
            },
        }
    </script>

    <div class="font-display bg-background-light dark:bg-background-dark">
        <div class="relative flex h-auto min-h-screen w-full flex-col group/design-root overflow-x-hidden">
            <div class="layout-container flex h-full grow flex-col">
                <header class="flex items-center justify-between whitespace-nowrap border-b border-solid border-slate-200 dark:border-slate-800 bg-white dark:bg-background-dark px-4 sm:px-6 lg:px-10 py-3">
                    <div class="flex items-center gap-4 text-slate-900 dark:text-white">
                        <div class="size-8 text-primary">
                        </div>
                        <h2 class="text-slate-900 dark:text-white text-lg font-bold leading-tight tracking-[-0.015em]">MediTurnos</h2>
                    </div>
                    <div class="flex flex-1 justify-end items-center gap-4">
                        <button class="flex max-w-[480px] cursor-pointer items-center justify-center overflow-hidden rounded-full h-10 w-10 bg-slate-100 dark:bg-slate-800 text-slate-900 dark:text-white text-sm font-bold leading-normal tracking-[0.015em] min-w-0">
                            <span class="material-symbols-outlined text-slate-600 dark:text-slate-300">notifications</span>
                        </button>
                        <div class="flex items-center gap-3">
                            <div class="user-avatar bg-center bg-no-repeat aspect-square bg-cover rounded-full size-10" data-alt="User avatar"></div>
                            <div class="hidden sm:flex flex-col text-right">
                                <p class="text-sm font-semibold text-slate-800 dark:text-slate-200">Ana García</p>
                                <p class="text-xs text-slate-500 dark:text-slate-400">Recepcionista</p>
                            </div>
                        </div>
                    </div>
                </header>
                <main class="flex-1 px-4 sm:px-6 lg:px-8 py-8">
                    <div class="layout-content-container flex flex-col max-w-7xl mx-auto flex-1 gap-6">
                        <div class="flex flex-col sm:flex-row flex-wrap justify-between items-start sm:items-center gap-4">
                            <h1 class="text-slate-900 dark:text-white text-4xl font-black leading-tight tracking-[-0.033em]">Listado de Médicos</h1>
                        </div>
                        <asp:GridView ID="dgvMedicos" runat="server" CssClass="table table-striped" AutoGenerateColumns="false">
                            <Columns>
                                <asp:BoundField HeaderText="Médico" DataField="Nombre" />
                                <asp:BoundField HeaderText="Especialidad" DataField="Especialidad" />
                            </Columns>
                        </asp:GridView>
                    </div>
                </main>
            </div>
        </div>
    </div>
</asp:Content>
