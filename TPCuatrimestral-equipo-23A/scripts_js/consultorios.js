function cargarConsultorio(id, nombre, activo) {
    document.getElementById('estadoVacio').style.display = 'none';
    document.getElementById('formularioEdicion').style.display = 'block';

    var hfConsultorioId = document.querySelector('[id$="hfConsultorioId"]');
    var txtNombreEditar = document.querySelector('[id$="txtNombreEditar"]');
    var chkActivoEditar = document.querySelector('[id$="chkActivoEditar"]');

    if (hfConsultorioId) hfConsultorioId.value = id;
    if (txtNombreEditar) txtNombreEditar.value = nombre;
    if (chkActivoEditar) chkActivoEditar.checked = activo;

    document.getElementById('sidebarTitulo').textContent = 'Editar: ' + nombre;

    if (chkActivoEditar) {
      actualizarEstadoSidebar(chkActivoEditar);
    }

    console.log('Consultorio cargado - ID:', id, 'Nombre:', nombre, 'Activo:', activo);
}

function limpiarFormulario() {
    document.getElementById('estadoVacio').style.display = 'flex';
    document.getElementById('formularioEdicion').style.display = 'none';

    var hfConsultorioId = document.querySelector('[id$="hfConsultorioId"]');
  var txtNombreEditar = document.querySelector('[id$="txtNombreEditar"]');
    var chkActivoEditar = document.querySelector('[id$="chkActivoEditar"]');

    if (hfConsultorioId) hfConsultorioId.value = '';
    if (txtNombreEditar) txtNombreEditar.value = '';
    if (chkActivoEditar) chkActivoEditar.checked = false;

    document.getElementById('sidebarTitulo').textContent = 'Editar Consultorio';

console.log('Formulario limpiado');
}

function actualizarEstadoSidebar(checkbox) {
    var statusText = document.getElementById('sidebarStatusText');
    var statusDescription = document.getElementById('sidebarStatusDescription');
    var statusMessage = document.getElementById('sidebarStatusMessage');

    if (checkbox.checked) {
        statusText.textContent = 'Consultorio Activo';
        statusDescription.textContent = 'Un consultorio activo puede recibir turnos y asignaciones';
      statusMessage.className = 'sidebar-status-message text-success';
    } else {
      statusText.textContent = 'Consultorio Inactivo';
        statusDescription.textContent = 'Un consultorio inactivo no recibirá turnos ni asignaciones';
        statusMessage.className = 'sidebar-status-message text-danger';
    }
}
