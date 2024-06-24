#!/bin/bash

# Salir si algo male sal
set -e

# Variables predeterminadas
URL_BASE="https://raw.githubusercontent.com/Jotalea/TheftDeterrent/main"
FILES=(
    "theftdeterrentclient-lib_6.0.0.11.huayra10_amd64.deb"
    "theftdeterrentclient_6.0.0.11.huayra10_amd64.deb"
    "theftdeterrentdaemon_6.0.0.11.huayra10_amd64.deb"
    "theftdeterrentguardian_6.0.0.11.huayra10_amd64.deb"
)
PATCHED_FILE="theftdeterrentguardian_6.0.0.11.debian10_amd64.deb"
DEFAULT_DIR="$HOME/tda"
LOG_FILE="tda_install_log.txt"
SCRIPT_VERSION=2
USE_LOG=true
CLEANUP=true

# Función para manejar errores
handle_error() {
    echo "Error en el paso: $1" >&2
    exit 1
}

# Función de ayuda
show_help() {
    echo "Uso: $0 [OPCIONES]"
    echo "Opciones:"
    echo "  --solo-descarga, --download-only, -D   No instala el programa, sólo descarga los archivos de instalación"
    echo "  --help, -H                             Muestra esta ayuda y no ejecuta el resto del script"
    echo "  --log <archivo>, -L <archivo>          Loguea los resultados al archivo especificado en lugar de $LOG_FILE"
    echo "  --dir <directorio>, -D <directorio>    Cambia el directorio a usar por el especificado"
    echo "  --mirror <URL>, -M <URL>               Permite usar un servidor distinto para descargar los archivos"
    echo "  --no-limpiar, --no-cleanup             Después de la instalación, no borra los archivos .deb que se usaron"
    echo "  --no-log                               Deshabilita el logging a $LOG_FILE"
    exit 0
}

# Procesar parámetros opcionales
process_parameters() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --solo-descarga | --download-only | -D)
                INSTALL=false
                CLEANUP=false
                ;;
            --no-limpiar | --no-cleanup)
                CLEANUP=false
                ;;
            --help | -H)
                show_help
                ;;
            --no-log)
                USE_LOG=false
                ;;
            --log | -L)
                shift
                LOG_FILE="$1"
                ;;
            --dir | -D)
                shift
                DIR="$1"
                validate_directory "$DIR"
                ;;
            --mirror | -M)
                shift
                URL_BASE="$1"
                ;;
            *)
                echo "Parámetro desconocido: $1"
                exit 1
                ;;
        esac
        shift
    done
}

# Función para validar y crear el directorio si no existe
validate_directory() {
    local dir="$1"
    if ! [[ -d "$dir" ]]; then
        echo "Creando el directorio $dir..."
        mkdir -p "$dir" || handle_error "No se pudo crear el directorio $dir"
    fi
    DEFAULT_DIR="$dir"
}

# Verificar si se ejecuta como root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        handle_error "Este script tiene que ejecutarse como root."
    fi
}

# Verificar dependencias
check_dependencies() {
    echo "Verificando dependencias..."
    dpkg -s wget &> /dev/null || apt update && apt install -y wget || handle_error "Instalar wget"
    dpkg -s dpkg &> /dev/null || handle_error "dpkg no está instalado"
}

# Verificar espacio en disco
check_disk_space() {
    local required_space_mb=50
    local available_space_mb=$(df "$DEFAULT_DIR" | tail -1 | awk '{print $4}')
    available_space_mb=$((available_space_mb / 1024))

    if (( available_space_mb < required_space_mb )); then
        handle_error "No tenés suficiente espacio. Necesitás al menos ${required_space_mb}MB más."
    fi
}

# Cambiar al directorio
change_directory() {
    cd "$DEFAULT_DIR" || handle_error "No se puede usar el directorio $DEFAULT_DIR"
}

# Descargar archivos .deb
download_files() {
    for FILE in "${FILES[@]}"; do
        if [ "$FILE" == "theftdeterrentguardian_6.0.0.11.huayra10_amd64.deb" ] && [ "$NEED_PATCH" == "true" ]; then
            FILE=$PATCHED_FILE
        fi

        if [ -f "$FILE" ]; then
            echo "Ya tenés el archivo $FILE, no lo voy a descargar de nuevo."
        else
            echo "Descargando $FILE..."
            wget "$URL_BASE/$FILE" || handle_error "No se pudo descargar $FILE desde $URL_BASE"
            chown "$USER:$USER" "$FILE"  # Cambiar propietario y grupo al usuario actual
            chmod 644 "$FILE"            # Establecer permisos rw-r--r--
        fi
    done
}

# Instalar archivos .deb
install_files() {
    for FILE in "${FILES[@]}"; do
        if [ "$FILE" == "theftdeterrentguardian_6.0.0.11.huayra10_amd64.deb" ] && [ "$NEED_PATCH" == "true" ]; then
            FILE=$PATCHED_FILE
        fi

        echo "Instalando $FILE..."
        sudo dpkg -i "$FILE" || handle_error "No se pudo instalar $FILE"
    done
}

# Limpiar archivos .deb
clean_up() {
    echo "Limpiando archivos .deb..."
    rm -f *.deb || handle_error "No se pudo borrar los archivos .deb"
}

# Iniciar logging
init_logging() {
    if $USE_LOG; then
        echo "Instalando..." > "$LOG_FILE"
    fi
}

# Mostrar ayuda si no se proporcionan parámetros
if [[ $# -eq 0 ]]; then
    show_help
fi

# Procesar parámetros
process_parameters "$@"

# Ejecutar funciones
check_root
check_dependencies
check_disk_space
validate_directory "$DEFAULT_DIR"
change_directory
download_files

if [[ "$INSTALL" == true ]]; then
    install_files
fi

if [[ "$CLEANUP" == true ]]; then
    clean_up
fi

# Finalizar
if $USE_LOG; then
    echo "Se instaló el Theft Deterrent." >> "$LOG_FILE"
    echo "Podés leer las instrucciones de post-instalación en https://github.com/Jotalea/TheftDeterrent/blob/main/README.md#post-instalación" >> "$LOG_FILE"
else
    echo "Se instaló el Theft Deterrent."
    echo "Podés leer las instrucciones de post-instalación en https://github.com/Jotalea/TheftDeterrent/blob/main/README.md#post-instalación"
fi

exit 0
