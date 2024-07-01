# Theft Deterrent
Links de descarga para Theft Deterrent (Agent, Client, Guardian, Daemon) e instrucciones de cómo instalarlo.

# Instrucciones
## Windows 10
1. Descargás el archivo "Theft Deterrent **Guardian**.exe" y lo instalás.
2. En una parte de la instalación tienen que marcar una casilla para que los deje seguir, la marcan, es para no poner una contraseña en caso de desinstalarlo.
3. Descargá el archivo "Theft Deterrent Agent.exe" y lo instalás.
4. Repetir el paso 2.
5. Reiniciás la computadora.
6. Una vez ya prendió, se debería abrir el programa automáticamente.
7. Vas a la parte de configuración, y ponés para que el servidor sea `citd.dgp.educ.ar`. Si con ese servidor no funcionó, intentá con `tds.educacion.gob.ar`.

## Huayra Linux
Funciona en Huayra 5 y Huayra 6, pero no en Huayra 6.5. Para esta versión, seguir las instrucciones para Debian.
1. Abrir la configuración.
2. Buscar la opción "Gestor de paquetes Synaptic" (o algo similar).
3. Una vez ahí, poner en el buscador "theft" y ya te debería aparecer.
4. Seleccionás las 4 que salen, dando doble click a la casilla.
5. Le das a Instalar (o Install).
6. Seguir con las instrucciones de [post instalación](https://github.com/Jotalea/TheftDeterrent/blob/main/README.md#post-instalación)

Si no te funciona, podés seguir los pasos de abajo o ver [este repositorio](https://github.com/HuayraLinux/theftdeterrent6).
Si estás buscando versiones de este programa para versiones anteriores de Huayra, mirá [este repositorio](https://github.com/HuayraLinux/theftdeterrent4).

## Debian Linux (incluye Mint, Ubuntu, Kali, Huayra, etc.)
Acá podés [**ejecutar el comando que descarga e instala todo**](https://github.com/Jotalea/TheftDeterrent/blob/main/README.md#Usar-un-solo-comando) (recomendado) o [**instalar los paquetes manualmente**](https://github.com/Jotalea/TheftDeterrent/blob/main/README.md#instalar-los-paquetes-manualmente).

### Usar un solo comando
1. Abrir una terminal
2. Ejecutar este comando:
```curl -fsSL https://raw.githubusercontent.com/Jotalea/TheftDeterrent/main/install.sh | sudo bash```
3. Seguir con las instrucciones de [post instalación](https://github.com/Jotalea/TheftDeterrent/blob/main/README.md#post-instalación)

### Instalar los paquetes manualmente
1. Descargar los 4 archivos que terminan en .deb que están disponibles en este repositorio.
2. En una terminal, van al directorio donde hayan guardado los archivos (generalmente es /home/usuario/Descargas).
3. Instalar la librería con el comando
   ```sudo dpkg -i theftdeterrentclient-lib_6.0.0.11.huayra10_amd64.deb```
4. Instalar el daemon con el comando
   ```sudo dpkg -i theftdeterrentdaemon_6.0.0.11.huayra10_amd64.deb```
5. Instalar guardian con el comando
   ```sudo dpkg -i theftdeterrentguardian_6.0.0.11.huayra10_amd64.deb```
6. Instalar el agente con
    ```sudo dpkg -i theftdeterrentclient_6.0.0.11.huayra10_amd64.deb```
7. Seguir con las instrucciones de [post instalación](https://github.com/Jotalea/TheftDeterrent/blob/main/README.md#post-instalación)

### Error al instalar el guardián
Si te da error al intentar instalar `theftdeterrentguardian_6.0.0.11.huayra10_amd64.deb`, podés intentar usar el parche hecho por [Maxelslasarte](https://huayra.educar.gob.ar/ayuda/?qa=user/Maxelslasarte), disponible en este repositorio como `theftdeterrentguardian_6.0.0.11.debian10_amd64.deb`.

Lo que hace este parche básicamente es modificar la dependencia de Python =>2.6 a Python =>3.**, por lo que puede no ser una solución definitiva.
El proceso para instalarlo sería lo mismo que ya mencioné anteriormente.
Esta opción viene incluída en el [script de instalación](https://github.com/Jotalea/TheftDeterrent/blob/main/README.md#Usar-un-solo-comando).

### Post-instalación
1. Reiniciar (recomendado, opcional)
2. Ejecutar en la terminal el comando ```theftdeterrentclient``` para verificar que se instaló.
3. Ir a la configuración del programa (dentro del mismo) y fijar el servidor a `citd.dgp.educ.ar`. Si con ese servidor no funcionó (probablemente porque tu computadora no es una Juana Manso), intentá con `tds.educacion.gob.ar`.

Acá lo configurás
![Pestaña de configuración de TDA](https://github.com/Jotalea/TheftDeterrent/assets/67925603/d91dac51-2cc4-4ff1-a9b3-2714ee34069d)

Se debería ver algo similar a esto
![Pestaña principal de TDA](https://github.com/Jotalea/TheftDeterrent/assets/67925603/a22b1b2b-b3fc-4f65-8ba1-6793631d00e6)
