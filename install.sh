#!/bin/bash

# Variables
URL_BASE="https://raw.githubusercontent.com/Jotalea/TheftDeterrent/main"
FILES=(
    "theftdeterrentclient-lib_6.0.0.11.huayra10_amd64.deb"
    "theftdeterrentclient_6.0.0.11.huayra10_amd64.deb"
    "theftdeterrentdaemon_6.0.0.11.huayra10_amd64.deb"
    "theftdeterrentguardian_6.0.0.11.huayra10_amd64.deb"
)
PATCHED_FILE="theftdeterrentguardian_6.0.0.11.debian10_amd64.deb"
DIR=${1:-~/tda}
LOG_FILE="tda_install_log.txt"

# Función para manejar errores
handle_error() {
    echo "Error en el paso: $1" | tee -a "$LOG_FILE"
    exit 1
}

# Verificar si se ejecuta como root
check_root() {
    if [ "$EUID" -ne 0 ]; then
        handle_error "Este script tiene que ejecutarse como root. Usá 'sudo ./install.sh'"
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
    local available_space_mb=$(df "$DIR" | tail -1 | awk '{print $4}')
    available_space_mb=$((available_space_mb / 1024))

    if (( available_space_mb < required_space_mb )); then
        handle_error "No tenés mas espacio. Necesitás al menos ${required_space_mb}MB más."
    fi
}

# Crear el directorio si no existe
create_directory() {
    echo "Creando el directorio $DIR..."
    mkdir -p "$DIR" || handle_error "Crear directorio"
}

# Cambiar al directorio
change_directory() {
    cd "$DIR" || handle_error "Cambiar de directorio"
}

# Descargar los archivos .deb
download_files() {
    for FILE in "${FILES[@]}"; do
        if [ "$FILE" == "theftdeterrentguardian_6.0.0.11.huayra10_amd64.deb" ] && [ "$NEED_PATCH" == "true" ]; then
            FILE=$PATCHED_FILE
        fi

        if [ -f "$FILE" ]; then
            echo "El archivo $FILE ya lo tenés, no lo descargo."
        else
            echo "Descargando $FILE..."
            wget "$URL_BASE/$FILE" || handle_error "Descargar $FILE"
        fi
    done
}

# Instalar los archivos .deb descargados
install_files() {
    for FILE in "${FILES[@]}"; do
        if [ "$FILE" == "theftdeterrentguardian_6.0.0.11.huayra10_amd64.deb" ] && [ "$NEED_PATCH" == "true" ]; then
            FILE=$PATCHED_FILE
        fi

        echo "Instalando $FILE..."
        sudo dpkg -i "$FILE" || handle_error "Instalar $FILE"
    done
}

# Limpiar archivos .deb
clean_up() {
    echo "Limpiando archivos .deb..."
    rm -f *.deb || handle_error "Limpiar archivos .deb"
}

# Detectar la distribución y preguntar si se necesita el parche
detect_distribution() {
    . /etc/os-release
    if [ "$ID" != "huayra" ]; then
        echo "Estás usando $ID. ¿Necesitás el parche para theftdeterrentguardian_6.0.0.11.huayra10_amd64.deb? (si/no)"
        read -r response
        if [[ "$response" =~ ^(s|S|SI|Si|si|yes|YES|Yes|y|Y)$ ]]; then
            NEED_PATCH="true"
            FILES=(
                "theftdeterrentclient-lib_6.0.0.11.huayra10_amd64.deb"
                "theftdeterrentclient_6.0.0.11.huayra10_amd64.deb"
                "theftdeterrentdaemon_6.0.0.11.huayra10_amd64.deb"
                "$PATCHED_FILE"
            )
        else
            NEED_PATCH="false"
        fi
    else
        NEED_PATCH="false"
    fi
}

# Logging inicial
echo "Iniciando instalación..." > "$LOG_FILE"

# Ejecutar funciones
check_dependencies | tee -a "$LOG_FILE"
check_disk_space | tee -a "$LOG_FILE"
create_directory | tee -a "$LOG_FILE"
change_directory | tee -a "$LOG_FILE"
detect_distribution | tee -a "$LOG_FILE"
download_files | tee -a "$LOG_FILE"
install_files | tee -a "$LOG_FILE"
clean_up | tee -a "$LOG_FILE"

echo "Se instaló el Theft Deterrent." | tee -a "$LOG_FILE"
echo "Podés leer las instrucciones de post-instalación en https://github.com/Jotalea/TheftDeterrent/blob/main/README.md#post-instalación"
