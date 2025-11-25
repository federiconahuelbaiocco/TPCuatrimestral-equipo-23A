var EspecialidadesModule = (function () {
    'use strict';

    function cargarEspecialidad(id, descripcion, activo) {
        var estadoVacio = document.getElementById('estadoVacio');
        var formularioEdicion = document.getElementById('formularioEdicion');

        if (estadoVacio) estadoVacio.style.display = 'none';
        if (formularioEdicion) formularioEdicion.style.display = 'block';

        var hfEspecialidadId = document.querySelector('[id$="hfEspecialidadId"]');
        var txtNombreEditar = document.querySelector('[id$="txtNombreEditar"]');
        var chkActivoEditar = document.querySelector('[id$="chkActivoEditar"]');
        var sidebarTitulo = document.getElementById('sidebarTitulo');

        if (hfEspecialidadId) hfEspecialidadId.value = id;
        if (txtNombreEditar) txtNombreEditar.value = descripcion;

        if (sidebarTitulo) sidebarTitulo.textContent = 'Editar: ' + descripcion;

        if (chkActivoEditar) {
            chkActivoEditar.checked = activo;
            actualizarEstadoSidebar(chkActivoEditar);
        }

        console.log('Especialidad cargada:', id, descripcion);
    }

    function limpiarFormulario() {
        var estadoVacio = document.getElementById('estadoVacio');
        var formularioEdicion = document.getElementById('formularioEdicion');

        if (estadoVacio) estadoVacio.style.display = 'flex';
        if (formularioEdicion) formularioEdicion.style.display = 'none';

        var hfEspecialidadId = document.querySelector('[id$="hfEspecialidadId"]');
        var txtNombreEditar = document.querySelector('[id$="txtNombreEditar"]');
        var chkActivoEditar = document.querySelector('[id$="chkActivoEditar"]');
        var sidebarTitulo = document.getElementById('sidebarTitulo');

        if (hfEspecialidadId) hfEspecialidadId.value = '';
        if (txtNombreEditar) txtNombreEditar.value = '';
        if (chkActivoEditar) chkActivoEditar.checked = false;

        if (sidebarTitulo) sidebarTitulo.textContent = 'Editar Especialidad';
    }

    function actualizarEstadoSidebar(checkbox) {
        var statusText = document.getElementById('sidebarStatusText');
        var statusDescription = document.getElementById('sidebarStatusDescription');
        var statusMessage = document.getElementById('sidebarStatusMessage');

        if (!statusText || !statusDescription || !statusMessage) return;

        if (checkbox.checked) {
            statusText.textContent = 'Especialidad Activa';
            statusDescription.textContent = 'Una especialidad activa puede ser asignada a médicos';
            statusMessage.className = 'sidebar-status-message text-success';
        } else {
            statusText.textContent = 'Especialidad Inactiva';
            statusDescription.textContent = 'Una especialidad inactiva no podrá ser asignada a médicos';
            statusMessage.className = 'sidebar-status-message text-danger';
        }
    }

    return {
        cargarEspecialidad: cargarEspecialidad,
        limpiarFormulario: limpiarFormulario,
        actualizarEstadoSidebar: actualizarEstadoSidebar
    };
})();

function cargarEspecialidad(id, descripcion, activo) {
    EspecialidadesModule.cargarEspecialidad(id, descripcion, activo);
}

function limpiarFormulario() {
    EspecialidadesModule.limpiarFormulario();
}

function mostrarFormularioEdicion() {
    document.getElementById('formularioEdicion').style.display = 'block';
    document.getElementById('estadoVacio').style.display = 'none';
}