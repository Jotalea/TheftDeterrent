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
1. Abrir la configuración.
2. Buscar la opción "Gestor de paquetes Synaptic" (o algo similar).
3. Una vez ahí, poner en el buscador "theft" y ya te debería aparecer.
4. Seleccionás las 4 que salen, dando doble click a la casilla.
5. Le das a Instalar (o Install).
6. Ejecutar en la terminal el comando ```theftdeterrentclient``` para verificar que se instaló.
7. Ir a la configuración del programa (dentro del mismo) y fijar el servidor a `citd.dgp.educ.ar`. Si con ese servidor no funcionó, intentá con `tds.educacion.gob.ar`.

Si no te funciona, podés seguir los pasos de abajo o ver [este repositorio](https://github.com/HuayraLinux/theftdeterrent6)

## Debian Linux (incluye Mint, Ubuntu, Kali, Huayra, etc.)
1. Descargar los 4 archivos que terminan en .deb que están disponibles en este repositorio.
2. En una terminal, van al directorio donde hayan guardado los archivos (generalmente es /home/usuario/Descargas).
3. Instalar la librería con el comando
   ```sudo dpkg -i theftdeterrentclient-lib_6.0.0.11.huayra10_amd64.deb```
5. Instalar el daemon con el comando
   ```sudo dpkg -i theftdeterrentdaemon_6.0.0.11.huayra10_amd64.deb```
7. Instalar guardian con el comando
   ```sudo dpkg -i theftdeterrentguardian_6.0.0.11.huayra10_amd64.deb```
9. Instalar el agente con
    ```sudo dpkg -i theftdeterrentclient_6.0.0.11.huayra10_amd64.deb```
11. Reiniciar (recomendado, opcional)
12. Ejecutar en la terminal el comando ```theftdeterrentclient``` para verificar que se instaló.
13. Ir a la configuración del programa (dentro del mismo) y fijar el servidor a `citd.dgp.educ.ar`. Si con ese servidor no funcionó, intentá con `tds.educacion.gob.ar`.