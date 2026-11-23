# Manual de Infraestructura — Microsoft Azure
















## Paso 1 — Entrar a Azure y comprobar la suscripción
















Ingresaremos a Microsoft Azure y verificaremos que tenemos una suscripción activa para crear los recursos del Sistema Alojamientos.
















### Instrucciones
















1. Ingrese a [Portal de Azure](https://portal.azure.com).
2. Inicie sesión con su cuenta de Microsoft.
3. En la barra de búsqueda superior, escriba Suscripciones.
4. Seleccione Suscripciones.
5. Haga clic en Azure for Students.
6. Compruebe que el estado sea Activa o Enabled.
















**Resultado esperado:** la suscripción Azure for Students aparece habilitada.
















---
















## Paso 2 — Comprobar crédito disponible, cuotas y regiones autorizadas
















Comprobaremos el crédito disponible y las cuotas de procesamiento de Azure for Students.
















### 2.1 — Verificar el crédito disponible
















#### Instrucciones
















1. Ingrese a [Portal de Azure](https://portal.azure.com).
2. En la barra de búsqueda superior, escriba Education.
3. Seleccione Education y abra Información general.
4. En los detalles de Azure for Students, localice Créditos disponibles.
5. Compruebe el saldo, los días restantes y la fecha de vencimiento. Revise también los costos del mes.
















**Resultado esperado:** el portal muestra crédito disponible y la fecha de vencimiento de Azure for Students.
















### 2.2 — Comprobar las cuotas de Azure
















#### Instrucciones
















1. En la barra de búsqueda de Azure, escriba Cuotas y abra el servicio.
2. En el menú lateral, seleccione Mis cuotas.
3. En Proveedor, seleccione Compute (Proceso).
4. En Suscripción, seleccione Azure for Students.
5. En Región, seleccione la ubicación en la que desea consultar las cuotas.
6. En el buscador de cuotas, escriba vCPU regionales totales.
7. Revise Uso actual y Límite. Haga clic en el nombre de la cuota para consultar sus detalles.
8. Borre la búsqueda anterior y escriba Basv2.
9. Busque Familia Basv2 estándar vCPUs y revise su Uso actual y Límite.
10. Para cada cuota, calcule las vCPU disponibles restando el uso actual al límite.
11. Compruebe que ambas cuotas tengan al menos 2 vCPU disponibles.
















**Resultado esperado:** las cuotas regional y de la familia Basv2 tienen al menos 2 vCPU disponibles.
















### 2.3 — Verificar las regiones autorizadas
















Identificaremos las regiones en las que Azure for Students permite crear recursos.
















#### Instrucciones
















1. Ingrese a [Portal de Azure](https://portal.azure.com).
2. En la barra de búsqueda superior, escriba Suscripciones.
3. Seleccione Suscripciones.
4. Abra Azure for Students.
5. En el menú izquierdo, seleccione Directiva (Policy).
6. En Cumplimiento, localice Allowed resource deployment regions.
7. Haga clic en el nombre de la directiva.
8. Seleccione Ver asignación.
9. Abra la pestaña Parámetros.
10. Localice listOfAllowedLocations.
11. Consulte las regiones autorizadas. Para ver la lista completa, utilice el ícono de copiar junto al valor.
















**Resultado esperado:** se muestra la lista de regiones autorizadas para crear recursos con la suscripción.
















---
















## Paso 3 — Calcular los costos de los recursos de Azure
















Utilizaremos la calculadora de precios de Azure para estimar el costo de la máquina virtual, el disco, las transacciones de almacenamiento, la transferencia de datos y la dirección IP pública.
















### 3.1 — Configurar la máquina virtual
















#### Instrucciones
















1. Ingrese a [Calculadora de precios de Azure](https://azure.microsoft.com/es-es/pricing/calculator/).
2. Busque Virtual Machines y seleccione Agregar al presupuesto.
3. En Región, seleccione North Central US.
4. En Sistema operativo, seleccione Linux; en Tipo, seleccione Ubuntu; y en Nivel, seleccione Standard.
5. En Serie de instancias, seleccione Basv2-series.
6. En Instancia, seleccione B2als v2 (2 vCPU, 4 GB RAM).
7. Indique 1 máquina virtual y 45 horas mensuales.
8. En Compute, seleccione Pago por uso.
















Las 45 horas corresponden a 1,5 horas diarias durante 30 días (1,5 × 30 = 45). El procesamiento genera costos mientras la VM está asignada; detenerla y desasignarla evita ese cargo cuando no se utiliza.
















### 3.2 — Configurar el disco administrado
















#### Instrucciones
















1. En Managed Disks, seleccione SSD estándar en Nivel.
2. En Redundancia, seleccione LRS.
3. En Tamaño del disco, seleccione E4: 32 GiB.
4. Indique 1 disco.
5. Mantenga desactivadas Agregar Instantánea y Enable Confidential OS Encryption.
















El disco almacena el sistema operativo y los datos. Su costo de capacidad permanece mientras exista el recurso, incluso si la VM está desasignada.
















### 3.3 — Configurar las transacciones de almacenamiento
















#### Instrucciones
















1. Localice Storage transactions.
2. En Unidades de transacción (10.000 transacciones), escriba 100.
3. Revise el costo estimado de las transacciones.
















Las 100 unidades representan 1.000.000 de transacciones mensuales. Para 45 horas de funcionamiento equivalen aproximadamente a 6,2 operaciones por segundo. Es una hipótesis inicial para contemplar lecturas y escrituras del disco, no una medición del consumo real. El valor debe ajustarse con las métricas observadas cuando el sistema esté en funcionamiento.
















### 3.4 — Configurar el ancho de banda
















#### Instrucciones
















1. En Ancho de banda, seleccione Salida a Internet en Tipo de transferencia de datos.
2. En Región de origen, seleccione North Central US.
3. En Con enrutamiento a través de, seleccione Red global de Microsoft.
4. En Transferencia de datos de salida, escriba 5 GB.
















Los 5 GB son una estimación inicial del volumen mensual de datos enviados a Internet; el costo real depende del tráfico generado.
















### 3.5 — Configurar la dirección IP pública
















#### Instrucciones
















1. Regrese al catálogo de productos.
2. Busque Direcciones IP (IP Addresses) y seleccione Agregar al presupuesto.
3. En Región, seleccione North Central US.
4. En Tipo, seleccione Estándar (ARM).
5. En Direcciones IP estáticas, indique 1.
6. En Horas, escriba 730.
7. En Prefijos de direcciones IP públicas, indique 0.
















Las 730 horas representan aproximadamente un mes completo. Una IP pública estática puede seguir generando costos mientras permanezca reservada, aunque la VM esté desasignada. Por eso se estima durante todo el mes y no solo durante las 45 horas de procesamiento.
















### 3.6 — Revisar el costo total
















#### Instrucciones
















1. En Soporte, mantenga Basic (incluido).
2. En Programa de licencias, mantenga Contrato de cliente de Microsoft (MCA).
3. Mantenga desactivada la opción Mostrar precios de desarrollo y pruebas.
4. Revise Costo inicial estimado, Costo mensual estimado y Costo anual estimado.
5. Compruebe que el total incluya la VM, el disco, las transacciones de almacenamiento, el tráfico saliente y la dirección IP pública.
















**Resultado esperado:** la calculadora presenta el costo estimado de los recursos configurados. Los importes pueden variar según los precios vigentes, las horas de uso y el consumo real.
















---
















## Paso 4 — Crear y verificar el presupuesto con alertas
















Configuraremos un presupuesto mensual de **10 USD** para supervisar los costos de la suscripción Azure for Students y recibir alertas al alcanzar los umbrales establecidos.
















### 4.1 — Abrir los presupuestos
















#### Instrucciones
















1. Ingrese a [Portal de Azure](https://portal.azure.com).
2. En la barra de búsqueda superior, escriba **Suscripciones** y abra el servicio.
3. Seleccione **Azure for Students**.
4. En el menú izquierdo, abra **Administración de costos → Presupuestos**.
5. Verifique que el ámbito corresponda a **Azure for Students**.
















### 4.2 — Configurar el presupuesto
















#### Instrucciones
















1. Seleccione **Agregar** para crear un presupuesto.
2. En **Ámbito**, compruebe que aparezca **Azure for Students**.
3. No agregue filtros, para supervisar toda la suscripción.
4. En **Nombre**, escriba **alojamientos-laboratorio**.
5. En **Período de restablecimiento**, seleccione **Mensual**.
6. En **Fecha de creación**, establezca **1 de octubre de 2026**.
7. En **Fecha de expiración**, establezca **30 de septiembre de 2027**.
8. En **Importe (USD)**, escriba **10**.
9. Continúe a la sección de alertas.
















### 4.3 — Configurar las alertas
















#### Instrucciones
















1. En la primera fila, seleccione **Coste real** y escriba **50** en el porcentaje. Compruebe que el importe sea **5 USD**.
2. En la segunda fila, seleccione **Coste real** y escriba **80**. Compruebe que el importe sea **8 USD**.
3. En la tercera fila, seleccione **Coste real** y escriba **100**. Compruebe que el importe sea **10 USD**.
4. Mantenga **Ninguno** en **Grupo de acciones** para las tres alertas.
5. En **Destinatarios de la alerta (correo electrónico)**, introduzca una dirección autorizada para recibir las notificaciones.
6. En **Idiomas**, seleccione **español (España)**.
7. Revise los valores y haga clic en **Crear** o **Guardar**, según la opción que muestre el portal.
















### 4.4 — Verificar el presupuesto
















#### Instrucciones
















1. Regrese a **Azure for Students → Administración de costos → Presupuestos**.
2. Abra **alojamientos-laboratorio**.
3. Compruebe que el ámbito sea **Azure for Students**, el período **Mensual** y el importe **10 USD**.
4. Verifique que existan tres alertas de **Coste real**: **50 % (5 USD)**, **80 % (8 USD)** y **100 % (10 USD)**.
5. Compruebe que el correo de notificaciones sea correcto y que los grupos de acciones estén en **Ninguno**.
















**Importante:** el presupuesto sirve para vigilar los costos; **no detiene automáticamente la máquina virtual ni bloquea la facturación**. Las alertas pueden llegar con retraso. La VM debe desasignarse cuando no se utilice para evitar cargos de procesamiento.
















**Resultado esperado:** el presupuesto **alojamientos-laboratorio** figura en la suscripción **Azure for Students**, con importe mensual de **10 USD** y alertas de coste real configuradas al **50 %, 80 % y 100 %**.
















---
















## Paso 5 — Crear el grupo de recursos de Azure
















Crearemos un grupo de recursos para organizar la máquina virtual y los componentes de red y almacenamiento del Sistema Alojamientos. El grupo permite administrar los recursos relacionados desde un mismo lugar.
















### Instrucciones
















1. Ingrese a [Portal de Azure](https://portal.azure.com).
2. En la barra de búsqueda superior, escriba **Grupos de recursos** y abra el servicio.
3. Seleccione **Crear**.
4. En la pestaña **Datos básicos**, configure los siguientes campos:
   - **Suscripción:** Azure for Students.
   - **Nombre del grupo de recursos:** rg-alojamientos-g01.
   - **Región:** (US) North Central US.
5. Abra la pestaña **Etiquetas** y deje vacíos los campos **Nombre** y **Valor**, porque no se requieren etiquetas para este grupo.
6. Seleccione **Revisar y crear**.
7. Compruebe que la revisión muestre la suscripción **Azure for Students**, el grupo **rg-alojamientos-g01**, la región **North Central US** y **Etiquetas: Ninguno**.
8. Seleccione **Crear** para generar el grupo de recursos.
9. Regrese a **Grupos de recursos** y compruebe que **rg-alojamientos-g01** aparezca en la lista, dentro de **Azure for Students**, con ubicación **North Central US**.
















**Nota:** la región del grupo de recursos indica dónde se almacenan sus metadatos; no determina por sí sola la región de los recursos que se agregarán posteriormente. El grupo **NetworkWatcherRG** es independiente y no debe modificarse ni eliminarse.
















**Resultado esperado:** el grupo de recursos **rg-alojamientos-g01** está creado y figura en la lista de Azure, bajo la suscripción **Azure for Students** y en la ubicación **North Central US**. La máquina virtual se configurará en el siguiente paso.
















---
















## Paso 6 — Abrir el asistente de VM y completar Datos básicos
















Configuraremos una VM Ubuntu con autenticación por clave SSH, reutilizando el grupo creado en el Paso 5. El nombre identifica el servidor; la región y el tamaño condicionan disponibilidad, cuotas y costo.
















### 6.1 — Abrir el asistente
















1. Ingrese a [Portal de Azure](https://portal.azure.com).
2. Busque **Máquinas virtuales** y abra el servicio.
3. Seleccione **Crear → Máquina virtual de Azure** (no conjunto de escalado).
4. Abra **Datos básicos**. Si aparece un aviso de experiencia preliminar, revise los campos reales antes de continuar.
















### 6.2 — Detalles del proyecto
















| Campo | Valor | ¿Por qué? |
|---|---|---|
| Suscripción | Azure for Students | La suscripción registra el consumo de recursos. |
| Grupo de recursos | rg-alojamientos-g01 | Agrupa el proyecto; seleccionar el grupo existente. |
















### 6.3 — Detalles de la instancia
















| Campo | Valor | ¿Por qué? |
|---|---|---|
| Nombre de la máquina virtual | vm-alojamientos-g01 | Identificador del servidor. |
| Región | North Central US | Región seleccionada para el proyecto. |
| Opciones de disponibilidad | No se requiere redundancia de la infraestructura | Se utilizará una VM sin réplica de disponibilidad. |
| Tipo de seguridad | Máquinas virtuales de inicio seguro (Trusted Launch) | Protección para máquinas virtuales de generación 2 frente a alteraciones del arranque; no es un programa adicional que deba instalarse. |
| Habilitar arranque seguro | Sí | Secure Boot comprueba firmas de componentes de arranque y ayuda a impedir cargadores no autorizados. |
| Habilitar vTPM | Sí | Módulo de seguridad virtual para almacenar información de seguridad y verificar mediciones de integridad del arranque. |
| Supervisión de integridad | No | No se habilita esta opción complementaria. |
| Imagen | Ubuntu Server 24.04 LTS | Sistema operativo Linux; revisar variante x64 Gen2. |
| Tamaño | Standard B2als_v2 | 2 vCPU y 4 GiB de RAM, conforme al cálculo de costos. |
| Arquitectura de VM | x64 | Arquitectura de Ubuntu prevista. |
| Priority | On-demand | Evita el desalojo propio de Azure Spot. |
















Para elegir el tamaño, abra **Ver todos los tamaños** cuando aparezca, busque **B2als_v2** y confirme que no exista advertencia de indisponibilidad para la suscripción.
















### 6.4 — Cuenta de administrador
















| Campo | Valor | ¿Por qué? |
|---|---|---|
| Tipo de autenticación | Clave pública SSH | Acceso por clave criptográfica en vez de contraseña. |
| Nombre de usuario | azureuser | Cuenta administradora de Ubuntu. |
| Origen de la clave SSH | Generar un par de claves nuevo | La clave se entregará al crear el recurso. |
| Formato de clave SSH | Ed25519 | Formato de clave definido para el proyecto. |
| Nombre del par de claves | vm-alojamientos-g01_key | Nombre del recurso de clave pública. |
















La opción **Puertos de entrada públicos** se explica en el **Paso 8 — Redes**, ya que su ubicación puede variar según la vista del asistente de Azure.
















**Resultado esperado:** VM Ubuntu y clave SSH Ed25519 correctamente configuradas.
















---
















## Paso 7 — Completar la pestaña Discos
















El disco administrado de 32 GiB almacena el sistema operativo y los archivos persistentes. Su costo puede continuar incluso cuando la VM esté desasignada.
















1. Abra la pestaña **Discos**.
2. Revise los campos en el orden de la pantalla:
















| Campo | Valor | ¿Por qué? |
|---|---|---|
| Cifrado en el host | Desactivado | Azure informa que no está registrado para la suscripción; el cifrado estándar en reposo permanece. |
| Tamaño del disco del sistema operativo | 32 GiB (E4) | Capacidad prevista en la estimación. |
| Tipo de disco del sistema operativo | SSD estándar | Corresponde a StandardSSD_LRS; no dejar Premium_LRS. |
| Usar discos administrados | Sí | Azure administra el recurso de almacenamiento. |
| Eliminar con VM | Activado | Solicita borrar el disco al eliminar la VM. |
| Habilitar compatibilidad con Ultra Disks | Desactivado | No es necesario para este proyecto. |
| Administración de claves | Clave administrada por la plataforma | Azure administra las claves de cifrado. |
| Discos de datos | Ninguno | No agregar discos adicionales. |
| Disco de SO efímero | Ninguno | El sistema requiere almacenamiento persistente. |
















3. No pulse **Crear y adjuntar un nuevo disco** ni **Asociar un disco existente**.
4. La recomendación de Azure para utilizar SSD Premium es informativa y no obliga a cambiar el tipo de disco.
















**Resultado esperado:** un disco SO administrado, **32 GiB**, **StandardSSD_LRS**, sin discos de datos.
















---
















## Paso 8 — Completar Redes e IP pública estática
















La **red virtual (VNet)** conecta recursos mediante direcciones privadas. Una **subred** es una parte de esa red. La VM usa una **interfaz de red (NIC)** —su adaptador de red virtual— que posee una dirección privada y puede asociarse a una dirección pública. Un **grupo de seguridad de red (NSG)** aplica reglas para permitir o bloquear conexiones a través de la NIC. Aquí se prepara la conectividad, pero no se abre SSH a Internet.
















### 8.1 — Red virtual
















1. Abra **Redes** y localice **Red virtual**.
2. Configure estos campos visibles:
















| Campo | Valor | ¿Por qué? |
|---|---|---|
| Virtual network | (new) vnet-northcentralus-1 (rg-alojamientos-g01) | Red privada de la VM. |
| Subnet | (new) snet-northcentralus-1 - 172.16.0.0/24 | Segmento privado de la red. |
















### 8.2 — Interfaz de red e IP pública
















1. En **Interfaz de red → IP pública**, seleccione **Crear nuevo** cuando corresponda.
2. Configure **Nombre: vm-alojamientos-g01-ip**, **SKU: Estándar**, **Versión: IPv4**, **Asignación: Estática**, **Nivel: Regional**.
3. Confirme la ventana. El selector debe indicar **vm-alojamientos-g01-ip (nueva)**.
















**¿Qué es una IP pública?** Es una dirección que Azure asigna al recurso para poder localizarlo desde Internet. Se diferencia de la **IP privada**, que se usa en la red virtual (en este despliegue, dentro del rango 172.16.0.0/24). **Estática** significa que se reserva mientras exista el recurso IP pública, incluso cuando la VM esté desasignada; por tanto, puede seguir generando costos. Tener IP pública no abre todos los puertos: el NSG controla el tráfico permitido.
















### 8.3 — Grupo de seguridad de red de NIC
















**¿Qué significa este campo?** Una **NIC** es la interfaz o adaptador virtual de la VM. Un **grupo de seguridad de red (NSG)** contiene reglas que autorizan o bloquean comunicaciones de esa interfaz. La opción **Avanzado** permite seleccionar y revisar explícitamente un NSG del proyecto.
















1. En la pestaña **Redes**, bajo **Interfaz de red**, busque **Grupo de seguridad de red de NIC**.
2. Seleccione **Avanzado** y pulse **Crear nuevo**. Se abrirá **Crear grupo de seguridad de red**: esa ventana no crea otra VM, sino solamente el recurso que controlará su tráfico.
3. En **Nombre**, escriba **vm-alojamientos-g01-nsg**.
4. Compruebe las secciones **Reglas de entrada** y **Reglas de salida**. Si muestran **No hay ningún resultado**, significa que todavía no se han creado reglas **personalizadas**. Este es el resultado previsto: Azure incorpora por separado reglas predeterminadas, incluida la denegación de conexiones entrantes no autorizadas desde Internet.
5. **Agregar una regla de entrada** permitiría definir qué conexiones pueden llegar desde fuera a la VM (por ejemplo, por SSH, puerto TCP 22). **Agregar una regla de salida** permitiría definir qué conexiones puede iniciar la VM hacia otros destinos. **No pulse ninguno de los dos botones en este paso**.
6. Confirme con **Crear** o **Aceptar**, según la pantalla, y compruebe que **vm-alojamientos-g01-nsg** quede seleccionado.
















**¿Qué significan «Any» e «Internet»?** **Any** (Cualquiera, \`*\`) significa cualquier dirección de origen, privada o pública. **Internet** es una etiqueta de servicio de Azure que representa el espacio público de Internet. **No son idénticos**, pero ambos abarcarían demasiados orígenes en una regla que permita conexiones **SSH TCP/22**. El acceso SSH se limitará posteriormente a una IPv4 de administración autorizada.
















**¿Es necesario borrar alguna regla?** No, si ambas listas de reglas personalizadas están vacías, como se espera al crear el NSG. **Solo si aparece** una regla personalizada que permita **TCP/22 desde Any o Internet**, elimine esa regla específica. **No elimine las reglas predeterminadas de Azure**.
















### 8.4 — Opciones inferiores de Redes
















| Campo | Valor | ¿Por qué? |
|---|---|---|
| Puertos de entrada públicos | Ninguno | Este campo puede aparecer bajo **Interfaz de red** cuando el NSG está en modo **Básico**. Al elegir **Avanzado**, puede dejar de mostrarse y el acceso se controla mediante las reglas del NSG. |
| Eliminar IP pública y NIC cuando se elimine la VM | Habilitado | Solicita eliminar los componentes; se revisará el valor real en la plantilla. |
| Habilitar redes aceleradas | Desactivado | No requerido por esta configuración. |
| Opciones de equilibrio de carga | Ninguno | No se utilizará un equilibrador de carga. |
















**Resultado esperado:** la VM utiliza VNet y subred indicadas, IP pública estática y NSG específico sin reglas personalizadas que abran SSH.
















---
















## Paso 9 — Completar Administración, Supervisión, Avanzado y Etiquetas
















Estas pestañas establecen el horario de operación y limitan servicios adicionales a los necesarios para el proyecto.
















### 9.1 — Administración
















1. Abra **Administración** y revise cada opción:
















| Campo | Valor | ¿Por qué? |
|---|---|---|
| Protocolo de seguridad de metadatos para Instance Metadata Service (IMDS) | Deshabilitado | No se agrega este modo de cumplimiento en el despliegue inicial. |
| Protocolo de seguridad de metadatos para WireServer | Deshabilitado | Se conserva la configuración prevista. |
| Habilitar identidad administrada asignada por el sistema | Desactivado | No se requiere identidad de Azure en esta etapa. |
| Inicio de sesión con Microsoft Entra ID | Desactivado | Acceso administrativo mediante clave SSH. |
| Copia de seguridad | Desactivada | Azure Backup no se configura en el asistente; los respaldos se planificarán antes de almacenar información importante. |
| Site Recovery | Desactivada | No configurar replicación. |
| Habilitar apagado automático | Activado | Evitar horas de procesamiento fuera de la ventana prevista. |
| Hora de apagado | 11:30 | Hora de la mañana; no confundir con 23:30. |
| Zona horaria | SA Pacific Standard Time | Zona equivalente a Bogotá (UTC−05:00) utilizada por el portal. |
| Notificación | Activada | Aviso previo a un correo autorizado; no publicar direcciones de contacto. |
| Habilitar evaluación periódica | Desactivada | Actualizaciones posteriores mediante un proceso controlado. |
| Habilitar revisión en caliente | Desactivada | No requerida para esta VM. |
| Opciones de orquestación de revisiones | Imagen predeterminada | Ajuste de la imagen. |
| Habilitar hibernación | Desactivada | No se utiliza en este despliegue. |
















2. En **Apagado automático**, marque **Habilitar apagado automático** y configure **11:30 a. m.** con la zona horaria de Bogotá.
3. Si activa la notificación previa, introduzca solamente un correo autorizado.
4. Antes de salir de **Administración**, confirme **Hora de apagado: 11:30** (mañana, no **23:30**) y la zona horaria de Bogotá. La revisión del resumen se realiza después, en el Paso 10.
















**¿Por qué?** La ventana de laboratorio es de **10:00 a 11:30 a. m.**. El apagado programado no enciende automáticamente la VM a las 10:00; ese encendido queda manual hasta configurar otra solución aprobada.
















### 9.2 — Supervisión
















1. Abra **Supervisión**.
2. Configure:
















| Campo | Valor | ¿Por qué? |
|---|---|---|
| Habilitar reglas de alerta recomendadas | Desactivado | No agregar alertas de monitorización no presupuestadas. |
| Diagnósticos de arranque | Habilitar con la cuenta de almacenamiento administrada (recomendado) | Ayuda a investigar fallos de arranque del SO. |
| Habilitar diagnósticos del SO invitado | Desactivado | No se necesita esta telemetría adicional. |
| Habilitar supervisión de estado de la aplicación | Desactivado | Todavía no se han instalado los servicios. |
















Azure puede informar de un cargo nominal por almacenamiento administrado de diagnósticos.
















### 9.3 — Avanzado
















1. Abra **Avanzado** y compruebe:
















| Campo | Valor | ¿Por qué? |
|---|---|---|
| Extensiones | Ninguna | Sin instalaciones adicionales en el asistente. |
| Aplicaciones de máquina virtual | Ninguna | Backend y Frontend se configurarán posteriormente. |
| Datos personalizados y cloud-init | Vacío / No | No ejecutar scripts al crear la VM. |
| Mayor rendimiento con NVMe | Desactivado | El tamaño seleccionado no admite esta opción. |
| Instalar SQL Server en esta máquina virtual | Desactivado | El proyecto empleará MySQL, no SQL Server. |
| Reservas de capacidad | Ninguno | No reservar capacidad adicional. |
| Tipo de controladora de disco | SCSI | Configuración reflejada en el resumen final. |
















### 9.4 — Etiquetas
















1. Abra **Etiquetas**.
2. Deje **Nombre** y **Valor** vacíos.
3. En **Recurso** puede aparecer **Todos los recursos seleccionados**; no se crea una etiqueta si no se introduce ningún par nombre-valor.
















**Resultado esperado:** apagado automático a las 11:30 hora de Bogotá, diagnósticos de arranque activados y ausencia de extensiones, servicios o etiquetas innecesarios.
















---
















## Paso 10 — Revisar y crear: auditar la plantilla antes del despliegue
















**Revisar y crear** muestra la configuración solicitada, pero no implementa aún la VM. La revisión de la plantilla ARM permite identificar reglas de seguridad y opciones de eliminación que no siempre resultan evidentes en el resumen.
















### 10.1 — Comparar el resumen completo tal como aparece en Azure
















Al seleccionar la pestaña **Revisar y crear**, Azure muestra un **resumen de las opciones configuradas**. En esta sección no se vuelven a llenar los formularios: se comparan los nombres de los campos y sus valores con las tablas siguientes antes de autorizar el despliegue. Las explicaciones y el procedimiento de configuración se encuentran en los Pasos 6 a 9.
















1. Abra la pestaña **Revisar y crear**. Localice el precio estimado, los términos de Azure Marketplace y el resumen de la configuración. Los avisos adicionales pueden variar según la versión del portal.
2. En **Precio**, compruebe que aparezca **1 X Standard B2als_v2** y, si corresponde, **Se aplican créditos de suscripción**. Compare el precio de procesamiento que indique Azure con el valor de referencia **0,0376 USD/h**; el precio vigente puede ser distinto y no incluye necesariamente el disco, la IP ni otros cargos.
3. En **TÉRMINOS**, lea las condiciones de Azure Marketplace. En los campos **Nombre**, **Dirección de correo electrónico preferida** y **Número de teléfono preferido**, verifique personalmente los datos del titular. **No copie información personal de contacto al manual ni a capturas públicas.**
4. Compare las secciones siguientes con **los campos y valores de la pantalla Revisar y crear**. Si un valor difiere, regrese a la pestaña correspondiente para corregirlo antes de continuar.
















#### Datos básicos
















| Campo mostrado por Azure | Valor esperado |
|---|---|
| Suscripción | Azure for Students |
| Grupo de recursos | rg-alojamientos-g01 |
| Nombre de la máquina virtual | vm-alojamientos-g01 |
| Región | North Central US |
| Opciones de disponibilidad | No se requiere redundancia de la infraestructura |
| Tipo de seguridad | Máquinas virtuales de inicio seguro |
| Habilitar arranque seguro | Sí |
| Habilitar vTPM | Sí |
| Supervisión de integridad | No |
| Imagen | Ubuntu Server 24.04 LTS |
| Tamaño | Standard B2als_v2 |
| Arquitectura de VM | x64 |
| Tipo de autenticación | Clave pública SSH |
| Nombre de usuario | azureuser |
| Formato de clave SSH | Ed25519 |
| Nombre del par de claves | vm-alojamientos-g01_key |
| Puertos de entrada públicos | Ninguno |
| Priority | On-demand |
















#### Discos
















| Campo mostrado por Azure | Valor esperado |
|---|---|
| Tamaño del disco del sistema operativo | 32 GiB |
| Tipo de disco del sistema operativo | StandardSSD_LRS |
| Usar discos administrados | Sí |
| Eliminar disco de SO con VM | Sí |
| Disco de SO efímero | Ninguno |
















#### Redes
















| Campo mostrado por Azure | Valor esperado |
|---|---|
| Red virtual | vnet-northcentralus-1 (nueva) |
| Subred | snet-northcentralus-1 (nueva) |
| IP pública | vm-alojamientos-g01-ip (nueva) |
| Grupo de seguridad de red de NIC | vm-alojamientos-g01-nsg (nueva) |
| Redes aceleradas | Desactivada |
| ¿Quiere colocar esta máquina virtual como subyacente respecto a una solución de equilibrio de carga existente? | No |
| Eliminar IP pública y NIC cuando se elimine la VM | Habilitado |
















#### Administración
















| Campo mostrado por Azure | Valor esperado |
|---|---|
| Identidad administrada asignada por el sistema | Desactivada |
| Inicio de sesión con Microsoft Entra ID | Desactivada |
| Copia de seguridad | Desactivada |
| Site Recovery | Desactivada |
| Habilitar evaluación periódica | Desactivada |
| Habilitar revisión en caliente | Desactivada |
| Opciones de orquestación de revisiones | Imagen predeterminada |
| Apagado automático | Activada |
| Hora de apagado | 11:30 |
| Zona horaria | SA Pacific Standard Time |
| Notificación | Activada |
| Modo de cumplimiento para IMDS | Deshabilitado |
| Modo de cumplimiento para WireServer | Deshabilitado |
| Habilitar hibernación | Desactivada |
















**Atención a la hora:** debe aparecer **11:30** (once y treinta de la mañana), **no 23:30** (once y treinta de la noche). La zona **SA Pacific Standard Time** corresponde al horario de Bogotá usado en esta configuración.
















#### Supervisión
















| Campo mostrado por Azure | Valor esperado |
|---|---|
| Alertas | Desactivada |
| Diagnósticos de arranque | Activada |
| Habilitar diagnósticos del SO invitado | Desactivada |
| Habilitar supervisión de estado de la aplicación | Desactivada |
















#### Avanzado
















| Campo mostrado por Azure | Valor esperado |
|---|---|
| Extensiones | Ninguno |
| Aplicaciones de máquina virtual | Ninguno |
| Cloud-init | No |
| Grupo de reserva de capacidad | Ninguno |
| Tipo de controladora de disco | SCSI |
















**Etiquetas:** deben permanecer vacías, según el Paso 9. Si no aparecen como sección separada en el resumen, compruebe su configuración en la pestaña Etiquetas.
















**Resultado de la comparación:** los valores del resumen coinciden con lo configurado en los Pasos 6 a 9. **No pulse Crear todavía**: falta la comprobación técnica de la plantilla de automatización, descrita en el apartado siguiente.
















### 10.2 — Ver la plantilla de automatización
















1. En la misma pestaña seleccione **Ver plantilla de automatización**.
2. Exporte los archivos **template.json** y **parameters.json** para examinarlos, sin desplegarlos manualmente.
3. Compruebe en **parameters.json** que **networkSecurityGroupRules** tenga **value: []**. Significa que no se solicitaron reglas de entrada personalizadas que abran SSH.
4. Verifique **publicIpAddressType: Static**, **publicIpAddressSku: Standard**, **virtualMachineSize: Standard_B2als_v2**, **osDiskType: StandardSSD_LRS**, **osDiskSizeGiB: 32** y **securityType: TrustedLaunch**.
5. Revise las opciones de eliminación: **nicDeleteOption: Delete**, **osDiskDeleteOption: Delete** y **pipDeleteOption: Detach**.
6. **Atención:** aunque en la interfaz se marcó eliminar IP y NIC con la VM, el valor **pipDeleteOption: Detach** significa que la IP pública podría sobrevivir a la eliminación de la VM. Se debe verificar y retirar expresamente cuando deje de ser necesaria para evitar costos residuales.
7. Confirme que el NSG quede asociado a la NIC y que no se agreguen NAT Gateways ni discos de datos imprevistos.
8. Si la exportación muestra **adminPublicKey** sin valor, no utilice la plantilla exportada para crear la VM por separado; el asistente entregará las claves dentro del proceso normal.
9. Regrese al asistente. Si Azure presenta errores de validación, corríjalos antes de pulsar **Crear**.
















**Resultado esperado:** resumen y plantilla coherentes, reglas personalizadas del NSG vacías, disco e IP correctos, y diferencia de eliminación **pipDeleteOption: Detach** identificada.
















---
















## Paso 11 — Crear la VM y proteger las claves SSH
















Tras validar la plantilla se despliega la máquina virtual, lo que puede comenzar a generar cargos de procesamiento. La clave privada es necesaria para administrar Ubuntu y debe permanecer bajo control del titular.
















### Instrucciones
















1. Regrese a **Revisar y crear**.
2. Confirme que el resumen corresponde a **vm-alojamientos-g01** en **rg-alojamientos-g01**, sin errores.
3. Pulse **Crear**.
4. Cuando aparezca **Descargar clave privada y crear recurso**, descargue la clave **Ed25519** y guárdela en una carpeta segura del equipo. No suba la clave privada a repositorios, archivos compartidos, Google Drive ni al manual. El recurso de clave pública **vm-alojamientos-g01_key** no sustituye el archivo privado.
5. Espere a que Azure indique **Se completó la implementación**.
6. En **Detalles de implementación**, compruebe que aparezcan la VM **vm-alojamientos-g01**, su interfaz de red, la IP **vm-alojamientos-g01-ip**, el NSG **vm-alojamientos-g01-nsg** y el recurso de programación de apagado automático, con estados satisfactorios.
7. Pulse **Ir al recurso** y compruebe en **Información general** el nombre de la VM. El asistente no instala por sí solo MySQL, Flask, Gunicorn ni Nginx.
8. Si ya no va a trabajar con la VM, selecciónela y pulse **Detener** desde Azure. La verificación final **Detenida (desasignada)** corresponde al inventario y control del siguiente paso.
















**Resultado esperado:** mensaje **Se completó la implementación**, VM y componentes creados y clave privada SSH descargada y custodiada.
















**Comprobación del despliegue:** en **Detalles de implementación**, identifique el recurso **CreateVirtualMachine-vm-alojamientos-g01** y confirme que la VM y los recursos asociados figuren como creados. Conserve la clave privada SSH en el equipo local. Compruebe el estado final de la VM en el Paso 12.
















---
















## Paso 12 — Verificar los recursos creados y sus propiedades
















La creación de una VM no genera únicamente una máquina virtual: se crean o asocian un disco, una interfaz de red (NIC), una dirección IP pública, un grupo de seguridad de red (NSG), una red virtual y la clave pública SSH. Vamos a inventariarlos, identificar sus relaciones y verificar las propiedades reales del recurso. **No crearemos ni eliminaremos ningún recurso en este paso.**
















### 12.1 — Abrir el inventario del grupo de recursos
















1. En el [Portal de Azure](https://portal.azure.com), abra **Grupos de recursos** desde la búsqueda superior (también es posible entrar por **Resource Manager → Todos los recursos** y filtrar por suscripción y grupo).
2. Seleccione **rg-alojamientos-g01**.
3. En **Información general**, abra la pestaña **Recursos**.
4. Si trabaja desde **Todos los recursos**, aplique **Suscripción: Azure for Students** y **Grupo de recursos: rg-alojamientos-g01**. No mezcle recursos de otros grupos.
5. Compruebe la columna **Nombre**, la columna **Tipo** y la columna **Ubicación**, tal como aparecen en Azure.
















### 12.2 — Comparar los recursos mostrados por Azure
















La siguiente tabla presenta los recursos que deben aparecer en el grupo del proyecto. Los sufijos de la interfaz de red y del disco son generados por Azure y pueden variar entre instalaciones; **no deben escribirse manualmente durante la creación**.
















| Nombre mostrado por Azure | Tipo mostrado por Azure | Ubicación |
|---|---|---|
| vm-alojamientos-g01 | Máquina virtual | North Central US |
| vm-alojamientos-g01-ip | Dirección IP pública | North Central US |
| vm-alojamientos-g01-nsg | Grupo de seguridad de red | North Central US |
| vm-alojamientos-g01139 | Interfaz de red | North Central US |
| vm-alojamientos-g01_key | Clave SSH | North Central US |
| vm-alojamientos-g01_OsDisk_1_929b4ca8b19a4e1e9866463262a5c29d | Disco | North Central US |
| vnet-northcentralus-1 | Red virtual | North Central US |
















**Cómo interpretar los recursos:** la **máquina virtual** ejecuta Ubuntu; el **disco** conserva el sistema y los datos; la **red virtual** aporta conectividad privada; la **NIC** une la máquina con la red; la **IP pública** proporciona una dirección alcanzable desde Internet si las reglas lo permiten; el **NSG** filtra comunicaciones; y **Clave SSH** es el recurso de **clave pública**, que no sustituye la clave privada descargada al crear la VM.
















El recurso regional **NetworkWatcher_northcentralus** puede aparecer en **NetworkWatcherRG**, fuera del grupo del proyecto. No lo modifique ni lo elimine automáticamente.
















### 12.3 — Abrir Información general de la VM
















1. En la lista de **Recursos**, seleccione el enlace azul **vm-alojamientos-g01**.
2. En el menú lateral, abra **Información general**.
3. En **Información esencial**, lea los campos y compárelos con los valores siguientes:
















| Campo mostrado por Azure | Valor observado |
|---|---|
| Grupo de recursos | rg-alojamientos-g01 |
| Estado | Detenido (desasignado) |
| Ubicación | North Central US |
| Suscripción | Azure for Students |
| Sistema operativo | Linux |
| Tamaño | Standard B2als v2 (2 vCPU, 4 GiB de memoria) |
| IP pública de NIC principal | 135.232.189.196 |
| Red virtual/subred | vnet-northcentralus-1/snet-northcentralus-1 |
| Nombre DNS | Sin configurar |
















**Importante:** la IP pública indicada corresponde a la configuración de referencia del laboratorio. Si Azure asigna una IP diferente, utilice la dirección que aparezca en el recurso de su propia suscripción.
















### 12.4 — Revisar las Propiedades de la VM
















1. En la misma página, desplácese hasta la pestaña **Propiedades**, situada debajo de **Información esencial**.
2. En las secciones **Máquina virtual**, **Redes**, **Tamaño**, **Detalles de la imagen de origen**, **Disco**, **Seguridad** y **Apagado automático**, compare:
















| Sección / campo mostrado por Azure | Valor observado |
|---|---|
| Máquina virtual → Nombre del equipo | vm-alojamientos-g01 |
| Máquina virtual → Generación de VM | V2 |
| Máquina virtual → Arquitectura de VM | x64 |
| Máquina virtual → Hibernación | Deshabilitado |
| Máquina virtual → Tipo de controladora de disco | SCSI |
| Redes → Dirección IP pública | 135.232.189.196 |
| Redes → Interfaz de red | vm-alojamientos-g01139 |
| Redes → Dirección IP privada | 172.16.0.4 |
| Redes → Red virtual/subred | vnet-northcentralus-1/snet-northcentralus-1 |
| Redes → Nombre DNS | Configurar (todavía sin configurar) |
| Tamaño → Tamaño | Standard B2als v2 |
| Tamaño → vCPU | 2 |
| Tamaño → RAM | 4 GiB |
| Detalles de la imagen de origen → Publicador | canonical |
| Detalles de la imagen de origen → Oferta | ubuntu-24_04-lts |
| Detalles de la imagen de origen → Plan | server |
| Disco → Disco del SO | vm-alojamientos-g01_OsDisk_1_929b4ca8b19a4e1e9866463262a5c29d |
| Disco → Cifrado en el host | Deshabilitado |
| Disco → Azure Disk Encryption | No habilitado |
| Disco → Discos de datos | 0 |
| Seguridad → Tipo de seguridad | Inicio seguro |
| Seguridad → Habilitar arranque seguro | Habilitado |
| Seguridad → Habilitar vTPM | Habilitado |
| Seguridad → Supervisión de integridad | Deshabilitado |
| Seguridad → Protocolo de seguridad de metadatos | Deshabilitado |
| Seguridad → WireServer | Deshabilitado |
| Seguridad → IMDS | Deshabilitado |
| Apagado automático → Apagado automático | Habilitado |
| Apagado automático → Apagado programado | 11:30 a. m. (Hora estándar de Sudamérica Pacífico) |
| Extensiones + aplicaciones | Ninguna instalada |
















La sección **Supervisión del mantenimiento** muestra **No habilitado**. **Azure de acceso puntual** aparece como **Deshabilitado**. Son valores de la interfaz observada y no significan que deba activarse ningún servicio adicional.
















**Qué significa «Apagado programado»:** el recurso dispone de una programación para apagarse a las 11:30 de la mañana en la zona horaria de Bogotá. Esto **no** programa el encendido a las 10:00; el inicio automático se revisará separadamente en el Paso 16.
















### 12.5 — Verificar asociaciones de red y el recurso de disco
















1. Regrese al grupo **rg-alojamientos-g01 → Recursos**.
2. Abra **vm-alojamientos-g01139** (**Interfaz de red**) y consulte sus propiedades de red. Compruebe que pertenece a la VM **vm-alojamientos-g01**, utiliza la red **vnet-northcentralus-1** y la subred **snet-northcentralus-1**, tiene asignada la dirección privada del servidor y está asociada al NSG **vm-alojamientos-g01-nsg**.
3. Abra **vm-alojamientos-g01-ip** y compruebe que sigue vinculada a la interfaz correcta, que es una dirección **IPv4 estática, SKU Estándar, nivel Regional**, y que coincide con la IP pública mostrada por la VM.
4. Abra el recurso **Disco** y compruebe que corresponde al sistema operativo de esta VM, es de tipo **SSD estándar** y tiene **32 GiB**. No formatee, cambie ni elimine el disco.
5. Si algún valor difiere de los esperados, regístrelo antes de modificar recursos. La plantilla revisada en el Paso 10 ya confirmaba la asociación prevista del NSG y la NIC; la pantalla de cada recurso sirve para verificar la asociación real tras el despliegue.
















**Resultado esperado del Paso 12:** el grupo contiene los **siete recursos** previstos, ubicados en **North Central US**. Las pestañas **Información general** y **Propiedades** permiten comprobar Ubuntu 24.04 LTS, 2 vCPU, 4 GiB, arranque seguro y vTPM, sin discos de datos, con apagado automático a las 11:30 a. m. Si la VM fue detenida desde el portal, su estado debe ser **Detenido (desasignado)**. Confirme también las asociaciones desde los recursos de NIC, IP pública y disco.
















---
















## Paso 13 — Detener y desasignar la VM para controlar costos
















Detener una VM desde el portal de Azure y **desasignarla** libera la capacidad de procesamiento asociada. **Cerrar una ventana de terminal SSH no apaga la máquina.** Una VM puede seguir generando costos si continúa ejecutándose o queda solamente detenida sin desasignar.
















### 13.1 — Consultar el estado
















1. En [Portal de Azure](https://portal.azure.com), abra **Máquinas virtuales**.
2. Seleccione **vm-alojamientos-g01**.
3. En el menú izquierdo, abra **Información general**.
4. En **Información esencial**, localice el campo **Estado**.
















### 13.2 — Desasignar únicamente si hace falta
















1. **Si el campo Estado indica En ejecución** y terminó la ventana de trabajo, pulse **Detener** en la barra superior.
2. Confirme la operación cuando Azure la solicite.
3. Mientras aparezca **Desasignando** o una notificación como **Deteniendo máquina virtual**, no repita la orden ni pulse **Eliminar**.
4. Seleccione **Actualizar** cuando termine la operación.
5. Compruebe que el estado sea **Detenido (desasignado)**. Según la vista del portal también puede aparecer **Detenida (desasignada)**. Lo importante es que indique **desasignado/desasignada**, no solamente **detenido/detenida**.
6. **Si la VM ya muestra Detenido (desasignado), no haga nada más.** No es necesario pulsar Detener de nuevo.
















### 13.3 — Interpretar el costo y el horario
















- **Procesamiento (vCPU/RAM):** una VM desasignada deja de generar la facturación normal de cómputo asignado.
- **Disco del sistema operativo:** se conserva y puede continuar facturándose aunque la VM esté desasignada.
- **Dirección IP pública:** es un recurso independiente que puede continuar facturándose mientras exista.
- **Apagado automático:** se verificó a las **11:30 a. m.**, zona **Hora estándar de Sudamérica Pacífico**. Si una VM se inicia después de esa hora, no debe asumirse que se apagará inmediatamente: desasígnela manualmente al finalizar.
















**No utilice Eliminar para ahorrar horas de cómputo.** Esa acción puede destruir recursos o provocar costos y procedimientos de recuperación adicionales.
















**Resultado esperado del Paso 13:** la VM **vm-alojamientos-g01** muestra **Estado: Detenido (desasignado)** y el botón **Iniciar** se encuentra disponible. Esta comprobación permite confirmar que el procesamiento dejó de estar asignado. Continúe con la configuración del nombre DNS de la dirección IP pública en el Paso 14.
















---
















## Paso 14 — Configurar y verificar el nombre DNS público de Azure
















En este paso asignaremos un **nombre DNS** a la dirección IP pública del servidor. Un **nombre de dominio completo (FQDN, Fully Qualified Domain Name)** es la dirección de texto que identifica un recurso en Internet. Azure crea este nombre a partir de una etiqueta elegida para el servidor, la región y el sufijo `cloudapp.azure.com`. Esta operación no requiere comprar un dominio ni crear una zona DNS adicional.
















### 14.1 — Abrir el recurso de dirección IP pública
















1. Ingrese al [Portal de Azure](https://portal.azure.com) con la suscripción **Azure for Students**.
2. En la barra de búsqueda superior, escriba **Grupos de recursos** y abra el servicio.
3. Seleccione **rg-alojamientos-g01** y, en **Información general → Recursos**, haga clic en **vm-alojamientos-g01-ip**, de tipo **Dirección IP pública**.
4. En **Información general → Esenciales**, compruebe que el grupo, la ubicación y la IP corresponden al proyecto. La dirección IP de referencia es **135.232.189.196**.
5. Localice el campo **Nombre DNS**. Si muestra **Sin configurar**, continúe con el apartado 14.2. Si muestra un nombre completo que coincide con el previsto, pase directamente a la verificación del apartado 14.3.
















### 14.2 — Configurar la etiqueta de nombre DNS
















1. Dentro del recurso **vm-alojamientos-g01-ip**, expanda **Configuración** en el menú izquierdo.
2. Seleccione la opción **Configuración** que aparece dentro de ese menú.
3. Localice **Etiqueta de nombre DNS** (*DNS name label*). Este campo contiene solamente la primera parte del dominio, no el nombre completo.
4. Escriba **alojamientos-g01**. Si Azure informa que la etiqueta no está disponible en **North Central US**, utilice una variante única y anote el nombre elegido para los pasos posteriores.
5. Compruebe que no está modificando la dirección IP, el SKU **Standard** ni el método de asignación **Static**.
6. Seleccione **Guardar** y espere a que Azure termine la actualización.
7. Regrese a **Información general** y localice nuevamente **Nombre DNS**. Con la etiqueta propuesta y la región del proyecto, el nombre esperado es `alojamientos-g01.northcentralus.cloudapp.azure.com`.
















### 14.3 — Comprobar las propiedades de la dirección IP
















1. En **Información general → Esenciales**, confirme que se muestra el nombre DNS completo.
2. En la pestaña **Propiedades**, compruebe la dirección IP, el método de asignación y la asociación con la máquina virtual.
3. Compare los datos con esta configuración de referencia:
















| Campo mostrado por Azure | Valor de referencia |
|---|---|
| Grupo de recursos | rg-alojamientos-g01 |
| Ubicación | North Central US |
| Suscripción | Azure for Students |
| SKU | Standard |
| Nivel | Regional |
| Dirección IP | 135.232.189.196 |
| Nombre DNS | alojamientos-g01.northcentralus.cloudapp.azure.com |
| Asociado a | vm-alojamientos-g01139 |
| Máquina virtual | vm-alojamientos-g01 |
| Versión de la dirección IP | IPv4 |
| Estado de aprovisionamiento | Succeeded |
| Método de asignación | Static |
| Ámbito de etiqueta de nombre de dominio | - |
| Tiempo de espera de inactividad | 4 |
| Preferencia de enrutamiento | Red de Microsoft |
















**Interpretación:** **Succeeded** indica que el recurso terminó de aprovisionarse. **Static** significa que la IP pública queda reservada mientras exista el recurso. El campo **Ámbito de etiqueta de nombre de dominio** puede mostrar un guion; compruebe el nombre completo en **Nombre DNS**, que es el campo relevante para esta tarea. Si aparece la sección **DDoS Protection** con estado **Desprotegido**, no confunda ese estado con un fallo del DNS: describe una opción distinta de protección de red.
















### 14.4 — Verificar la resolución del nombre DNS con Git Bash
















El sistema **DNS (Domain Name System)** traduce un nombre como `alojamientos-g01.northcentralus.cloudapp.azure.com` a una dirección IP. Para comprobar que la traducción funciona desde otro equipo, utilizaremos `nslookup`, una herramienta de consulta DNS disponible en Windows.
















1. En Windows, abra el menú **Inicio**, busque **Git Bash** y ejecútelo.
2. Escriba el siguiente comando y presione **Enter**:
















~~~bash
nslookup alojamientos-g01.northcentralus.cloudapp.azure.com
~~~
















3. Identifique los datos de la respuesta. Puede ver una salida similar a este **ejemplo de resultado correcto**:
















~~~text
Servidor:  one.one.one.one
Address:  1.1.1.1
















Respuesta no autoritativa:
Nombre:  alojamientos-g01.northcentralus.cloudapp.azure.com
Address:  135.232.189.196
~~~
















4. En la parte superior, **Servidor** y **Address: 1.1.1.1** identifican el servidor DNS que respondió. Su nombre y su dirección pueden ser diferentes en otro equipo.
5. En la sección **Respuesta no autoritativa**, compruebe que **Nombre** sea el dominio consultado y que **Address** coincida con la IP pública registrada en Azure, en este ejemplo **135.232.189.196**.
6. Si la dirección devuelta es correcta, la resolución DNS está comprobada. Si aparece **Non-existent domain**, **NXDOMAIN**, un tiempo de espera o una IP distinta, revise la etiqueta y la dirección IP pública en Azure, espere a que se actualicen los servidores DNS y repita la consulta.
















**¿Qué significa «Respuesta no autoritativa»?** Significa que la respuesta proviene de un servidor DNS que realiza consultas para otros equipos, y no directamente del servidor responsable del dominio. Es habitual y no representa un error.
















**Resultado esperado del Paso 14:** en Azure figura el FQDN configurado y la consulta `nslookup` devuelve la IP pública correcta. Esta prueba comprueba el DNS; el acceso por SSH y la publicación de los servicios web se configurarán en los pasos posteriores.








---








## Paso 15 — Autorizar el acceso SSH desde una dirección IPv4 pública








En este paso configuraremos una **regla de seguridad de entrada** en Azure para permitir el acceso administrativo al servidor Ubuntu desde un computador autorizado. **SSH (Secure Shell)** es un protocolo para establecer sesiones remotas cifradas. El servicio SSH utiliza normalmente el **puerto TCP 22**.








Un **grupo de seguridad de red (NSG)** controla qué tráfico se permite o deniega hacia los recursos asociados. Configuraremos una regla limitada a una sola **dirección IPv4 pública de origen**. El grupo de seguridad previsto para el proyecto es **vm-alojamientos-g01-nsg**.








### 15.1 — Revisar las reglas de entrada existentes








1. Ingrese al [Portal de Azure](https://portal.azure.com) y abra **Grupos de recursos**.
2. Seleccione **rg-alojamientos-g01** y localice el recurso **vm-alojamientos-g01-nsg**, de tipo **Grupo de seguridad de red**.
3. En el menú izquierdo, abra **Configuración → Reglas de seguridad de entrada**.
4. Compruebe las reglas existentes. Un NSG nuevo normalmente muestra las siguientes reglas predeterminadas:








| Prioridad | Nombre | Acción | Función |
|---|---|---|---|
| 65000 | AllowVnetInBound | Allow | Permite tráfico de entrada dentro de la red virtual. |
| 65001 | AllowAzureLoadBalancerInBound | Allow | Permite tráfico procedente del equilibrador de carga de Azure. |
| 65500 | DenyAllInBound | Deny | Bloquea el tráfico de entrada que no haya sido autorizado por una regla de mayor prioridad. |








5. Revise si ya existe alguna regla personalizada que permita **TCP 22**. Si existe, compruebe su origen antes de crear otra regla; no cree reglas duplicadas.
6. **No elimine ni modifique las reglas predeterminadas.** Azure evalúa primero los números de prioridad menores, de modo que la regla personalizada de prioridad **100** se evaluará antes que las anteriores.








### 15.2 — Identificar la dirección IPv4 pública del computador administrador








La dirección de **origen** debe ser la dirección IPv4 pública desde la cual se realizará la conexión SSH; **no** la dirección IP pública del servidor Azure. Esta dirección puede cambiar si se utiliza otra red, se activa una VPN o el proveedor de Internet reasigna la conexión.








1. En Windows, abra **Inicio → Git Bash**.
2. Ejecute:








~~~bash
curl -4 -s https://api.ipify.org
echo
~~~








3. Anote la IPv4 pública devuelta por el comando. No copie la dirección de ejemplo de otro equipo ni la dirección del servidor de Azure.
4. Agregue el sufijo **/32** a la dirección obtenida. Por ejemplo, si la IPv4 devuelta fuera **203.0.113.25** (ejemplo ilustrativo, no una dirección real que deba autorizarse), el valor de origen sería **203.0.113.25/32**.
5. **¿Qué significa /32?** Es la notación CIDR que indica una sola dirección IPv4. Restringe el origen autorizado de la regla a ese equipo o conexión, en lugar de aceptar todo Internet.








### 15.3 — Agregar la regla de seguridad de entrada








1. Regrese a **vm-alojamientos-g01-nsg → Reglas de seguridad de entrada**.
2. Seleccione **Agregar**. Azure abrirá el formulario **Agregar regla de seguridad de entrada**.
3. Complete los campos visibles en este orden:








| Campo mostrado por Azure | Valor que debe establecer | Explicación |
|---|---|---|
| Origen | **Direcciones IP** | Permite limitar el origen a una IPv4 específica; no conservar **Any**. |
| Intervalos de direcciones IP de origen y CIDR | **La IPv4 obtenida en 15.2, seguida de /32** | Este campo aparece después de seleccionar **Direcciones IP**. |
| Intervalos de puertos de origen | `*` | El computador cliente puede utilizar puertos de origen variables. |
| Destino | **Any** | La regla se aplica a los destinos protegidos por este NSG. |
| Servicio | **Custom** | Permite indicar manualmente el puerto SSH. |
| Intervalos de puertos de destino | **22** | Puerto estándar de SSH; si aparece 8080 como valor inicial, reemplácelo. |
| Protocolo | **TCP** | Limita la regla al protocolo usado por SSH; no conservar **Any**. |
| Acción | **Permitir** | Autoriza solo las conexiones que cumplen todas las condiciones. |
| Prioridad | **100** | Se evalúa antes que las reglas predeterminadas; el valor debe estar libre. |
| Nombre | **Allow-SSH-Admin** | Nombre identificador de la regla de administración. |
| Descripción | **Permitir SSH TCP 22 desde la IP pública autorizada** | Resume la finalidad y el alcance de la regla. |








4. Compruebe especialmente **Origen**, **puerto de destino 22** y **protocolo TCP**. No deje la combinación **Origen: Any** y **TCP 22**, pues permitiría intentos de conexión desde todo Internet.
5. Si la prioridad **100** ya está ocupada por otra regla personalizada, seleccione una prioridad libre conforme a la planificación de reglas del NSG; no sobrescriba una regla sin revisarla.
6. Seleccione **Agregar** para guardar la regla.








### 15.4 — Verificar la regla creada








1. Permanezca en **vm-alojamientos-g01-nsg → Reglas de seguridad de entrada**.
2. Localice la fila **Allow-SSH-Admin**.
3. Verifique que indique **Prioridad: 100**, **Puerto: 22**, **Protocolo: TCP**, **Origen: su dirección IPv4 pública/32** y **Acción: Allow**. El campo **Destino** puede mostrarse como **Cualquiera**.
4. Compruebe que las reglas predeterminadas **AllowVnetInBound**, **AllowAzureLoadBalancerInBound** y **DenyAllInBound** continúen presentes.
5. Si la IP pública del computador cambia, actualice el **Origen** de la regla antes de intentar una nueva conexión administrativa.
6. La creación de esta regla no inicia la máquina virtual ni comprueba por sí sola la autenticación SSH. La conexión a Ubuntu se probará cuando corresponda encender el servidor y utilizar la clave privada SSH descargada durante su creación.








**Resultado esperado del Paso 15:** existe una regla de entrada **Allow-SSH-Admin** que permite tráfico **TCP 22** únicamente desde la IPv4 pública autorizada con máscara **/32**, y se conservan todas las reglas predeterminadas del NSG. La máquina virtual puede permanecer **Detenida (desasignada)** durante la configuración de la regla.




---




## Paso 16 — Verificar el apagado automático y programar el encendido diario




En este paso estableceremos un horario para utilizar la máquina virtual **vm-alojamientos-g01** durante la ventana de laboratorio de **10:00 a 11:30 de la mañana, hora de Bogotá**. La programación pretende reducir horas de procesamiento fuera de ese período.




El **apagado automático** se configura en las opciones de la máquina virtual y debe detener y desasignar la VM a las **11:30 a. m.** Para programar el **encendido a las 10:00 a. m.**, usaremos una **tarea** de Azure. Esta tarea crea un recurso **Logic Apps (Consumo)**, que ejecuta operaciones de automatización y puede producir cargos por consumo. El inicio programado es independiente del apagado automático.




### 16.1 — Comprobar el apagado automático de la VM




1. Abra el [Portal de Azure](https://portal.azure.com) y busque **Máquinas virtuales**.
2. Seleccione **vm-alojamientos-g01**.
3. En el menú izquierdo busque **Apagado automático**.
4. Compruebe que esté **Habilitado**, con la hora **11:30 a. m.** y la zona **Hora estándar de Sudamérica Pacífico** (**SA Pacific Standard Time**), correspondiente a Bogotá (UTC−05:00).
5. Si coincide, conserve la programación existente; no cree otro apagado. Si no coincide, ajuste los campos visibles, guarde los cambios y confirme nuevamente el horario.
6. El apagado programado **no enciende automáticamente** la VM a las 10:00 a. m.; para ello se necesita la tarea de los apartados siguientes.




### 16.2 — Abrir una tarea de inicio programado




1. En la máquina virtual **vm-alojamientos-g01**, abra la sección **Tareas** del menú izquierdo, dentro de las opciones de automatización.
2. Seleccione **Agregar una tarea**. Se abrirá el asistente de cuatro etapas: **Seleccionar una plantilla → Autenticar → Configurar → Revisar y crear**.
3. En **Seleccionar una plantilla**, localice **Start Virtual Machine** (iniciar máquina virtual). No seleccione **Power off Virtual Machine**, **Deallocate Virtual Machine** ni **Send monthly cost for resource**.
4. Haga clic en **Seleccionar** dentro de **Start Virtual Machine** y luego en **Siguiente: Autenticar**.
5. Revise el aviso de Azure: **Esta tarea se puede facturar**. Antes de habilitar tareas recurrentes, tenga presente que Logic Apps (Consumo), la VM, los discos y la IP pública tienen modelos de cobro diferentes. Una tarea automática no garantiza que todo el despliegue sea gratuito.




### 16.3 — Autenticar las conexiones requeridas por la plantilla




En **Autenticar**, la plantilla puede solicitar estas dos conexiones:




| Conexión mostrada por Azure | Función dentro de la tarea |
|---|---|
| VM de Azure (azurevm) | Autoriza las acciones sobre la máquina virtual. |
| Office 365 Outlook (office365) | Permite a la plantilla utilizar funciones de correo. |




1. En la fila **VM de Azure (azurevm)**, si figura **No conectado**, seleccione **Crear**.
2. Revise la ventana de autorización, autentíquese con la cuenta correspondiente y autorice solamente si los permisos solicitados corresponden a la tarea. Regrese al asistente y compruebe que aparezca **Conectado**.
3. En la fila **Office 365 Outlook (office365)**, seleccione **Crear** si la conexión está pendiente.
4. En **Nombre para mostrar**, introduzca un identificador descriptivo, como **outlook-alojamientos-g01**. Este nombre **no** es la dirección de correo.
5. En **Tipo de autenticación**, seleccione **Office 365 (sign in as user)** si utiliza una cuenta de Microsoft 365 institucional o de trabajo compatible. La opción **Federated Identity Credential** es otro método de autenticación y no se necesita para este ejercicio.
6. Inicie sesión en la cuenta autorizada y revise los permisos requeridos por Outlook. No introduzca contraseñas, claves, códigos de verificación ni datos personales en el manual.
7. Regrese al asistente y confirme que **VM de Azure (azurevm)** y **Office 365 Outlook (office365)** figuren como **Conectado**.
8. Si no dispone de una cuenta de Microsoft 365 compatible o no está autorizado a conceder los permisos solicitados, **no fuerce la conexión**: conserve el encendido manual hasta elegir un método alternativo de automatización.




**Importante:** la dirección de correo usada para avisos del **apagado automático** no sustituye esta autenticación de Office 365. Son mecanismos distintos.




### 16.4 — Configurar el horario de encendido




Seleccione **Siguiente: Configurar** y complete los campos de la plantilla de inicio.




| Campo mostrado por Azure | Valor que debe establecer | Explicación |
|---|---|---|
| Nombre de la tarea | **start-vm-alojamientos-g01-1000** | Nombre identificador del encendido programado. |
| Start Time — fecha | **Fecha futura en que debe comenzar la programación** | Selecciónela desde el calendario; no conserve una fecha inicial vencida. |
| Start Time — hora | **10:00:00** | Encendido a las diez de la mañana en la zona horaria indicada. |
| Timezone | **SA Pacific Standard Time** | Zona horaria correspondiente a Bogotá, UTC−05:00. |
| Interval | **1** | Una ejecución por cada unidad de frecuencia. |
| Frequency | **Day** | La tarea se repetirá diariamente. |
| Notify Me | **Desactivado** | No se requieren mensajes de notificación adicionales. |
| Enter email | **Dirección de correo válida y autorizada** | Algunas versiones de esta plantilla exigen el parámetro de correo incluso con notificaciones desactivadas. |




**Cómo interpretar la programación:** **Interval: 1** junto con **Frequency: Day** significa que la tarea intentará ejecutarse **cada día**, incluidos sábados y domingos. Solo utilice esa frecuencia si el laboratorio debe operar diariamente. Si el uso previsto se limita a determinados días, ajuste la periodicidad conforme a las opciones disponibles antes de crear la tarea.




**Fecha de inicio:** al seleccionar una fecha, confirme el orden día/mes/año del formulario. Por ejemplo, **10/11/2026** equivale al **10 de noviembre de 2026** cuando Azure utiliza formato día/mes/año; no copie una fecha histórica o ya vencida en futuras instalaciones.




**Nota sobre el correo:** aunque **Notify Me** esté **Desactivado**, complete **Enter email** con un correo autorizado. No es necesario publicar en el manual ni en evidencias compartidas la dirección de una persona.




### 16.5 — Revisar y crear la tarea




1. Compruebe la fecha y hora, la zona horaria y la frecuencia. Verifique que **Enter email** contenga una dirección de correo válida y autorizada, incluso con **Notify Me: Desactivado**, según el apartado 16.4.
2. Seleccione **Siguiente: Revisar y crear**.
3. Azure debe presentar un recurso nuevo con el nombre **start-vm-alojamientos-g01-1000** y el tipo **Logic Apps (Consumo)**.
4. Revise el aviso de facturación. La pantalla puede no ofrecer una estimación exacta para cada ejecución; la automatización puede generar cargos que se suman al consumo de los demás recursos.
5. Si los datos son correctos, pulse **Crear**.
6. Si Azure informa un fallo de validación, revise los campos y conexiones correspondientes antes de volver a crear la tarea. Evite generar recursos duplicados; no elimine la VM ni las conexiones para corregir la configuración de la tarea.




### 16.6 — Comprobar la tarea creada




1. Vuelva a **vm-alojamientos-g01 → Tareas**.
2. Compruebe que aparezca **start-vm-alojamientos-g01-1000** con **Tipo: Tarea programada** y **Respaldado por: Logic Apps (Consumo)**.
3. Haga clic en el nombre de la tarea.
4. En **Autenticar**, confirme que ambas conexiones, **azurevm** y **office365**, continúen en estado **Conectado**.
5. Abra la pestaña **Configurar** y compruebe **Start Time: 10:00:00**, **Timezone: SA Pacific Standard Time**, **Interval: 1**, **Frequency: Day**, **Notify Me: Desactivado** y que **Enter email** tenga una dirección autorizada. No modifique la dirección de correo solo para comprobarla.
6. Si los valores coinciden, salga de los detalles sin guardar cambios innecesarios.
7. Para revisar ejecuciones, vuelva a **Tareas** y seleccione **Ver** en la columna **Ejecuciones**. Si todavía no llegó la primera hora programada, el historial puede estar vacío y eso no indica, por sí solo, un fallo.




### 16.7 — Comprobar la primera ejecución programada




1. Después de la primera fecha y hora programadas, consulte el historial de **Ejecuciones** de la tarea.
2. Compruebe que la ejecución correspondiente se completó correctamente.
3. Abra **Máquinas virtuales → vm-alojamientos-g01 → Información general** y confirme que la VM se encuentra **En ejecución**, siempre que esté dentro de la ventana de laboratorio.
4. Después de las **11:30 a. m.**, compruebe que el estado vuelve a **Detenido (desasignado)**. Una VM desasignada deja de generar el cargo normal de procesamiento, pero el disco y la IP pública pueden seguir generando costos.
5. Si alguna ejecución falla, examine los detalles del historial y las conexiones antes de repetirla; no programe un segundo encendido con el mismo propósito.




**Resultado esperado del Paso 16:** existe una tarea de inicio programado **start-vm-alojamientos-g01-1000**, con periodicidad **1 Day** a las **10:00:00** en **SA Pacific Standard Time**, y el apagado automático de la VM permanece configurado para las **11:30 a. m.**. La creación y la configuración de la tarea se verifican en el portal; **su funcionamiento efectivo solo queda comprobado después de revisar una ejecución programada satisfactoria**.


---

## Paso 17 — Acceder a Ubuntu, actualizar el sistema y comprobar el entorno

Accederemos a la máquina virtual mediante **SSH (Secure Shell)** desde Git Bash en Windows. Identificaremos el usuario y la versión de Ubuntu, consultaremos las actualizaciones disponibles, instalaremos las necesarias y comprobaremos si el servidor requiere reiniciarse. **Actualizar paquetes no es lo mismo que cambiar de versión de Ubuntu**: conservaremos Ubuntu Server 24.04 LTS.

### 17.1 — Conectarse a Ubuntu desde Git Bash

1. Ingrese al [Portal de Azure](https://portal.azure.com) y abra **Máquinas virtuales → vm-alojamientos-g01**.
2. Compruebe que el estado sea **En ejecución**. Si se encuentra **Detenido (desasignado)**, iníciela solamente cuando necesite trabajar y tenga presente el costo de cómputo.
3. Abra **Git Bash** en Windows (no PowerShell).
4. Ejecute el comando siguiente; la ruta indicada corresponde al lugar donde se descargó la clave privada en este proyecto:

~~~bash
ssh -i "$HOME/Downloads/vm-alojamientos-g01_key.pem" azureuser@135.232.189.196
~~~

| Elemento | Función |
|---|---|
| `ssh` | Abre una conexión remota cifrada. |
| `-i` | Selecciona el archivo de clave privada para la autenticación. |
| `$HOME/Downloads/vm-alojamientos-g01_key.pem` | Ruta local de la clave privada descargada al crear la VM. |
| `azureuser` | Usuario autorizado de Ubuntu. |
| `135.232.189.196` | Dirección IPv4 pública de esta VM. |

Cada estudiante debe utilizar **su propia** clave, usuario e IP. **Nunca comparta ni suba la clave privada a un chat, Drive o GitHub.** El NSG debe mantener el acceso SSH TCP 22 restringido a la IPv4 administrativa autorizada con `/32`.

5. Compruebe que aparece el mensaje de bienvenida de Ubuntu y un indicador similar a `azureuser@vm-alojamientos-g01:~$`. Desde ese momento, los comandos se ejecutan **dentro de Ubuntu**, aunque la conexión se haya iniciado en Git Bash.

### 17.2 — Identificar el usuario y la versión de Ubuntu

1. Ejecute:

~~~bash
whoami
~~~

`whoami` muestra el usuario de la sesión. Para esta máquina, el resultado verificado es `azureuser`.

2. Ejecute:

~~~bash
cat /etc/os-release
~~~

`cat` muestra el contenido de un archivo; `/etc/os-release` contiene los datos de identificación de la distribución Linux. En este proyecto se verificaron, entre otros, los siguientes campos:

~~~text
PRETTY_NAME="Ubuntu 24.04.5 LTS"
VERSION_ID="24.04"
VERSION_CODENAME=noble
ID=ubuntu
~~~

`noble` es el nombre corto de Ubuntu 24.04 y se empleará para seleccionar el repositorio compatible de Docker. Si aparece otra distribución o versión, **compruebe su compatibilidad antes de continuar**, en lugar de ejecutar sin revisar comandos preparados para Ubuntu 24.04.

### 17.3 — Consultar e instalar actualizaciones de Ubuntu

1. Actualice el catálogo de paquetes:

~~~bash
sudo apt update
~~~

- `sudo` concede permisos administrativos para esta operación.
- `apt` es el administrador de paquetes de Ubuntu.
- `update` descarga la información actualizada de los repositorios; **no instala** todavía las actualizaciones de los programas.

2. Consulte qué paquetes tienen versiones nuevas disponibles:

~~~bash
apt list --upgradable
~~~

`apt list --upgradable` muestra los paquetes que pueden actualizarse según el catálogo actual. En una consulta del servidor del proyecto se identificaron 14 paquetes, entre ellos `apt`, `ca-certificates`, componentes de DNS y bibliotecas del sistema. En otras fechas, la cantidad puede variar.

3. **Si aparecen paquetes pendientes**, revise la lista y ejecute:

~~~bash
sudo apt upgrade
~~~

`upgrade` instala las actualizaciones permitidas por APT para los paquetes ya instalados. Revise el resumen antes de confirmar con `Y` cuando se solicite; si anuncia eliminaciones inesperadas, cambios no comprendidos o errores, no continúe sin examinarlos. No cierre SSH durante la actualización.

4. **Si no aparecen paquetes pendientes**, omita `sudo apt upgrade`: no es necesario reinstalar software que ya está actualizado.

**Importante:** no utilice `do-release-upgrade`; ese comando corresponde a cambios de versión de la distribución y no es necesario para mantener actualizado Ubuntu 24.04 LTS.

### 17.4 — Comprobar si el sistema necesita reiniciarse

Algunas actualizaciones solo terminan de aplicarse tras un reinicio. Consulte la señal que mantiene Ubuntu:

~~~bash
if [ -f /var/run/reboot-required ]; then
    echo "REINICIO REQUERIDO"
else
    echo "NO REQUIERE REINICIO"
fi
~~~

| Elemento | Explicación |
|---|---|
| `if ... then ... else ... fi` | Evalúa una condición y muestra un resultado u otro. |
| `-f /var/run/reboot-required` | Comprueba si existe el archivo que señala la necesidad de reinicio. |
| `echo` | Muestra un mensaje en la terminal. |

- Si aparece **NO REQUIERE REINICIO**, continúe con el siguiente apartado.
- Si aparece **REINICIO REQUERIDO**, compruebe primero que no haya operaciones importantes en curso, revise el horario automático de Azure y, dentro de una ventana segura, ejecute `sudo reboot`. SSH se desconectará temporalmente; vuelva a conectarse con el comando del apartado 17.1 y repita la comprobación.

No se debe interpretar la ausencia de este archivo como una auditoría completa de todos los servicios del sistema.

### 17.5 — Verificar las actualizaciones pendientes

1. Consulte de nuevo:

~~~bash
apt list --upgradable
~~~

2. Si no se enumeran paquetes después de `Listing... Done`, APT no identifica actualizaciones pendientes en ese momento. Si todavía aparecen, examine cuáles son y si están retenidos antes de decidir otra operación.

**Resultado esperado del Paso 17:** acceso SSH comprobado, usuario y distribución identificados, actualizaciones consultadas y aplicadas cuando correspondía, y necesidad de reinicio revisada. La segunda lista de paquetes actualizables se utiliza como comprobación final: no debe considerarse vacía sin observar su salida.

---

## Paso 18 — Instalar Docker Engine y Docker Compose en Ubuntu

Prepararemos Ubuntu para descargar **Docker Engine** y **Docker Compose** desde el repositorio oficial de Docker. Docker Engine permite crear y ejecutar contenedores; Docker Compose permite describir y administrar varios servicios desde un archivo YAML. Los repositorios del Frontend y Backend del Sistema Alojamientos ya incluyen archivos `Dockerfile`, pero **todavía no desplegaremos las aplicaciones**.

La referencia oficial de instalación es [Install Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/). La comprobación, instalación y verificación se realizan dentro de la sesión SSH de Ubuntu, no en la terminal local de Windows.

### 18.1 — Comprobar si Docker y Docker Compose ya están disponibles

1. Consulte la versión del cliente Docker:

~~~bash
docker --version
~~~

2. Consulte Docker Compose:

~~~bash
docker compose version
~~~

Si ambos comandos muestran versiones, **no reinstale inmediatamente** los paquetes; compruebe su funcionamiento en el apartado 18.9. Si Ubuntu muestra `Command 'docker' not found` o el complemento Compose no está disponible, continúe con las comprobaciones previas. En esta VM, **ambos comandos estaban inicialmente ausentes**.

### 18.2 — Comprobar paquetes anteriores de contenedores

Antes de usar el repositorio oficial, ejecute:

~~~bash
dpkg -l | grep -E 'docker|containerd|runc'
~~~

`dpkg -l` lista paquetes registrados; la barra `|` entrega esa salida a `grep -E`, que busca términos relacionados con Docker, Containerd o Runc. Si no aparece ninguna línea, la búsqueda no encontró coincidencias; **no es un fallo de Ubuntu**. Si aparecen paquetes marcados con `ii`, revise cuáles están instalados y compruebe posibles conflictos antes de instalar otros. No elimine paquetes automáticamente.

**Comprobación del proyecto:** esta búsqueda no mostró líneas, por lo que no se detectaron paquetes coincidentes en la salida consultada.

### 18.3 — Comprobar las dependencias `ca-certificates` y `curl`

Ejecute:

~~~bash
dpkg -l ca-certificates curl
~~~

| Paquete | Para qué sirve |
|---|---|
| `ca-certificates` | Proporciona certificados de confianza para verificar conexiones HTTPS. |
| `curl` | Permite descargar la clave pública desde el sitio oficial de Docker. |

La marca `ii` al inicio de la fila indica que el paquete está instalado. Si alguno falta, instálelo después de actualizar APT mediante `sudo apt install ca-certificates curl`; si ambos están instalados, no es necesario reinstalarlos.

**Comprobación del proyecto:** `ca-certificates` versión `20260816ubuntu0.24.04.2` y `curl` versión `8.5.0-2ubuntu10.16` aparecieron con `ii`, por lo que se continuó sin reinstalarlos.

### 18.4 — Preparar el directorio de claves del repositorio

1. Asegure que existe el directorio con los permisos previstos:

~~~bash
sudo install -m 0755 -d /etc/apt/keyrings
~~~

`install -d` crea el directorio si hace falta y `-m 0755` establece permisos para que el propietario pueda modificarlo y los demás puedan leer o acceder a él. Este directorio almacena las claves que APT usará para verificar repositorios externos.

2. Compruebe sus propiedades:

~~~bash
ls -ld /etc/apt/keyrings
~~~

`ls -ld` muestra los permisos, propietario y demás propiedades del **directorio**, no de sus archivos. La salida del proyecto fue `drwxr-xr-x ... root root ... /etc/apt/keyrings`; corresponde a permisos `755`. **No copie al terminal una línea de resultado como si fuera un comando.**

### 18.5 — Descargar y comprobar la clave oficial de Docker

1. Compruebe primero si existe:

~~~bash
ls -l /etc/apt/keyrings/docker.asc
~~~

Si aparece `No such file or directory`, la clave todavía no existe en esa ruta y debe descargarse. Si ya existe, examine su huella antes de sustituirla.

2. Para descargar la clave oficial cuando haga falta, ejecute:

~~~bash
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg \
  -o /etc/apt/keyrings/docker.asc
~~~

`curl -f` informa de respuestas HTTP fallidas; `-sS` oculta el progreso pero conserva los errores; `-L` sigue redirecciones; `-o` guarda el archivo en la ruta indicada. La barra invertida al final de la primera línea continúa el mismo comando en la siguiente.

3. Compruebe primero los permisos del archivo para asegurar que APT pueda leer la clave:

~~~bash
ls -l /etc/apt/keyrings/docker.asc
~~~

**Resultado de referencia:** permisos `-rw-r--r--`, propietario `root` y tamaño **3817 bytes** (el tamaño puede variar). Si el archivo ya tiene permiso de lectura para todos, continúe con la comprobación de la huella. Solo si falta ese permiso, ejecute:

~~~bash
sudo chmod a+r /etc/apt/keyrings/docker.asc
ls -l /etc/apt/keyrings/docker.asc
~~~

`chmod a+r` concede permiso de lectura a todos los usuarios. El segundo comando permite confirmar el ajuste.

4. Compruebe su huella digital:

~~~bash
gpg --show-keys --with-fingerprint /etc/apt/keyrings/docker.asc
~~~

GPG muestra la identidad y la huella criptográfica de la clave pública. La referencia de Docker es:

~~~text
9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88
~~~

La comprobación del proyecto mostró esa misma huella y la identidad **Docker Release (CE deb)**. El directorio `~/.gnupg` puede crearse automáticamente la primera vez que se ejecuta GPG; no es un error.

### 18.6 — Configurar el repositorio oficial de Docker

1. Compruebe si ya existe el archivo de configuración:

~~~bash
ls -l /etc/apt/sources.list.d/docker.sources
~~~

Si existe, revise su contenido antes de modificarlo; si no existe, créelo con el bloque siguiente. En esta VM inicialmente no existía.

2. Cree el archivo (copie el bloque completo, incluida la última línea `EOF`):

~~~bash
sudo tee /etc/apt/sources.list.d/docker.sources > /dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
~~~

`sudo tee` escribe un archivo con permisos administrativos; `<<EOF` y `EOF` delimitan el contenido. `> /dev/null` evita repetirlo en pantalla. El campo `Suites` obtiene el nombre de Ubuntu (`noble`) desde `/etc/os-release`; `Architectures` consulta la arquitectura de paquetes (`amd64`); `Signed-By` indica la clave que usará APT.

3. Verifique el contenido:

~~~bash
cat /etc/apt/sources.list.d/docker.sources
~~~

**Configuración verificada en el proyecto:**

~~~text
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: noble
Components: stable
Architectures: amd64
Signed-By: /etc/apt/keyrings/docker.asc
~~~

Este archivo **no instala Docker**; indica dónde buscar sus paquetes y cómo verificar su firma.

### 18.7 — Actualizar el catálogo de paquetes con el repositorio nuevo

Ejecute:

~~~bash
sudo apt update
~~~

Es necesario repetir `apt update` porque se agregó una fuente de paquetes nueva. El comando consulta las versiones disponibles, pero no instala Docker. Compruebe que aparecen referencias a `https://download.docker.com/linux/ubuntu` para `noble` y `noble/stable amd64 Packages`, sin errores de firma o descarga.

**Comprobación del proyecto:** el catálogo se actualizó, se descargó la información del repositorio oficial y APT terminó con `All packages are up to date.`

### 18.8 — Instalar Docker Engine y Docker Compose

Si Docker y Compose ya están instalados y funcionan, no repita la instalación. Cuando haga falta, ejecute:

~~~bash
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
~~~

| Paquete | Función |
|---|---|
| `docker-ce` | Motor que crea y ejecuta contenedores. |
| `docker-ce-cli` | Comando `docker` para comunicarse con el motor. |
| `containerd.io` | Componente que gestiona la ejecución y el ciclo de vida de contenedores. |
| `docker-buildx-plugin` | Complemento para construir imágenes. |
| `docker-compose-plugin` | Complemento que habilita `docker compose`. |

No se incluye `-y`: primero revise la lista de paquetes, descargas, uso de disco y posibles eliminaciones. Si todo es esperado, confirme con `Y` cuando APT lo solicite. La instalación puede añadir dependencias necesarias automáticamente.

**Comprobación del proyecto:** APT informó **7 paquetes nuevos**, **102 MB** descargados y aproximadamente **389 MB** de espacio adicional. Se instalaron Docker Engine y CLI **29.9.3**, Containerd **2.4.2**, Buildx **0.38.1**, Docker Compose **5.7.0**, además de `docker-ce-rootless-extras` y `pigz`. No aparecieron errores de instalación. Los mensajes sobre reinicios diferidos de otros servicios o sesiones con binarios antiguos deben revisarse según corresponda, pero no implicaron un fallo de la instalación.

### 18.9 — Verificar el servicio, las versiones y un contenedor de prueba

1. Compruebe que el servicio de Docker esté activo:

~~~bash
sudo systemctl is-active docker
~~~

`systemctl` consulta servicios administrados por Linux e `is-active` indica si están funcionando. **Resultado verificado:** `active`.

2. Compruebe las versiones instaladas:

~~~bash
docker --version
docker compose version
~~~

**Resultados verificados:** `Docker version 29.9.3, build 5457199` y `Docker Compose version v5.7.0`.

3. Compruebe la ejecución real de un contenedor temporal:

~~~bash
sudo docker run --rm hello-world
~~~

| Elemento | Función |
|---|---|
| `sudo` | Ejecuta Docker con permisos administrativos. |
| `docker run` | Crea e inicia un contenedor a partir de una imagen. |
| `--rm` | Elimina automáticamente el **contenedor** al finalizar, no la imagen. |
| `hello-world` | Imagen de prueba oficial que verifica la comunicación y ejecución del motor. |

Docker buscará primero la imagen localmente; si falta, la descargará de Docker Hub. Después ejecutará el contenedor y mostrará un mensaje de confirmación. La descarga requiere conexión a Internet, pero no publica puertos del servidor.

**Resultado verificado en esta VM:** la imagen `hello-world` se descargó correctamente y el contenedor mostró:

~~~text
Hello from Docker!
This message shows that your installation appears to be working correctly.
~~~

4. No es necesario agregar `azureuser` al grupo `docker` para este laboratorio. Dicho grupo proporciona acceso muy privilegiado al motor y puede equivaler a permisos de administrador; mientras tanto utilizaremos `sudo docker` para ejecutar contenedores. No abra los puertos de MySQL (`3306`) ni Gunicorn/Flask (`5000`) a Internet. La publicación de los servicios, las redes entre contenedores y HTTPS se configurarán en pasos posteriores.

**Resultado esperado del Paso 18:** Docker Engine y Docker Compose instalados desde el repositorio oficial cuando se necesiten, servicio Docker activo y ejecución satisfactoria de `hello-world`. **En el Sistema Alojamientos estas tres comprobaciones quedaron verificadas.** La instalación de Docker no significa que el Frontend, el Backend ni la base de datos ya estén desplegados.



---

## Paso 19 — Preparar Git y descargar los repositorios públicos del Sistema Alojamientos

En este paso prepararemos el directorio de trabajo de Ubuntu y descargaremos el código fuente del Frontend y del Backend desde GitHub mediante **HTTPS**. Los dos repositorios del proyecto se encuentran disponibles públicamente, por lo que esta descarga no necesita introducir usuario, contraseña ni tokens.

La máquina virtual ya cuenta con Docker Engine y Docker Compose, instalados y verificados en el Paso 18. La descarga del código fuente no equivale a construir imágenes, instalar dependencias, iniciar contenedores ni publicar el sistema en Internet.

### 19.1 — Comprobar que Git está instalado

Ejecute en la sesión SSH de Ubuntu:

~~~bash
git --version
~~~

`git` es el sistema de control de versiones que permite obtener y actualizar el código de los repositorios; `--version` consulta la versión instalada sin modificar archivos. Si Git ya responde con su versión, no es necesario reinstalarlo.

**Resultado verificado en esta VM:** `git version 2.43.0`.

### 19.2 — Crear el directorio de trabajo del proyecto

Ejecute:

~~~bash
mkdir -p "$HOME/alojamientos"
~~~

`mkdir` crea un directorio; `-p` evita un error si ya existe; `$HOME` corresponde al directorio personal del usuario conectado, que en este servidor es `/home/azureuser`. No se utiliza `sudo` porque el directorio pertenece a `azureuser`.

Compruebe su existencia y propietario:

~~~bash
ls -ld "$HOME/alojamientos"
~~~

`ls -ld` muestra los permisos y el propietario del directorio, no su contenido.

**Resultado verificado:** existe `/home/azureuser/alojamientos` y pertenece a `azureuser`.

### 19.3 — Restringir los permisos del directorio

El directorio alojará el código del proyecto. Aplique permisos que impidan el acceso ordinario de otras cuentas locales:

~~~bash
chmod 700 "$HOME/alojamientos"
ls -ld "$HOME/alojamientos"
~~~

`chmod` modifica los permisos. El valor `700` concede al propietario permiso de lectura, escritura y acceso al directorio, sin conceder acceso al grupo ni a otros usuarios. La cuenta administradora del sistema conserva sus facultades administrativas.

**Resultado verificado:** la salida comienza por `drwx------` y muestra como propietario y grupo a `azureuser`.

### 19.4 — Descargar el repositorio del Frontend mediante HTTPS

Ejecute:

~~~bash
git clone https://github.com/oflodororni/alojamientos-frontend.git "$HOME/alojamientos/frontend"
~~~

`git clone` obtiene los archivos del repositorio y su historial de versiones. La URL `https://github.com/oflodororni/alojamientos-frontend.git` identifica el origen público; la ruta final indica el destino local. Git crea automáticamente el directorio `frontend`, por lo que no se crea antes manualmente.

**Comprobación del proyecto:** la descarga concluyó con `Receiving objects: 100% (91/91)` y `Resolving deltas: 100% (14/14)`, sin errores.

### 19.5 — Comprobar los archivos del Frontend

Ejecute:

~~~bash
ls -la "$HOME/alojamientos/frontend"
~~~

`-l` muestra permisos, propietarios y tamaños; `-a` incluye archivos ocultos, como `.git`. El comando solamente consulta los archivos.

| Archivo o directorio comprobado | Función |
|---|---|
| `Dockerfile` | Instrucciones para construir la imagen Docker del Frontend. |
| `nginx.conf` | Configuración de Nginx incluida en el repositorio. |
| `package.json` y `package-lock.json` | Dependencias y referencias de versiones del proyecto JavaScript. |
| `index.html` | Documento HTML principal. |
| `src/` | Código fuente del Frontend. |
| `vite.config.js` | Configuración de Vite. |
| `.dockerignore` | Exclusiones del contexto de construcción de Docker. |
| `.git/` | Metadatos e historial de Git. |
| `docs/` | Documentación incluida en el repositorio. |

**Resultado verificado:** los archivos y directorios anteriores aparecen en `/home/azureuser/alojamientos/frontend`.

### 19.6 — Descargar y comprobar el repositorio del Backend

Ejecute:

~~~bash
git clone https://github.com/oflodororni/alojamientos-api.git "$HOME/alojamientos/backend"
~~~

Este comando descarga el repositorio público de la API mediante HTTPS y crea el directorio local `backend`. No instala Python ni MySQL, no modifica el repositorio remoto y no inicia contenedores.

Para verificar la estructura descargada, ejecute:

~~~bash
ls -la "$HOME/alojamientos/backend"
~~~

| Archivo o directorio comprobado | Función |
|---|---|
| `Dockerfile` | Instrucciones de construcción de la imagen del Backend. |
| `app/` y `app.py` | Código y punto de entrada de la aplicación Flask. |
| `requirements.txt` | Dependencias de Python necesarias para la aplicación. |
| `pyproject.toml` | Configuración del proyecto Python. |
| `migrations/` | Migraciones de la base de datos. |
| `scripts/` | Scripts auxiliares del proyecto. |
| `.dockerignore` | Exclusiones del contexto de construcción Docker. |
| `.git/` | Metadatos e historial de Git. |
| `README.md` y `docs/` | Documentación del Backend. |

**Resultado verificado:** el directorio `/home/azureuser/alojamientos/backend` contiene los archivos y carpetas previstos, incluidos `Dockerfile`, `app/`, `app.py`, `requirements.txt` y `migrations/`.

### 19.7 — Comprobar la rama y el estado de ambos repositorios

Ejecute, un comando por repositorio:

~~~bash
git -C "$HOME/alojamientos/frontend" status -sb
git -C "$HOME/alojamientos/backend" status -sb
~~~

`-C` indica el directorio en el que Git ejecuta la consulta; `status` muestra el estado de los archivos; `-s` abrevia la salida y `-b` incluye la rama actual. Estos comandos no alteran el contenido.

**Resultado verificado para ambos repositorios:**

~~~text
## main...origin/main
~~~

La salida indica que ambos están situados en la rama `main`, asociada a `origin/main`, y que Git no detecta modificaciones locales pendientes.

**Consideraciones de seguridad y operación:**

- Los repositorios se consultan y descargan mediante HTTPS. La descarga pública no necesita credenciales personales.
- No almacene contraseñas, secretos, claves privadas ni archivos de configuración con credenciales en el código ni en el repositorio público. Revise también su historial antes de publicar información sensible.
- La carpeta `alojamientos` está restringida a `azureuser`, aunque esto no reemplaza la protección de las credenciales de la aplicación.
- La descarga del código no abre los puertos HTTP, HTTPS, MySQL ni del Backend en el NSG de Azure. El despliegue de servicios y la configuración de red se realizarán en pasos posteriores.
- No ejecute `git pull` ni realice cambios al código sin comprobar primero el estado del repositorio y el impacto de una nueva versión.

**Resultado esperado del Paso 19:** Git está disponible, `/home/azureuser/alojamientos` existe con permisos `700`, los repositorios `frontend` y `backend` se descargaron desde GitHub mediante HTTPS y ambos muestran la rama `main` sin modificaciones locales. **Todas estas comprobaciones quedaron verificadas en el Sistema Alojamientos.**

---

## Paso 20 — Preparar, configurar y comprobar MySQL 8.4 con Docker

El Sistema Alojamientos utilizará **MySQL 8.4** como base de datos, ejecutado en un contenedor Docker. Su información se almacenará en un **volumen persistente** y se accederá a MySQL mediante la red interna de Docker Compose; **no publicaremos el puerto 3306 en Internet**.

Este paso documenta las comprobaciones realizadas en Ubuntu y la preparación de la base de datos. La ejecución de las migraciones de estructura mediante Flask-Migrate corresponde al siguiente capítulo del Backend. Las contraseñas se guardan localmente en un archivo `.env` restringido; **no se copian al manual, al chat ni a GitHub**.

### 20.1 — Comprobar el espacio libre del sistema

Ejecute en la sesión SSH de Ubuntu:

~~~bash
df -h /
~~~

`df` informa del espacio del sistema de archivos; `-h` presenta unidades legibles y `/` limita la consulta al sistema raíz. Esta consulta no modifica el disco. Al copiar comandos, no incluya el indicador de terminal `azureuser@vm-alojamientos-g01:~$`, porque es una indicación de la consola y no parte del comando.

**Resultado comprobado:** `/dev/root`, tamaño utilizable **30 GB**, usados **2,5 GB**, disponibles **28 GB**, ocupación **9 %**. Se dispone de espacio para comenzar el laboratorio, pero deberá revisarse periódicamente al almacenar imágenes, registros y datos.

### 20.2 — Identificar el directorio de datos de Docker

~~~bash
sudo docker info --format '{{.DockerRootDir}}'
~~~

`docker info` consulta la configuración del motor; `--format` muestra únicamente el campo `DockerRootDir`. Se utiliza `sudo` para consultar el daemon con permisos administrativos.

**Resultado comprobado:** `/var/lib/docker`. Docker administra este directorio: no deben editarse manualmente sus archivos internos.

### 20.3 — Crear el volumen persistente de MySQL

~~~bash
sudo docker volume create alojamientos_mysql_data
~~~

`docker volume create` crea un almacenamiento administrado por Docker. El volumen es independiente del sistema de archivos temporal del contenedor y permite conservar los datos cuando se recrea el contenedor **siempre que el volumen continúe existiendo**.

**Resultado comprobado:** `alojamientos_mysql_data`. La creación del volumen no instala MySQL ni crea un disco administrado adicional de Azure.

### 20.4 — Verificar las propiedades del volumen

~~~bash
sudo docker volume inspect alojamientos_mysql_data
~~~

`inspect` muestra las propiedades registradas por Docker sin modificarlas. Verifique los siguientes campos:

| Campo | Valor comprobado | Significado |
|---|---|---|
| `Name` | `alojamientos_mysql_data` | Identificador del volumen. |
| `Driver` | `local` | Almacenamiento administrado localmente por Docker. |
| `Mountpoint` | `/var/lib/docker/volumes/alojamientos_mysql_data/_data` | Ubicación física administrada por Docker. |
| `Scope` | `local` | El volumen pertenece a esta VM. |

**Resultado comprobado:** las propiedades coinciden. **Persistencia no significa respaldo**: la pérdida del disco o la eliminación del volumen puede ocasionar pérdida de datos.

### 20.5 — Localizar la configuración de la base de datos del Backend

Antes de configurar MySQL, identificaremos qué espera el código del Backend, sin inventar nombres de variables:

~~~bash
grep -RIlE 'SQLALCHEMY_DATABASE_URI|DATABASE_URL|MYSQL_|DB_HOST|DB_NAME|DB_USER|DB_PASSWORD' "$HOME/alojamientos/backend/app" "$HOME/alojamientos/backend/app.py"
~~~

`grep` busca texto; `-R` recorre subdirectorios, `-I` omite binarios, `-l` muestra **solo las rutas** de archivos coincidentes y `-E` permite buscar varios patrones. No muestra valores de contraseñas.

**Resultado comprobado:** `/home/azureuser/alojamientos/backend/app/config.py`.

### 20.6 — Identificar las variables de conexión

~~~bash
grep -nE 'getenv|environ|SQLALCHEMY_DATABASE_URI|MYSQL_|DB_|DATABASE_URL' "$HOME/alojamientos/backend/app/config.py"
~~~

`-n` agrega el número de línea. En la salida se identificaron las siguientes variables de entorno:

| Variable | Valor predeterminado en el código | Función |
|---|---|---|
| `DB_USER` | Vacío | Usuario de conexión. |
| `DB_PASSWORD` | Vacío | Contraseña de conexión. |
| `DB_HOST` | `localhost` | Servidor MySQL. |
| `DB_PORT` | `3306` | Puerto de MySQL. |
| `DB_NAME` | `alojamientos_db` | Base de datos de la aplicación. |
| `SECRET_KEY` | Sin valor predeterminado mostrado | Clave secreta requerida por Flask. |

El Backend también consulta `JWT_EXP_MINUTES` y `CORS_ALLOWED_ORIGINS`. En Docker, `localhost` dentro del Backend **no identifica al contenedor MySQL**; configuraremos `DB_HOST=mysql` para utilizar la resolución de nombres de la red de Compose.

### 20.7 — Revisar la cadena de conexión y las validaciones

~~~bash
sed -n '23,47p' "$HOME/alojamientos/backend/app/config.py"
~~~

`sed -n '23,47p'` muestra exclusivamente ese intervalo de líneas; no modifica el archivo. El código construye la URL de SQLAlchemy mediante:

~~~python
SQLALCHEMY_DATABASE_URI = (
    f"mysql+pymysql://{_db_user}:{_db_password}@{_db_host}:{_db_port}/{_db_name}"
)
~~~

La aplicación utiliza **MySQL con PyMySQL**. Fuera del modo de pruebas, valida que estén definidos `DB_USER`, `DB_NAME` y `SECRET_KEY`. También configuraremos `DB_PASSWORD` aunque su ausencia no esté validada expresamente en el fragmento revisado. Como la URL se construye mediante texto, las credenciales generadas posteriormente utilizarán caracteres hexadecimales para evitar problemas con delimitadores especiales de URL.

**Resultado comprobado:** se conoce la forma de construir la conexión; todavía no se ha probado la conexión desde Flask.

### 20.8 — Verificar las dependencias de MySQL en Python

~~~bash
grep -nEi 'pymysql|sqlalchemy|flask-migrate|mysqlclient' "$HOME/alojamientos/backend/requirements.txt"
~~~

`-i` ignora diferencias de mayúsculas/minúsculas. Se verificaron las siguientes dependencias declaradas en el repositorio:

| Dependencia | Versión declarada | Finalidad |
|---|---|---|
| Flask-SQLAlchemy | `3.1.1` | Integración con Flask. |
| Flask-Migrate | `4.1.0` | Gestión de migraciones. |
| PyMySQL | `1.1.2` | Conexión con MySQL. |
| SQLAlchemy | `2.0.49` | Acceso a datos y modelos. |

Estas dependencias se instalarán en la imagen del Backend; no es necesario instalarlas directamente en el Ubuntu anfitrión.

### 20.9 — Buscar configuraciones existentes de Compose y ejemplos de entorno

~~~bash
find "$HOME/alojamientos" -maxdepth 3 -type f \( -name 'compose.yaml' -o -name 'compose.yml' -o -name 'docker-compose.yml' -o -name 'docker-compose.yaml' -o -name '.env.example' -o -name 'env.example' \) -print
~~~

`find` busca archivos (`-type f`) hasta tres niveles (`-maxdepth 3`), con cualquiera de los nombres indicados. Es una búsqueda de solo lectura.

**Resultado comprobado:** no se obtuvieron coincidencias dentro de la profundidad consultada. Se creará un archivo de Compose para el despliegue en esta VM.

### 20.10 — Crear y proteger el archivo privado `.env`

~~~bash
touch "$HOME/alojamientos/.env"
chmod 600 "$HOME/alojamientos/.env"
ls -l "$HOME/alojamientos/.env"
~~~

`touch` crea el archivo si no existe; `chmod 600` concede lectura y escritura únicamente al propietario, y `ls -l` permite comprobarlo. En esta etapa el archivo aún no tiene credenciales.

**Resultado comprobado:** `/home/azureuser/alojamientos/.env`, propietario `azureuser`, permisos `-rw-------` y tamaño inicial **0 bytes**.

### 20.11 — Generar las credenciales de MySQL y la clave de Flask

Ejecute el siguiente programa **una sola vez, con el archivo `.env` vacío**:

~~~bash
python3 - <<'PY'
from pathlib import Path
from secrets import token_hex

archivo = Path.home() / "alojamientos" / ".env"

if not archivo.is_file() or archivo.stat().st_size != 0:
    raise SystemExit("No se modifica .env: falta el archivo o ya contiene datos.")

variables = {
    "MYSQL_ROOT_PASSWORD": token_hex(24),
    "MYSQL_DATABASE": "alojamientos_db",
    "MYSQL_USER": "alojamientos_app",
    "MYSQL_PASSWORD": token_hex(24),
    "SECRET_KEY": token_hex(32),
}

with archivo.open("w", encoding="utf-8") as destino:
    for nombre, valor in variables.items():
        destino.write(f"{nombre}={valor}\n")

archivo.chmod(0o600)
print("Credenciales generadas y almacenadas correctamente.")
PY
~~~

`secrets.token_hex()` genera valores aleatorios criptográficamente seguros. El script establece contraseñas distintas para el administrador `root` y el usuario de aplicación `alojamientos_app`, además de `SECRET_KEY`; utiliza caracteres hexadecimales para compatibilidad con la URL de PyMySQL. La condición inicial evita sobrescribir por accidente un `.env` que ya tenga contenido. El resultado **no imprime secretos**.

**Resultado comprobado:** `Credenciales generadas y almacenadas correctamente.` No vuelva a ejecutar este paso sobre una base inicializada: cambiar las variables del archivo no cambia automáticamente las credenciales ya persistidas en MySQL.

### 20.12 — Mostrar únicamente los nombres de las variables

~~~bash
cut -d= -f1 "$HOME/alojamientos/.env"
~~~

`cut` separa cada línea utilizando `=` (`-d=`) y muestra únicamente el primer campo (`-f1`), evitando imprimir valores. Se verificaron estos nombres:

~~~text
MYSQL_ROOT_PASSWORD
MYSQL_DATABASE
MYSQL_USER
MYSQL_PASSWORD
SECRET_KEY
~~~

### 20.13 — Validar valores no vacíos y permisos sin revelar secretos

~~~bash
python3 - <<'PY'
from pathlib import Path
from stat import S_IMODE

archivo = Path.home() / "alojamientos" / ".env"
variables = {}
for linea in archivo.read_text().splitlines():
    if "=" in linea:
        nombre, valor = linea.split("=", 1)
        variables[nombre] = valor

requeridas = [
    "MYSQL_ROOT_PASSWORD", "MYSQL_DATABASE", "MYSQL_USER",
    "MYSQL_PASSWORD", "SECRET_KEY",
]
for nombre in requeridas:
    estado = "CORRECTO" if variables.get(nombre) else "FALTA O ESTA VACIA"
    print(f"{nombre}: {estado}")
permisos = S_IMODE(archivo.stat().st_mode)
print(f"Permisos: {oct(permisos)}")
print("Protección: CORRECTA" if permisos == 0o600 else "REVISAR PERMISOS")
PY
~~~

El script revisa que cada valor exista, sin mostrarlo; comprueba además los permisos `600`. **Resultado comprobado:** cinco variables con estado `CORRECTO`, `Permisos: 0o600` y `Protección: CORRECTA`. No publique el contenido del archivo `.env` ni lo añada a repositorios.

### 20.14 — Crear la configuración inicial de MySQL en Compose

En esta etapa el archivo describe **solamente MySQL**. Ejecute:

~~~bash
cat > "$HOME/alojamientos/compose.yaml" <<'EOF'
services:
  mysql:
    image: mysql:8.4
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    volumes:
      - alojamientos_mysql_data:/var/lib/mysql

volumes:
  alojamientos_mysql_data:
    external: true
EOF
~~~

`cat > archivo <<'EOF'` escribe un bloque literal en el archivo indicado. **Atención:** el operador `>` reemplaza el contenido previo del archivo; empléelo en esta etapa inicial y no sobre una configuración posterior sin respaldo. Los marcadores `${...}` permiten que Docker Compose utilice las variables del archivo privado.

| Opción | Motivo |
|---|---|
| `mysql:8.4` | Utiliza la serie 8.4 de MySQL prevista para el laboratorio. |
| `restart: unless-stopped` | Permite el reinicio del contenedor según la política de Docker, excepto cuando se ha detenido expresamente. |
| `environment` | Entrega a MySQL las variables de inicialización. |
| `alojamientos_mysql_data:/var/lib/mysql` | Monta el volumen persistente en el directorio de datos de MySQL. |
| `external: true` | Reutiliza el volumen creado anteriormente. |

**No se incluye `ports`**, por lo que no se publica MySQL en las interfaces de red de la VM. Compruebe la existencia con `ls -l "$HOME/alojamientos/compose.yaml"`.

**Resultado comprobado:** archivo de **363 bytes**, propiedad de `azureuser`.

### 20.15 — Validar el Compose inicial sin imprimir las contraseñas

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" config --quiet && echo "Configuración Docker Compose válida"
~~~

`--env-file` selecciona las variables privadas; `-f` selecciona el Compose; `config --quiet` valida la configuración sin imprimirla ya expandida con secretos; `&& echo` muestra un mensaje únicamente cuando la validación termina sin errores. No crea contenedores ni instala MySQL.

**Resultado comprobado:** `Configuración Docker Compose válida`.

### 20.16 — Descargar la imagen MySQL 8.4

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" pull mysql
~~~

`pull mysql` descarga la imagen del servicio `mysql` desde el registro de imágenes, sin iniciarla. Utiliza almacenamiento e Internet de la VM.

**Resultado comprobado:** `[+] pull 13/13` y `Image mysql:8.4 Pulled`.

### 20.17 — Verificar la imagen almacenada

~~~bash
sudo docker image ls mysql:8.4
~~~

`docker image ls` muestra la imagen local y sus tamaños, sin modificarla. **Resultado comprobado:** imagen `mysql:8.4`, ID abreviado `a81d043930e5`, `DISK USAGE` **1,12 GB** y `CONTENT SIZE` **254 MB**. Las medidas son conceptos diferentes y **no deben sumarse**.

### 20.18 — Iniciar MySQL con Docker Compose

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" up -d mysql
~~~

`up` crea e inicia el servicio indicado; `-d` lo deja en segundo plano. Al iniciar el servidor por primera vez con un volumen vacío, la imagen de MySQL inicializa la base de datos y el usuario de aplicación con los valores establecidos. El comando no publica puertos adicionales.

**Resultado comprobado:** red `alojamientos_default` creada y contenedor `alojamientos-mysql-1` iniciado. El estado `Started` no sustituye una prueba de conexión a MySQL.

### 20.19 — Comprobar el estado y la publicación de puertos

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" ps
~~~

`ps` muestra los contenedores, su estado y los puertos; no modifica los servicios.

**Resultado comprobado:** `alojamientos-mysql-1`, imagen `mysql:8.4`, estado `Up 34 seconds`, puertos `3306/tcp, 33060/tcp`. Estas anotaciones indican puertos del contenedor; **no aparece** una publicación del tipo `0.0.0.0:3306->3306/tcp`. No es necesario abrir el puerto 3306 en el NSG de Azure.

### 20.20 — Comprobar la autenticación y la base de datos

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" exec -T mysql sh -c 'MYSQL_PWD="$MYSQL_PASSWORD" mysql --user="$MYSQL_USER" --database="$MYSQL_DATABASE" --batch --skip-column-names --execute="SELECT DATABASE(), 1;"'
~~~

`exec -T mysql` ejecuta el cliente dentro del contenedor sin terminal interactiva. `MYSQL_PWD` suministra al cliente la contraseña que ya está en el entorno del contenedor; no escribe su valor literal en el comando. `SELECT DATABASE(), 1;` comprueba el nombre de la base seleccionada y que una consulta responde.

**Resultado comprobado:** `alojamientos_db    1`. El usuario de la aplicación se autenticó y accedió a la base de datos. Esta consulta no crea tablas ni registros.

### 20.21 — Comprobar el volumen conectado al contenedor

~~~bash
sudo docker inspect alojamientos-mysql-1 --format '{{range .Mounts}}{{.Name}} -> {{.Destination}} ({{.Type}}){{println}}{{end}}'
~~~

`docker inspect` consulta los montajes efectivos (`.Mounts`) del contenedor e informa nombre, destino y tipo. **Resultado comprobado:**

~~~text
alojamientos_mysql_data -> /var/lib/mysql (volume)
~~~

Esto confirma que los datos se dirigen al volumen persistente. Todavía no se ha comprobado una restauración ni se ha configurado un respaldo independiente.

### 20.22 — Identificar los archivos de migraciones del Backend

Para preparar la estructura de las tablas de MySQL, se consultaron los scripts incluidos en el repositorio del Backend, **sin ejecutarlos**:

~~~bash
find "$HOME/alojamientos/backend/migrations" -maxdepth 2 -type f -name '*.py' -print
~~~

`find` limita la búsqueda a dos niveles y a archivos Python. Se encontraron:

| Archivo | Propósito indicado por su nombre |
|---|---|
| `migrations/env.py` | Entorno de ejecución de Alembic. |
| `versions/fc96811ac078_crear_tablas_usuarios_y_perfiles.py` | Tablas de usuarios y perfiles. |
| `versions/65db71a03565_crear_tabla_alojamientos.py` | Tabla de alojamientos. |
| `versions/ebb9cbe49179_crear_tabla_comodidades_y_relacion_con_.py` | Tabla de comodidades y sus relaciones. |

La función de estos archivos se infiere de sus nombres; el orden se comprueba mediante sus declaraciones de dependencia en el apartado siguiente.

### 20.23 — Identificar las dependencias y el orden de migraciones

~~~bash
grep -HnE '^(revision|down_revision)' "$HOME/alojamientos/backend/migrations/versions/"*.py
~~~

`grep -HnE` muestra nombre del archivo, número de línea y declaraciones `revision`/`down_revision`. Alembic utiliza esos identificadores para establecer el orden, no el nombre alfabético de los archivos.

| Orden | `revision` | `down_revision` | Propósito |
|---|---|---|---|
| 1 | `fc96811ac078` | `None` | Usuarios y perfiles. |
| 2 | `65db71a03565` | `fc96811ac078` | Alojamientos. |
| 3 | `ebb9cbe49179` | `65db71a03565` | Comodidades y relaciones. |

**Resultado comprobado:** existe una secuencia lineal de tres migraciones. La ejecución mediante Flask-Migrate se continuará en el capítulo del Backend.

### 20.24 — Comprobar si MySQL ya contiene tablas

Antes de aplicar migraciones, se consultó el número de tablas de `alojamientos_db`:

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" exec -T mysql sh -c 'MYSQL_PWD="$MYSQL_PASSWORD" mysql --user="$MYSQL_USER" --database="$MYSQL_DATABASE" --batch --skip-column-names --execute="SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE();"'
~~~

`information_schema.tables` contiene los metadatos de las tablas; `COUNT(*)` cuenta las pertenecientes a la base de datos seleccionada. Esta consulta no crea ni cambia tablas.

**Resultado comprobado:** `0` tablas. **En este punto** MySQL estaba inicializado, su usuario podía conectarse, el volumen estaba montado y ninguna migración de la aplicación había creado tablas.

**Resultado esperado del Paso 20:** MySQL 8.4 funciona dentro de Docker, con usuario de aplicación autenticado, base `alojamientos_db` accesible, puertos sin publicación externa y volumen `alojamientos_mysql_data` efectivamente montado. Se verificó que la base estaba vacía antes de aplicar migraciones. **Estos resultados quedaron comprobados**. La ejecución de migraciones y el despliegue de Flask continúan en el Paso 21.

**Seguridad y costos:** proteja el `.env` (modo `600`), no incluya contraseñas en el manual ni en GitHub, mantenga el puerto `3306` fuera de las reglas públicas del NSG y supervise disco e imágenes. La persistencia del volumen no sustituye una estrategia de copia de seguridad. La VM y otros recursos de Azure pueden seguir causando cargos según sus estados y modelos de facturación.

---

## Paso 21 — Construir y comprobar el Backend Flask/Gunicorn con Docker

En este paso añadiremos el servicio Backend al archivo Docker Compose utilizado por MySQL, construiremos su imagen, iniciaremos Flask mediante Gunicorn y verificaremos la respuesta HTTP interna. **No publicaremos directamente el puerto 5000**, no modificaremos los repositorios remotos y aplicaremos las migraciones de MySQL en el apartado 21.14, después de comprobar el Backend y el estado inicial de la base de datos. Se reutilizarán las credenciales creadas y comprobadas en el Paso 20.

### 21.1 — Revisar el Dockerfile del Backend

~~~bash
cat "$HOME/alojamientos/backend/Dockerfile"
~~~

`cat` muestra las instrucciones de construcción de la imagen, sin ejecutarlas. El archivo verificado contiene:

~~~dockerfile
FROM python:3.11-slim
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir gunicorn==26.2.0 'PyMySQL[rsa]==1.1.2'
COPY . .
EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "--access-logfile", "-", "app:crear_app()"]
~~~

| Instrucción | Función |
|---|---|
| `FROM python:3.11-slim` | Define la imagen base de Python. |
| `ENV` | Evita archivos `.pyc` y facilita los registros inmediatos en consola. |
| `WORKDIR /app` | Define el directorio de trabajo dentro del contenedor. |
| `COPY requirements.txt` y `RUN pip install` | Incorporan e instalan las dependencias, Gunicorn y soporte de PyMySQL. |
| `COPY . .` | Incorpora el código del Backend a la imagen. |
| `EXPOSE 5000` | Documenta el puerto del servicio; no lo publica en Azure. |
| `CMD` | Inicia dos trabajadores Gunicorn que cargan la factoría `crear_app()`. |

**Resultado comprobado:** el Dockerfile define Python 3.11 y Gunicorn 26.2.0, con el puerto interno 5000. No hace falta instalar estas dependencias en el sistema operativo anfitrión.

### 21.2 — Revisar el punto de entrada `app.py`

~~~bash
cat "$HOME/alojamientos/backend/app.py"
~~~

El contenido observado fue:

~~~python
from app import crear_app

# Creamos la aplicacion
app = crear_app()

if __name__ == "__main__":
    # Modo debug para reinicio automatico al guardar cambios
    app.run(debug=True, port=5000)
~~~

La condición `if __name__ == "__main__"` ejecuta el servidor de desarrollo solamente al iniciar el archivo directamente. En el contenedor, Docker utiliza Gunicorn conforme al `CMD` del Dockerfile; **no se inicia el servidor de desarrollo con `debug=True`**.

### 21.3 — Localizar la factoría de aplicación `crear_app()`

~~~bash
grep -nE '^def crear_app\(' "$HOME/alojamientos/backend/app/__init__.py"
~~~

`grep -nE` busca la definición y muestra su número de línea. **Resultado comprobado:** `18:def crear_app():`. La función invocada por Gunicorn existe en el paquete `app`; su inicialización se examina en el apartado siguiente.

### 21.4 — Revisar la inicialización de Flask y las rutas

~~~bash
sed -n '1,110p' "$HOME/alojamientos/backend/app/__init__.py"
~~~

Este comando muestra las primeras 110 líneas del archivo, sin modificarlas. Se observó que `crear_app()`:

1. Crea `Flask(__name__)` y carga la clase `Config`.
2. Inicializa SQLAlchemy mediante `db.init_app(app)` y Flask-Migrate mediante `migrate.init_app(app, db)`.
3. Configura CORS con `CORS_ALLOWED_ORIGINS`.
4. Registra el endpoint `/health`, que devuelve información del servicio y la versión `v1`.
5. Registra las rutas `/api/v1/usuarios`, `/api/v1/admin`, `/api/v1/alojamientos` y `/api/v1/comodidades`, además de manejadores de errores.

**Observación:** `/health` verifica que Flask atiende solicitudes HTTP, pero no equivale a comprobar las consultas de negocio o la conexión efectiva con MySQL. Ambas cosas se verifican por separado. El resto del archivo no se modificó.

### 21.5 — Incorporar el servicio Backend a Docker Compose

Primero respalde el archivo válido que hasta este momento contiene únicamente MySQL:

~~~bash
cp "$HOME/alojamientos/compose.yaml" "$HOME/alojamientos/compose.yaml.bak"
~~~

`cp` conserva una copia para recuperación. Luego sustituya la configuración por la siguiente, que **mantiene MySQL y agrega Backend**:

~~~bash
cat > "$HOME/alojamientos/compose.yaml" <<'EOF'
services:
  mysql:
    image: mysql:8.4
    restart: unless-stopped
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    volumes:
      - alojamientos_mysql_data:/var/lib/mysql

  backend:
    build:
      context: ./backend
    restart: unless-stopped
    environment:
      DB_HOST: mysql
      DB_PORT: "3306"
      DB_NAME: ${MYSQL_DATABASE}
      DB_USER: ${MYSQL_USER}
      DB_PASSWORD: ${MYSQL_PASSWORD}
      SECRET_KEY: ${SECRET_KEY}
    depends_on:
      - mysql
    expose:
      - "5000"

volumes:
  alojamientos_mysql_data:
    external: true
EOF
~~~

`build.context: ./backend` indica dónde está el Dockerfile. Las variables `DB_*` se asignan a los valores correctos del `.env`; `DB_HOST=mysql` permite localizar el servidor por el nombre de servicio en la red interna. `depends_on` establece dependencia de inicio, **pero no garantiza por sí solo que MySQL esté listo para aceptar conexiones**. `expose: "5000"` documenta el puerto interno; no es una publicación en la VM. No se utiliza `ports` para MySQL ni para Backend.

Valide la configuración sin imprimir el contenido expandido con secretos:

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" config --quiet && echo "Configuración de MySQL y Backend válida"
~~~

**Resultado comprobado:** `Configuración de MySQL y Backend válida`. La validación comprueba la estructura del Compose, no el comportamiento de los servicios.

### 21.6 — Construir la imagen Docker del Backend

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" build backend
~~~

`build backend` procesa únicamente el Dockerfile del Backend: prepara Python, instala dependencias y copia el código. **No inicia el contenedor ni ejecuta migraciones**. En una VM de 4 GiB de RAM conviene evitar compilaciones paralelas innecesarias.

**Resultado comprobado:** `Image alojamientos-backend Built`.

### 21.7 — Verificar la imagen construida

~~~bash
sudo docker image ls alojamientos-backend
~~~

La consulta lista la imagen local sin modificarla. **Resultado comprobado:** `alojamientos-backend:latest`, ID abreviado `cee20252a3c3`, uso de disco **283 MB**, tamaño de contenido **66,3 MB**. Estas medidas representan conceptos distintos y no deben sumarse.

### 21.8 — Iniciar el servicio Backend

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" up -d --no-build backend
~~~

`up -d` crea/inicia el servicio en segundo plano; `--no-build` reutiliza la imagen ya construida. Compose también comprueba la dependencia de MySQL. No se publican los puertos 5000 ni 3306.

**Resultado comprobado:** `alojamientos-mysql-1 Running` y `alojamientos-backend-1 Started`. El mensaje `Started` no demuestra por sí solo que Flask esté respondiendo: se continúa con verificaciones.

### 21.9 — Comprobar el estado y los puertos de ambos contenedores

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" ps
~~~

`ps` consulta los estados y puertos sin reiniciar servicios. Se observaron:

| Servicio | Estado observado | Puertos mostrados |
|---|---|---|
| `alojamientos-backend-1` | `Up 30 seconds` | `5000/tcp` |
| `alojamientos-mysql-1` | `Up 13 minutes` | `3306/tcp, 33060/tcp` |

Los puertos aparecen **sin asignaciones de host** (por ejemplo, no aparece `0.0.0.0:5000->5000/tcp`). En esta configuración, el tráfico previsto entre servicios utiliza la red interna de Docker. La publicación HTTP/HTTPS mediante Nginx se abordará posteriormente.

### 21.10 — Revisar los registros del Backend

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" logs --tail 50 backend
~~~

`logs` consulta la salida del servicio; `--tail 50` limita la vista a las últimas 50 líneas. El comando no reinicia ni modifica el servicio. En una ejecución correcta deben aparecer los mensajes de inicio de Gunicorn, escucha en `0.0.0.0:5000`, trabajador `sync` y dos trabajadores iniciados. Como referencia, en el laboratorio se obtuvo **Gunicorn 26.2.0** con PID **7** y **8** (los PID pueden variar). Compruebe que no haya errores de importación ni fallos de arranque.

### 21.11 — Probar el endpoint HTTP de salud desde el contenedor

Como el Backend no tiene un puerto externo publicado, consultaremos `/health` desde el mismo contenedor:

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" exec -T backend python -c 'import urllib.request; respuesta = urllib.request.urlopen("http://127.0.0.1:5000/health", timeout=10); print("HTTP:", respuesta.status); print("Respuesta:", respuesta.read().decode())'
~~~

`exec -T backend` ejecuta un proceso dentro del contenedor; `python -c` utiliza `urllib.request` para enviar una petición HTTP al puerto **local del contenedor**, con tiempo límite de 10 segundos. El comando no crea archivos ni modifica la base de datos.

**Resultado comprobado:**

~~~text
HTTP: 200
Respuesta: {"service":"alojamientos-api","status":"ok","version":"v1"}
~~~

Esto prueba que Gunicorn y Flask responden satisfactoriamente al endpoint de salud. **No valida todavía las tablas de negocio ni los endpoints que usan MySQL**.

### 21.12 — Comprobar que Flask-Migrate reconoce la última migración

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" exec -T backend flask --app 'app:crear_app()' db heads
~~~

`flask --app 'app:crear_app()'` carga la aplicación mediante su factoría; `db heads` consulta la revisión o revisiones finales disponibles en los scripts de Alembic. **No ejecuta `db upgrade` ni aplica migraciones**.

**Resultado comprobado:**

~~~text
ebb9cbe49179 (head)
~~~

Este resultado coincide con el orden de los tres scripts identificado en el Paso 20. **`head` significa última migración disponible en el código; no significa que ya esté aplicada en MySQL.**

Continúe con la consulta de la revisión aplicada en MySQL antes de ejecutar las migraciones.

### 21.13 — Consultar la versión de migración aplicada actualmente

Antes de modificar la estructura de la base de datos, consulte qué revisión tiene registrada MySQL:

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" exec -T backend flask --app 'app:crear_app()' db current
~~~

- `exec -T backend` ejecuta el comando dentro del contenedor del Backend, sin abrir una terminal interactiva.
- `flask --app 'app:crear_app()'` carga la aplicación usando su factoría de Flask.
- `db current` pregunta a Alembic qué revisión figura aplicada en la base de datos, a diferencia de `db heads`, que consulta la última disponible en los archivos del código.

La instrucción no ejecuta las migraciones pendientes ni crea tablas de negocio; según el estado de Alembic, puede inicializar elementos técnicos de seguimiento.

**Resultado comprobado antes de aplicar migraciones:**

~~~text
INFO  [alembic.runtime.migration] Context impl MySQLImpl.
INFO  [alembic.runtime.migration] Will assume non-transactional DDL.
~~~

No se mostró ningún identificador de revisión. Esto era coherente con la base `alojamientos_db` inicialmente vacía que se había comprobado en el Paso 20. `MySQLImpl` confirma que Alembic utiliza el dialecto de MySQL; el aviso de `non-transactional DDL` indica que ciertos cambios de estructura no pueden revertirse automáticamente como una sola transacción. **No interprete esos mensajes informativos como errores.**

### 21.14 — Aplicar las migraciones de la base de datos

Con la base de datos de este laboratorio inicialmente vacía y la cadena de scripts revisada, ejecute:

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" exec -T backend flask --app 'app:crear_app()' db upgrade
~~~

`db upgrade` **sí modifica MySQL**: aplica las migraciones pendientes por orden hasta la revisión final (`head`). No requiere introducir la contraseña en el comando porque la configuración de SQLAlchemy ya la recibe mediante las variables de entorno del contenedor Backend. En un entorno con información real, revise primero el respaldo de la base de datos, el contenido de las migraciones y la ventana de mantenimiento. Dado que MySQL puede realizar DDL no transaccional, si ocurre un error **no repita a ciegas el comando**: examine las tablas y la revisión aplicada antes de reintentar.

**Resultado comprobado:**

~~~text
INFO  [alembic.runtime.migration] Context impl MySQLImpl.
INFO  [alembic.runtime.migration] Will assume non-transactional DDL.
INFO  [alembic.runtime.migration] Running upgrade  -> fc96811ac078, crear tablas usuarios y perfiles
INFO  [alembic.runtime.migration] Running upgrade fc96811ac078 -> 65db71a03565, crear tabla alojamientos
INFO  [alembic.runtime.migration] Running upgrade 65db71a03565 -> ebb9cbe49179, crear tabla comodidades y relacion con alojamientos
~~~

En una ejecución satisfactoria, las tres revisiones se aplican en el orden indicado, sin errores. La verificación del estado final y de las tablas se realiza en los apartados siguientes.

### 21.15 — Confirmar la revisión aplicada después de la actualización

Consulte nuevamente la revisión actual:

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" exec -T backend flask --app 'app:crear_app()' db current
~~~

`current` solo consulta el registro de migraciones, sin volver a aplicar `upgrade`.

**Resultado comprobado:**

~~~text
INFO  [alembic.runtime.migration] Context impl MySQLImpl.
INFO  [alembic.runtime.migration] Will assume non-transactional DDL.
ebb9cbe49179 (head)
~~~

El identificador `ebb9cbe49179` coincide con el `head` disponible. **En esta cadena de migraciones no quedan revisiones pendientes por aplicar.**

### 21.16 — Comprobar directamente las tablas creadas en MySQL

Desde el contenedor MySQL, consulte el catálogo de tablas del esquema configurado:

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" exec -T mysql sh -c 'MYSQL_PWD="$MYSQL_PASSWORD" mysql --user="$MYSQL_USER" --database="$MYSQL_DATABASE" --batch --execute="SHOW TABLES;"'
~~~

- `exec -T mysql` ejecuta la consulta en el contenedor de la base de datos.
- `sh -c` interpreta la instrucción dentro del contenedor; las variables de credenciales se expanden allí, evitando escribir su valor en la terminal.
- `MYSQL_PWD` proporciona la contraseña al cliente MySQL a través del entorno del proceso; no se imprime su contenido. Este método es apropiado para esta comprobación de laboratorio, pero las variables de entorno no sustituyen una gestión de secretos más estricta en producción.
- `--user` y `--database` eligen el usuario de aplicación y `alojamientos_db`.
- `--batch --execute="SHOW TABLES;"` presenta la lista de tablas sin introducir ni modificar registros.

**Resultado comprobado:**

~~~text
Tables_in_alojamientos_db
alembic_version
alojamiento_comodidad
alojamientos
comodidades
perfiles
usuarios
~~~

| Tabla | Función principal |
|---|---|
| `usuarios` | Datos de usuarios. |
| `perfiles` | Perfiles asociados al sistema. |
| `alojamientos` | Alojamientos registrados. |
| `comodidades` | Catálogo de comodidades. |
| `alojamiento_comodidad` | Relación entre alojamientos y comodidades. |
| `alembic_version` | Registro técnico de la revisión de migración aplicada. |

**Se verificaron seis tablas.** Esta consulta comprueba su existencia, no cada columna, índice o clave foránea.

### 21.17 — Probar la consulta a MySQL desde Flask y SQLAlchemy

Una vez verificado el esquema, comprobaremos que el propio Backend puede consultar la tabla `usuarios` mediante su integración SQLAlchemy:

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" exec -T backend python -c 'from app import crear_app; from sqlalchemy import text; app=crear_app(); app.app_context().push(); db=app.extensions["sqlalchemy"]; total=db.session.execute(text("SELECT COUNT(*) FROM usuarios")).scalar(); print("Conexión Backend-MySQL: correcta"); print("Registros en usuarios:", total)'
~~~

La factoría `crear_app()` carga la configuración de Flask; el contexto de aplicación permite utilizar la sesión de SQLAlchemy; `SELECT COUNT(*) FROM usuarios` cuenta los registros de una tabla existente. **La consulta es de solo lectura** y no crea usuarios ni publica el puerto de MySQL.

**Resultado comprobado:**

~~~text
Conexión Backend-MySQL: correcta
Registros en usuarios: 0
~~~

La aplicación ejecutó una consulta SQL correctamente utilizando la conexión configurada hacia MySQL. El número **0** significa que no había usuarios registrados en ese momento; no es un error.

### 21.18 — Consultar las rutas HTTP registradas por Flask

Liste las rutas y los métodos que la aplicación tiene registrados:

~~~bash
sudo docker compose --env-file "$HOME/alojamientos/.env" -f "$HOME/alojamientos/compose.yaml" exec -T backend flask --app 'app:crear_app()' routes
~~~

`flask routes` consulta el mapa de URLs de la aplicación. **No ejecuta peticiones a los endpoints** ni modifica MySQL; por tanto, la existencia de una ruta no equivale a una prueba funcional de sus permisos, validaciones o respuestas.

**Resultado comprobado (16 rutas):**

| Endpoint | Método | Ruta |
|---|---|---|
| `admin.listar_usuarios` | GET | `/api/v1/admin/usuarios` |
| `alojamientos.actualizar_alojamiento` | PATCH | `/api/v1/alojamientos/<int:alojamiento_id>` |
| `alojamientos.asignar_comodidades` | PATCH | `/api/v1/alojamientos/<int:alojamiento_id>/comodidades` |
| `alojamientos.crear_alojamiento` | POST | `/api/v1/alojamientos` |
| `alojamientos.eliminar_alojamiento` | DELETE | `/api/v1/alojamientos/<int:alojamiento_id>` |
| `alojamientos.listar_alojamientos` | GET | `/api/v1/alojamientos` |
| `alojamientos.obtener_detalle` | GET | `/api/v1/alojamientos/<int:alojamiento_id>` |
| `comodidades.crear_comodidad` | POST | `/api/v1/comodidades` |
| `comodidades.listar_comodidades` | GET | `/api/v1/comodidades` |
| `comodidades.obtener_detalle` | GET | `/api/v1/comodidades/<int:comodidad_id>` |
| `health` | GET | `/health` |
| `static` | GET | `/static/<path:filename>` |
| `usuarios.actualizar_perfil` | PATCH | `/api/v1/usuarios/perfil` |
| `usuarios.login` | POST | `/api/v1/usuarios/login` |
| `usuarios.obtener_perfil` | GET | `/api/v1/usuarios/perfil` |
| `usuarios.registro` | POST | `/api/v1/usuarios/registro` |

La aplicación reconoce operaciones de administración, usuarios, alojamientos, comodidades y salud. La ruta `static` es la ruta interna de Flask para archivos estáticos. **No se ha verificado todavía mediante peticiones HTTP el funcionamiento de todas las operaciones de negocio.**

**Resultado final del Paso 21:** Backend construido e iniciado en Docker, Gunicorn en funcionamiento, `/health` con HTTP 200, MySQL accesible por SQLAlchemy, tres migraciones aplicadas y registradas hasta `ebb9cbe49179 (head)`, seis tablas creadas y dieciséis rutas HTTP registradas. **Quedan pendientes** la publicación segura de la API mediante Nginx/HTTPS, las pruebas funcionales de los endpoints de negocio y la integración del Frontend.

---

## Paso 22 — Implementar el Frontend con Docker y Nginx

Prepararemos el Frontend utilizando el repositorio ya descargado en Ubuntu. Antes de construir la imagen, revisaremos la configuración real de Nginx, el Dockerfile y la dirección de la API utilizada durante la compilación. Conservaremos los servicios MySQL y Backend, el volumen persistente y las credenciales existentes. No publicaremos directamente los puertos de MySQL ni del Backend.

### 22.1 — Conectarse a la máquina virtual

Compruebe que la VM esté en ejecución. Desde Git Bash en Windows, utilice la clave privada y la dirección de la VM indicadas en el Paso 17:

```sh
ssh -i "$HOME/Downloads/vm-alojamientos-g01_key.pem" azureuser@135.232.189.196
```

**Comprobación de la conexión:** verifique que aparezca el indicador `azureuser@vm-alojamientos-g01`, correspondiente a la sesión de trabajo en Ubuntu. No se necesita descargar otra clave ni crear otra VM.

### 22.2 — Revisar el estado actual de los contenedores

```sh
cd "$HOME/alojamientos"
sudo docker compose ps
```

`cd` sitúa la sesión en la carpeta del proyecto y `docker compose ps` consulta el estado y los puertos de los contenedores. No modifica los servicios ni sus datos.

**Resultado comprobado:**

| Contenedor | Imagen | Servicio | Estado observado | Puertos internos |
| :---- | :---- | :---- | :---- | :---- |
| alojamientos-backend-1 | alojamientos-backend | backend | Up 14 seconds | 5000/tcp |
| alojamientos-mysql-1 | mysql:8.4 | mysql | Up 14 seconds | 3306/tcp, 33060/tcp |

Ambos contenedores figuraban creados hacía seis días y recién iniciados. No aparecen asignaciones de puertos al host. El estado `Up` comprueba que los contenedores están en ejecución; no sustituye una prueba HTTP o de conexión a MySQL tras el arranque.

### 22.3 — Revisar la configuración de Nginx del Frontend

```sh
sed -n '1,200p' "$HOME/alojamientos/frontend/nginx.conf"
```

`sed -n` consulta las primeras 200 líneas del archivo sin modificarlo.

**Resultado comprobado:**

```nginx
server {
    listen 80;
    server_name _;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

| Directiva | Función |
| :---- | :---- |
| `listen 80` | Nginx escucha en el puerto HTTP 80 del entorno donde se ejecuta. |
| `server_name _` | Nombre genérico para el servidor. |
| `root /usr/share/nginx/html` | Directorio de los archivos estáticos. |
| `index index.html` | Página de entrada. |
| `try_files $uri $uri/ /index.html` | Permite entregar la aplicación SPA cuando la ruta no corresponde a un archivo existente. |

La configuración observada solamente sirve el Frontend. No contiene un proxy hacia el Backend ni TLS. Antes de modificarla, se revisará el Dockerfile y la variable de compilación de Vite para decidir cómo integrar los servicios sin publicar el puerto 5000.

### 22.4 — Revisar el Dockerfile del Frontend

Ejecute en Ubuntu:

```sh
sed -n '1,200p' "$HOME/alojamientos/frontend/Dockerfile"
```

**Resultado comprobado:**

```dockerfile
FROM node:22-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
ARG VITE_API_URL
ENV VITE_API_URL=${VITE_API_URL}
RUN test -n "$VITE_API_URL" && npm run build

FROM nginx:stable-alpine
COPY --from=build /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
```

| Instrucción | Función |
| :---- | :---- |
| `FROM node:22-alpine AS build` | Define una etapa de compilación con Node.js 22. |
| `WORKDIR /app` | Establece el directorio de trabajo de la etapa. |
| `COPY package.json package-lock.json ./` y `RUN npm ci` | Instalan las dependencias según las versiones del archivo de bloqueo. |
| `COPY . .` | Copia el código del Frontend al contexto de compilación. |
| `ARG VITE_API_URL` y `ENV VITE_API_URL=${VITE_API_URL}` | Reciben la dirección de la API durante la construcción y la entregan a Vite. |
| `RUN test -n "$VITE_API_URL" && npm run build` | Exige una URL no vacía antes de compilar la aplicación. |
| `FROM nginx:stable-alpine` | Selecciona Nginx para la imagen final, sin incorporar el entorno Node.js de compilación. |
| `COPY --from=build /app/dist /usr/share/nginx/html` | Copia los archivos compilados al directorio público de Nginx. |
| `COPY nginx.conf /etc/nginx/conf.d/default.conf` | Incorpora la configuración del servidor web. |
| `EXPOSE 80` | Documenta el puerto HTTP del contenedor; no lo publica en el host. |

**Resultado:** el Dockerfile está preparado para una compilación parametrizada en dos etapas. No se necesita instalar Node.js directamente en Ubuntu ni modificar el Dockerfile para suministrar `VITE_API_URL`. Todavía no se ha ejecutado la construcción del Frontend.

### 22.5 — Revisar cómo el Frontend obtiene la dirección de la API

```sh
grep -n 'VITE_API_URL' "$HOME/alojamientos/frontend/src/js/api/http.js"
```

`grep -n` identifica las líneas que contienen la variable y sus números de línea, sin modificar el código.

**Resultado comprobado:**

```text
4:const API_URL = import.meta.env.VITE_API_URL;
```

El cliente HTTP obtiene la dirección de la API de la configuración de Vite. Su valor se incorpora durante la compilación, por lo que cambiarlo después requiere reconstruir la imagen del Frontend. No se deben introducir secretos en variables `VITE_`, porque pueden quedar incorporadas al JavaScript accesible en el navegador.

**Propuesta para la etapa de producción:** utilizar `VITE_API_URL=/api/v1` y enrutar esas solicitudes mediante Nginx al servicio `backend:5000`, conservando MySQL y Backend sin puertos publicados. Antes de aplicar la propuesta se debe comprobar cómo el cliente HTTP construye las URLs completas y si admite una base relativa. La configuración de HTTPS se realizará en el paso correspondiente. No se ha cambiado ningún archivo del servidor ni se ha iniciado el Frontend.

### 22.6 — Revisar la construcción de las solicitudes HTTP

```sh
sed -n '1,200p' "$HOME/alojamientos/frontend/src/js/api/http.js"
```

**Resultado comprobado:** el archivo importa `getToken` y `formatApiError`, define `const API_URL = import.meta.env.VITE_API_URL;` y construye las solicitudes mediante:

```javascript
response = await fetch(`${API_URL}${path}`, {
  ...options,
  headers,
});
```

El cliente establece `Content-Type: application/json`, añade `Authorization: Bearer ${token}` cuando existe un token, trata HTTP 204 como respuesta sin contenido, intenta interpretar el cuerpo como JSON y procesa errores de conexión y respuestas HTTP no satisfactorias.

La concatenación admite una base relativa `/api/v1`: para una ruta `path` igual a `/alojamientos`, el navegador solicita `/api/v1/alojamientos` al mismo origen que sirve la página. Esto coincide con la ruta Flask registrada en 21.18. La base no debe terminar en `/` si las rutas de los servicios ya comienzan por `/`. El navegador no debe usar `backend:5000` (nombre interno de Docker) ni `localhost:5000` como destino de producción. Nginx deberá enrutar las solicitudes de API al Backend conservando el prefijo `/api/v1`. El proxy será configurado y comprobado en la fase de publicación; todavía no está disponible.

**Decisión de configuración:** mantener el código fuente sin cambios y suministrar `VITE_API_URL=/api/v1` durante la construcción. Con el mismo esquema, dominio y puerto del Frontend, no se requiere CORS para esas solicitudes del navegador. No se ha probado aún el consumo real ni la autenticación en Azure.

### 22.7 — Comprobar las exclusiones de construcción

```sh
cat "$HOME/alojamientos/frontend/.dockerignore"
```

**Resultado comprobado:**

```text
.git
.env
.env.*
!.env.example
node_modules/
dist/
*.log
```

| Patrón | Finalidad |
| :---- | :---- |
| `.git` | Excluye los metadatos e historial del repositorio. |
| `.env` y `.env.*` | Excluyen los archivos de entorno con posibles credenciales. |
| `!.env.example` | Permite incluir el ejemplo de entorno, que no debe contener secretos reales. |
| `node_modules/` | Excluye las dependencias locales; el Dockerfile instala sus propias dependencias. |
| `dist/` | Excluye compilaciones anteriores; Vite genera una nueva. |
| `*.log` | Excluye archivos de registro coincidentes. |

El archivo es adecuado para la construcción prevista y no requiere cambios. El `.env` privado de Ubuntu está además fuera del contexto `./frontend`. Las variables `VITE_` incorporadas al navegador son públicas, no deben transportar credenciales.

### 22.8 — Configurar la dirección de la API para producción

Desde la sesión SSH de Ubuntu, ejecute:

~~~bash
cd "$HOME/alojamientos"

if ! grep -q '^VITE_API_URL=' .env; then
    printf '\nVITE_API_URL=/api/v1\n' >> .env
fi

grep '^VITE_API_URL=' .env
~~~

`grep -q` comprueba si ya existe la variable sin mostrar su contenido; la condición evita agregarla por segunda vez. `printf` y `>>` agregan la línea al final del archivo existente, sin sustituir las credenciales. Si la variable ya existe con otro valor, revise y corrija únicamente esa línea antes de compilar. La última instrucción muestra solo la dirección pública relativa de la API, no los secretos del archivo.

**Resultado comprobado:**

~~~text
VITE_API_URL=/api/v1
~~~

### 22.9 — Incorporar el Frontend a Docker Compose

1. Cree un respaldo de la configuración vigente en el directorio del proyecto:

~~~bash
cp compose.yaml "compose.yaml.antes-frontend.$(date +%Y%m%d-%H%M%S).bak"
~~~

`cp` copia el archivo y `date` incorpora fecha y hora al nombre para distinguir este respaldo del creado en el Paso 21. Compruebe que el respaldo exista antes de editar el archivo:

~~~bash
ls -lt compose.yaml.antes-frontend.*.bak
~~~

`ls -lt` muestra los respaldos coincidentes, con sus propiedades y ordenados por fecha de modificación. Si no aparece el respaldo recién creado, no continúe con la edición hasta comprobarlo.

2. Abra el archivo:

~~~bash
nano compose.yaml
~~~

3. Agregue el siguiente servicio dentro de `services:`, al mismo nivel que `mysql` y `backend`, antes del bloque principal `volumes:`. Conserve las definiciones existentes y el volumen externo de MySQL.

~~~yaml
  frontend:
    build:
      context: ./frontend
      args:
        VITE_API_URL: ${VITE_API_URL:?Definir VITE_API_URL}
    restart: unless-stopped
    depends_on:
      - backend
    expose:
      - "80"
~~~

| Parámetro | Función |
|---|---|
| `build.context` | Utiliza el directorio que contiene el Dockerfile del Frontend. |
| `build.args` | Suministra la base de la API a la etapa de compilación. La expresión `:?` exige que la variable exista y no esté vacía. |
| `restart: unless-stopped` | Define la política de reinicio del contenedor. |
| `depends_on` | Establece el orden de inicio respecto al Backend; no garantiza su disponibilidad HTTP. |
| `expose` | Declara el puerto 80 interno sin publicar un puerto en la VM. |

4. Guarde con `Ctrl + O`, confirme con `Enter` y salga con `Ctrl + X`. No repita el bloque si el servicio ya existe.

Compruebe la sintaxis de Compose y que reconozca los tres servicios en el apartado 22.10. La publicación de puertos y el funcionamiento de los servicios se verifican después de construir e iniciar el Frontend.

### 22.10 — Validar Docker Compose

~~~bash
sudo docker compose config --quiet && echo "Configuración válida"
sudo docker compose config --services
~~~

`config --quiet` comprueba que Compose pueda interpretar la configuración sin mostrar los valores de las credenciales. `config --services` enumera los servicios definidos; no inicia los contenedores.

**Resultados comprobados:**

~~~text
Configuración válida
~~~

~~~text
mysql
backend
frontend
~~~

### 22.11 — Construir la imagen Docker del Frontend

Desde el directorio `/home/azureuser/alojamientos`, ejecute:

~~~bash
sudo docker compose build frontend
~~~

`build frontend` construye únicamente la imagen del servicio Frontend según su Dockerfile: emplea Node.js 22, instala las dependencias con `npm ci`, compila Vite con el argumento `VITE_API_URL` y copia los archivos compilados a la imagen final de Nginx. No inicia el contenedor, no modifica MySQL ni aplica migraciones. Evite realizar construcciones paralelas innecesarias en la VM de 4 GiB de RAM.

**Resultado esperado:** `Image alojamientos-frontend Built`. Si la construcción termina con errores, revise su salida antes de iniciar el servicio.

**Resultado comprobado:** la salida de construcción mostró `[+] build 1/1` y `Image alojamientos-frontend Built`, con una duración de **16,2 segundos**. La imagen resultante se verifica en el apartado 22.12.

### 22.12 — Verificar la imagen construida

~~~bash
sudo docker image ls alojamientos-frontend
~~~

`docker image ls` consulta la imagen existente sin iniciar contenedores ni modificar los archivos.

**Resultado comprobado:**

| Campo | Valor observado |
|---|---|
| IMAGE | `alojamientos-frontend:latest` |
| ID | `27ffc4d4c844` |
| DISK USAGE | 93,9 MB |
| CONTENT SIZE | 26,5 MB |

El uso de disco y el tamaño del contenido son medidas distintas; no deben sumarse. La existencia de la imagen confirma que está disponible localmente para iniciar el servicio, pero no demuestra todavía que Nginx responda, que la compilación contenga la URL prevista ni que exista comunicación con la API.

### 22.13 — Iniciar el contenedor del Frontend

~~~bash
sudo docker compose up -d --no-build --no-deps frontend
~~~

| Parámetro | Función |
|---|---|
| `up` | Crea e inicia el contenedor del servicio seleccionado. |
| `-d` | Ejecuta el servicio en segundo plano. |
| `--no-build` | Reutiliza la imagen construida en 22.11. |
| `--no-deps` | Evita iniciar o recrear los servicios dependientes; MySQL y Backend ya estaban en ejecución. |
| `frontend` | Selecciona únicamente el Frontend. |

**Resultado comprobado:** `[+] up 1/1` y `Container alojamientos-frontend-1 Started`, con una duración de **0,4 segundos**. El inicio del contenedor no implica que el servidor web ya responda correctamente a peticiones HTTP.

### 22.14 — Comprobar los tres contenedores

~~~bash
sudo docker compose ps
~~~

**Resultado comprobado:**

| Contenedor | Imagen | Estado observado | Puertos mostrados |
|---|---|---|---|
| `alojamientos-backend-1` | `alojamientos-backend` | Up 28 minutes | 5000/tcp |
| `alojamientos-frontend-1` | `alojamientos-frontend` | Up 13 seconds | 80/tcp |
| `alojamientos-mysql-1` | `mysql:8.4` | Up 28 minutes | 3306/tcp, 33060/tcp |

MySQL y Backend conservaron su tiempo de ejecución; el Frontend se inició sin recrear aquellos contenedores. No se muestran asignaciones de puertos al host. El puerto HTTP 80 del Frontend aún no está publicado en la VM; no se deben abrir los puertos 5000, 3306 ni 33060 en Azure.

### 22.15 — Consultar los registros de Nginx

~~~bash
sudo docker compose logs --tail 50 frontend
~~~

`logs` consulta los mensajes del servicio; `--tail 50` limita el número de líneas. No modifica el contenedor.

**Resultados comprobados:**

~~~text
10-listen-on-ipv6-by-default.sh: info: /etc/nginx/conf.d/default.conf differs from the packaged version
/docker-entrypoint.sh: Configuration complete; ready for start up
2026/11/15 14:53:40 [notice] 1#1: using the "epoll" event method
2026/11/15 14:53:40 [notice] 1#1: nginx/1.30.6
2026/11/15 14:53:40 [notice] 1#1: start worker processes
2026/11/15 14:53:40 [notice] 1#1: start worker process 29
2026/11/15 14:53:40 [notice] 1#1: start worker process 30
~~~

La diferencia entre `default.conf` y el archivo de fábrica es un mensaje informativo coherente con el Dockerfile que incorpora la configuración personalizada. Nginx 1.30.6 inició sus procesos trabajadores; no se observaron errores de arranque en los registros proporcionados.

### 22.16 — Validar la configuración de Nginx

~~~bash
sudo docker compose exec -T frontend nginx -t
~~~

`exec -T frontend` ejecuta un comando dentro del contenedor sin abrir una terminal interactiva; `nginx -t` comprueba la sintaxis y la validez de la configuración cargada, sin reiniciar Nginx.

**Resultado comprobado:**

~~~text
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
~~~

### 22.17 — Comprobar los archivos compilados

~~~bash
sudo docker compose exec -T frontend ls -lh /usr/share/nginx/html
~~~

`ls -lh` consulta los archivos y directorios, con sus tamaños en unidades legibles. La ruta corresponde al directorio público de Nginx al cual el Dockerfile copia la compilación de Vite.

**Resultado comprobado:**

| Archivo o directorio | Tamaño observado | Función |
|---|---|---|
| `index.html` | 396 bytes | Documento HTML principal del Frontend. |
| `assets/` | 4,0 KB (tamaño del directorio) | Archivos de recursos generados por Vite. |
| `50x.html` | 497 bytes | Página de error incluida en la imagen base de Nginx. |

La presencia de `50x.html` no indica que haya ocurrido un error. Los archivos de entrada de la aplicación están presentes; falta comprobar su entrega HTTP.

### 22.18 — Comprobar la respuesta HTTP interna del Frontend

~~~bash
sudo docker compose exec -T frontend wget -S -O /dev/null http://127.0.0.1/
~~~

`wget` realiza una petición HTTP desde el propio contenedor; `-S` muestra los encabezados de la respuesta y `-O /dev/null` descarta el cuerpo descargado. `127.0.0.1` identifica el contenedor Frontend en esta prueba, no el equipo Windows ni la interfaz pública de Azure.

**Resultado comprobado (15 de noviembre de 2026):**

~~~text
HTTP/1.1 200 OK
Server: nginx/1.30.6
Content-Type: text/html
Content-Length: 396
~~~

Se descargaron los 396 bytes de la respuesta satisfactoriamente. Esto confirma que Nginx entrega la página HTML principal desde el puerto interno 80; no comprueba aún la ejecución de JavaScript en un navegador ni el acceso a Internet.

### 22.19 — Comprobar la comunicación interna del Frontend con el Backend

~~~bash
sudo docker compose exec -T frontend wget -qO- http://backend:5000/health
~~~

`backend` es el nombre del servicio en Compose, que se resuelve dentro de la red compartida de Docker. El puerto 5000 corresponde a Gunicorn. `wget -qO-` muestra el cuerpo de la respuesta en la terminal, sin guardar un archivo.

**Resultado comprobado:**

~~~json
{"service":"alojamientos-api","status":"ok","version":"v1"}
~~~

El contenedor Frontend pudo localizar al Backend y recibir su respuesta HTTP de salud por la red interna. No se publicó el puerto 5000. Esta es una prueba de conectividad entre contenedores, no una solicitud del JavaScript del Frontend ni una verificación de los endpoints de negocio.

**Resultado final del Paso 22:** imagen del Frontend construida, contenedor iniciado, Nginx 1.30.6 con configuración válida, archivos compilados presentes, página principal con HTTP 200 y comunicación interna Frontend–Backend comprobada mediante `/health`. MySQL y Backend permanecieron en ejecución durante el inicio del Frontend. La base de API preparada es `/api/v1`. **Quedan pendientes** el proxy inverso, la publicación HTTP controlada, HTTPS, la comprobación de la comunicación desde el navegador y las pruebas funcionales integradas. No se requieren nuevas migraciones para continuar.


---

## Paso 23 — Configurar el proxy inverso y la publicación web

El Frontend, el Backend y MySQL ya están desplegados y comprobados internamente. Utilizaremos el Nginx del contenedor Frontend como punto de entrada web: entregará los archivos compilados de Vite y dirigirá las solicitudes de la API hacia el Backend a través de la red interna de Docker. La base de la API del Frontend seguirá siendo `/api/v1`. No instalaremos otro servidor web ni modificaremos el código de los repositorios. MySQL y Gunicorn conservarán sus puertos internos; HTTPS corresponde al Paso 24. Antes de publicar puertos, prepararemos y validaremos la configuración.

### 23.1 — Comprobar el DNS interno de Docker

Desde el directorio `/home/azureuser/alojamientos`, en la sesión SSH de Ubuntu, ejecute:

~~~bash
sudo docker compose exec -T frontend cat /etc/resolv.conf
~~~

`exec -T frontend` ejecuta el comando dentro del contenedor sin terminal interactiva. `cat /etc/resolv.conf` consulta el archivo de configuración de resolución de nombres del contenedor. No modifica su contenido.

**Resultado comprobado:**

~~~text
nameserver 127.0.0.11
options edns0 trust-ad ndots:0
~~~

Docker generó el archivo e identificó su resolvedor interno. La dirección `127.0.0.11` corresponde al DNS integrado de Docker en la red del contenedor; no es la dirección del Backend ni debe configurarse como dirección pública de la API. Se utilizará para que Nginx pueda resolver el nombre `backend` y actualizar la dirección cuando se recree ese contenedor. No edite `/etc/resolv.conf`.

### 23.2 — Crear el directorio de configuración de producción

~~~bash
mkdir -p "$HOME/alojamientos/nginx"
ls -ld "$HOME/alojamientos/nginx"
~~~

`mkdir -p` crea el directorio si no existe; `ls -ld` comprueba sus propiedades. La configuración específica de Azure se conservará fuera del repositorio `frontend`, de modo que la actualización del código desde GitHub no tenga que sobrescribirla. Se reutilizará el Nginx que ya forma parte de la imagen Frontend.

**Resultado comprobado:**

~~~text
drwxrwxr-x 2 azureuser azureuser 4096 Nov 15 15:04 /home/azureuser/alojamientos/nginx
~~~

El directorio existe, pertenece a `azureuser` y presenta permisos `775`. Está dentro del directorio de proyecto protegido con permisos `700` según la comprobación del Paso 19. No almacene claves privadas TLS ni otros secretos en este directorio de configuración pública sin establecer una protección específica.


### 23.3 — Crear la configuración del proxy inverso

Abra el archivo de producción en la sesión SSH de Ubuntu:

~~~bash
nano "$HOME/alojamientos/nginx/default.conf"
~~~

Introduzca la configuración siguiente, conservando literalmente las variables de Nginx que comienzan por `$`:

~~~nginx
upstream backend_api {
    zone backend_api 64k;
    resolver 127.0.0.11 valid=10s ipv6=off;
    server backend:5000 resolve;
}

server {
    listen 80;
    server_name alojamientos-g01.northcentralus.cloudapp.azure.com;

    root /usr/share/nginx/html;
    index index.html;

    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $remote_addr;
    proxy_set_header X-Forwarded-Proto $scheme;

    location /api/ {
        proxy_pass http://backend_api;
    }

    location = /health {
        proxy_pass http://backend_api;
    }

    location / {
        try_files $uri $uri/ /index.html;
    }
}
~~~

Guarde con `Ctrl + O`, confirme con `Enter` y salga con `Ctrl + X`. El archivo se crea fuera del repositorio `frontend` y no sustituye todavía la configuración que utiliza el contenedor en ejecución.

| Directiva | Función |
|---|---|
| `upstream backend_api` | Define el destino de las solicitudes que Nginx debe entregar al Backend. |
| `zone backend_api 64k` | Reserva memoria compartida para el estado del grupo de servidores entre trabajadores de Nginx. |
| `resolver 127.0.0.11 valid=10s ipv6=off` | Usa el DNS interno verificado en 23.1, limita la validez de las respuestas a 10 segundos y desactiva consultas IPv6. |
| `server backend:5000 resolve` | Identifica el servicio Backend de Compose y permite actualizar la IP resuelta sin recargar Nginx por cada cambio de IP. |
| `listen 80` y `server_name` | Definen el puerto HTTP interno y el dominio previsto de la aplicación. No publican el puerto de la VM. |
| `root` e `index` | Conservan la ubicación de los archivos compilados del Frontend y el documento de entrada. |
| `proxy_set_header` | Transmite el host, la dirección del cliente observada por Nginx y el esquema de la solicitud. `X-Forwarded-For` se establece con `$remote_addr` en lugar de confiar en un valor suministrado por el cliente. |
| `location /api/` | Dirige las solicitudes de API al Backend. `proxy_pass http://backend_api` no incluye un componente URI adicional, por lo que conserva la ruta solicitada, incluido `/api/v1/`. |
| `location = /health` | Envía el endpoint exacto de salud al Backend. |
| `location /` y `try_files` | Sirven los archivos estáticos y conservan la navegación de la SPA mediante `index.html`. |

La resolución dinámica mediante `resolve` en grupos de servidores está disponible en Nginx de código abierto desde la versión 1.27.3; la versión 1.30.6 observada en el Paso 22 es compatible. Referencia: [documentación del módulo upstream de Nginx](https://nginx.org/en/docs/http/ngx_http_upstream_module.html). La configuración mantiene el puerto 5000 dentro de Docker. En esta etapa no se han configurado certificados TLS; no envíe contraseñas ni tokens a través de una conexión HTTP pública.

### 23.4 — Revisar el archivo creado

~~~bash
cat "$HOME/alojamientos/nginx/default.conf"
~~~

`cat` muestra el contenido guardado sin modificarlo. Compare todas las directivas, las llaves y las variables con el bloque del apartado 23.3.

**Resultado comprobado:** se ejecutó `nano` y la salida de `cat` mostró íntegramente la configuración indicada en 23.3, incluyendo el grupo `backend_api`, la resolución mediante `127.0.0.11`, el dominio de Azure, las rutas `/api/` y `/health` y el tratamiento de las rutas de la SPA. No se observaron diferencias respecto al contenido propuesto. Esta revisión confirma la existencia y el contenido del archivo, pero no equivale a una validación de sintaxis con `nginx -t` ni prueba su funcionamiento.


### 23.5 — Respaldar Docker Compose

Desde el directorio `/home/azureuser/alojamientos`, ejecute:

~~~bash
cp compose.yaml "compose.yaml.antes-proxy.$(date +%Y%m%d-%H%M%S).bak"
~~~

`cp` conserva una copia del archivo de configuración vigente. `$(date +%Y%m%d-%H%M%S)` agrega la fecha y hora al nombre para distinguir el respaldo de los anteriores. Este respaldo permite recuperar la configuración del Paso 22. No contiene una copia de los datos de MySQL y no sustituye un respaldo de la base de datos.

Compruebe que el respaldo exista antes de editar Compose:

~~~bash
ls -lt compose.yaml.antes-proxy.*.bak
~~~

La salida debe mostrar el archivo recién creado, con su fecha y hora. Si no aparece, revise la operación de copia antes de continuar. `ls -lt` verifica su existencia, no una restauración del respaldo.

### 23.6 — Incorporar la configuración de Nginx a Docker Compose

Abra el archivo de configuración del proyecto:

~~~bash
nano compose.yaml
~~~

Modifique únicamente el servicio `frontend` para que quede así, sin duplicar su definición:

~~~yaml
  frontend:
    build:
      context: ./frontend
      args:
        VITE_API_URL: ${VITE_API_URL:?Definir VITE_API_URL}
    restart: unless-stopped
    depends_on:
      - backend
    expose:
      - "80"
    volumes:
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf:ro
~~~

| Elemento agregado | Función |
|---|---|
| `volumes` (dentro de `frontend`) | Define los montajes de archivos o directorios de ese servicio. |
| `./nginx/default.conf` | Archivo de configuración de producción creado en Ubuntu en 23.3. La ruta relativa se resuelve respecto al proyecto Compose. |
| `/etc/nginx/conf.d/default.conf` | Ruta del archivo de configuración dentro del contenedor Nginx. El montaje sustituye la vista del archivo incorporado en la imagen en esa ubicación. |
| `:ro` | Montaje de solo lectura para que el contenedor no modifique el archivo del anfitrión. |

Conserve intactas las definiciones de MySQL, Backend y el bloque principal `volumes:` que declara `alojamientos_mysql_data` como externo. No agregue todavía `ports`: se comprobará primero el proxy internamente. Guarde con `Ctrl + O`, confirme con `Enter` y salga con `Ctrl + X`.

La decisión de utilizar un montaje de solo lectura evita modificar el repositorio del Frontend o reconstruir la imagen únicamente para aplicar la configuración del proxy. Los cambios de Compose se aplicarán al contenedor en una operación posterior; guardar el YAML no modifica por sí solo el contenedor activo.

Valide el archivo en el apartado 23.7 y compruebe el montaje efectivo en el apartado 23.11.

### 23.7 — Validar Docker Compose

~~~bash
sudo docker compose config --quiet && echo "Configuración válida"
~~~

`config --quiet` valida la configuración de Compose sin imprimir las variables de entorno expandidas, lo que evita mostrar credenciales de MySQL y Flask. `&& echo` muestra la confirmación únicamente si la validación termina correctamente. Este comando no crea ni reinicia contenedores; tampoco verifica por sí solo la sintaxis interna de Nginx ni el enrutamiento de las peticiones HTTP.

**Resultado comprobado:**

~~~text
Configuración válida
~~~


### 23.8 — Validar el proxy inverso en un contenedor temporal

Antes de sustituir el contenedor Frontend activo, ejecute desde `/home/azureuser/alojamientos`:

~~~bash
sudo docker compose run --rm --no-deps frontend nginx -t
~~~

| Parámetro | Función |
|---|---|
| `run` | Crea un contenedor temporal con la definición actualizada del servicio. |
| `--rm` | Elimina el contenedor temporal al terminar la prueba. |
| `--no-deps` | Evita iniciar o recrear los servicios dependientes. |
| `frontend` | Selecciona el servicio que incluye el montaje de configuración. |
| `nginx -t` | Comprueba la sintaxis y la validez de los archivos de configuración sin iniciar el servidor web de forma permanente. |

**Resultado comprobado:**

~~~text
[+] run 1/1
Container alojamientos-frontend-run-38a5df86039e Created
10-listen-on-ipv6-by-default.sh: info: can not modify /etc/nginx/conf.d/default.conf (read-only file system?)
/docker-entrypoint.sh: Configuration complete; ready for start up
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
~~~

Docker informó la creación del contenedor temporal en 0,2 segundos. El mensaje informativo del script de inicio que intenta modificar `default.conf` es coherente con el montaje `:ro` configurado en 23.6. No es necesario quitar el modo de solo lectura ni cambiar permisos: Nginx pudo leer la configuración y completar su prueba correctamente. La prueba no sustituye la comprobación de solicitudes HTTP al Backend mediante el proxy.


### 23.9 — Recrear el Frontend con el proxy inverso

Después de comprobar la configuración en el contenedor temporal, ejecute desde `/home/azureuser/alojamientos`:

~~~bash
sudo docker compose up -d --no-build --no-deps --force-recreate frontend
~~~

| Parámetro | Función |
|---|---|
| `up -d` | Crea e inicia el servicio en segundo plano. |
| `--no-build` | Reutiliza la imagen existente sin volver a compilar el Frontend. |
| `--no-deps` | Excluye los servicios dependientes de la operación. |
| `--force-recreate` | Fuerza la recreación del contenedor para incorporar la configuración actualizada de Compose. |
| `frontend` | Limita la operación al servicio Frontend. |

**Resultado comprobado:**

~~~text
[+] up 1/1
Container alojamientos-frontend-1 Started
~~~

La operación informó una duración de **0,7 segundos**. No fue necesario reconstruir la imagen, alterar las credenciales ni ejecutar migraciones. Compruebe el montaje y el enrutamiento HTTP en los apartados siguientes.

**Nota:** el mensaje informativo de solo lectura mostrado en 23.8 es parte de la salida de Nginx, no un comando. No quite el montaje `:ro` ni modifique permisos por ese aviso.

### 23.10 — Verificar el estado de los contenedores

~~~bash
sudo docker compose ps
~~~

`ps` muestra los contenedores del proyecto, su estado y los puertos, sin reiniciar ni modificar los servicios.

**Resultado comprobado:**

| Contenedor | Imagen | Antigüedad observada | Estado observado | Puertos mostrados |
|---|---|---|---|---|
| `alojamientos-backend-1` | `alojamientos-backend` | 6 days ago | Up 51 minutes | 5000/tcp |
| `alojamientos-frontend-1` | `alojamientos-frontend` | 10 seconds ago | Up 9 seconds | 80/tcp |
| `alojamientos-mysql-1` | `mysql:8.4` | 6 days ago | Up 51 minutes | 3306/tcp, 33060/tcp |

La antigüedad y los tiempos de ejecución muestran que solo el Frontend fue recreado; Backend y MySQL continuaron en ejecución. Ninguno tiene una asignación de puerto al anfitrión en esta salida. El estado `Up` no sustituye una petición HTTP de prueba.


### 23.11 — Verificar el montaje de la configuración de Nginx

Ejecute desde `/home/azureuser/alojamientos`:

~~~bash
sudo docker inspect alojamientos-frontend-1 --format '{{range .Mounts}}{{.Source}} -> {{.Destination}} | RW={{.RW}}{{println}}{{end}}'
~~~

`docker inspect` consulta las propiedades efectivas del contenedor. El formato limita la salida a los montajes: `.Source` identifica el origen en Ubuntu, `.Destination` indica la ruta dentro del contenedor y `.RW` indica si se permite escritura. No muestra las variables de entorno ni las credenciales.

**Resultado comprobado:**

~~~text
/home/azureuser/alojamientos/nginx/default.conf -> /etc/nginx/conf.d/default.conf | RW=false
~~~

El archivo de producción se encuentra montado en la ubicación prevista. `RW=false` confirma que el montaje es de solo lectura para el contenedor. No es necesario modificar el Dockerfile ni los permisos para corregir el aviso informativo del apartado 23.8.

### 23.12 — Comprobar el funcionamiento del proxy inverso

~~~bash
sudo docker compose exec -T frontend wget -S -O - http://127.0.0.1/health
~~~

`exec -T frontend` ejecuta la prueba dentro del contenedor Frontend. `wget -S` muestra los encabezados HTTP y `-O -` envía el cuerpo a la salida estándar. `127.0.0.1` se refiere al propio contenedor; al no especificar otro puerto, HTTP utiliza el 80 de Nginx. A diferencia del apartado 22.19 (consulta directa a `backend:5000`), esta solicitud pasa por el proxy inverso configurado en el apartado 23.3.

**Resultado comprobado (15 de noviembre de 2026, 15:18:33 UTC):**

~~~text
HTTP/1.1 200 OK
Server: nginx/1.30.6
Content-Type: application/json
Content-Length: 60
Access-Control-Allow-Origin: http://127.0.0.1:5500
Vary: Origin
~~~

~~~json
{"service":"alojamientos-api","status":"ok","version":"v1"}
~~~

Nginx recibe la solicitud en el puerto 80, resuelve el destino `backend:5000` mediante la configuración del grupo `backend_api`, reenvía la ruta `/health` y entrega la respuesta JSON. La prueba confirma el enrutamiento interno, no la disponibilidad desde Internet.

### 23.13 — Comprobar una ruta de la API

~~~bash
sudo docker compose exec -T frontend wget -S -O - http://127.0.0.1/api/v1/alojamientos
~~~

La solicitud GET utiliza una ruta de negocio registrada en Flask (apartado 21.18). Atraviesa el mismo Nginx, que conserva el prefijo `/api/v1` al reenviar la solicitud al Backend. No crea ni modifica alojamientos.

**Resultado comprobado (15 de noviembre de 2026, 15:18:44 UTC):**

~~~text
HTTP/1.1 200 OK
Server: nginx/1.30.6
Content-Type: application/json
Content-Length: 62
Access-Control-Allow-Origin: http://127.0.0.1:5500
Vary: Origin
~~~

~~~json
{"data":[],"message":"Lista de alojamientos.","success":true}
~~~

La respuesta HTTP y el campo `success: true` confirman que se procesó satisfactoriamente la consulta de alojamientos. `data: []` es una lista vacía; no representa un error ni prueba por sí sola todas las operaciones de negocio. La conexión Backend–MySQL ya fue verificada en el apartado 21.17. Los indicadores de progreso o el orden de impresión de los encabezados y del cuerpo pueden variar en la terminal.

**Observación de CORS:** las dos respuestas contienen `Access-Control-Allow-Origin: http://127.0.0.1:5500` y `Vary: Origin`. El origen permitido observado corresponde a una dirección de desarrollo. La arquitectura elegida utiliza el mismo origen para el Frontend y la API mediante `VITE_API_URL=/api/v1`; por ello, ese encabezado no impide las solicitudes del navegador al mismo esquema, dominio y puerto. La política CORS deberá revisarse antes de concluir la puesta en producción, sin ampliar los orígenes indiscriminadamente. No se ha modificado en esta fase. No se requiere reconstruir las imágenes ni repetir las migraciones para continuar.

Antes de continuar, compruebe que el montaje de solo lectura esté confirmado (23.11) y que ambas rutas devuelvan HTTP 200 (23.12 y 23.13). No transmita contraseñas ni tokens por HTTP público.


### 23.14 — Comprobar la disponibilidad de los puertos web en Ubuntu

Antes de publicar Nginx, compruebe si el anfitrión tiene procesos en escucha en los puertos web. Ejecute en Ubuntu mediante SSH:

~~~bash
sudo ss -ltnp '( sport = :80 or sport = :443 )'
~~~

| Parámetro | Función |
|---|---|
| `-l` | Limita la consulta a sockets en escucha. |
| `-t` | Selecciona TCP. |
| `-n` | Muestra los puertos como números, sin traducirlos a nombres de servicios. |
| `-p` | Muestra los procesos asociados cuando están disponibles. |
| `( sport = :80 or sport = :443 )` | Filtra los puertos locales HTTP y HTTPS. |

**Resultado comprobado:** el comando mostró únicamente los encabezados `State`, `Recv-Q`, `Send-Q`, `Local Address:Port`, `Peer Address:Port` y `Process`, sin filas de sockets. No se identificaron procesos TCP escuchando en los puertos 80 y 443 del anfitrión en ese momento. Esta consulta no demuestra por sí sola la ausencia de reglas NAT o de publicación de Docker; debe interpretarse junto con `docker compose ps` del apartado 23.10, donde no figuraban asignaciones de puertos al anfitrión. El Nginx interno ya funcionaba en el puerto 80 de su contenedor.

### 23.15 — Comprobar el firewall de Ubuntu

~~~bash
sudo ufw status verbose
~~~

`ufw status verbose` consulta el estado y los detalles disponibles de Uncomplicated Firewall (UFW) en Ubuntu; no activa, desactiva ni modifica reglas.

**Resultado comprobado:**

~~~text
Status: inactive
~~~

UFW no estaba activo. Esto no significa que no existan filtros de red: Docker administra reglas para sus redes y puertos publicados, y Azure aplica las reglas del NSG asociado a la interfaz de red. Docker advierte que su publicación de puertos puede eludir las reglas ordinarias de UFW; por ello, activar UFW por sí solo no garantiza el filtrado de puertos de contenedores. Referencia: [Docker — Packet filtering and firewalls](https://docs.docker.com/engine/network/packet-filtering-firewalls/).

**Decisión de configuración:** conservar UFW sin cambios en esta etapa de laboratorio y utilizar el NSG de Azure como control de acceso externo, verificando las reglas efectivas antes de autorizar el tráfico HTTP. La regla SSH debe seguir restringida a la IPv4 administrativa autorizada con `/32`. No se publicarán los puertos 5000, 3306 ni 33060. No se enviarán contraseñas ni tokens por HTTP público; HTTPS corresponde al Paso 24.


### 23.16 — Respaldar la configuración antes de publicar HTTP

Desde `/home/azureuser/alojamientos`, cree una copia del archivo Compose vigente antes de editarlo:

~~~bash
cp compose.yaml "compose.yaml.antes-http.$(date +%Y%m%d-%H%M%S).bak"
~~~

`cp` copia el archivo; `$(date +%Y%m%d-%H%M%S)` agrega la fecha y hora al nombre. Este respaldo permite recuperar la configuración anterior, que ya incluye el proxy inverso pero todavía no publica el puerto 80. No sustituye un respaldo de los datos de MySQL.

Verifique que la copia se haya creado correctamente antes de modificar el archivo. El apartado 23.19 vuelve a comprobar su existencia antes de aplicar los cambios.

### 23.17 — Configurar la publicación del puerto 80

Abra el archivo de configuración:

~~~bash
nano compose.yaml
~~~

Modifique exclusivamente el bloque `frontend`, conservando los bloques de MySQL, Backend y el volumen persistente externo:

~~~yaml
  frontend:
    build:
      context: ./frontend
      args:
        VITE_API_URL: ${VITE_API_URL:?Definir VITE_API_URL}
    restart: unless-stopped
    depends_on:
      - backend
    expose:
      - "80"
    ports:
      - "0.0.0.0:80:80"
    volumes:
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf:ro
~~~

| Elemento nuevo | Función |
|---|---|
| `ports` | Define la asignación del puerto del anfitrión al puerto del contenedor. |
| `0.0.0.0` | Publica en todas las interfaces IPv4 del anfitrión. |
| Primer `80` | Puerto TCP 80 de Ubuntu. |
| Segundo `80` | Puerto TCP 80 del contenedor Nginx. |

`expose` no publica por sí solo puertos en Ubuntu; el nuevo bloque `ports` sí establece esa publicación cuando se aplica al contenedor. Se conserva el montaje de solo lectura de Nginx. Guarde con `Ctrl + O`, `Enter` y `Ctrl + X`. No agregue `ports` a MySQL ni al Backend. Antes de aplicar esta configuración, revise las reglas del NSG, pues la asignación a todas las interfaces IPv4 no limita por sí sola el origen del tráfico.

Valide Compose según el apartado 23.18 y compare el bloque `frontend` con la configuración anterior antes de recrear el contenedor (23.19).

### 23.18 — Validar Docker Compose

~~~bash
sudo docker compose config --quiet && echo "Configuración válida"
~~~

`config --quiet` valida la estructura de Compose sin imprimir las credenciales expandidas; `&& echo` muestra la confirmación solo si la validación es satisfactoria. No aplica los cambios al contenedor activo ni permite verificar por sí solo el alcance de las reglas de red de Azure.

**Resultado comprobado:**

~~~text
Configuración válida
~~~


### 23.19 — Verificar el respaldo y la configuración del Frontend

Antes de aplicar la publicación de puertos, consulte el respaldo anterior a HTTP:

~~~bash
ls -lt compose.yaml.antes-http.*.bak
~~~

`ls -lt` lista los archivos coincidentes, con sus propiedades y ordenados desde el más recientemente modificado. Si no existe un respaldo, revise la situación antes de recrear el servicio; no se debe presentar una copia de la configuración ya modificada como el respaldo anterior a HTTP.

Consulte solamente el bloque del Frontend, sin expandir las variables de entorno:

~~~bash
sed -n '/^  frontend:/,/^volumes:/p' compose.yaml
~~~

`sed -n` muestra desde la línea que inicia el servicio `frontend` hasta el encabezado principal `volumes:`. Compruebe que el bloque conserve la configuración del apartado 23.17, incluido el montaje de solo lectura y la siguiente asignación:

~~~yaml
    ports:
      - "0.0.0.0:80:80"
~~~

**Resultados comprobados (15 de noviembre de 2026):**

~~~text
-rw-rw-r-- 1 azureuser azureuser 970 Nov 15 15:23 compose.yaml.antes-http.20261115-152340.bak
~~~

El archivo de respaldo existe, pertenece a `azureuser` y tiene 970 bytes. Se comprobó su existencia, no se ensayó una restauración ni se inspeccionó su contenido. Sus permisos son `664`; está dentro del directorio del proyecto protegido con permisos `700` según el Paso 19. No confunda este respaldo de configuración con una copia de los datos de MySQL.

El segundo comando mostró el siguiente bloque:

~~~yaml
  frontend:
    build:
      context: ./frontend
      args:
        VITE_API_URL: ${VITE_API_URL:?Definir VITE_API_URL}
    restart: unless-stopped
    depends_on:
      - backend
    expose:
      - "80"
    ports:
      - "0.0.0.0:80:80"
    volumes:
      - ./nginx/default.conf:/etc/nginx/conf.d/default.conf:ro

volumes:
~~~

La definición coincide con la propuesta del apartado 23.17. Se conserva el argumento de compilación, la política de reinicio, la dependencia del Backend y el montaje de solo lectura. La asignación `0.0.0.0:80:80` está presente en el archivo; el encabezado final `volumes:` corresponde al bloque principal de Compose. Esta consulta no muestra sus elementos ni las definiciones de MySQL y Backend. La publicación efectiva se verificará cuando se recree el Frontend. **El apartado 23.19 queda comprobado**, incluyendo la existencia del respaldo solicitado en 23.16.

### 23.20 — Revisar las reglas de seguridad en Azure

1. Ingrese al [Portal de Azure](https://portal.azure.com).
2. Abra **Grupos de recursos → rg-alojamientos-g01 → vm-alojamientos-g01-nsg**.
3. Seleccione **Configuración → Reglas de seguridad de entrada**.
4. Compruebe que SSH siga limitado a la IPv4 administrativa autorizada con `/32`, que las reglas predeterminadas permanezcan presentes y que no existan reglas personalizadas que permitan acceso directo desde Internet a MySQL o Gunicorn. En esta etapa no agregue ni modifique reglas.

**Resultado comprobado en el portal (captura del 15 de noviembre de 2026):**

| Prioridad | Regla | Puerto de destino | Protocolo | Origen | Destino | Acción |
|---|---|---|---|---|---|---|
| 100 | Allow-SSH-Admin | 22 | TCP | IPv4 administrativa autorizada /32 | Cualquiera | Allow |
| 65000 | AllowVnetInBound | Cualquiera | Cualquiera | VirtualNetwork | VirtualNetwork | Allow |
| 65001 | AllowAzureLoadBalancerInBound | Cualquiera | Cualquiera | AzureLoadBalancer | Cualquiera | Allow |
| 65500 | DenyAllInBound | Cualquiera | Cualquiera | Cualquiera | Cualquiera | Deny |

La captura muestra solamente una regla personalizada, `Allow-SSH-Admin`, con prioridad 100 y origen restringido a una IPv4 con máscara `/32`. Los puertos 80, 443, 5000, 3306 y 33060 no tienen autorización de entrada desde Internet en las reglas observadas. Se conservan las reglas predeterminadas, incluidas las autorizaciones específicas de la red virtual y Azure Load Balancer. Se omite la IP administrativa concreta para que el procedimiento pueda reutilizarse de manera segura.

**Decisión de configuración:** conservar estas reglas mientras se verifica el respaldo y se aplica la publicación HTTP del puerto 80 al anfitrión. Una publicación en Docker no equivale a autorizar el acceso desde Internet en el NSG. Primero se realizarán pruebas desde Ubuntu; después se autorizará HTTP de forma controlada y se configurará HTTPS. No se enviarán contraseñas ni tokens a través de HTTP sin cifrar.

Antes de continuar, compruebe que el respaldo y el bloque `frontend` coincidan con lo indicado en 23.19, y que las reglas de entrada del NSG correspondan a la tabla anterior. Todavía no se ha aplicado la publicación del puerto 80 ni se debe autorizar tráfico HTTP externo.


### 23.21 — Aplicar la publicación del puerto 80 al contenedor Frontend

Después de confirmar el respaldo, la configuración de Compose y las reglas del NSG, ejecute desde `/home/azureuser/alojamientos`:

~~~bash
sudo docker compose up -d --no-build --no-deps --force-recreate frontend
~~~

| Parámetro | Función |
|---|---|
| `up -d` | Crea e inicia el servicio en segundo plano. |
| `--no-build` | Reutiliza la imagen existente, sin recompilar Vite. |
| `--no-deps` | Evita iniciar o recrear los servicios dependientes. |
| `--force-recreate` | Recrea el contenedor para incorporar la asignación del puerto 80. |
| `frontend` | Limita la operación al servidor web Frontend. |

**Resultado comprobado:**

~~~text
[+] up 1/1
Container alojamientos-frontend-1 Started
~~~

La operación informó una duración de **0,8 segundos**. La configuración `0.0.0.0:80:80` asigna el puerto HTTP del contenedor al puerto 80 de las interfaces IPv4 de Ubuntu. El acceso desde Internet sigue sujeto a las reglas del NSG revisadas en 23.20. No se ejecutaron nuevas migraciones ni se reconstruyeron imágenes.

### 23.22 — Verificar la publicación del puerto

~~~bash
sudo docker compose ps
~~~

`ps` consulta el estado de los servicios y los puertos publicados, sin modificar los contenedores.

**Resultado comprobado:**

| Contenedor | Imagen | Antigüedad observada | Estado observado | Puertos mostrados |
|---|---|---|---|---|
| `alojamientos-backend-1` | alojamientos-backend | 6 days ago | Up 2 hours | 5000/tcp |
| `alojamientos-frontend-1` | alojamientos-frontend | 11 seconds ago | Up 10 seconds | 0.0.0.0:80->80/tcp |
| `alojamientos-mysql-1` | mysql:8.4 | 6 days ago | Up 2 hours | 3306/tcp, 33060/tcp |

Los tres contenedores están en ejecución. Los tiempos de ejecución confirman que se recreó únicamente el Frontend; MySQL y Backend permanecieron activos. La asignación `0.0.0.0:80->80/tcp` demuestra la publicación del puerto HTTP en el anfitrión. Los puertos 5000, 3306 y 33060 continúan sin asignaciones al anfitrión y se usan dentro de Docker. El estado `Up` y la asignación del puerto no sustituyen la comprobación de respuestas HTTP desde Ubuntu.

El puerto HTTP está publicado en Ubuntu, pero la regla de entrada del NSG aún no permite HTTP desde Internet. Realice primero las pruebas en Ubuntu. No utilice HTTP sin cifrar para transmitir credenciales o tokens.


### 23.23 — Comprobar el Frontend desde Ubuntu

Ejecute directamente desde la sesión SSH de Ubuntu, fuera de los contenedores:

~~~bash
curl -I --max-time 10 http://127.0.0.1/
~~~

`curl -I` realiza una solicitud HEAD para consultar los encabezados HTTP sin descargar el cuerpo; `--max-time 10` limita la duración de la operación a diez segundos. En esta prueba `127.0.0.1` identifica a Ubuntu (anfitrión), a diferencia de las pruebas mediante `docker compose exec` realizadas desde el contenedor. Docker debe entregar la solicitud al puerto 80 de Nginx.

**Resultado comprobado (15 de noviembre de 2026):**

~~~text
HTTP/1.1 200 OK
Server: nginx/1.30.6
Date: Sun, 15 Nov 2026 15:58:12 GMT
Content-Type: text/html
Content-Length: 396
Last-Modified: Sun, 15 Nov 2026 14:52:45 GMT
Connection: keep-alive
ETag: "6af9c73d-18c"
Accept-Ranges: bytes
~~~

Nginx responde en el puerto publicado de Ubuntu y anuncia el documento HTML de 396 bytes. La solicitud HEAD confirma los encabezados de la página, pero no ejecuta JavaScript ni comprueba el acceso desde Internet.

### 23.24 — Comprobar el Backend a través del puerto publicado

~~~bash
curl -i --max-time 10 http://127.0.0.1/health
~~~

`curl -i` incluye los encabezados de la respuesta y su cuerpo; a diferencia de `-I`, realiza una solicitud GET en este comando. La petición se dirige al puerto HTTP 80 de Ubuntu. Nginx debe reenviarla al servicio `backend:5000` según la configuración del apartado 23.3.

**Resultado comprobado:**

~~~text
HTTP/1.1 200 OK
Server: nginx/1.30.6
Date: Sun, 15 Nov 2026 15:58:24 GMT
Content-Type: application/json
Content-Length: 60
Connection: keep-alive
Access-Control-Allow-Origin: http://127.0.0.1:5500
Vary: Origin

{"service":"alojamientos-api","status":"ok","version":"v1"}
~~~

El código HTTP 200 y el cuerpo JSON confirman que el Backend responde a través de Nginx desde Ubuntu. El puerto 5000 continúa sin publicación directa al anfitrión. Esta prueba de salud no sustituye una consulta de negocio.

### 23.25 — Comprobar una consulta de la API

~~~bash
curl -i --max-time 10 http://127.0.0.1/api/v1/alojamientos
~~~

Esta solicitud GET comprueba que la ruta de negocio `/api/v1/alojamientos` llega al Backend mediante el puerto publicado de Nginx, conservando el prefijo de la API. No crea ni modifica alojamientos y no necesita enviar contraseñas ni tokens para esta consulta.

**Resultado comprobado:**

~~~text
HTTP/1.1 200 OK
Server: nginx/1.30.6
Date: Sun, 15 Nov 2026 15:58:37 GMT
Content-Type: application/json
Content-Length: 62
Connection: keep-alive
Access-Control-Allow-Origin: http://127.0.0.1:5500
Vary: Origin

{"data":[],"message":"Lista de alojamientos.","success":true}
~~~

El Backend devolvió una lista vacía y `success: true`: la consulta fue satisfactoria, aunque no devolvió alojamientos. No se realizó un registro de prueba. Las respuestas de la API siguen incluyendo el origen CORS de desarrollo `http://127.0.0.1:5500`. Esta cabecera no bloquea las peticiones del mismo origen, que será la arquitectura utilizada por el Frontend con `/api/v1`; se revisará la configuración CORS antes de finalizar la puesta en producción. Las pruebas con `curl` no demuestran por sí solas el consumo de la API mediante JavaScript en el navegador.

Antes de autorizar el acceso externo, compruebe las tres respuestas HTTP 200 de los apartados 23.23 a 23.25 y el estado de los contenedores de 23.22. Por seguridad, limite inicialmente HTTP a la IPv4 administrativa autorizada; no utilice contraseñas ni tokens por HTTP. En la fase de HTTPS se revisarán las reglas públicas necesarias para la validación y renovación de certificados y el acceso HTTPS definitivo.


### 23.26 — Crear la regla de entrada HTTP en Azure

Las pruebas desde Ubuntu ya fueron satisfactorias. Ahora autorizaremos inicialmente HTTP TCP 80 solo desde la IPv4 pública administrativa para comprobar el acceso por el DNS de Azure. Esta restricción es temporal hasta preparar HTTPS; no utilice HTTP para transmitir credenciales o tokens.

1. Abra el [Portal de Azure](https://portal.azure.com) y seleccione el grupo de recursos `rg-alojamientos-g01`.
2. Abra `vm-alojamientos-g01-nsg` → **Configuración → Reglas de seguridad de entrada**.
3. Seleccione **Agregar** y complete los campos siguientes. Utilice la IPv4 administrativa autorizada en `Allow-SSH-Admin`, no la IP pública de la VM.

| Campo | Valor previsto | Función |
|---|---|---|
| Origen | Direcciones IP | Limita los orígenes autorizados. |
| Intervalos de direcciones IP de origen y CIDR | Misma IPv4 administrativa de SSH, con `/32` | Autoriza una sola IPv4 pública. |
| Intervalos de puertos de origen | `*` | Permite los puertos de origen variables del cliente. |
| Destino | Cualquiera | Aplica al destino protegido por el NSG. |
| Servicio | Custom (o HTTP si fija TCP 80) | Permite seleccionar el servicio web. |
| Intervalos de puertos de destino | `80` | Puerto HTTP publicado por Docker. |
| Protocolo | TCP | Protocolo de transporte de HTTP. |
| Acción | Permitir | Autoriza el tráfico que cumpla la regla. |
| Prioridad | `110` | Se evalúa antes de las reglas predeterminadas. |
| Nombre | `Allow-HTTP-Admin` | Identifica el acceso HTTP administrativo. |
| Descripción | Permitir HTTP para pruebas administrativas | Explica el propósito temporal. |

4. Revise los campos y pulse **Agregar**. No modifique `Allow-SSH-Admin` ni las reglas predeterminadas. No habilite TCP 443 todavía ni publique los puertos 5000, 3306 y 33060.

**Resultado comprobado:** `Allow-HTTP-Admin` aparece en las reglas de entrada con prioridad **110**, puerto **80** y protocolo **TCP**. `Allow-SSH-Admin` conserva la prioridad **100**, TCP **22**, origen limitado a la IPv4 administrativa con `/32` y acción Permitir. Las tres reglas predeterminadas de Azure permanecen presentes. Compruebe todos los campos de la regla HTTP en el apartado 23.27 sin crear otra regla ni modificar SSH.


### 23.27 — Verificar la regla HTTP

1. En `vm-alojamientos-g01-nsg` → **Reglas de seguridad de entrada**, seleccione directamente `Allow-HTTP-Admin`.
2. Revise todos los campos del formulario existente, desplazándose hacia abajo si es necesario.

**Resultado comprobado:**

| Campo | Valor observado |
|---|---|
| Origen | IP Addresses |
| Intervalos de direcciones IP de origen y CIDR | Misma IPv4 administrativa autorizada en SSH, con `/32` |
| Intervalos de puertos de origen | `*` |
| Destino | Any |
| Servicio | HTTP |
| Intervalos de puertos de destino | `80` |
| Protocolo | TCP |
| Acción | Permitir |
| Prioridad | `110` |
| Nombre | `Allow-HTTP-Admin` |
| Descripción | Permitir HTTP para pruebas administrativas |

El servicio predefinido **HTTP** fija el puerto TCP 80; por tanto, es equivalente a la selección Custom con esos parámetros. El origen coincide con la dirección IPv4 de `Allow-SSH-Admin` y está limitado a una dirección mediante `/32`. No se transcribe la dirección administrativa al manual. La regla autoriza el tráfico que cumple sus condiciones y no habilita HTTP para todo Internet. Se conserva SSH con su regla independiente y no se habilitan los puertos internos del Backend y MySQL.

3. Cierre el formulario sin guardar cambios: no se requiere ninguna corrección ni crear una segunda regla HTTP.

Antes de continuar, confirme todos los valores de la tabla. Realice las pruebas HTTP externas con Git Bash en Windows, sin conectarse mediante SSH y sin enviar credenciales ni tokens.


### 23.28 — Comprobar el acceso externo al Frontend

Abra una ventana independiente de **Git Bash en Windows, sin conectarse mediante SSH**. En la terminal local suele aparecer `MINGW64`; si aparece `azureuser@vm-alojamientos-g01`, está trabajando en Ubuntu y no en el computador administrador.

~~~bash
curl -I --max-time 15 http://alojamientos-g01.northcentralus.cloudapp.azure.com/
~~~

`curl -I` solicita los encabezados HTTP mediante HEAD; `--max-time 15` limita la duración de la prueba a 15 segundos. El dominio público debe dirigir al servidor de Azure y la regla `Allow-HTTP-Admin` debe permitir la conexión desde la IPv4 administrativa autorizada. **Resultado esperado:** `HTTP/1.1 200 OK` y `Content-Type: text/html`.

**Resultado comprobado desde Git Bash en Windows (15 de noviembre de 2026):**

~~~text
HTTP/1.1 200 OK
Server: nginx/1.30.6
Date: Sun, 15 Nov 2026 16:08:01 GMT
Content-Type: text/html
Content-Length: 396
Last-Modified: Sun, 15 Nov 2026 14:52:45 GMT
Connection: keep-alive
ETag: "6af9c73d-18c"
Accept-Ranges: bytes
~~~

El indicador `MINGW64` confirmó que la prueba se ejecutó en la terminal local de Windows. Se recibió una respuesta satisfactoria a través del dominio público y del puerto TCP 80 permitido por el NSG. El servidor y los encabezados de la página coinciden con la comprobación previa desde Ubuntu. La petición HEAD comprueba los encabezados de la página, no la ejecución del JavaScript del Frontend.

**Si no se obtiene la respuesta esperada:** compruebe que la terminal sea local de Windows (`MINGW64`), que la IPv4 pública actual del cliente coincida con la autorizada, que el DNS resuelva a la IP de la VM y que las reglas efectivas del NSG permitan TCP 80 desde ese origen. No amplíe la regla HTTP a todo Internet ni reinicie los contenedores sin identificar la causa. Continúe con 23.29 y 23.30 cuando obtenga HTTP 200. No envíe credenciales ni tokens por HTTP.


### 23.29 — Comprobar el acceso externo al Backend

Desde la misma ventana local de Git Bash en Windows, sin SSH, ejecute:

~~~bash
curl -i --max-time 15 http://alojamientos-g01.northcentralus.cloudapp.azure.com/health
~~~

`curl -i` muestra los encabezados y el cuerpo de la respuesta; `--max-time 15` limita la prueba a 15 segundos. La solicitud entra por el puerto 80 publicado de Nginx y la ubicación exacta `/health` la reenvía al Backend por la red interna de Docker. No se utiliza directamente el puerto 5000 desde Windows.

**Resultado comprobado (15 de noviembre de 2026):**

~~~text
HTTP/1.1 200 OK
Server: nginx/1.30.6
Date: Sun, 15 Nov 2026 16:08:50 GMT
Content-Type: application/json
Content-Length: 60
Connection: keep-alive
Access-Control-Allow-Origin: http://127.0.0.1:5500
Vary: Origin

{"service":"alojamientos-api","status":"ok","version":"v1"}
~~~

La respuesta confirma el acceso externo autorizado al endpoint de salud del Backend a través del proxy inverso, sin publicar Gunicorn directamente. El encabezado CORS conserva el origen de desarrollo, como se observó en 23.12; deberá revisarse para producción. La prueba no verifica por sí sola las consultas a MySQL.

### 23.30 — Comprobar el acceso externo a la API

Desde la misma ventana local de Git Bash en Windows, sin SSH, ejecute:

~~~bash
curl -i --max-time 15 http://alojamientos-g01.northcentralus.cloudapp.azure.com/api/v1/alojamientos
~~~

La solicitud GET consulta el listado de alojamientos sin crear ni modificar registros. Nginx conserva la ruta `/api/v1/alojamientos` al reenviarla a Flask. La respuesta debe ser JSON y no el HTML de la SPA.

**Resultado comprobado (15 de noviembre de 2026):**

~~~text
HTTP/1.1 200 OK
Server: nginx/1.30.6
Date: Sun, 15 Nov 2026 16:09:11 GMT
Content-Type: application/json
Content-Length: 62
Connection: keep-alive
Access-Control-Allow-Origin: http://127.0.0.1:5500
Vary: Origin

{"data":[],"message":"Lista de alojamientos.","success":true}
~~~

`success: true` y el código HTTP 200 indican que la consulta fue satisfactoria. El arreglo `data: []` indica que no se devolvieron alojamientos; no constituye un error. La prueba externa confirma el recorrido por el dominio público, NSG, puerto 80 de Nginx y API de Flask. Se complementa con la comprobación previa de SQLAlchemy y MySQL del Paso 21. No se considera aún probada la ejecución de JavaScript en un navegador ni las operaciones de autenticación y escritura.

### Resultado final del Paso 23

| Comprobación | Resultado comprobado |
|---|---|
| Configuración de proxy inverso | Nginx validado y montaje de solo lectura activo. |
| DNS interno de Docker | 127.0.0.11, utilizado para localizar el Backend. |
| Publicación HTTP | `0.0.0.0:80->80/tcp` únicamente en Frontend. |
| Acceso SSH | Regla `Allow-SSH-Admin`, TCP 22, IPv4 administrativa /32. |
| Acceso HTTP | Regla `Allow-HTTP-Admin`, TCP 80, misma IPv4 administrativa /32. |
| Frontend desde Windows | HTTP 200, HTML. |
| Endpoint `/health` desde Windows | HTTP 200, JSON y `status: ok`. |
| Endpoint `/api/v1/alojamientos` desde Windows | HTTP 200, JSON y `success: true`. |
| Backend y MySQL | Puertos 5000, 3306 y 33060 sin publicación directa al host. |

**Paso 23 completado:** las pruebas internas y externas previstas resultaron satisfactorias. El acceso HTTP está restringido a la IP administrativa autorizada; todavía no es una publicación abierta a cualquier usuario ni una conexión cifrada. No se deben realizar registros, inicios de sesión ni enviar tokens por HTTP. Quedan pendientes el certificado TLS, HTTPS, la redirección HTTP a HTTPS, la renovación del certificado, la revisión de CORS y las pruebas funcionales desde el navegador. El Paso 24 abordará HTTPS sin crear otra VM ni instalar un segundo servidor web.

---

# Anexo A — Pruebas funcionales y administración de usuarios del Sistema Alojamientos

**Objetivo:** comprobar el funcionamiento de la aplicación desplegada en Azure, registrar usuarios desde la interfaz gráfica, verificar la persistencia de la información en MySQL y asignar permisos administrativos mediante el script desarrollado en el Backend.

**Alcance:** esta actividad complementaria es exclusiva del Sistema Alojamientos, utilizado como proyecto de referencia. No constituye un nuevo paso de implementación de la infraestructura ni reemplaza las pruebas funcionales integrales previstas en el Anexo B. Cada equipo debe adaptar el procedimiento a las funcionalidades, los usuarios, las rutas y los mecanismos de administración de su propio proyecto. Los resultados de esta actividad se muestran como referencia; deben comprobarse en cada instalación.

## A.1 — Obtener la dirección de la aplicación en Azure

1. Ingrese al [Portal de Microsoft Azure](https://portal.azure.com).
2. En la barra de búsqueda, escriba **Máquinas virtuales** y abra el servicio.
3. Seleccione **vm-alojamientos-g01** (o la VM de su propio proyecto).
4. Abra **Información general** en el menú izquierdo.
5. En **Información esencial**, compruebe que el campo **Estado** indique **En ejecución**. Si la máquina está desasignada, iníciela únicamente durante la ventana de trabajo autorizada.
6. En la parte derecha de **Información esencial**, localice **Nombre DNS**, debajo de **Red virtual/subred**. No confunda el nombre DNS con la dirección IP pública de la NIC.
7. Pulse el icono de copiar situado a la derecha del **Nombre DNS**. El nombre de referencia es `alojamientos-g01.northcentralus.cloudapp.azure.com`.
8. Abra el navegador y utilice la dirección correspondiente a su VM. En el Sistema Alojamientos, la dirección HTTP comprobada en el Paso 23 es [http://alojamientos-g01.northcentralus.cloudapp.azure.com/](http://alojamientos-g01.northcentralus.cloudapp.azure.com/).

**Precaución de seguridad:** el Paso 23 deja HTTP restringido a la IPv4 administrativa autorizada y no configura HTTPS. La URL HTTP pública sirve para comprobar que la página carga, pero no se deben enviar contraseñas ni tokens a través de ella. Los registros e inicios de sesión de los apartados A.2, A.3 y A.11 deben realizarse por HTTPS cuando esté habilitado, o mediante un túnel SSH cifrado para este laboratorio. Si aún no dispone de HTTPS, abra una ventana independiente de Git Bash en Windows y ejecute:

~~~bash
ssh -i "$HOME/Downloads/vm-alojamientos-g01_key.pem" -N -L 127.0.0.1:8080:127.0.0.1:80 azureuser@135.232.189.196
~~~

`-N` mantiene la conexión para el reenvío de puertos sin iniciar una consola remota; `-L 127.0.0.1:8080:127.0.0.1:80` reenvía el puerto local 8080 al puerto 80 de la VM por SSH. El puerto local queda limitado a la interfaz de loopback. Mantenga esa ventana abierta y realice todas las pruebas de interfaz en [http://127.0.0.1:8080/](http://127.0.0.1:8080/). Aunque el navegador muestra HTTP local, el tramo entre el equipo y la VM está cifrado por SSH. Utilice su propia clave, usuario e IP autorizados. Si el puerto 8080 está ocupado, elija otro puerto local libre y adapte la URL del navegador. No es necesario abrir otro puerto en el NSG. Esta conexión sirve únicamente para las pruebas desde la interfaz; la sesión administrativa de consola se abrirá después, en A.4.

## A.2 — Registrar y probar el primer usuario

Desde la interfaz gráfica, abra el formulario de registro y cree un usuario convencional de laboratorio.

| Campo | Valor de referencia |
|---|---|
| Correo electrónico | `rodolfo@gmail.com` |
| Contraseña | Definida durante el registro; no se incluye en el manual. |
| Rol inicial | `usuario` (asignado por el Backend). |

Utilice cuentas de prueba autorizadas y contraseñas exclusivas del laboratorio. No utilice contraseñas de correo electrónico ni de otros servicios. Si la cuenta ya existe, no intente registrarla nuevamente: compruebe su identidad y utilice las credenciales autorizadas.

Inicie sesión con el primer usuario. Compruebe que puede consultar y actualizar el perfil, crear un alojamiento de prueba, consultarlo en la interfaz, modificarlo y eliminarlo conforme a sus permisos. Utilice únicamente datos de prueba y no elimine alojamientos de otros usuarios. Compruebe que las funciones administrativas no estén autorizadas para este usuario. Cierre sesión antes de registrar la segunda cuenta.

**Resultado esperado:** el usuario puede autenticarse y realizar las operaciones normales que tiene autorizadas, sin privilegios administrativos.

## A.3 — Registrar el usuario que será administrador

Regrese al formulario de registro y cree el segundo usuario mediante el mismo procedimiento.

| Campo | Valor de referencia |
|---|---|
| Correo electrónico | `admin@ejemplo.com` |
| Contraseña | Definida durante el registro; no se incluye en el manual. |
| Rol inicial | `usuario` (asignado por el Backend). |

Aunque el correo contenga la palabra `admin`, no otorga privilegios por sí mismo. El Backend registra la cuenta inicialmente como `usuario`; el cambio de rol se hará posteriormente mediante el script autorizado. Si la cuenta ya existe, no la registre otra vez. Antes de promoverla, compruebe en MySQL a qué usuario corresponde y qué rol tiene.

**Resultado esperado:** ambas cuentas están registradas; la nueva cuenta `admin@ejemplo.com` todavía tiene rol `usuario` si no fue promovida previamente.

## A.4 — Establecer la conexión SSH con Ubuntu

Una vez realizadas las operaciones iniciales desde la interfaz gráfica, abra una nueva ventana de **Git Bash en Windows** para la administración del servidor. Ejecute:

~~~bash
ssh -i "$HOME/Downloads/vm-alojamientos-g01_key.pem" azureuser@135.232.189.196
~~~

| Elemento | Explicación |
|---|---|
| `ssh` | Establece una conexión remota cifrada. |
| `-i` | Selecciona el archivo de clave privada para autenticar la conexión. |
| `$HOME/Downloads/` | Directorio local donde se encuentra la clave en el equipo de referencia. |
| `vm-alojamientos-g01_key.pem` | Archivo privado de la clave SSH descargada al crear la VM. |
| `azureuser` | Usuario autorizado para administrar Ubuntu. |
| `135.232.189.196` | IP pública de la VM de referencia. |

Cada equipo debe utilizar su propia clave, usuario e IP. No publique ni comparta la clave privada. Una vez que aparezca el indicador de Ubuntu, similar a `azureuser@vm-alojamientos-g01:~$`, los comandos siguientes se ejecutarán dentro del servidor, no en Windows. Mantenga la ventana del túnel de A.1 abierta si la necesita para continuar las pruebas de interfaz.

## A.5 — Ubicarse en el directorio del proyecto

Ejecute en la sesión SSH de Ubuntu:

~~~bash
cd "$HOME/alojamientos"
~~~

| Elemento | Explicación |
|---|---|
| `cd` | Cambia el directorio de trabajo actual. |
| `$HOME` | Directorio personal del usuario de Ubuntu; en este proyecto, `/home/azureuser`. |
| `alojamientos` | Directorio principal del proyecto desplegado. |

El directorio completo es `/home/azureuser/alojamientos`. Contiene `compose.yaml`, el archivo que define los servicios `frontend`, `backend` y `mysql`, así como los directorios de código y las configuraciones del despliegue. Ejecute los comandos de Docker Compose desde esta ruta para que se utilice la definición de servicios correcta.

Compruebe el estado de los contenedores:

~~~bash
sudo docker compose ps
~~~

`sudo` utiliza los permisos administrativos necesarios para operar Docker; `docker compose` administra los servicios definidos por el archivo Compose; `ps` consulta su estado y los puertos publicados. Compruebe que `frontend`, `backend` y `mysql` estén en ejecución (`Up`). No es necesario reconstruirlos ni reiniciarlos para consultar usuarios o cambiar un rol.

## A.6 — Ingresar a la base de datos MySQL

Desde el directorio del proyecto, ejecute:

~~~bash
sudo docker compose exec mysql sh -c 'MYSQL_PWD="$MYSQL_PASSWORD" mysql --user="$MYSQL_USER" --database="$MYSQL_DATABASE"'
~~~

| Elemento | Función |
|---|---|
| `sudo` | Ejecuta Docker con los permisos administrativos requeridos en Ubuntu. |
| `docker compose` | Administra los servicios definidos en `compose.yaml`. |
| `exec` | Ejecuta un comando en un contenedor existente y en funcionamiento. |
| Primer `mysql` | Nombre del servicio de base de datos en Docker Compose. |
| `sh -c` | Ejecuta la instrucción entre comillas simples mediante el intérprete de comandos dentro del contenedor. |
| `MYSQL_PWD="$MYSQL_PASSWORD"` | Proporciona al cliente MySQL la contraseña mediante la variable ya configurada en el contenedor, sin escribir su valor en la línea de comandos. |
| Segundo `mysql` | Programa cliente que establece la conexión con el servidor MySQL. |
| `--user="$MYSQL_USER"` | Selecciona el usuario de base de datos de la aplicación. |
| `--database="$MYSQL_DATABASE"` | Selecciona la base de datos configurada para la aplicación. |

Las comillas simples exteriores impiden que Ubuntu expanda esas variables antes de entrar al contenedor; las comillas dobles interiores conservan los valores correctamente al expandirlos dentro del contenedor. Se emplean las variables de entorno existentes, no las credenciales del usuario web. No imprima las variables ni el contenido de `.env`.

**¿Por qué se ingresa mediante Docker?** MySQL está instalado dentro de su propio contenedor y su puerto no se publica directamente a Internet. `docker compose exec` permite ejecutar su cliente sin instalar MySQL en Ubuntu ni abrir el puerto 3306. Se utiliza el usuario de aplicación configurado, no es necesario acceder como root de MySQL.

**Resultado esperado:** se muestra la bienvenida del cliente MySQL y el indicador `mysql>`. A partir de ese momento las instrucciones son SQL (o comandos del cliente), no comandos de Ubuntu.

## A.7 — Consultar los usuarios registrados

Compruebe primero la base de datos seleccionada:

~~~sql
SELECT DATABASE();
~~~

El resultado esperado es `alojamientos_db`.

Consulte ahora los usuarios:

~~~sql
SELECT id, correo, rol FROM usuarios ORDER BY id;
~~~

**Resultado esperado de referencia antes de promover el administrador:**

| id | correo | rol |
|---:|---|---|
| 1 | rodolfo@gmail.com | usuario |
| 2 | admin@ejemplo.com | usuario |

Los identificadores y la cantidad de usuarios pueden variar según los registros existentes. Si el administrador ya fue promovido, podrá aparecer directamente con rol `admin`; no es necesario repetir la modificación.

| Elemento | Función |
|---|---|
| `SELECT` | Consulta la información almacenada; no modifica registros. |
| `id` | Identificador único del usuario. |
| `correo` | Correo electrónico de la cuenta registrada. |
| `rol` | Nivel de autorización de la cuenta. |
| `FROM usuarios` | Indica que los datos provienen de la tabla `usuarios`. |
| `ORDER BY id` | Ordena los resultados de forma ascendente por identificador. |
| `;` | Finaliza la sentencia SQL. |

Se seleccionan únicamente los campos necesarios; no se consultan las contraseñas ni sus hashes. Identifique exactamente el correo del usuario autorizado que se convertirá en administrador. En el proyecto de referencia es `admin@ejemplo.com`. Si no aparece, compruebe el registro en la interfaz antes de continuar.

Salga de MySQL:

~~~sql
exit;
~~~

Compruebe que vuelve a aparecer el indicador de Ubuntu. La salida del cliente no detiene el contenedor ni el servidor MySQL.

## A.8 — Identificar el script para promover administradores

El Backend contiene el archivo `scripts/promover_admin.py`. Puede consultar su código en [GitHub — promover_admin.py](https://github.com/oflodororni/alojamientos-api/blob/main/scripts/promover_admin.py).

Con respecto al directorio principal del despliegue, el código fuente descargado está en `backend/scripts/promover_admin.py`. Dentro del contenedor Backend, el Dockerfile establece `/app` como directorio de trabajo y copia el código del repositorio. Por ello, la ruta relativa que utilizaremos dentro del contenedor es `scripts/promover_admin.py` (ruta absoluta `/app/scripts/promover_admin.py`).

El script recibe exactamente un argumento: el correo electrónico de un usuario existente. Crea la aplicación Flask mediante `crear_app()`, utiliza el contexto de la aplicación y su configuración, y llama a `UsuarioServicio.promover_a_admin()` para asignar el rol administrativo mediante la lógica de negocio del Backend. No crea una cuenta nueva ni utiliza el formulario público para conceder privilegios. Si el usuario no existe, informa el error y finaliza con un código distinto de cero.

## A.9 — Ejecutar el script dentro del contenedor Backend

Después de identificar el usuario y salir de MySQL, ejecute desde Ubuntu, en el directorio principal del proyecto:

~~~bash
sudo docker compose exec backend python scripts/promover_admin.py admin@ejemplo.com
~~~

| Elemento | Función |
|---|---|
| `sudo` | Proporciona los permisos requeridos para utilizar Docker en este servidor. |
| `docker compose` | Identifica y administra los servicios del proyecto. |
| `exec` | Ejecuta una instrucción en un contenedor existente, sin crear otro contenedor. |
| `backend` | Selecciona el servicio donde está instalada la aplicación Flask. |
| `python` | Ejecuta el intérprete de Python disponible dentro del contenedor. |
| `scripts/promover_admin.py` | Ruta relativa del script encargado de cambiar el rol del usuario. |
| `admin@ejemplo.com` | Argumento que identifica la cuenta previamente consultada y autorizada para recibir privilegios. |

**Resultado esperado:**

~~~text
Exito: el usuario 'admin@ejemplo.com' ahora tiene rol de administrador.
~~~

### ¿Por qué se ejecuta dentro de Docker?

El contenedor Backend ya dispone de Python, Flask, SQLAlchemy, las dependencias instaladas, el código fuente, las variables de entorno de la aplicación y conectividad con el servicio `mysql` en la red interna de Compose. Ejecutar el script allí permite utilizar exactamente el entorno de la aplicación desplegada y la base de datos correspondiente. El servicio de usuarios se encarga de la modificación persistente en MySQL. No se necesita instalar Python directamente en Ubuntu, reconstruir la imagen, reiniciar los contenedores ni ejecutar una sentencia `UPDATE` manual en la base de datos.

~~~mermaid
flowchart TD
    A[Consola SSH de Ubuntu] -->|docker compose exec backend| B[Contenedor Backend]
    B --> C[scripts/promover_admin.py]
    C --> D[UsuarioServicio.promover_a_admin]
    D -->|Actualiza el rol| E[Contenedor MySQL]
    E --> F[Tabla usuarios: usuario a admin]
~~~

**Importante:** conceda este rol únicamente a cuentas autorizadas. Si el script informa que el usuario no existe, compruebe la dirección consultada en A.7 antes de repetir el comando.

## A.10 — Verificar el cambio en la base de datos

Ingrese nuevamente al cliente MySQL desde Ubuntu:

~~~bash
sudo docker compose exec mysql sh -c 'MYSQL_PWD="$MYSQL_PASSWORD" mysql --user="$MYSQL_USER" --database="$MYSQL_DATABASE"'
~~~

Ejecute la misma consulta, una vez que aparezca `mysql>`:

~~~sql
SELECT id, correo, rol FROM usuarios ORDER BY id;
~~~

**Resultado esperado de referencia después de promover al administrador:**

| id | correo | rol |
|---:|---|---|
| 1 | rodolfo@gmail.com | usuario |
| 2 | admin@ejemplo.com | admin |

Compruebe que la cuenta seleccionada tiene el rol `admin` y que el rol del primer usuario permanece como `usuario`. Los demás registros existentes no deben modificarse como consecuencia de esta operación.

Salga de MySQL:

~~~sql
exit;
~~~

## A.11 — Comprobar las funcionalidades administrativas desde la interfaz

Regrese a la interfaz gráfica mediante la conexión segura indicada en A.1. Inicie sesión con `admin@ejemplo.com`. Si tenía una sesión iniciada con esa cuenta, ciérrela primero y vuelva a iniciar sesión para obtener un token JWT actualizado con el nuevo rol.

Compruebe las funciones administrativas implementadas en la aplicación, como la consulta de usuarios y la creación de comodidades, según las opciones disponibles en la interfaz. Compare los permisos con los de `rodolfo@gmail.com`. Compruebe que el usuario convencional no pueda realizar operaciones reservadas al administrador y que el usuario promovido sí pueda hacerlo. Utilice exclusivamente datos de prueba autorizados y cierre las sesiones cuando termine. Si utilizó un túnel SSH para el navegador, podrá cerrarlo con `Ctrl+C` en la ventana correspondiente después de finalizar las pruebas.

**Resultado esperado del Anexo A:** el sistema permite registrar usuarios desde la interfaz gráfica, consultar sus registros en MySQL, promover una cuenta existente a administrador utilizando el script del Backend, verificar la persistencia del cambio y comprobar las funcionalidades autorizadas para ambos roles.

**Nota:** los comandos, identificadores y salidas se han preparado para el Sistema Alojamientos; cada equipo debe comprobar los resultados reales de su propio despliegue. No se deben incluir contraseñas, hashes, tokens JWT ni claves privadas en evidencias o archivos compartidos. Esta actividad no certifica la implementación de HTTPS ni la ejecución de las demás actividades pendientes del Anexo B.

---

# Anexo B — Plan de actividades pendientes para completar la implementación y el mantenimiento

## Alcance y estado de la implementación

El procedimiento práctico de este manual finaliza en el **Paso 23 — Configurar el proxy inverso y la publicación web**. Los Pasos 1 al 23 contienen las instrucciones y comprobaciones de la implementación realizada en el Sistema Alojamientos. Este anexo conserva la planificación de las actividades que sería necesario desarrollar para completar la puesta en servicio segura, la integración funcional, la recuperación, la automatización del despliegue y el mantenimiento posterior.

**Carácter del anexo:** los Pasos 24 al 29 que se describen a continuación son actividades propuestas, no procedimientos ejecutados ni resultados verificados. Los comandos que aparecen son referencias de trabajo; las configuraciones completas, versiones, permisos, valores y resultados deberán confirmarse al ejecutar cada fase. No es necesario realizar estas actividades para reproducir los Pasos 1 al 23. No se deben presentar como implementadas en el servidor sin una comprobación real.

### Punto de partida

| Componente | Estado comprobado al finalizar el Paso 23 |
|---|---|
| Infraestructura | VM Ubuntu Server 24.04 LTS, Standard B2als_v2, 2 vCPU, 4 GiB de RAM y disco SSD estándar de 32 GiB. |
| Red | VNet, subred, NIC, IP pública estática y DNS de Azure configurados. |
| Administración | Acceso SSH limitado a la IPv4 administrativa autorizada mediante `Allow-SSH-Admin`. Encendido y apagado programados configurados; su ejecución efectiva debe verificarse. |
| Aplicaciones | MySQL 8.4, Backend Flask/Gunicorn y Frontend Vite/Nginx desplegados mediante Docker Compose en `/home/azureuser/alojamientos`. |
| Datos | Volumen externo `alojamientos_mysql_data` montado; migraciones aplicadas hasta `ebb9cbe49179 (head)` y seis tablas verificadas. |
| Proxy inverso | Nginx sirve el Frontend y reenvía `/api/` y `/health` hacia `backend:5000`; configuración de producción montada en modo de solo lectura. |
| Acceso web | HTTP TCP 80 publicado únicamente por el Frontend y permitido en Azure desde la IPv4 administrativa (`Allow-HTTP-Admin`). Las consultas `/`, `/health` y `/api/v1/alojamientos` devolvieron HTTP 200 desde Windows. |
| Seguridad pendiente | HTTPS, renovación de certificados, revisión de CORS de desarrollo y pruebas de autenticación y autorización; no enviar contraseñas ni tokens por HTTP. |
| Operación pendiente | Pruebas funcionales desde el navegador, respaldos externos y restauración, CD, mantenimiento y comprobación final. |

La arquitectura propuesta mantendrá una sola VM, los tres servicios actuales, la red interna de Docker y el volumen persistente. Se reutilizarán el dominio `alojamientos-g01.northcentralus.cloudapp.azure.com`, el NSG `vm-alojamientos-g01-nsg` y las configuraciones existentes. En otro proyecto deben adaptarse los nombres, rutas, IP, dominio y repositorios a los recursos propios. No se contratarán servicios adicionales de pago sin evaluar su necesidad y costo.

### Orden de las actividades pendientes

| Paso propuesto | Actividad | Condición para considerarlo terminado |
|---|---|---|
| 24 | Configurar HTTPS con Let's Encrypt | Certificado confiable, redirección, acceso HTTPS y renovación comprobada. |
| 25 | Realizar pruebas funcionales de integración | Operaciones reales verificadas desde el navegador y permisos comprobados. |
| 26 | Configurar copias de seguridad y recuperación | Respaldos protegidos fuera de la VM y restauración aislada satisfactoria. |
| 27 | Implementar CI/CD con GitHub Actions y Azure | Una revisión validada se despliega de manera controlada y recuperable. |
| 28 | Configurar el mantenimiento de la infraestructura | Controles periódicos definidos, comprobados y documentados. |
| 29 | Realizar la verificación final de la infraestructura | Evidencias de funcionamiento, seguridad, costos y limitaciones consolidadas. |

Se planifican las copias de seguridad antes de automatizar despliegues, para contar con un mecanismo de recuperación. Si antes del Paso 26 ya existen datos importantes, se debe realizar un respaldo adecuado antes de cualquier prueba que los modifique o de cualquier cambio de infraestructura que pueda afectarlos. Los horarios de inicio y apagado del laboratorio (10:00 a 11:30 a. m., hora de Bogotá) condicionan las pruebas, las renovaciones y las tareas automáticas.

## B.1 — Paso 24 propuesto: configurar HTTPS con Let's Encrypt

### Objetivo

Publicar el sistema mediante **HTTPS (Hypertext Transfer Protocol Secure)**, utilizando TLS para cifrar el tráfico entre el navegador y Nginx, autenticar el servidor mediante un certificado confiable y proteger la integridad de las comunicaciones. Let's Encrypt será la autoridad certificadora y Certbot el cliente ACME encargado de solicitar y renovar certificados. El método previsto es **HTTP-01 con webroot**: Certbot escribirá un archivo de validación en un directorio compartido con Nginx y la autoridad certificadora lo consultará mediante HTTP TCP 80. Se reutilizará el servidor web existente, sin instalar otro Nginx en Ubuntu.

### Actividades previstas, en orden

| Apartado | Actividad | Procedimiento previsto y comprobación |
|---|---|---|
| 24.1 | Comprobar si Certbot está instalado | En la sesión SSH de Ubuntu, ejecutar `certbot --version`. Si no existe, continuar con la selección del método de instalación; si existe, identificar cómo está instalado antes de duplicarlo. |
| 24.2 | Consultar disponibilidad | Ejecutar `apt-cache policy certbot`; revisar versión candidata y repositorios. Comparar con las instrucciones oficiales para Ubuntu 24.04 y escoger un único método de instalación mantenible. |
| 24.3 | Instalar Certbot | Actualizar el catálogo de paquetes si corresponde e instalar Certbot conforme al método elegido. No instalar el complemento de Nginx para modificar automáticamente un servidor que se encuentra dentro de Docker; se utilizará el autenticador webroot. |
| 24.4 | Verificar la instalación | Consultar `certbot --version` y la ayuda de `certbot certonly`. Comprobar si existe un servicio o temporizador de renovación asociado a la instalación. |
| 24.5 | Respaldar las configuraciones | Desde `/home/azureuser/alojamientos`, crear copias con fecha de `compose.yaml` y `nginx/default.conf`, comprobar su existencia y conservarlas para una reversión. No sobrescribir el `.env` ni el volumen de MySQL. |
| 24.6 | Preparar la validación ACME | Crear un directorio en Ubuntu, por ejemplo `/var/www/certbot`, y el subdirectorio `.well-known/acme-challenge`. Asegurar que Certbot pueda escribir y Nginx leer los archivos de validación. No guardar secretos en ese directorio público. |
| 24.7 | Preparar Nginx para HTTP-01 | Incorporar una ubicación específica `/.well-known/acme-challenge/`, con el directorio webroot y entrega de archivos existentes. Antes de ampliar la regla HTTP a Internet, hacer que el resto de rutas devuelvan temporalmente un aviso de indisponibilidad, sin entregar la aplicación ni reenviar credenciales por HTTP. No configurar aún referencias a certificados inexistentes. |
| 24.8 | Compartir el webroot con el contenedor | Añadir al servicio `frontend` un montaje de solo lectura del directorio de validación. Conservar el archivo de configuración de Nginx montado, las dependencias, el puerto 80 y las definiciones de Backend y MySQL. |
| 24.9 | Validar y aplicar la preparación | Ejecutar `sudo docker compose config --quiet` y probar `nginx -t` en un contenedor temporal. Si ambas comprobaciones son correctas, recrear solo el Frontend con `--no-build --no-deps --force-recreate`. Verificar la ruta ACME mediante un archivo de prueba y HTTP local. No ampliar el NSG si Nginx aún entrega la aplicación por HTTP a cualquier cliente autorizado. |
| 24.10 | Habilitar HTTP para validación pública | En Azure, agregar una regla TCP 80 con origen etiqueta de servicio Internet (por ejemplo `Allow-HTTP`, prioridad libre). Mantener SSH limitado a la IPv4 administrativa. Comprobar la regla nueva y retirar la regla HTTP administrativa redundante únicamente cuando corresponda. No abrir los puertos 5000, 3306 ni 33060. |
| 24.11 | Comprobar el archivo de prueba desde fuera | Desde una ventana local de Git Bash en Windows **sin sesión SSH**, consultar el dominio y la ruta del archivo ACME. Verificar HTTP 200 y el contenido esperado; comprobar que las demás rutas no entreguen la aplicación sin cifrado. La prueba administrativa no demuestra por sí sola alcance desde toda Internet: revisar el NSG y la validación de la autoridad certificadora. Eliminar el archivo de prueba al finalizar. |
| 24.12 | Solicitar el certificado | Ejecutar Certbot con `certonly --webroot`, la ruta preparada y el dominio real. Leer y aceptar las condiciones de Let's Encrypt si corresponde e indicar un contacto autorizado cuando se solicite. Evitar solicitudes repetidas innecesarias; revisar el DNS, la accesibilidad y los posibles límites de emisión si el proceso no es satisfactorio. |
| 24.13 | Verificar el certificado | Consultar `sudo certbot certificates`; confirmar que el dominio coincide, revisar las fechas de vigencia y las rutas de certificado (`fullchain.pem`) y clave privada (`privkey.pem`). No mostrar ni copiar el contenido de la clave privada a la consola, al manual o a GitHub. |
| 24.14 | Configurar TLS en Nginx | Preparar un bloque HTTPS con `listen 443 ssl`, el dominio, el certificado y la clave, TLS 1.2/1.3, archivos estáticos de Vite y las rutas de proxy `/api/` y `/health`. Mantener el prefijo de API y los encabezados de proxy. En el bloque HTTP, conservar la excepción ACME y hacer que el resto redirija al dominio HTTPS fijo. |
| 24.15 | Configurar Docker Compose para HTTPS | Publicar TCP 443 solo en Frontend, por ejemplo `0.0.0.0:443:443`. Montar las rutas pertinentes de certificados de Certbot en modo de solo lectura. Los archivos de `live` suelen ser enlaces a `archive`: conservar las rutas necesarias para que sigan resolviéndose después de renovar, sin exponer las claves de cuenta ACME ni otorgar permisos públicos a las claves privadas. |
| 24.16 | Validar y aplicar HTTPS | Validar Compose y la sintaxis de Nginx antes de sustituir el contenedor. Recrear únicamente Frontend; comprobar estado, puertos y montaje. Desde Ubuntu comprobar la respuesta HTTPS local utilizando el nombre real del dominio para verificar el certificado. Ante una validación fallida, detener el cambio y recuperar la configuración segura anterior. |
| 24.17 | Habilitar HTTPS en Azure | Preparar una regla `Allow-HTTPS` para TCP 443, con prioridad libre. Inicialmente limitarla a la IP administrativa para verificar TLS y revisar CORS y acceso a los datos en el Paso 25. Ampliarla a Internet solo tras completar las verificaciones de seguridad previstas. No modificar el alcance de SSH ni abrir directamente Backend o MySQL. |
| 24.18 | Comprobar la redirección HTTP | Desde Git Bash local, consultar los encabezados HTTP del dominio. Comprobar un código de redirección 301 o 308 y `Location` hacia HTTPS, conservando la ruta y los parámetros que correspondan. Verificar que la excepción ACME sigue funcionando. No establecer una redirección general que impida validar nuevos certificados. |
| 24.19 | Comprobar las respuestas HTTPS | Desde Windows, consultar `/`, `/health` y `/api/v1/alojamientos` por HTTPS sin deshabilitar la validación de certificados. Confirmar HTML, JSON y HTTP 200 según corresponda. Verificar en el navegador que el certificado sea confiable, coincida con el dominio y no haya contenido mixto. La ejecución de operaciones de negocio se verifica en el Paso 25. |
| 24.20 | Preparar la renovación automática | Revisar la programación de Certbot y adecuarla a la ventana de funcionamiento de la VM. Configurar un deploy hook que valide y recargue Nginx únicamente después de una renovación exitosa, utilizando rutas absolutas y el Compose correcto. La recarga debe leer los archivos renovados mediante los montajes persistentes. |
| 24.21 | Probar la renovación | Ejecutar `sudo certbot renew --dry-run` durante una ventana en que el servidor esté accesible. Revisar los registros, comprobar independientemente la recarga o utilizar la opción de prueba del hook si la versión instalada la admite. Verificar que las renovaciones no dependan de un momento en que la VM esté desasignada. |

### Comandos de referencia para las comprobaciones

Los comandos que consultan el software y los servicios locales se ejecutarán dentro de Ubuntu mediante SSH. Por ejemplo:

~~~bash
certbot --version
apt-cache policy certbot
sudo certbot certificates
sudo certbot renew --dry-run
~~~

La solicitud del certificado, solo después de completar la preparación y la validación HTTP, tendrá una forma semejante a:

~~~bash
sudo certbot certonly --webroot -w /var/www/certbot -d alojamientos-g01.northcentralus.cloudapp.azure.com
~~~

`certonly` solicita el certificado sin reescribir automáticamente la configuración de Nginx; `--webroot` utiliza los archivos servidos por HTTP; `-w` selecciona el directorio y `-d` el dominio. El comando definitivo dependerá de la versión instalada y la configuración comprobada.

Las comprobaciones externas se realizarán desde Git Bash local en Windows, sin SSH. Después de configurar TLS y autorizar el acceso administrativo HTTPS:

~~~bash
curl -I --max-time 15 http://alojamientos-g01.northcentralus.cloudapp.azure.com/
curl -I --max-time 15 https://alojamientos-g01.northcentralus.cloudapp.azure.com/
curl -i --max-time 15 https://alojamientos-g01.northcentralus.cloudapp.azure.com/health
curl -i --max-time 15 https://alojamientos-g01.northcentralus.cloudapp.azure.com/api/v1/alojamientos
~~~

No utilizar `curl -k` para declarar válido el certificado. Un resultado exitoso de `/health` demuestra que el servicio responde, pero no todas las operaciones de negocio. Conservar el puerto 80 exclusivamente para redirección y validación ACME.

**Resultado esperado del Paso 24:** acceso seguro por HTTPS con certificado confiable y renovación comprobada, sin publicación directa de los puertos de Gunicorn ni MySQL. La apertura definitiva del acceso HTTPS desde Internet se autorizará tras las comprobaciones de seguridad del Paso 25.

Referencias para desarrollar este paso: [Certbot](https://certbot.eff.org/), [documentación de Certbot](https://eff-certbot.readthedocs.io/en/stable/using.html), [tipos de validación de Let's Encrypt](https://letsencrypt.org/docs/challenge-types/), [configuración HTTPS de Nginx](https://nginx.org/en/docs/http/configuring_https_servers.html).

## B.2 — Paso 25 propuesto: realizar pruebas funcionales de integración

### Objetivo

Demostrar que el sistema publicado funciona de extremo a extremo: el navegador carga el Frontend, el JavaScript envía solicitudes a la API mediante el proxy inverso, Flask aplica las reglas de negocio y MySQL conserva los datos. Las pruebas deben utilizar HTTPS, usuarios y registros de laboratorio, sin mostrar contraseñas ni tokens. Se revisará la implementación real antes de determinar los campos, permisos y respuestas de cada operación. No se asumirán funcionalidades que no existan en el proyecto.

### Actividades previstas, en orden

| Apartado | Actividad | Procedimiento previsto y comprobación |
|---|---|---|
| 25.1 | Abrir el dominio HTTPS | Desde el computador administrador, abrir el dominio en un navegador y comprobar el certificado y la ausencia de advertencias TLS. Mantener el acceso restringido mientras se realizan las pruebas iniciales. |
| 25.2 | Verificar recursos estáticos | Abrir las herramientas de desarrollador (F12), pestaña Network o Red; recargar la página y comprobar que HTML, CSS, JavaScript e imágenes se descarguen correctamente. Revisar errores 404 y contenido mixto. |
| 25.3 | Revisar la consola del navegador | Consultar Console o Consola y verificar que no haya errores JavaScript que impidan cargar o utilizar la aplicación. No copiar valores sensibles que aparezcan en las herramientas de desarrollo. |
| 25.4 | Revisar las solicitudes a la API | Filtrar Fetch/XHR en Network. Identificar URL, método, estado HTTP y estructura general de respuesta. La API debe utilizar `/api/v1` en el mismo origen HTTPS del Frontend, no `localhost:5000` ni el nombre interno `backend`. |
| 25.5 | Revisar CORS y configuración de seguridad | Examinar `CORS_ALLOWED_ORIGINS` en el código del Backend y la configuración de Compose; el Paso 23 mostró el origen de desarrollo `http://127.0.0.1:5500`. Para el despliegue del mismo origen, retirar ese origen de desarrollo si no es necesario y configurar únicamente los orígenes autorizados conforme al comportamiento real de Flask-CORS. Validar los cambios y recrear solo el Backend si corresponde; CORS no sustituye la autenticación. Revisar también que no se entreguen secretos ni páginas de depuración. |
| 25.6 | Comprobar la consulta inicial | Abrir la lista de alojamientos y comprobar la solicitud GET a la API. Una lista vacía es válida si la base no tiene registros. Confirmar que la interfaz interpreta correctamente el JSON. |
| 25.7 | Probar el registro de usuarios | Revisar las reglas del registro y crear desde el formulario un usuario de prueba con datos ficticios y contraseña segura. Comprobar los campos obligatorios, la respuesta y el mensaje de éxito. No registrar datos personales de terceros. |
| 25.8 | Verificar el registro en MySQL | Dentro de Ubuntu, consultar las tablas `usuarios` y `perfiles` con el usuario de aplicación utilizando únicamente campos no sensibles o conteos. Confirmar que la operación persistió los datos y verificar el mecanismo de hash de contraseña en el código; no mostrar contraseñas, hashes ni datos privados. |
| 25.9 | Probar autenticación | Iniciar sesión con el usuario de laboratorio y comprobar la respuesta de la API y el estado de la interfaz. Verificar también que credenciales incorrectas se rechacen de manera adecuada. |
| 25.10 | Comprobar autorización JWT | Verificar que las peticiones protegidas incluyen la cabecera de autenticación prevista sin exponer el valor del token. Probar una petición sin autenticación o con token inválido; debe rechazarse según las reglas del Backend. |
| 25.11 | Probar el perfil | Consultar el perfil, actualizar los campos permitidos y volver a consultarlos. Comprobar que solo se permite modificar la información autorizada y que los cambios permanecen al recargar. |
| 25.12 | Preparar el usuario administrador | Inspeccionar los modelos, validadores y scripts del repositorio Backend para identificar el procedimiento autorizado de creación o asignación de permisos. No inventar credenciales, campos o roles ni habilitar privilegios por medio del registro público. |
| 25.13 | Probar la creación de alojamientos | Con un usuario autorizado, introducir un alojamiento ficticio mediante el formulario existente o la solicitud API documentada. Verificar validaciones, respuesta y persistencia en MySQL. |
| 25.14 | Probar la consulta de alojamientos | Comprobar el listado y, si está implementada en el Frontend, la vista de detalle. Contrastar el identificador y los datos mostrados con la respuesta de la API. |
| 25.15 | Probar la actualización | Modificar un campo admitido del alojamiento de prueba. Consultar de nuevo el registro y comprobar la persistencia de los valores actualizados. |
| 25.16 | Probar las comodidades | Revisar los permisos para crear y consultar comodidades, crear registros de prueba y asociarlos a un alojamiento mediante las operaciones existentes. Verificar la relación en la interfaz, en la API y mediante consultas de solo lectura. |
| 25.17 | Probar la eliminación | Con la autorización correspondiente, eliminar únicamente un alojamiento creado para el laboratorio. Confirmar que deja de aparecer y que el tratamiento de sus relaciones coincide con las reglas de negocio. No eliminar registros reales ni tablas. |
| 25.18 | Comprobar restricciones de acceso | Con un usuario ordinario, intentar operaciones que el código reserve a administradores y comprobar el rechazo sin cambios en los datos. Probar las rutas protegidas y el acceso a recursos ajenos conforme a sus permisos. Si existen vulnerabilidades, resolverlas antes de publicar la aplicación a todo Internet. |
| 25.19 | Comprobar persistencia | Conservar un registro de prueba e identificar el volumen montado; recrear controladamente un contenedor de aplicación, sin eliminar MySQL ni el volumen, y volver a comprobar el registro. Esta prueba no equivale a una restauración de respaldo. No utilizar `docker compose down -v` ni `docker volume rm`. |
| 25.20 | Consolidar los resultados y autorizar publicación | Registrar operaciones, datos de prueba, resultados esperados y obtenidos, sin secretos. Si TLS, autorización, CORS y exposición de puertos son correctos, habilitar el TCP 443 con origen Internet en el NSG y repetir las consultas desde un cliente externo autorizado para la prueba. Mantener SSH limitado y verificar que HTTP solo redirija o valide ACME. |

### Rutas de referencia del Backend

El Paso 21 identificó las siguientes rutas de aplicación. Se revisarán los controladores y esquemas reales para conocer los parámetros, errores y permisos; la existencia de una ruta no demuestra su funcionamiento ni que tenga una interfaz visual implementada.

| Método | Ruta | Operación a comprobar |
|---|---|---|
| GET | `/health` | Disponibilidad del servicio HTTP. |
| POST | `/api/v1/usuarios/registro` | Registro de usuario. |
| POST | `/api/v1/usuarios/login` | Autenticación. |
| GET / PATCH | `/api/v1/usuarios/perfil` | Consulta y actualización del perfil propio. |
| GET | `/api/v1/admin/usuarios` | Consulta administrativa de usuarios. |
| GET / POST | `/api/v1/alojamientos` | Listado y creación. |
| GET / PATCH / DELETE | `/api/v1/alojamientos/<int:alojamiento_id>` | Detalle, actualización y eliminación. |
| PATCH | `/api/v1/alojamientos/<int:alojamiento_id>/comodidades` | Asociación de comodidades. |
| GET / POST | `/api/v1/comodidades` | Listado y creación de comodidades. |
| GET | `/api/v1/comodidades/<int:comodidad_id>` | Consulta de detalle de comodidad. |

### Registro de pruebas

Para cada caso de prueba documentar: identificador, requisito, usuario o rol de prueba, precondición, datos ficticios utilizados, operación, solicitud HTTP, resultado esperado, resultado real y estado (satisfactorio, no satisfactorio o pendiente). Si una funcionalidad no existe en el Frontend, identificarla como prueba API, sin afirmar que se ejecutó desde una pantalla inexistente. Controlar tanto los casos exitosos como las validaciones y restricciones.

**Resultado esperado del Paso 25:** integración verificada mediante operaciones reales, autorización comprobada, comunicación cifrada y persistencia demostrada. El sistema podrá publicarse al alcance autorizado una vez que la seguridad y la disponibilidad lo permitan.

## B.3 — Paso 26 propuesto: configurar copias de seguridad y recuperación

### Objetivo

Proteger la información frente a pérdida del disco, errores de operación, fallos de actualización o eliminación accidental de recursos. El volumen `alojamientos_mysql_data` conserva los datos cuando se recrea un contenedor, pero no protege ante la pérdida de la VM o de su disco. Se propone una copia lógica de MySQL mediante `mysqldump`, respaldos de configuración, una copia externa protegida y una restauración de prueba independiente. La estrategia debe definir cuánto dato sería aceptable perder (RPO) y cuánto tiempo sería aceptable tardar en recuperar el servicio (RTO), según las necesidades del proyecto.

### Actividades previstas, en orden

| Apartado | Actividad | Procedimiento previsto y comprobación |
|---|---|---|
| 26.1 | Definir el alcance del respaldo | Inventariar `alojamientos_db`, Compose, `.env`, Nginx, certificados y su recuperación, versiones de Git e imágenes y scripts de administración. Determinar periodicidad, retención, responsables, RPO y RTO. |
| 26.2 | Comprobar el espacio disponible | Consultar `df -h /` y `sudo docker system df`. Estimar espacio para exportación, compresión y restauración temporal sin saturar el disco de 32 GiB. Si no hay capacidad suficiente, no iniciar una restauración local. |
| 26.3 | Crear un directorio privado | Preparar una ruta como `$HOME/alojamientos/backups`, separada de ambos repositorios y del directorio público de Nginx. Organizar respaldos por fecha y tipo. |
| 26.4 | Proteger los permisos | Establecer permisos `700` para el directorio y `600` para los archivos que contengan datos o secretos; utilizar `umask 077` al generarlos. Verificar permisos y propietario. |
| 26.5 | Comprobar la herramienta de exportación | Desde la carpeta del proyecto, consultar `sudo docker compose exec -T mysql mysqldump --version`. Revisar los permisos requeridos por el usuario de respaldo y el motor de las tablas. No transmitir contraseñas en parámetros literales ni mostrarlas mediante `docker compose config`. |
| 26.6 | Generar el respaldo lógico | Ejecutar `mysqldump` dentro del contenedor con las credenciales protegidas, exportando el esquema y los datos de `alojamientos_db`. Para tablas InnoDB, evaluar `--single-transaction --quick` y `--no-tablespaces` según permisos; impedir migraciones y cambios de esquema durante la exportación. Incluir los objetos necesarios (por ejemplo, triggers, rutinas o eventos si existen). Escribir primero en un archivo temporal y conservarlo como respaldo válido solo si la operación termina correctamente. |
| 26.7 | Comprobar el archivo generado | Revisar el código de salida de la exportación, su tamaño y permisos. Un archivo existente o de tamaño mayor que cero no prueba por sí solo que se completó el respaldo. Eliminar o identificar archivos parciales; no imprimir el SQL con datos personales. |
| 26.8 | Comprimir la copia | Utilizar `gzip` sobre el respaldo exitoso o una canalización controlada. En una canalización, comprobar el fallo de cualquiera de sus comandos (por ejemplo, mediante `pipefail` en Bash). Mantener acceso restringido al archivo comprimido. |
| 26.9 | Comprobar integridad | Verificar el archivo comprimido con `gzip -t` y generar una suma SHA-256 mediante `sha256sum`. Conservar la suma de verificación junto a la copia. Estas pruebas complementan, pero no sustituyen, una restauración. |
| 26.10 | Respaldar configuración y versiones | Conservar `compose.yaml`, `.env`, `nginx/default.conf` y los futuros scripts de respaldo/despliegue. Registrar los commits de Frontend y Backend, las referencias de las imágenes efectivamente utilizadas y las instrucciones para recuperar o reemitir certificados. Las copias con secretos y claves privadas deben cifrarse; no almacenar credenciales en GitHub. |
| 26.11 | Crear una copia externa | Transferir el respaldo cifrado a un almacenamiento autorizado fuera del disco de la VM, por ejemplo un equipo administrativo protegido mediante SCP/SFTP y almacenamiento cifrado. Verificar la copia y su checksum en el destino. Si se elige almacenamiento de Azure, evaluar precio, acceso, retención y recuperación antes de contratarlo. |
| 26.12 | Preparar una restauración aislada | Crear un MySQL temporal de versión compatible, con nombre de contenedor, proyecto y volumen diferentes de producción, sin publicar puertos y sin compartir el volumen original. Verificar recursos libres y credenciales de prueba. |
| 26.13 | Importar el respaldo | Descomprimir y restaurar el SQL solo en el entorno temporal. Confirmar explícitamente el nombre del destino y sus montajes antes de ejecutar la importación; nunca restaurar sobre producción como prueba. Verificar el resultado y los errores. |
| 26.14 | Comprobar la recuperación | Comparar listado de tablas, revisión de `alembic_version` y cantidades de registros con los valores registrados en el momento del respaldo. Realizar consultas de lectura y, si procede, probar una aplicación de laboratorio conectada al entorno restaurado. Registrar el tiempo de restauración. Eliminar solamente los recursos temporales identificados una vez concluida la comprobación. |
| 26.15 | Automatizar la generación | Crear un script con fecha, directorio protegido, bloqueo para evitar ejecuciones simultáneas, control de errores, verificación de integridad y mensajes sin secretos. No reiniciar MySQL ni modificar datos para respaldarlos. Automatizar también la transferencia externa si existe un destino autorizado. |
| 26.16 | Programar los respaldos | Configurar un servicio y temporizador de systemd o una alternativa equivalente, durante la ventana de encendido de la VM. Contemplar las ejecuciones omitidas mientras esté desasignada; comprobar el horario real de Ubuntu y que MySQL esté listo. Ejecutar una prueba manual y verificar una ejecución programada real. |
| 26.17 | Establecer la retención | Definir cuántas copias conservar en la VM y fuera de ella, según capacidad y RPO. Revisar los archivos candidatos antes de eliminar copias vencidas; conservar al menos una copia verificada y evitar borrar respaldos si falló el más reciente. |
| 26.18 | Documentar el procedimiento de recuperación | Definir cómo reconstruir la VM, instalar Docker, recuperar configuración y versiones, crear el volumen, restaurar MySQL, comprobar migraciones, iniciar los servicios y recuperar HTTPS. Especificar quién autoriza restaurar producción y cómo validar los datos antes de habilitar nuevamente el acceso. |

### Elementos de la estrategia de respaldo

| Elemento | Método previsto y precaución |
|---|---|
| Datos de MySQL | Exportación SQL consistente, comprimida, con verificación y prueba de restauración. |
| Configuración de producción | Copias de Compose y Nginx; conservar la versión correspondiente a la aplicación. |
| Credenciales y claves | `.env` y materiales de recuperación cifrados, con acceso limitado. No publicar ni utilizar los repositorios como copia de secretos. |
| Código y compilaciones | Registrar los identificadores de commit y de las imágenes, y conservar las versiones necesarias para regresar a un despliegue anterior. |
| TLS | Proteger la configuración y materiales necesarios de Certbot o documentar el proceso de reemisión. |
| Copia externa | Almacenamiento independiente de la VM, con control de acceso y comprobación periódica de que puede recuperarse. |

La primera restauración será un ensayo que no afecte los datos originales. La recuperación real requerirá una ventana de mantenimiento y una decisión explícita sobre el momento al que se recuperará la información. No utilizar `docker compose down -v`, `docker volume prune` ni borrar el volumen de producción como parte de un ensayo.

**Resultado esperado del Paso 26:** respaldo manual y automatizado, verificación de integridad, copia externa protegida, retención determinada y restauración de prueba satisfactoria. En la etapa inicial se pretende evitar el costo adicional de Azure Backup, siempre que exista un destino externo seguro que cumpla los requisitos.

Referencias: [MySQL: mysqldump](https://dev.mysql.com/doc/refman/8.4/en/mysqldump.html), [volúmenes de Docker](https://docs.docker.com/engine/storage/volumes/).

## B.4 — Paso 27 propuesto: implementar CI/CD con GitHub Actions y Azure

### Objetivo

Integrar la validación automatizada del código con la publicación controlada de nuevas versiones del Sistema Alojamientos. Se revisará la integración continua ya desarrollada en los repositorios, sin sustituirla innecesariamente. Se implementará un mecanismo de despliegue que preserve la configuración de producción y los datos de MySQL.

| Concepto | Significado en este proyecto |
|---|---|
| CI (Continuous Integration) | Integración continua: comprobar automáticamente los cambios, las pruebas y la construcción del código. |
| CD (Continuous Delivery) | Entrega continua: dejar una revisión validada lista para desplegarla mediante una autorización controlada. |
| CD (Continuous Deployment) | Despliegue continuo: publicar automáticamente las revisiones autorizadas que satisfagan las condiciones de calidad y operación. |

### Estrategia técnica propuesta

La opción preferida será autenticar GitHub Actions en Azure mediante **OpenID Connect (OIDC)** y utilizar **Azure Run Command** para invocar en la VM un procedimiento de despliegue controlado. OIDC permite obtener credenciales temporales sin guardar un secreto permanente de Azure en GitHub. Run Command puede ejecutar instrucciones con privilegios administrativos en Ubuntu mediante el agente de Azure; por eso debe limitarse estrictamente el alcance de identidad, permisos y workflows. No se debe ampliar SSH a los rangos de Internet de los runners.

Esta alternativa depende de los permisos disponibles en Microsoft Entra ID y la suscripción Azure for Students, de la disponibilidad de entornos y protecciones en GitHub, y de la capacidad del agente de la VM. Si no se dispone de los permisos necesarios, mantener CI y un despliegue manual controlado, hasta seleccionar y verificar una alternativa segura. No asignar Owner, Contributor a toda la suscripción ni utilizar claves administrativas permanentes para resolver una limitación sin analizar el alcance requerido.

### Actividades previstas, en orden

| Apartado | Actividad | Procedimiento previsto y comprobación |
|---|---|---|
| 27.1 | Revisar CI existente | Examinar `.github/workflows/` en `alojamientos-api` y `alojamientos-frontend`. Identificar eventos, ramas, pruebas, herramientas, versiones y resultados de las ejecuciones existentes. Distinguir qué se ejecuta realmente de lo que solo está declarado. |
| 27.2 | Comprobar las validaciones del Backend | Revisar instalación de dependencias, pruebas de Flask y configuración del entorno de pruebas. Confirmar que CI no altere la base de producción ni utilice sus credenciales. Determinar las condiciones mínimas para autorizar una nueva versión. |
| 27.3 | Comprobar las validaciones del Frontend | Revisar `npm ci`, pruebas y compilación Vite, incluyendo la configuración de `VITE_API_URL`. Verificar que el código de producción pueda construirse con la base relativa `/api/v1`. |
| 27.4 | Definir la estrategia de publicación | Establecer ramas autorizadas, revisión de cambios y condición de CI satisfactoria. Utilizar el identificador exacto del commit verificado, no un `git pull` indiscriminado de una rama que pueda haber avanzado después de las pruebas. |
| 27.5 | Preparar el entorno de producción en GitHub | Configurar el entorno `production` en cada repositorio según las funciones disponibles. Restringir las ramas admitidas y proteger los workflows; aplicar aprobación cuando esté disponible. Excluir cambios no confiables, forks y pull requests sin autorización de los jobs administrativos. |
| 27.6 | Preparar la identidad federada | Comprobar permisos para registrar una aplicación o identidad compatible en Microsoft Entra y configurar credenciales federadas para cada repositorio/entorno autorizado. Vincular emisor, audiencia y sujeto correctos; no crear federaciones genéricas que admitan ramas o repositorios arbitrarios. |
| 27.7 | Configurar RBAC | Determinar las operaciones mínimas necesarias de lectura de estado y ejecución de Run Command; limitar la asignación a la VM y comprobar qué operaciones admite el rol. Reconocer que ejecutar comandos administrativos equivale a un permiso muy sensible. No conceder permisos de modificación sobre recursos ajenos al despliegue. |
| 27.8 | Configurar parámetros y autenticación | Registrar los identificadores de tenant, suscripción, cliente, grupo de recursos, VM y parámetros no sensibles en las variables o configuración autorizada de GitHub. Configurar `azure/login` mediante OIDC y permisos mínimos del workflow (`id-token: write` en el job que lo requiera). Mantener `.env` únicamente en el servidor y los secretos de producción fuera de los registros. |
| 27.9 | Probar conexión GitHub–Azure | Ejecutar un workflow controlado que se autentique, consulte la VM y su estado y, si está autorizado, ejecute una comprobación de solo lectura mediante Run Command. Verificar que el agente de Azure esté disponible. No iniciar, detener ni cambiar la VM como parte de esta primera prueba. |
| 27.10 | Crear el procedimiento local de actualización | Preparar un script con rutas absolutas y propietario/permisos controlados. Recibir únicamente parámetros validados (servicio permitido y commit exacto). Comprobar estado del repositorio, registrar versión actual, obtener el commit autorizado, construir y activar el servicio. Run Command puede ejecutarse como root: preservar la propiedad de los repositorios de `azureuser` y no ampliar privilegios del código no confiable. |
| 27.11 | Controlar despliegues simultáneos | Configurar concurrencia en GitHub y un bloqueo común en la VM, por ejemplo `flock`, que coordine ambos repositorios y las tareas que modifican la infraestructura. La concurrencia de un repositorio no impide por sí sola ejecuciones del otro. Coordinar respaldos y migraciones. |
| 27.12 | Preparar las migraciones | Identificar si el Backend nuevo incorpora revisiones de Alembic. Verificar respaldo y compatibilidad del esquema con las versiones anterior y nueva. Definir ventana y orden para aplicar migraciones, evitando que un Backend activo incompatible acceda a tablas modificadas. No ejecutar migraciones a ciegas ni suponer que revertir la imagen revierte el esquema. |
| 27.13 | Configurar CD del Backend | Vincular el job de despliegue con la CI que valida el mismo commit. Construir y desplegar únicamente Backend, usando las credenciales persistentes del servidor. Aplicar migraciones cuando corresponda según el procedimiento anterior, verificar `/health` y una consulta real a MySQL. Mantener Frontend y MySQL salvo acciones planificadas. |
| 27.14 | Configurar CD del Frontend | Vincular la publicación al commit autorizado, construir Vite con `VITE_API_URL=/api/v1` y recrear únicamente Frontend. Conservar montajes Nginx, webroot y TLS; comprobar sintaxis, HTTPS y entrega de los archivos estáticos. |
| 27.15 | Ejecutar despliegues de prueba | Comenzar con ejecución manual (`workflow_dispatch`) dentro del horario de laboratorio y con una revisión explícita ya validada. Comprobar cada servicio por separado y revisar el resultado del comando remoto. No reportar éxito si solo se confirmó el inicio del comando. |
| 27.16 | Incorporar pruebas posteriores | Realizar comprobaciones con tiempos de espera y reintentos limitados: contenedores activos, HTTPS con validación TLS, `/health`, endpoint de negocio de lectura y estado de migraciones cuando corresponda. Validar también desde el exterior durante el ensayo; no confiar únicamente en los registros. |
| 27.17 | Preparar recuperación de versiones | Conservar commits e imágenes de aplicación anteriores con etiquetas o identificadores inmutables; no perderlos por sobrescribir una etiqueta `latest` o por una limpieza de Docker. Diseñar y ensayar una reversión de aplicación. Si se modificó el esquema, determinar recuperación compatible y evitar restaurar datos por encima de cambios nuevos sin autorización. |
| 27.18 | Automatizar publicación autorizada | Después de ensayar el proceso de entrega, definir el disparador de CD (por ejemplo, una revisión de `main` cuya CI haya sido satisfactoria). Comprobar el estado de la VM, respetar el apagado programado y disponer de tiempo suficiente para terminar. Si está desasignada, registrar el despliegue pendiente y reanudarlo de forma controlada durante la ventana de trabajo, sin encenderla automáticamente fuera del presupuesto. |
| 27.19 | Verificar el ciclo completo | Realizar un cambio controlado en cada repositorio, comprobar CI y desplegar la revisión correspondiente. Confirmar funcionalidad, versión desplegada y ausencia de cambios en los datos que debían conservarse. Probar que un fallo de CI impida ejecutar CD. |
| 27.20 | Consolidar historial y operación | Registrar commit, imagen, fecha, responsable o workflow, estado de respaldo, migraciones, pruebas y resultado de cada despliegue. Documentar el método manual de emergencia y los pasos para revocar las credenciales federadas si dejan de necesitarse. |

### Flujo previsto de una publicación

~~~text
Cambio autorizado en GitHub
  -> CI: pruebas y construcción de la revisión
  -> ¿CI satisfactoria? No: detener el despliegue
  -> Sí: verificar autorización, commit y disponibilidad de la VM
  -> autenticación OIDC en Azure
  -> Run Command: ejecutar procedimiento local con bloqueo
  -> identificar versión anterior y comprobar respaldo si corresponde
  -> construir imagen y aplicar migraciones cuando proceda
  -> recrear el servicio seleccionado
  -> verificar estado, HTTPS, API y datos
  -> éxito: registrar revisión desplegada
  -> fallo: detener y aplicar la recuperación aprobada
~~~

El workflow del Backend puede necesitar respaldo y migraciones; el del Frontend no debe aplicar migraciones. Ambos conservan las configuraciones externas a los repositorios. Con un único contenedor por servicio, una recreación puede causar una interrupción breve: no se garantiza un despliegue sin interrupciones ni alta disponibilidad.

**Resultado esperado del Paso 27:** integración continua verificada y un mecanismo de entrega/despliegue controlado que permita publicar versiones autorizadas sin abrir SSH globalmente, con trazabilidad, control de concurrencia y recuperación ensayada. La automatización completa queda condicionada a los permisos y horarios realmente disponibles.

Referencias: [GitHub Actions: OpenID Connect en Azure](https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-azure), [Microsoft Learn: Run Command para VM Linux](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/run-command), [Docker Compose up](https://docs.docker.com/reference/cli/docker/compose/up/).

## B.5 — Paso 28 propuesto: configurar el mantenimiento de la infraestructura

### Objetivo

Establecer las tareas que permitan conservar Ubuntu, Docker, las aplicaciones, los datos y los certificados en condiciones de operación seguras. Supervisar la capacidad de la VM de 2 vCPU y 4 GiB, el disco de 32 GiB y el presupuesto mensual de 10 USD. Evitar tareas que dupliquen servicios o eliminen datos necesarios para recuperación.

### Actividades previstas, en orden

| Apartado | Actividad | Procedimiento previsto y comprobación |
|---|---|---|
| 28.1 | Comprobar estado de Azure | Revisar en el portal la suscripción, grupo `rg-alojamientos-g01`, estado de la VM y recursos asociados. Confirmar el estado tras encendido y desasignación; no confundir cerrar SSH con apagar el servidor. |
| 28.2 | Supervisar CPU y créditos | En Métricas de Azure, consultar porcentaje de CPU y créditos de CPU de la serie B cuando estén disponibles. Correlacionar picos con compilaciones, pruebas o respaldos. Evaluar contención antes de ampliar el tamaño de VM. |
| 28.3 | Supervisar memoria RAM | Ejecutar `free -h` en Ubuntu. Interpretar la memoria disponible y el uso de swap si existe, no únicamente el valor libre. Revisar posibles terminaciones por falta de memoria. |
| 28.4 | Supervisar almacenamiento | Consultar `df -h /` y `sudo docker system df`. Identificar crecimiento de imágenes, registros, respaldos y datos de MySQL; no modificar directamente `/var/lib/docker`. Definir alertas o acciones según capacidad observada. |
| 28.5 | Supervisar los contenedores | Desde `$HOME/alojamientos`, ejecutar `sudo docker compose ps` y `sudo docker stats --no-stream`. Revisar estado, reinicios, CPU y memoria. Confirmar que MySQL y Backend siguen sin puertos publicados. |
| 28.6 | Consultar registros de Nginx | Usar `sudo docker compose logs --tail 50 frontend`. Revisar códigos HTTP, errores de proxy y TLS. Relacionar los eventos con solicitudes y comprobar que no se registren secretos. |
| 28.7 | Consultar registros del Backend | Usar `sudo docker compose logs --tail 50 backend`. Identificar arranque de Gunicorn, errores de aplicación, problemas de base de datos y fallos de autenticación. No compartir registros que incluyan tokens o datos personales. |
| 28.8 | Consultar registros de MySQL | Usar `sudo docker compose logs --tail 50 mysql`. Revisar inicialización, disponibilidad, errores y advertencias relevantes; complementar con consultas SQL de solo lectura cuando corresponda. |
| 28.9 | Controlar tamaño de registros | Revisar el controlador de logs efectivo de Docker. Definir límites y rotación por servicio mediante Compose, o la configuración apropiada del motor; conservar suficiente historial para diagnóstico. Validar los cambios y aplicar en una ventana controlada, pues suelen afectar a contenedores recreados. |
| 28.10 | Actualizar Ubuntu | Ejecutar `sudo apt update`, consultar `apt list --upgradable` y revisar antes de `sudo apt upgrade`. Comprobar necesidad de reinicio, siguiendo el Paso 17. Asegurar respaldos y una ventana de mantenimiento; no utilizar `do-release-upgrade` sin una planificación específica. |
| 28.11 | Actualizar Docker | Revisar versiones del motor, Compose y sus complementos, los cambios publicados y compatibilidad. Actualizar paquetes de forma planificada desde el repositorio configurado y volver a comprobar los tres servicios. Un reinicio del motor puede afectar a toda la aplicación. |
| 28.12 | Actualizar el código de aplicaciones | Utilizar el procedimiento validado del Paso 27. Verificar CI, revisión exacta, respaldo, migraciones y pruebas posteriores. No actualizar directamente los repositorios con cambios locales sin examinarlos. |
| 28.13 | Actualizar imágenes y dependencias | Evaluar actualizaciones de Python, Node.js, Nginx y MySQL, además de dependencias Python y JavaScript. Registrar versiones y probar compatibilidad. Las actualizaciones de MySQL requieren especial revisión de la ruta de actualización, respaldo y recuperación; evitar cambios de versión mayor no planificados. |
| 28.14 | Administrar imágenes no utilizadas | Identificar imágenes y capas que ya no estén en uso. Confirmar que no sean necesarias para recuperación ni estén referenciadas por contenedores. Eliminar únicamente recursos identificados y autorizados, sin limpiar volúmenes de MySQL ni eliminar indiscriminadamente imágenes. |
| 28.15 | Revisar certificados TLS | Consultar `sudo certbot certificates`, revisar temporizadores, últimos intentos de renovación y fechas de vencimiento. Verificar desde el exterior el certificado que Nginx realmente está entregando. Si la VM estuvo desasignada, comprobar que la renovación se pueda ejecutar en su horario. |
| 28.16 | Revisar respaldos | Comprobar la última copia satisfactoria, suma SHA-256, retención y existencia externa. Verificar periódicamente una restauración aislada y el tiempo que tarda. Un archivo comprimido no es prueba suficiente de recuperación. |
| 28.17 | Revisar acceso administrativo | Comprobar SSH, permisos de `.env`, montajes, reglas de entrada y accesos a GitHub y Azure. Revisar identidades y roles federados, revocar accesos que ya no se necesiten y comprobar que no se abrió SSH, Gunicorn o MySQL a Internet. |
| 28.18 | Revisar los costos reales | Consultar Administración de costos, consumo y créditos de Azure for Students. Comparar los cargos de VM, disco, IP, transferencias y Logic Apps con el presupuesto del Paso 4. Ajustar la planificación, no interpretar el presupuesto como un límite que apaga automáticamente la VM. |
| 28.19 | Comprobar automatización de encendido y apagado | Revisar el historial de Logic Apps y los estados de la VM a las horas configuradas. Confirmar en el servidor los temporizadores de respaldos y renovación; las tareas deben ejecutarse dentro de la ventana real de funcionamiento. |
| 28.20 | Establecer la rutina operativa | Asignar frecuencia, responsable y criterio de aceptación a cada comprobación. Registrar incidentes reales, acciones correctivas y verificaciones de recuperación en una bitácora operativa separada del procedimiento de implementación. |

### Comandos de consulta de referencia

Ejecutar dentro de la sesión SSH de Ubuntu. Para las operaciones de Compose, ubicarse en el directorio del proyecto:

~~~bash
cd "$HOME/alojamientos"
free -h
df -h /
sudo docker system df
sudo docker compose ps
sudo docker stats --no-stream
sudo docker compose logs --tail 50 frontend
sudo docker compose logs --tail 50 backend
sudo docker compose logs --tail 50 mysql
~~~

`free -h` presenta información de memoria; `df -h /` consulta el sistema de archivos raíz; `docker system df` resume el uso de almacenamiento administrado por Docker; `stats --no-stream` ofrece una captura del consumo de los contenedores sin dejar la consola en actualización continua; `logs --tail 50` limita la consulta a las últimas 50 líneas de cada servicio. Las consultas anteriores no recrean ni eliminan contenedores. Examinar las salidas sin divulgar información sensible.

### Periodicidad inicial propuesta

| Frecuencia | Actividades |
|---|---|
| Diaria, dentro del horario operativo | Comprobar disponibilidad, estado de contenedores, resultado del respaldo y posibles alertas de costos. |
| Semanal | Revisar registros, memoria, CPU y almacenamiento; consultar las actualizaciones pendientes y comprobar las copias externas. |
| Mensual | Revisar costos, crédito, permisos, dependencias, certificados, recursos innecesarios y capacidad de recuperación mediante un ensayo periódico. |
| Antes de cada despliegue o mantenimiento | Verificar versiones, recursos libres, ventana de trabajo, respaldo recuperable y procedimiento de reversión. |
| Después de cada cambio | Comprobar servicios, HTTPS, endpoints y persistencia; registrar el cambio y su resultado. |

La periodicidad final dependerá de la criticidad del sistema y de la ventana de operación. La VM única y el horario limitado corresponden al laboratorio; no constituyen una infraestructura redundante ni garantizan servicio las 24 horas.

**Resultado esperado del Paso 28:** procedimiento de operación y mantenimiento comprobado, con indicadores revisados, actualizaciones controladas, diagnóstico mediante registros y seguimiento del presupuesto. Evitar la limpieza destructiva automática de Docker.

## B.6 — Paso 29 propuesto: realizar la verificación final de la infraestructura

### Objetivo

Consolidar la evidencia de todos los componentes de infraestructura y las actividades de seguridad, funcionalidad, recuperación y operación. Esta fase no consiste en reinstalar los servicios, sino en verificar los requisitos técnicos y documentar el estado final. Se utilizarán consultas no destructivas y los resultados de los ensayos ejecutados en los pasos anteriores. Los elementos no verificados se identificarán expresamente como pendientes.

### Actividades previstas, en orden

| Apartado | Comprobación | Evidencia y criterio previsto |
|---|---|---|
| 29.1 | Suscripción y presupuesto | Azure for Students activa, crédito vigente, presupuesto y alertas del Paso 4 consultados. |
| 29.2 | Inventario de recursos | Grupo de recursos, VM, disco, NIC, VNet, IP, NSG, clave pública y recursos de automatización identificados. No mantener recursos adicionales sin justificar su uso. |
| 29.3 | Máquina virtual | Comprobar estado, Ubuntu 24.04 LTS, tamaño Standard B2als_v2, disco y recursos disponibles, comparándolos con la configuración prevista. |
| 29.4 | Red virtual | Revisar VNet, subred, IP privada y asociación de NIC, NSG e IP pública. Confirmar que corresponden al proyecto. |
| 29.5 | IP y DNS | Verificar en Azure la IP estática y el FQDN. Desde Git Bash en Windows, sin SSH, consultar `nslookup alojamientos-g01.northcentralus.cloudapp.azure.com` y comparar la resolución con la IP propia. |
| 29.6 | Reglas de seguridad | Revisar reglas efectivas del NSG. SSH TCP 22 limitado a una IPv4 autorizada; HTTP TCP 80 para redirección y ACME; HTTPS TCP 443 según la publicación autorizada. Backend TCP 5000 y MySQL TCP 3306/33060 sin asignación pública directa. |
| 29.7 | Acceso administrativo | Verificar la conexión SSH mediante la clave privada protegida. No compartir la clave ni crear accesos globales para la verificación. |
| 29.8 | Docker y Compose | Comprobar `docker --version`, `docker compose version`, `sudo systemctl is-active docker`, `sudo docker compose config --quiet`, `sudo docker compose ps` e imágenes. No mostrar Compose expandido con credenciales. |
| 29.9 | Base de datos | Verificar el volumen externo y su montaje, el usuario de aplicación, las tablas y `flask db current` frente a `flask db heads`. No reaplicar migraciones como parte de una comprobación de lectura. |
| 29.10 | Backend | Confirmar Gunicorn, rutas registradas, respuesta `/health` y consulta de lectura desde SQLAlchemy a MySQL. Distinguir salud HTTP de acceso real a la base. |
| 29.11 | Frontend | Comprobar archivos compilados de Vite, carga del navegador, recursos estáticos y solicitudes Fetch/XHR al mismo origen HTTPS. |
| 29.12 | Nginx y proxy | Ejecutar `nginx -t` dentro del contenedor Frontend, revisar montajes de solo lectura y comprobar el enrutamiento de `/api/` y `/health`. |
| 29.13 | HTTPS | Verificar certificado, dominio, vigencia, redirección de HTTP y resultado de renovación de prueba. Comprobar sin omitir la validación TLS. |
| 29.14 | Integración funcional | Consultar el registro de pruebas del Paso 25 y ejecutar una prueba representativa desde el navegador, con datos de laboratorio. Verificar autenticación, permisos y persistencia. |
| 29.15 | Recuperación | Confirmar el respaldo más reciente y su copia externa, integridad y evidencia de restauración aislada. Revisar que el método esté documentado. |
| 29.16 | CI/CD | Consultar GitHub Actions, CI, ejecución de CD, commit e imagen desplegados, verificaciones posteriores y evidencia de recuperación. Si la automatización está limitada por permisos, registrar el método realmente implementado y lo pendiente. |
| 29.17 | Seguridad | Comprobar permisos de archivos, ausencia de secretos publicados, credenciales federadas y reglas de acceso. Revisar configuración de CORS, autorización de API y archivos TLS protegidos. |
| 29.18 | Automatización operativa | Revisar evidencia de ejecución de encendido y apagado programados, respaldos y renovación; no dar por comprobada una tarea solo por existir su configuración. |
| 29.19 | Control de costos | Comparar el consumo real con la estimación inicial y el presupuesto mensual. Identificar cargos aun con la VM desasignada y documentar diferencias. |
| 29.20 | Arquitectura definitiva | Actualizar el diagrama con los recursos, servicios, puertos, redes, montajes, flujos de CI/CD, respaldos y componentes realmente implementados. Distinguir los que permanezcan como propuesta. |
| 29.21 | Conclusiones y cierre | Consolidar los resultados comprobados, las limitaciones, las actividades pendientes y las recomendaciones de operación. Indicar el alcance real de la implementación y las condiciones de entrega. |

### Arquitectura objetivo para la implementación completa

~~~text
Usuarios / navegador web
           |
           | HTTPS TCP 443 (HTTP TCP 80: redirección y ACME)
           v
IP pública estática + DNS de Azure
           |
NSG: SSH TCP 22 restringido / HTTP y HTTPS según autorización
           |
+----------------------------------------------------------------+
| VM Ubuntu Server 24.04 LTS                                      |
|                                                                |
| Docker Compose: red interna alojamientos_default               |
|                                                                |
|  Nginx + Frontend Vite                                         |
|      |                                                         |
|      | Proxy /api/ y /health -> Backend Flask/Gunicorn TCP 5000  |
|      |                              |                          |
|      |                              v                          |
|      |                      MySQL 8.4 TCP 3306                |
|      |                              |                          |
|      |                      alojamientos_mysql_data            |
|      |                                                         |
| Certbot: certificados y renovación                            |
| Scripts de respaldo y mantenimiento + temporizadores           |
+----------------------------------------------------------------+
    ^                                          |
    | Despliegue controlado                    | Copia cifrada
    |                                          v
GitHub Actions -> Azure (OIDC / Run Command)   Almacenamiento externo
~~~

La arquitectura objetivo incorpora HTTPS, respaldos y despliegue automatizado, que todavía no se han verificado en el Paso 23. El diagrama definitivo se ajustará a lo que efectivamente se ejecute, especialmente si existen restricciones de Azure for Students o del entorno GitHub. La aplicación seguirá dependiendo de una única VM y su disponibilidad estará condicionada a su horario de funcionamiento.

### Lista final de verificación del anexo

| Estado al terminar el Paso 23 | Comprobación |
|---|---|
| Comprobado | Infraestructura base, DNS y acceso SSH administrativo. |
| Comprobado | MySQL con volumen persistente, Backend con migraciones y conexión a la base de datos. |
| Comprobado | Frontend desplegado, Nginx y proxy inverso, acceso HTTP desde el computador autorizado. |
| Pendiente | HTTPS, certificado y renovación. |
| Pendiente | Pruebas funcionales desde el navegador y revisión de autorización y CORS. |
| Pendiente | Publicación HTTPS desde Internet, después de las verificaciones de seguridad. |
| Pendiente | Copias de seguridad protegidas y restauración comprobada. |
| Pendiente | CI/CD de Azure, recuperación de versiones y despliegue automatizado. |
| Pendiente | Procedimientos periódicos de mantenimiento y comprobación real de las automatizaciones. |
| Pendiente | Verificación final, costos reales, arquitectura y cierre de la implementación completa. |

**Cierre del anexo:** el manual práctico conserva los Pasos 1 al 23 como procedimientos desarrollados. Este anexo documenta de forma anticipada las fases 24 a 29, sus objetivos, las actividades en secuencia, las precauciones y los criterios de comprobación. No certifica su ejecución ni reemplaza una guía práctica validada de esas fases.
