# Alojamientos en Azure

Sistema de gestión de alojamientos y comodidades con un frontend Vite, una API Flask servida por Gunicorn, MySQL 8.4 y Nginx. Docker Compose ejecuta los servicios en una VM Ubuntu 24.04 de Azure.

## Comprobaciones del laboratorio

| Alcance | Evidencia |
| --- | --- |
| Suscripción y VM | Azure for Students activa. VM Standard B2als v2 en North Central US, con 2 vCPU, 4 GiB de RAM, Trusted Launch, Secure Boot y vTPM. |
| Control de costos | Presupuesto mensual de 10 USD, con alertas de costo real al 50 %, 80 % y 100 %. |
| DNS y seguridad de red | El DNS resolvió a la IP pública de la VM. El NSG limitó SSH y HTTP a una IPv4 administrativa /32. MySQL y Gunicorn conservaron sus puertos internos. |
| Apagado programado | Azure guardó el apagado a las 11:30 a. m., hora de Bogotá. |
| Contenedores | Docker Engine 29.10.0 y Compose 5.8.0 operativos. MySQL 8.4.13 y Gunicorn 26.2.0 saludables. La configuración de Nginx pasó `nginx -t`. |
| Base de datos | Se aplicaron tres migraciones sobre una base nueva. La revisión quedó en `ebb9cbe49179 (head)`, con seis tablas. |
| Paso 23 | Desde Windows, `/`, `/health` y `/api/v1/alojamientos` devolvieron HTTP 200. Salud devolvió `status: ok` y la consulta de alojamientos devolvió `success: true`. |
| Anexo A | Se comprobaron ambos roles en MySQL. Se promovió solo la cuenta designada con el script oficial. En la interfaz se confirmó que el administrador puede consultar usuarios y crear comodidades y que la cuenta normal tiene esas funciones restringidas. |

## Comprobaciones pendientes

Quedan por documentar el saldo de crédito, las cuotas regional y Basv2, la lista de regiones permitidas, la estimación total de costos y algunos detalles del disco y de la plantilla original. El encendido diario a las 10:00 a. m. y la primera desasignación programada quedan pendientes de verificación. El Anexo B queda fuera del alcance de esta entrega.

## Archivos de referencia

| Ubicación | Contenido |
| --- | --- |
| [Frontend](frontend/) | Interfaz, dependencias y configuración de Nginx. |
| [Backend](backend/) | API, migraciones, pruebas y scripts de administración. |
| [Docker Compose](compose.yaml) y [publicación HTTP](compose.http.yaml) | Definiciones de los servicios y del puerto de entrada. |
| [Infraestructura](infra/) | Dockerfiles, proxy Nginx y scripts de Ubuntu y despliegue. |
| [Manuales](docs/) | Guías de infraestructura e implementación local. Los resultados históricos que contienen son referencias. |
