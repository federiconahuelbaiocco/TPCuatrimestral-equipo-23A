window.mostrarToastMensaje = function(mensaje, tipo = "info") {
    var div = document.createElement('div');
    div.innerText = mensaje;
    var safeMensaje = div.innerHTML;

    var toast = document.createElement('div');
    toast.className = 'position-fixed top-50 start-50 translate-middle text-bg-' + tipo + ' border-0 shadow-lg rounded-3';
    toast.style.zIndex = 99999;
    toast.style.minWidth = '480px';
    toast.style.maxWidth = '90vw';
    toast.style.padding = '1rem 1.25rem';
    toast.style.fontSize = '1.05rem';
    toast.style.boxSizing = 'border-box';

    toast.innerHTML = "<div class='d-flex align-items-center justify-content-center gap-3 w-100'>" +
        "<div class='flex-grow-1 text-center'>" + safeMensaje + "</div>" +
        "<button type='button' class='btn-close btn-close-white' aria-label='Close' onclick='(function(el){el.parentNode.removeChild(el);})(this.closest(\"div.position-fixed\"));'></button>" +
        "</div>";

    document.body.appendChild(toast);
    // No auto-cerrar: el toast se cerrará solo cuando el usuario pulse el botón de cierre
};
