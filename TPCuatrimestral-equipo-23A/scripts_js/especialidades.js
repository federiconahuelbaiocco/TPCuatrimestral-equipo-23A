var EspecialidadesModule = (function() {
    'use strict';

    function cargarEspecialidad(id, descripcion, activo) {
        document.getElementById('estadoVacio').style.display = 'none';
  document.getElementById('formularioEdicion').style.display = 'block';

        var hfEspecialidadId = document.querySelector('[id$="hfEspecialidadId"]');
        var txtNombreEditar = document.querySelector('[id$="txtNombreEditar"]');
  var chkActivoEditar = document.querySelector('[id$="chkActivoEditar"]');

        if (hfEspecialidadId) hfEspecialidadId.value = id;
        if (txtNombreEditar) txtNombreEditar.value = descripcion;
        if (chkActivoEditar) chkActivoEditar.checked = activo;

     document.getElementById('sidebarTitulo').textContent = 'Editar: ' + descripcion;

   if (chkActivoEditar) {
   actualizarEstadoSidebar(chkActivoEditar);
   }

        console.log('Especialidad cargada - ID:', id, 'Descripcion:', descripcion, 'Activo:', activo);
    }

    function limpiarFormulario() {
 document.getElementById('estadoVacio').style.display = 'flex';
 document.getElementById('formularioEdicion').style.display = 'none';

        var hfEspecialidadId = document.querySelector('[id$="hfEspecialidadId"]');
        var txtNombreEditar = document.querySelector('[id$="txtNombreEditar"]');
        var chkActivoEditar = document.querySelector('[id$="chkActivoEditar"]');

   if (hfEspecialidadId) hfEspecialidadId.value = '';
        if (txtNombreEditar) txtNombreEditar.value = '';
        if (chkActivoEditar) chkActivoEditar.checked = false;

        document.getElementById('sidebarTitulo').textContent = 'Editar Especialidad';

        console.log('Formulario limpiado');
    }

    function actualizarEstadoSidebar(checkbox) {
        var statusText = document.getElementById('sidebarStatusText');
        var statusDescription = document.getElementById('sidebarStatusDescription');
     var statusMessage = document.getElementById('sidebarStatusMessage');

        if (checkbox.checked) {
  statusText.textContent = 'Especialidad Activa';
       statusDescription.textContent = 'Una especialidad activa puede ser asignada a medicos';
   statusMessage.className = 'sidebar-status-message text-success';
 } else {
    statusText.textContent = 'Especialidad Inactiva';
  statusDescription.textContent = 'Una especialidad inactiva no podra ser asignada a medicos';
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
    if (document.querySelector('[id$="hfEspecialidadId"]')) {
        EspecialidadesModule.limpiarFormulario();
    }
}

function actualizarEstadoSidebar(checkbox) {
    if (document.querySelector('[id$="hfEspecialidadId"]')) {
   EspecialidadesModule.actualizarEstadoSidebar(checkbox);
    }
}
