# Despliegue de Alojamientos en Azure

Este repositorio reúne el backend, el frontend y la infraestructura. El instalador construye las imágenes a partir del código incluido. Los enlaces de la tabla identifican las revisiones desde las que se exportó ese código.

| Componente | Revisión |
| --- | --- |
| [Backend Flask y Gunicorn](https://github.com/oflodororni/alojamientos-api/tree/380775d4f7c7540b28fa5b6132be0b0025f35345) | `380775d4f7c7540b28fa5b6132be0b0025f35345` |
| [Frontend Vite](https://github.com/oflodororni/alojamientos-frontend/tree/2313ed4435fb1b0f451dfaa4edb014c9cc966483) | `2313ed4435fb1b0f451dfaa4edb014c9cc966483` |

## Obtener el código

Con acceso al repositorio privado, clónalo o descarga el ZIP desde **Code → Download ZIP**. Para seguir el procedimiento de instalación usa Ubuntu 24.04 o WSL 2 con Ubuntu 24.04 y Docker disponible para ese entorno.

    git clone https://github.com/simonba11710/alojamientos-azure.git
    cd alojamientos-azure

Los [manuales de infraestructura](docs/01_Manual_Infraestructura.md) y de [implementación local](docs/Manual_Implementacion_Local_Alojamientos.md) se conservan como referencia. Los nombres de recursos, resultados históricos y repositorios que aparecen en ellos pertenecen al laboratorio original. Para ejecutar esta copia, sigue los comandos de este README. Los flujos CI bajo `backend/.github` y `frontend/.github` se conservan como referencia de los componentes.

La VM se da por creada según lo informado. Los resultados históricos de los manuales son referencias. La comprobación en esta instalación sigue pendiente.

| Pasos | Comprobación en Azure |
| --- | --- |
| 1–4 | Suscripción habilitada, saldo y vencimiento, cuotas regional y Basv2, directiva de regiones y estimación con la región y SKU reales. Revisar presupuesto mensual de 10 USD y alertas de coste real al 50/80/100 %. Confirmar correo autorizado y fechas vigentes si falta el presupuesto. |
| 5–12 | Auditar el grupo, la VM, la imagen Ubuntu, Trusted Launch, disco, NIC, red, NSG e IP pública. Comparar con la guía y revisar la plantilla o historial del despliegue si está disponible. |
| 13–16 | Comprobar desasignación según la ventana de uso, DNS, SSH desde la IPv4 administrativa /32 y apagado automático. Revisar horario, zona horaria y recursos necesarios para cualquier encendido programado. |
| 17–19 | Comprobar Ubuntu, disco y memoria. Revisar Docker, Compose y el estado y origen de ambos repositorios. |
| 20–23 | Comprobar MySQL con su cuenta de aplicación, las revisiones Alembic, Gunicorn, Nginx y las respuestas internas y externas de los tres endpoints. |

## Acceso y despliegue

Para una VM, usa el cliente SSH local con la clave ya autorizada o agrega la parte pública de una clave temporal a la cuenta de la VM conservando las entradas existentes en authorized_keys. Comprueba la huella del servidor por un canal de confianza. La parte privada se queda en el equipo. La regla NSG de SSH debe limitarse a la IPv4 pública administrativa /32.

Para una instalación nueva, clona o extrae el repositorio en el equipo Ubuntu. En una instalación existente, compara la configuración antes de copiar archivos y mantén el nombre de proyecto Compose y el archivo .env vigentes. Si MySQL ya tiene datos, confirma el estado de las migraciones y el respaldo disponible.

Ejecuta en Ubuntu desde la raíz del proyecto:

    bash infra/bootstrap.sh
    bash infra/bootstrap.sh apply
    bash infra/deploy.sh internal

La primera ejecución de bootstrap refresca los índices APT y simula la actualización. El modo apply instala actualizaciones y, si procede, Docker Engine y Compose mediante el repositorio oficial. El primer despliegue crea .env con permisos restringidos y claves generadas en Ubuntu. Para una instalación existente, conserva el .env original y sus credenciales.

El modo internal aplica las migraciones únicamente si la base todavía no tiene tablas. Si ya las tiene, comprueba que su revisión sea la esperada y sale si difiere. El modo internal no publica puertos. Para probar desde el equipo local, publica Nginx en 127.0.0.1 en la VM y abre un túnel:

    HTTP_BIND_IP=127.0.0.1 bash infra/deploy.sh publish
    ssh -o ExitOnForwardFailure=yes -N -L 127.0.0.1:8080:127.0.0.1:80 USUARIO@HOST

Para el paso 23, después de aprobar el cambio, limita TCP 80 en el NSG a la IPv4 administrativa /32, configura HTTP_BIND_IP en .env con la IP privada de la NIC y ejecuta de nuevo el modo publish. Comprueba por el DNS público /, /health y /api/v1/alojamientos desde la IP autorizada. Nginx es el único servicio con puerto publicado. Si ejecutas el Anexo A después de este cambio, sustituye el destino remoto 127.0.0.1:80 del túnel por la IP privada de la NIC y conserva el extremo local en 127.0.0.1:8080.

Si ejecutas todo en tu propio Ubuntu, después de publicar en loopback abre `http://127.0.0.1/` desde ese equipo. Las comprobaciones de solo lectura son:

    bash infra/deploy.sh verify
    curl -fsS http://127.0.0.1/health
    curl -fsS http://127.0.0.1/api/v1/alojamientos

## Anexo A

1. Abre http://127.0.0.1:8080 a través del túnel. Registra dos cuentas de prueba desde la interfaz y verifica el acceso y las funciones de la cuenta normal. Usa correos de prueba acordados con el responsable.
2. Localiza scripts/promover_admin.py en el Backend. Con la cuenta de MySQL de la aplicación y las consultas del manual, comprueba los roles de las dos cuentas antes de promover. En las evidencias recoge solo los campos necesarios, como correo de prueba y rol.
3. Desde la raíz del proyecto ejecuta el comando siguiente con el correo real de la cuenta de prueba autorizada.

       sudo docker compose exec -T backend python scripts/promover_admin.py CORREO_DE_PRUEBA

4. Comprueba el rol persistido en MySQL. Cierra y vuelve a iniciar sesión para obtener un token nuevo. Verifica las funciones administrativas de la segunda cuenta y confirma que la primera conserva solo las funciones de su rol. Registra el resultado observado de cada prueba. Usa el túnel para toda operación con contraseñas o tokens.
