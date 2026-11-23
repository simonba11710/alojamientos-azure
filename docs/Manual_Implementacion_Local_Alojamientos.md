# Manual de implementación local — Sistema Alojamientos

## Paso 1 — Verificar Git y Git Bash

**Qué se hace y por qué:** Git permite obtener y versionar el código. Git Bash es la terminal en la que se ejecutan los comandos de este manual; comprobarla evita usar por error PowerShell o el Bash de WSL, que interpretan de forma distinta rutas y argumentos.

1. En Visual Studio Code, abrir la terminal integrada **Git Bash**.
2. Ejecutar:
   ```bash
   git --version
   printf 'Intérprete Bash: %s\n' "$BASH_VERSION"
   ```
3. Confirmar que la terminal seleccionada en VS Code sea **Git Bash**, no PowerShell ni la terminal Ubuntu/WSL. Si al escribir `bash` Windows abre WSL, elegir el perfil Git Bash de VS Code en lugar de depender de ese comando.
4. Si Git no está instalado o Git Bash no está disponible, instalar **Git para Windows** desde <https://git-scm.com/downloads/win>, reiniciar VS Code y repetir la comprobación.

**Cómo interpretar las instrucciones y los comandos:** `git --version` verifica Git; `$BASH_VERSION` muestra la versión del intérprete Bash. Si el segundo dato está vacío, no está ejecutando el intérprete esperado.

**Si no se obtiene el resultado esperado:** Si `git` no existe, instalar Git para Windows; si la versión de Bash no aparece, seleccionar Git Bash en VS Code y repetir antes de continuar.

**Resultado esperado:** aparece `git version ...` en Git Bash. No volver a instalar Git si ya funciona.

## Paso 2 — Verificar e instalar WSL 2

**Qué se hace y por qué:** WSL 2 aporta el entorno Linux sobre el que trabaja Docker Desktop en Windows. Se verifica antes de instalar o actualizar para evitar cambios innecesarios, reinicios y solicitudes de permisos administrativos.

1. En Git Bash, ejecutar:
   ```bash
   wsl.exe --version
   wsl.exe --status
   ```
2. Verificar que WSL esté instalado y actualizado. Docker Desktop con motor WSL 2 requiere WSL **2.1.5 o posterior**.
3. **Solo si WSL no está instalado**, abrir Git Bash con permisos de administrador y ejecutar:
   ```bash
   wsl.exe --install --no-distribution
   ```
   Reiniciar Windows cuando se solicite. No es necesario instalar una distribución Ubuntu para utilizar Docker desde Git Bash.
4. **Si WSL está instalado, pero es antiguo**, ejecutar:
   ```bash
   wsl.exe --update
   ```
5. **Si el valor predeterminado no es la versión 2**, ejecutar:
   ```bash
   wsl.exe --set-default-version 2
   ```
6. Repetir `wsl.exe --version` y `wsl.exe --status`.

**Cómo interpretar las instrucciones y los comandos:** `wsl.exe --version` comprueba componentes instalados; `wsl.exe --status` informa el estado y la versión predeterminada. Los comandos `--install`, `--update` y `--set-default-version` **modifican Windows** y solo se ejecutan en las condiciones que indica el paso.

**Si no se obtiene el resultado esperado:** Si Windows solicita administrador o reinicio, completar esa intervención y repetir la comprobación; no asumir que el cambio quedó aplicado antes del reinicio.

**Resultado esperado:** WSL está disponible con una versión compatible y el motor de virtualización de Windows habilitado. Si Windows indica que la virtualización no está disponible, resolver ese requisito antes de continuar.

## Paso 3 — Verificar e instalar Docker Desktop

**Qué se hace y por qué:** Docker Desktop administra los contenedores desde Windows. Que el comando `docker` exista no garantiza que el motor esté iniciado; por eso también se abre la aplicación y se comprueba después su conexión.

1. En Git Bash, ejecutar:
   ```bash
   docker --version
   ```
2. Si muestra su versión, **no reinstalarlo**. Abrir Docker Desktop.
3. Si no está instalado, descargar **Docker Desktop para Windows** en <https://www.docker.com/products/docker-desktop/>, instalarlo con la opción de motor **WSL 2** y reiniciar si se solicita.
4. En Docker Desktop, comprobar **Settings > General > Use WSL 2 based engine** cuando aparezca esa opción. En algunas instalaciones se habilita de manera automática.

**Cómo interpretar las instrucciones y los comandos:** `docker --version` comprueba que existe el cliente. La disponibilidad real del servidor se verifica con `docker info` en el Paso 4.

**Si no se obtiene el resultado esperado:** Si existe el cliente pero Docker Desktop no abre o muestra error, resolver el arranque antes de avanzar al Paso 4.

**Resultado esperado:** Docker Desktop está instalado, iniciado y configurado para ejecutar contenedores Linux.

## Paso 4 — Verificar Docker y Docker Compose

**Qué se hace y por qué:** Se comprueban dos componentes diferentes: el motor Docker, encargado de ejecutar contenedores, y Docker Compose, que coordina los servicios MySQL, Flask y Nginx descritos en un único archivo.

1. Con Docker Desktop iniciado, ejecutar:
   ```bash
   docker info --format 'ServerVersion={{.ServerVersion}} OSType={{.OSType}} OperatingSystem={{.OperatingSystem}}'
   docker compose version
   ```
2. La primera orden debe mostrar información del **Server** con `OSType=linux` y `docker compose version` debe mostrar una versión.
3. Si aparece un error de conexión, iniciar Docker Desktop, comprobar que el motor está en funcionamiento y repetir los comandos.

**Cómo interpretar las instrucciones y los comandos:** `docker info --format ...` consulta el motor y muestra solo los campos necesarios; `docker compose version` verifica el complemento de orquestación. La salida `OSType=linux` es necesaria para las imágenes del proyecto.

**Si no se obtiene el resultado esperado:** Si `docker info` informa que no puede conectar al daemon, revisar Docker Desktop y el motor Linux; no continuar únicamente porque `docker --version` funcione.

**Resultado esperado:** motor Docker y Compose operativos.

## Paso 5 — Crear la carpeta de trabajo

**Qué se hace y por qué:** La carpeta raíz reúne los dos repositorios y los archivos compartidos `compose.yaml` y `.env`. Verificar el contenido y los permisos evita sobrescribir trabajo anterior o ejecutar órdenes en otro directorio.

1. En Git Bash, ejecutar:
   ```bash
   mkdir -p /c/AlojamientosEmpresa
   cd /c/AlojamientosEmpresa
   pwd
   ls -la
   test -w . && echo 'La carpeta permite escritura'
   ```
2. Revisar el contenido mostrado por `ls -la` antes de crear archivos: **no sobrescribir** manuales, configuraciones, carpetas ni datos que ya existan.
3. Si la ruta elegida no tiene permisos de escritura, utilizar otra carpeta con permisos y mantener esa misma ubicación durante todos los pasos siguientes.

**Cómo interpretar las instrucciones y los comandos:** `mkdir -p` crea la carpeta si falta y no borra una existente; `cd` cambia de directorio; `pwd` imprime la ubicación real; `ls -la` muestra archivos, incluso ocultos; `test -w .` verifica permisos de escritura.

**Si no se obtiene el resultado esperado:** Si la carpeta contiene archivos previos, revisarlos en `ls -la`. No utilizar `rm -rf` ni cambiar de ubicación sin actualizar los pasos siguientes.

**Resultado esperado:** `pwd` muestra `/c/AlojamientosEmpresa`. El comando crea la carpeta si falta y la conserva si ya existe.

## Paso 6 — Clonar el backend oficial

**Qué se hace y por qué:** El backend se obtiene directamente de `https://github.com/oflodororni/api-alojamientos.git`, que contiene el código fuente de la API Flask. Clonarlo conserva la estructura y el historial Git que la aplicación necesita; no se descargan ZIP ni se altera el código fuente remoto.

1. En Git Bash, ejecutar:
   ```bash
   cd /c/AlojamientosEmpresa
   if [ -e backend ]; then
     echo 'backend ya existe; no se sobrescribirá.'
   else
     git clone https://github.com/oflodororni/api-alojamientos.git backend
   fi
   ```
2. Si aparece el mensaje de que la carpeta existe, no borrarla: el paso 7 permite verificar el origen de su contenido.

**Cómo interpretar las instrucciones y los comandos:** `[ -e backend ]` comprueba si el destino ya existe; `git clone URL backend` descarga la fuente con su historial. Si la carpeta ya existe, no significa que sea correcta: hay que completar el Paso 7.

**Si no se obtiene el resultado esperado:** Si falla el clon, comprobar acceso a GitHub y conectividad; si `backend` ya existe, comprobar su contenido en el Paso 7.

**Resultado esperado:** existe una carpeta `backend` obtenida de GitHub o se ha identificado una carpeta existente que requiere revisión.

## Paso 7 — Confirmar el origen y el estado del backend

**Qué se hace y por qué:** Antes de editar, se comprueba que la copia proviene del repositorio esperado, que se usa la rama correcta y que no hay cambios previos sin revisar. El SHA permite identificar exactamente la versión recibida.

1. En Git Bash, ejecutar:
   ```bash
   cd /c/AlojamientosEmpresa/backend
   git remote -v
   git branch --show-current
   git status --short
   git rev-parse HEAD
   ```
2. Registrar el SHA mostrado por `git rev-parse HEAD`: identifica la versión exacta del código fuente que se está implementando y permite compararla posteriormente.
3. La URL de `origin` debe ser `https://github.com/oflodororni/api-alojamientos.git` y la rama habitual debe ser `main`.
4. Si `origin` es diferente, aparece `not a git repository` o existen cambios locales desconocidos, detenerse y revisar la carpeta. **No cambiar el remoto ni eliminar archivos automáticamente.**

**Cómo interpretar las instrucciones y los comandos:** `git remote -v` muestra las direcciones remotas; `git branch --show-current` identifica la rama; `git status --short` revela cambios locales; `git rev-parse HEAD` devuelve el identificador exacto del commit actual.

**Si no se obtiene el resultado esperado:** Si el remoto es inesperado o `git status` muestra cambios desconocidos, detenerse y conservar los archivos antes de proceder.

**Resultado esperado:** el backend corresponde al repositorio oficial y se conoce su estado local.

## Paso 8 — Comprobar y configurar la identidad de Git

**Qué se hace y por qué:** Git incorpora nombre y correo a la autoría de cada commit; esto es distinto de iniciar sesión en GitHub. Se deben utilizar el nombre y correo de quien realizará los commits y configurarlos únicamente en la copia local del backend.

1. En Git Bash, dentro de `backend`, comprobar si hay identidad definida:
   ```bash
   git config --get user.name
   git config --get user.email
   ```
2. Si falta alguno de los datos, definir el **nombre y correo de la persona que creará los commits**. Sustituir los marcadores siguientes por los valores reales y configurarlos exclusivamente en este repositorio:
   ```bash
   git config --local user.name "NOMBRE_PARA_GIT"
   git config --local user.email "CORREO_PARA_GIT"
   ```
3. Verificar de nuevo:
   ```bash
   git config --local --get user.name
   git config --local --get user.email
   ```
4. No utilizar valores de ejemplo como identidad definitiva ni modificar la configuración global. No continuar hasta que ambas consultas devuelvan los datos elegidos.

**Cómo interpretar las instrucciones y los comandos:** `git config --get` consulta la identidad efectiva; `git config --local` guarda los datos solo en `.git/config` de este repositorio. Ninguno de estos comandos autentica en GitHub.

**Si no se obtiene el resultado esperado:** Si falta nombre o correo, definir los datos correctos; los marcadores `NOMBRE_PARA_GIT` y `CORREO_PARA_GIT` no deben quedar guardados literalmente.

**Resultado esperado:** nombre y correo reales disponibles en la configuración Git local del backend.

## Paso 9 — Proteger los archivos privados del backend

**Qué se hace y por qué:** Un archivo `.env` contendrá contraseñas reales; `.gitignore` evita incorporarlo por accidente a nuevos commits. La comprobación de seguimiento es indispensable porque ignorar un archivo no lo retira del historial si ya estaba versionado.

1. En `backend`, comprobar si existe el archivo `.gitignore` y si Git registra un `.env`:
   ```bash
   test -f .gitignore && echo 'Existe .gitignore' || echo 'Falta .gitignore'
   git ls-files .env
   ```
2. Si `.gitignore` existe, abrirlo y **añadir solamente las reglas que falten**. Si no existe, crearlo en `backend/` con el siguiente contenido:
   ```gitignore
   .env
   .env.*
   !.env.example
   .venv/
   venv/
   __pycache__/
   *.py[cod]
   .pytest_cache/
   .coverage
   htmlcov/
   *.log
   instance/
   backups/
   ```
3. Verificar:
   ```bash
   git check-ignore -v --no-index .env
   ```
4. Si `git ls-files .env` mostró un archivo, detener cualquier publicación hasta retirarlo del seguimiento de Git de forma segura.

**Cómo interpretar las instrucciones y los comandos:** `git ls-files .env` identifica si `.env` ya está bajo seguimiento; `git check-ignore -v --no-index .env` muestra qué regla lo excluye, aunque todavía no exista. El resultado vacío de la primera consulta es el esperado.

**Si no se obtiene el resultado esperado:** Si `.env` aparece en `git ls-files`, bloquear la publicación y revisar su seguimiento e historial antes de dar este paso por aprobado.

**Resultado esperado:** `.env` queda ignorado y Git no registra credenciales locales.

## Paso 10 — Comprobar el formato de .gitignore

**Qué se hace y por qué:** Se valida que `.gitignore` tenga un formato adecuado y que el cambio preparado para el siguiente commit no arrastre errores de espacios. Preparar (`git add`) no equivale a publicar.

1. Abrir `backend/.gitignore` en VS Code; si aparece **CRLF**, seleccionar **LF** y guardar.
2. En Git Bash, dentro de `backend`, ejecutar:
   ```bash
   git add .gitignore
   git diff --cached --check
   git diff --cached --name-only
   ```
3. Si aparece `trailing whitespace` con `^M`, volver a guardar el archivo en LF y repetir.

**Cómo interpretar las instrucciones y los comandos:** `git add .gitignore` prepara solo ese archivo; `git diff --cached --check` busca errores de espacios; `git diff --cached --name-only` enumera archivos preparados. Todavía no se crea ningún commit.

**Si no se obtiene el resultado esperado:** Si `git diff --cached --check` informa espacios o finales de línea, corregir y volver a preparar solo `.gitignore`.

**Resultado esperado:** `git diff --cached --check` no muestra errores. No ejecutar todavía `git commit` ni `git push`.

## Paso 11 — Comprobar los archivos del backend

**Qué se hace y por qué:** Antes de crear archivos Docker, se comprueba que el repositorio realmente contenga la aplicación Flask, dependencias, migraciones y pruebas esperadas. Un archivo faltante puede indicar que se clonó otra versión.

1. Dentro de `backend`, ejecutar:
   ```bash
   ls -l app.py requirements.txt requirements-dev.txt pyproject.toml
   ls -ld app migrations tests scripts
   ```
2. Si alguno no existe, revisar el paso 7 antes de crear o reemplazar archivos.

**Cómo interpretar las instrucciones y los comandos:** `ls -l` comprueba archivos y `ls -ld` comprueba directorios sin listar su contenido. Un error «No such file» debe investigarse antes de crear sustitutos.

**Si no se obtiene el resultado esperado:** Ante un archivo ausente, confirmar la rama y el SHA; no inventar una estructura distinta para hacer pasar la comprobación.

**Resultado esperado:** están presentes el código Flask, las dependencias, migraciones, pruebas y scripts del repositorio oficial.

## Paso 12 — Comprobar los puertos que utilizará el proyecto

**Qué se hace y por qué:** Cada servicio necesita un puerto del computador para poder consultarlo desde Windows. Se comprueban conflictos y se cambia solo el puerto publicado, sin interferir con otros programas ni alterar los puertos internos de Docker.

1. En Git Bash, ejecutar:
   ```bash
   netstat.exe -ano | grep -E ':(3307|5000|8080)[[:space:]]' || true
   ```
2. Comprobar si algún proceso está **LISTENING** en los puertos `3307` (MySQL), `5000` (API) o `8080` (frontend).
3. Si un puerto está ocupado, anotar el **PID** de la última columna de `netstat.exe -ano` e identificar el programa en el Administrador de tareas de Windows (pestaña **Detalles**) antes de cambiarlo. No detener servicios ajenos al proyecto sin revisarlos. Por ejemplo, si MySQL de Windows ya utiliza el puerto 3307, puede elegirse 3308 si está libre. **El puerto alternativo no es obligatorio**; depende de cada equipo.
4. Anotar un puerto libre para el servicio afectado. En el **paso 17**, modificar `DB_HOST_PORT`, `API_HOST_PORT` o `FRONTEND_HOST_PORT` dentro de `.env`. Si cambia el puerto de la API o del frontend, modificar también `VITE_API_URL` o `CORS_ALLOWED_ORIGINS`, respectivamente.
5. Los puertos `3306` (MySQL dentro de Docker), `5000` (Flask dentro de Docker) y `80` (Nginx dentro de Docker) **no se cambian**: solo cambian los puertos publicados en Windows.

**Cómo interpretar las instrucciones y los comandos:** `netstat.exe -ano` lista conexiones, puertos y PID; `grep` filtra los puertos de interés. El `|| true` evita que una búsqueda sin coincidencias detenga el bloque; debe comprobarse igualmente el resultado visual.

**Si no se obtiene el resultado esperado:** Si un puerto está ocupado, identificar su proceso y elegir otro puerto libre; no detener MySQL de Windows ni otro programa sin autorización.

**Resultado esperado:** los tres puertos previstos están disponibles o se han elegido alternativas para configurarlas en `.env`.

## Paso 13 — Crear backend/.dockerignore

**Qué se hace y por qué:** `.dockerignore` reduce los archivos enviados al constructor de la imagen. Protege contra la inclusión de secretos y cachés, pero su función es diferente de `.gitignore`, que afecta al control de versiones.

1. En VS Code, crear el archivo **`backend/.dockerignore`**.
2. Copiar el contenido completo:

```dockerignore
.git
.env
.env.*
!.env.example
__pycache__/
*.py[cod]
.venv/
venv/
.pytest_cache/
.coverage
htmlcov/
*.log
instance/
backups/
```

3. Guardar en formato LF.

**Cómo interpretar las instrucciones y los comandos:** Las reglas de `.dockerignore` se copian a un archivo, **no se ejecutan en Git Bash**. La línea `.git` excluye metadatos Git y `.env` excluye credenciales del contexto de construcción.

**Si no se obtiene el resultado esperado:** Si el archivo ya existe, examinarlo y añadir únicamente reglas que falten; no reemplazar decisiones previas sin revisión.

**Resultado esperado:** los datos locales, carpetas temporales y archivos privados no se incluyen al construir la imagen Docker.

## Paso 14 — Crear Dockerfile del backend

**Qué se hace y por qué:** El Dockerfile convierte el código Flask en una imagen repetible con Python y Gunicorn. El soporte RSA permite autenticar PyMySQL frente a MySQL 8.4; las pruebas permanecen en esta imagen local para poder ejecutarlas.

1. En la carpeta `backend`, comprobar que no exista un `Dockerfile` propio. Si ya existe, revisarlo y conservarlo hasta confirmar que es compatible.
2. Crear `backend/Dockerfile` con este contenido:
   ```dockerfile
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
   ```
3. Comprobar que `PyMySQL[rsa]` aparece en el archivo: MySQL 8.4 puede requerir soporte RSA para la autenticación. No cambiar el método de autenticación de MySQL ni borrar el volumen para solucionar ese error.
4. Tener presente que `COPY . .` incorpora los archivos no excluidos mediante `.dockerignore`: **las carpetas de documentación y pruebas todavía se incluyen en la imagen de validación local**. Se mantienen para reproducir las pruebas del paso 25; la optimización de una imagen de producción distinta debe tratarse en la fase Azure, sin borrar la documentación del repositorio.

**Cómo interpretar las instrucciones y los comandos:** `FROM` selecciona Python, `WORKDIR` establece `/app`, `COPY requirements.txt` permite reutilizar capas, `RUN pip install` prepara Flask/Gunicorn/RSA, y `CMD` arranca Gunicorn cuando el contenedor se inicia.

**Si no se obtiene el resultado esperado:** Ante errores de `pip` o Gunicorn, revisar el log de construcción. Si PyMySQL pide `cryptography`, verificar que la línea RSA corregida esté realmente en el Dockerfile.

**Resultado esperado:** `backend/Dockerfile` incluye Flask, Gunicorn y el soporte RSA necesario para PyMySQL.

## Paso 15 — Crear la plantilla de variables de entorno

**Qué se hace y por qué:** La plantilla enumera los valores que Docker Compose necesita sin incluir claves privadas. Separar configuración y código permite utilizar distintos puertos localmente y, después, direcciones HTTPS en Azure.

1. En la carpeta principal `/c/AlojamientosEmpresa`, crear el archivo **`.env.example`**.
2. Copiar exactamente el contenido siguiente:

```dotenv
# Copiar a .env y sustituir los tres marcadores de claves privadas.
SECRET_KEY=REEMPLAZAR_SECRET_KEY
DB_PASSWORD=REEMPLAZAR_DB_PASSWORD
MYSQL_ROOT_PASSWORD=REEMPLAZAR_MYSQL_ROOT_PASSWORD

# Puertos publicados en Windows (modificarlos solo si están ocupados).
DB_HOST_PORT=3307
API_HOST_PORT=5000
FRONTEND_HOST_PORT=8080

# URL que utiliza el navegador para llamar a Flask; Vite la integra al compilar.
VITE_API_URL=http://localhost:5000/api/v1

# Origen desde el que se abre el frontend en el navegador.
CORS_ALLOWED_ORIGINS=http://localhost:8080
```

3. Guardar el archivo en formato LF. No escribir claves reales en `.env.example`.
4. `VITE_API_URL` es la URL a la que se conectará el navegador; `CORS_ALLOWED_ORIGINS` es la URL desde la que el navegador abre el frontend. En local se utilizan `localhost:5000` y `localhost:8080`.

**Cómo interpretar las instrucciones y los comandos:** Las líneas `CLAVE=valor` se guardan en `.env.example`; **no son comandos de terminal**. Los tres valores `REEMPLAZAR_...` son marcadores, no contraseñas válidas.

**Si no se obtiene el resultado esperado:** Si `.env.example` existe, cotejar sus claves antes de editar. No reemplazar accidentalmente valores configurados por otra persona.

**Resultado esperado:** existe una plantilla sin datos sensibles que permite cambiar puertos y URL sin modificar el código de Flask ni de Vite.

## Paso 16 — Generar las claves privadas sin mostrarlas

**Qué se hace y por qué:** Se generan claves aleatorias y se escriben directamente en `.env` sin mostrarlas en pantalla. El contenedor temporal de Python evita exigir Python instalado en Windows y el modo de creación exclusivo impide sobrescribir secretos existentes.

1. En Git Bash, desde la carpeta principal, comprobar que exista `.env.example` y revisar si `.env` ya fue creado:
   ```bash
   cd /c/AlojamientosEmpresa
   test -f .env.example && echo 'Plantilla disponible'
   test -e .env && echo 'Ya existe .env: no sobrescribir' || echo 'Falta .env'
   ```
2. **Solo si `.env` no existe**, ejecutar el siguiente bloque completo en Git Bash. Docker genera las tres claves y las escribe directamente en `.env`; no imprime sus valores:
   ```bash
   MSYS_NO_PATHCONV=1 docker run --rm -i --mount "type=bind,source=$(pwd -W),target=/trabajo" -w /trabajo python:3.11-slim python - <<'PY'
   from pathlib import Path
   import secrets

   original = Path('.env.example').read_text(encoding='utf-8')
   reemplazos = {
       'REEMPLAZAR_SECRET_KEY': secrets.token_hex(32),
       'REEMPLAZAR_DB_PASSWORD': secrets.token_hex(24),
       'REEMPLAZAR_MYSQL_ROOT_PASSWORD': secrets.token_hex(24),
   }
   if any(marcador not in original for marcador in reemplazos):
       raise SystemExit('Faltan marcadores en .env.example; no se creó .env.')
   for marcador, valor in reemplazos.items():
       original = original.replace(marcador, valor)
   destino = Path('.env')
   with destino.open('x', encoding='utf-8') as archivo:
       archivo.write(original)
   print('Archivo .env creado sin mostrar claves.')
   PY
   ```
3. No compartir, añadir a Git ni mostrar el contenido de `.env`. Si el comando falla, comprobar qué archivo se creó antes de repetirlo; no sobrescribir un `.env` existente.

**Cómo interpretar las instrucciones y los comandos:** `docker run --rm` usa un contenedor temporal; `--mount` comparte la carpeta de trabajo; `secrets.token_hex` genera claves aleatorias; `open("x")` falla si `.env` ya existe. `MSYS_NO_PATHCONV=1` evita convertir de forma incorrecta la ruta del montaje al pasar por Git Bash.

**Si no se obtiene el resultado esperado:** Si falla la generación, comprobar si `.env` fue creado parcialmente. No ejecutar de nuevo el bloque para sobrescribirlo o imprimir claves.

**Resultado esperado:** se creó `.env` a partir de la plantilla con tres claves distintas, sin revelar su contenido en la terminal.

## Paso 17 — Verificar variables y puertos del archivo .env

**Qué se hace y por qué:** Se comprueba que la configuración privada esté completa sin imprimir claves. Se distingue el puerto del navegador, el puerto del contenedor, la URL de API con `/api/v1` y el origen CORS, que no contiene ese prefijo.

1. Si `.env` no existe, volver al paso 16. No reemplazar ni regenerar las claves cuando `.env` ya fue creado.
2. En Git Bash, desde `/c/AlojamientosEmpresa`, comprobar sin mostrar las claves:
   ```bash
   if grep -q 'REEMPLAZAR_' .env; then echo 'Faltan claves en .env'; else echo 'No quedan marcadores pendientes'; fi
   grep -E '^(DB_HOST_PORT|API_HOST_PORT|FRONTEND_HOST_PORT|VITE_API_URL|CORS_ALLOWED_ORIGINS)=' .env
   ```
3. Mantener los puertos `3307`, `5000` y `8080` si están libres. Si el paso 12 detectó un puerto ocupado, editar únicamente el valor correspondiente:
   - `DB_HOST_PORT`: puerto de MySQL accesible desde Windows.
   - `API_HOST_PORT`: puerto de Flask; también debe coincidir con el puerto de `VITE_API_URL`.
   - `FRONTEND_HOST_PORT`: puerto de Nginx; también debe coincidir con el origen `CORS_ALLOWED_ORIGINS`.
4. La URL del frontend hacia la API **debe incluir el prefijo `/api/v1`**:
   ```dotenv
   VITE_API_URL=http://localhost:5000/api/v1
   CORS_ALLOWED_ORIGINS=http://localhost:8080
   ```
5. Si utiliza otro puerto para Flask, cambiar solo el número de puerto de `VITE_API_URL` y conservar `/api/v1`. `CORS_ALLOWED_ORIGINS` lleva el origen del frontend, **sin** `/api/v1`.
6. Guardar `.env` sin comillas añadidas ni espacios alrededor de `=`. Nunca publicarlo en GitHub.

**Cómo interpretar las instrucciones y los comandos:** `grep -q` detecta marcadores sin imprimirlos; `grep -E` muestra únicamente las cinco variables públicas seleccionadas. No ejecutar `cat .env` ni `docker compose config` sin `--quiet` para registrar evidencias.

**Si no se obtiene el resultado esperado:** Si hay marcadores, corregir únicamente `.env`. Si cambia `VITE_API_URL`, habrá que reconstruir el frontend; reiniciarlo solamente no actualiza el JavaScript.

**Resultado esperado:** claves privadas presentes, sin marcadores; puertos disponibles y URL de API con `/api/v1`.

## Paso 18 — Crear el archivo compose.yaml

**Qué se hace y por qué:** Compose describe qué se inicia, cómo se conectan los servicios y dónde se guarda MySQL. La red Docker permite que Flask encuentre la base como `db`; el volumen conserva datos aunque se reinicie el contenedor.

1. En `/c/AlojamientosEmpresa`, crear **`compose.yaml`**.
2. Copiar el contenido completo:

```yaml
services:
  db:
    image: mysql:8.4
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD:?Definir MYSQL_ROOT_PASSWORD en .env}
      MYSQL_DATABASE: alojamientos_db
      MYSQL_USER: alojamientos
      MYSQL_PASSWORD: ${DB_PASSWORD:?Definir DB_PASSWORD en .env}
    ports:
      - "127.0.0.1:${DB_HOST_PORT:-3307}:3306"
    volumes:
      - mysql_data:/var/lib/mysql
    healthcheck:
      test: ["CMD-SHELL", 'mysqladmin ping -h 127.0.0.1 -u root -p"$$MYSQL_ROOT_PASSWORD" --silent']
      interval: 10s
      timeout: 5s
      retries: 30
      start_period: 30s
    restart: unless-stopped

  api:
    build:
      context: ./backend
    environment:
      SECRET_KEY: ${SECRET_KEY:?Definir SECRET_KEY en .env}
      JWT_EXP_MINUTES: "15"
      DB_USER: alojamientos
      DB_PASSWORD: ${DB_PASSWORD:?Definir DB_PASSWORD en .env}
      DB_HOST: db
      DB_PORT: "3306"
      DB_NAME: alojamientos_db
      CORS_ALLOWED_ORIGINS: ${CORS_ALLOWED_ORIGINS:?Definir CORS_ALLOWED_ORIGINS en .env}
    ports:
      - "127.0.0.1:${API_HOST_PORT:-5000}:5000"
    depends_on:
      db:
        condition: service_healthy
    restart: unless-stopped

  frontend:
    build:
      context: ./frontend
      args:
        VITE_API_URL: ${VITE_API_URL:?Definir VITE_API_URL en .env}
    ports:
      - "127.0.0.1:${FRONTEND_HOST_PORT:-8080}:80"
    depends_on:
      - api
    restart: unless-stopped

volumes:
  mysql_data:
```

3. Guardar en LF. El archivo configura **MySQL 8.4**, **Flask** y el **frontend**. El frontend se clonará en el paso 26; aún no debe existir necesariamente.
4. Comprobar que Flask se conecta a MySQL mediante `DB_HOST: db` y el puerto interno `3306`, mientras que el navegador utiliza la URL indicada por `VITE_API_URL`.
5. Los puertos publicados en Windows, el origen CORS y la URL de la API se leen del archivo `.env`. En Azure se configurarán con otros valores y se reconstruirá el frontend para la dirección pública HTTPS.

**Cómo interpretar las instrucciones y los comandos:** En `compose.yaml`, `build.context` indica la carpeta de código; `environment` aporta variables al contenedor; `depends_on: condition: service_healthy` espera MySQL; `volumes` persiste datos y `127.0.0.1` limita los puertos al propio equipo.

**Si no se obtiene el resultado esperado:** Si otro `compose.yaml` ya existe, compararlo antes de reemplazarlo. Los nombres de servicios deben permanecer `db`, `api` y `frontend` para que funcionen los comandos posteriores.

**Resultado esperado:** `compose.yaml` contiene tres servicios, almacenamiento persistente de MySQL y configuración local parametrizada sin contraseñas incorporadas en el código.

## Paso 19 — Validar la configuración de Docker Compose

**Qué se hace y por qué:** El comando comprueba la sintaxis YAML y que Compose pueda resolver las variables requeridas. No inicia servicios ni demuestra funcionamiento, pero detecta errores de configuración antes de descargar imágenes o utilizar recursos.

1. En Git Bash, ejecutar desde la carpeta principal:
   ```bash
   cd /c/AlojamientosEmpresa
   docker compose config --quiet
   ```
2. Si no aparece ningún error, la estructura y las variables utilizadas por Compose son válidas.
3. Si Compose muestra una variable no definida, revisar `.env`. Si informa un error YAML, revisar la indentación de `compose.yaml`.

**Cómo interpretar las instrucciones y los comandos:** `docker compose config --quiet` valida YAML y la interpolación de variables sin imprimir una configuración que podría contener secretos. Un código de salida cero no significa que los contenedores ya estén ejecutándose.

**Si no se obtiene el resultado esperado:** Si Compose falla, corregir primero YAML, nombres de servicios o variables faltantes. No exponer el contenido completo de `.env` para diagnosticar.

**Resultado esperado:** el comando termina sin errores. No imprime contraseñas en la terminal.

## Paso 20 — Construir la imagen del backend

**Qué se hace y por qué:** Construir la imagen instala las dependencias definidas para Flask y prepara el proceso Gunicorn. Es una prueba de empaquetado; todavía no prueba la conexión con MySQL ni la ejecución del backend.

1. Desde la carpeta principal, ejecutar:
   ```bash
   docker compose build api
   ```
2. Comprobar que finaliza la instalación de las dependencias Python y de Gunicorn sin errores.
3. Si la compilación falla, revisar el mensaje completo y los archivos `backend/Dockerfile` y `backend/requirements.txt` antes de repetirla.

**Cómo interpretar las instrucciones y los comandos:** `docker compose build api` ejecuta el Dockerfile del backend. Una imagen construida no está necesariamente iniciada: para crear el contenedor se utiliza `docker compose up -d api` en el Paso 22.

**Si no se obtiene el resultado esperado:** Si Docker falla al descargar una imagen o instalar Python, revisar red, espacio y mensajes antes de repetir; no borrar volúmenes.

**Resultado esperado:** Docker indica que la imagen del servicio `api` quedó construida.

## Paso 21 — Iniciar MySQL y comprobar que está saludable

**Qué se hace y por qué:** MySQL debe estar disponible y saludable antes de aplicar migraciones. Docker crea el volumen persistente la primera vez; las credenciales de inicialización no deben cambiarse a ciegas sobre una base ya creada.

1. Desde la carpeta principal, ejecutar:
   ```bash
   docker compose up -d db
   docker compose ps db
   ```
2. Esperar a que el estado de `db` indique **healthy**. Si sigue iniciando, revisar:
   ```bash
   docker compose logs --tail 50 db
   ```
3. No ejecutar migraciones mientras la base de datos no esté saludable.

**Cómo interpretar las instrucciones y los comandos:** `docker compose up -d db` crea e inicia MySQL en segundo plano; `docker compose ps db` muestra su estado; `docker compose logs --tail 50 db` enseña los últimos mensajes sin imprimir todo el historial.

**Si no se obtiene el resultado esperado:** Si MySQL permanece en `starting` o `unhealthy`, consultar los logs. Las contraseñas de variables no restablecen automáticamente usuarios de un volumen ya inicializado.

**Resultado esperado:** MySQL está iniciado y dispone del volumen persistente `mysql_data`.

## Paso 22 — Iniciar el backend

**Qué se hace y por qué:** Se inicia el servidor Flask de la API después de preparar MySQL. Los registros permiten detectar fallos de arranque y diferenciar una imagen construida de un servicio realmente operativo.

1. Ejecutar:
   ```bash
   docker compose up -d api
   docker compose ps api
   docker compose logs --tail 50 api
   ```
2. Comprobar que el servicio no se reinicia repetidamente y que Gunicorn escucha en el puerto 5000 del contenedor.
3. Ante errores de conexión a la base de datos, comprobar primero `db` y las variables de `compose.yaml`.

**Cómo interpretar las instrucciones y los comandos:** `docker compose up -d api` inicia Flask mediante Gunicorn; `docker compose ps api` confirma el estado y `docker compose logs` permite diagnosticar reinicios o errores de conexión.

**Si no se obtiene el resultado esperado:** Si la API reinicia, consultar `docker compose logs --tail 80 api` y confirmar que MySQL está `healthy`.

**Resultado esperado:** el servicio `api` está iniciado sin errores críticos.

## Paso 23 — Aplicar las migraciones existentes

**Qué se hace y por qué:** Las migraciones versionadas crean o actualizan las tablas esperadas sin crear manualmente tablas ni inventar migraciones. `db current` permite comprobar hasta qué versión de esquema llegó la base.

1. Ejecutar desde `/c/AlojamientosEmpresa`:
   ```bash
   docker compose exec api flask --app 'app:crear_app()' db upgrade
   ```
2. El comando utiliza las migraciones incluidas en el repositorio y crea o actualiza las tablas en `alojamientos_db`.
3. Verificar el estado:
   ```bash
   docker compose exec api flask --app 'app:crear_app()' db current
   ```

**Cómo interpretar las instrucciones y los comandos:** `flask --app ... db upgrade` aplica las revisiones existentes; `db current` pregunta qué revisión tiene la base. No ejecutar `db migrate` como sustituto: generaría nuevos archivos de migración.

**Si no se obtiene el resultado esperado:** Si falla la autenticación MySQL, verificar `PyMySQL[rsa]`, credenciales y estado de la base antes de tocar migraciones o contraseñas.

**Resultado esperado:** la migración termina sin errores y `db current` muestra la revisión aplicada. **No generar migraciones nuevas** cuando las existentes se aplican correctamente.

## Paso 24 — Verificar que la API responde

**Qué se hace y por qué:** El endpoint `/health` comprueba que la API es accesible desde Windows y responde como aplicación, no solo que existe el contenedor. Todavía no sustituye las pruebas de autenticación ni las operaciones de negocio.

1. En Git Bash, ejecutar:
   ```bash
   curl -i http://localhost:5000/health
   ```
2. Comprobar que responde con código HTTP **200** y un JSON con `status` igual a `ok`. Si cambió `API_HOST_PORT` en el paso 17, sustituir el puerto `5000` en este comando.
3. Si la respuesta falla, consultar:
   ```bash
   docker compose ps
   docker compose logs --tail 80 api
   ```

**Cómo interpretar las instrucciones y los comandos:** `curl -i` envía una solicitud HTTP y muestra cabeceras y respuesta. El código `200` y `status: ok` comprueban salud básica, pero no validan todavía inicio de sesión ni acceso a datos.

**Si no se obtiene el resultado esperado:** Si responde un código distinto de 200, comprobar puerto, estado de `api` y logs; no atribuirlo automáticamente a Nginx.

**Resultado esperado:** el endpoint `/health` funciona desde Windows y responde la API contenida en Docker.

## Paso 25 — Ejecutar las pruebas automatizadas del backend

**Qué se hace y por qué:** Pytest detecta regresiones en las funciones programadas del backend. Estas pruebas usan SQLite de ensayo y deben complementarse luego con pruebas reales de MySQL, navegador y permisos.

1. Desde la carpeta principal, ejecutar:
   ```bash
   docker compose exec -e FLASK_TESTING=true api python -m pytest -q
   ```
2. Las pruebas del repositorio usan SQLite en memoria, por lo que no deberían modificar la base MySQL del contenedor.
3. Comprobar la cantidad de pruebas ejecutadas y si existe algún fallo. Si aparecen fallos, registrar el error y resolverlo antes de aprobar este paso.

**Cómo interpretar las instrucciones y los comandos:** `docker compose exec` ejecuta un comando dentro del contenedor ya iniciado; `-e FLASK_TESTING=true` activa la configuración de pruebas; `python -m pytest -q` ejecuta Pytest con salida resumida.

**Si no se obtiene el resultado esperado:** Si un test falla, conservar el error y revisar su caso; no marcar aprobado por un único test o por una construcción Docker exitosa.

**Resultado esperado:** todas las pruebas terminan satisfactoriamente. **Comprobar el resultado en el equipo donde se ejecuta el proyecto; no asumir que las pruebas pasan sin ejecutarlas.**

## Paso 26 — Clonar el repositorio oficial del frontend

**Qué se hace y por qué:** El frontend se clona desde su repositorio fuente para conservar código, historial y archivo de bloqueo de dependencias. Se mantiene separado del backend porque cada componente se construye y versiona por su cuenta.

1. En Git Bash, ejecutar:
   ```bash
   cd /c/AlojamientosEmpresa
   if [ -e frontend ]; then
     echo 'frontend ya existe; no se sobrescribirá.'
   else
     git clone https://github.com/oflodororni/frontend-alojamientos.git frontend
   fi
   ```
2. Si existe una carpeta anterior, conservarla y comprobar su origen en el paso siguiente.

**Cómo interpretar las instrucciones y los comandos:** La comprobación `[ -e frontend ]` evita sobrescribir una carpeta previa. `git clone` descarga el repositorio fuente completo en `frontend` y no realiza publicaciones.

**Si no se obtiene el resultado esperado:** Si `frontend` ya existe, validar su procedencia en el Paso 27 y no mezclar manualmente archivos de otro repositorio.

**Resultado esperado:** existe la carpeta `frontend` obtenida del repositorio oficial o identificada para revisión.

## Paso 27 — Verificar el repositorio y los archivos del frontend

**Qué se hace y por qué:** Se comprueba que el frontend sea el esperado y que incluya `package-lock.json`, necesario para instalar versiones reproducibles con `npm ci`. El SHA y el estado Git ayudan a documentar la línea base.

1. Ejecutar:
   ```bash
   cd /c/AlojamientosEmpresa/frontend
   git remote -v
   git branch --show-current
   git status --short
   git rev-parse HEAD
   ls -l package.json package-lock.json vite.config.js index.html
   ls -ld src
   ```
2. Confirmar que `origin` corresponde a `https://github.com/oflodororni/frontend-alojamientos.git` y registrar el SHA mostrado por `git rev-parse HEAD`.
3. Si el origen o los archivos no coinciden, detenerse y revisar la carpeta existente; no borrar cambios.

**Cómo interpretar las instrucciones y los comandos:** `git remote`, `branch`, `status` y `rev-parse` verifican procedencia y versión; `ls` comprueba que existen los archivos de Vite y el lockfile. Un cambio no autorizado en `package-lock.json` altera la reproducibilidad.

**Si no se obtiene el resultado esperado:** Si `package-lock.json` falta o se modifica sin explicación, registrar la diferencia antes de construir: `npm ci` depende de ese archivo.

**Resultado esperado:** frontend correcto con archivos necesarios para construir Vite.

## Paso 28 — Crear frontend/.dockerignore

**Qué se hace y por qué:** Se evita enviar a Docker dependencias `node_modules` de Windows, compilaciones anteriores y secretos. El contenedor instalará sus propias dependencias compatibles con Linux.

1. En VS Code, crear **`frontend/.dockerignore`**.
2. Copiar:

```dockerignore
.git
.env
.env.*
!.env.example
node_modules/
dist/
*.log
```

3. Guardar el archivo en LF.

**Cómo interpretar las instrucciones y los comandos:** `.dockerignore` pertenece al contexto `frontend`: `node_modules/` se excluye porque la imagen Node debe instalar módulos Linux propios y `dist/` porque la compilación debe generarse desde el código.

**Si no se obtiene el resultado esperado:** Si ya hay reglas existentes, no sobrescribirlas sin comparación; las carpetas `node_modules/` y `dist/` deben excluirse.

**Resultado esperado:** la construcción del frontend excluye `node_modules`, `dist` y archivos de entorno locales.

## Paso 29 — Crear la configuración de Nginx para el frontend

**Qué se hace y por qué:** Nginx entregará los archivos estáticos producidos por Vite. La regla `try_files` permite refrescar rutas internas de la SPA; esta configuración local no actúa como proxy `/api` ni proporciona HTTPS.

1. Crear **`frontend/nginx.conf`**.
2. Copiar:

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

3. Guardar en LF. Esta configuración devuelve `index.html` cuando una ruta del frontend requiere ser atendida por la aplicación web.

**Cómo interpretar las instrucciones y los comandos:** El bloque `nginx` se guarda en `frontend/nginx.conf`: `listen 80` abre el puerto interno, `root` señala `dist` copiado y `try_files ... /index.html` permite rutas de la SPA.

**Si no se obtiene el resultado esperado:** Si el servidor responde 404 al refrescar rutas internas, revisar `try_files` y el archivo Nginx copiado en la imagen.

**Resultado esperado:** existe `frontend/nginx.conf`.

## Paso 30 — Crear el Dockerfile del frontend

**Qué se hace y por qué:** La construcción tiene dos etapas: Node instala y compila, y la imagen final de Nginx sirve solo los archivos resultantes. `VITE_API_URL` se integra al JavaScript durante el build y no debe confundirse con un secreto.

1. Crear **`frontend/Dockerfile`** (sin extensión).
2. Copiar:

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

3. Guardar en formato LF. La primera etapa instala las dependencias de Vite, recibe `VITE_API_URL` desde Docker Compose y compila los archivos estáticos. La segunda etapa los publica mediante Nginx.
4. El Dockerfile **no debe contener una URL fija de la API**: la recibe durante la construcción de la imagen.

**Cómo interpretar las instrucciones y los comandos:** `FROM ... AS build` usa Node solo durante la compilación; `npm ci` respeta el lockfile; `ARG/ENV VITE_API_URL` configura la URL de la API; `COPY --from=build` lleva los archivos estáticos a Nginx.

**Si no se obtiene el resultado esperado:** Si `npm ci` falla, revisar `package-lock.json`, conexión y errores de paquetes; no sustituirlo arbitrariamente por `npm install`.

**Resultado esperado:** existe `frontend/Dockerfile` y la URL del backend se suministra desde la configuración del entorno.

## Paso 31 — Comprobar la URL de API utilizada por el frontend

**Qué se hace y por qué:** El frontend debe utilizar la dirección real de los endpoints Flask; omitir `/api/v1` hizo fallar la conexión en la ejecución documentada. Comprobar el valor antes de construir evita repetir imágenes innecesariamente.

1. En Git Bash, ejecutar:
   ```bash
   cd /c/AlojamientosEmpresa/frontend
   grep -n 'VITE_API_URL' src/js/api/http.js
   ```
2. Verificar que el cliente utiliza `import.meta.env.VITE_API_URL`. No modificar `src/js/api/http.js`.
3. Desde la carpeta principal, verificar únicamente la URL pública, sin mostrar claves:
   ```bash
   cd /c/AlojamientosEmpresa
   grep '^VITE_API_URL=' .env
   ```
4. En local, el valor debe ser `VITE_API_URL=http://localhost:5000/api/v1`, sustituyendo `5000` solo si se eligió otro puerto. La API usa `/api/v1` para las operaciones; el endpoint de salud sigue disponible en `/health`.
5. La URL se incorpora durante `docker compose build frontend`: si se cambia, es necesario reconstruir la imagen.

**Cómo interpretar las instrucciones y los comandos:** `grep -n` muestra la línea del código donde se consume `VITE_API_URL`; el segundo `grep` consulta solo esa variable en `.env`. El resultado debe terminar en `/api/v1`.

**Si no se obtiene el resultado esperado:** Si falta `/api/v1`, ajustar `.env` y planear reconstruir el frontend; no modificar el cliente HTTP original para ocultar el problema.

**Resultado esperado:** el frontend apunta a la raíz real de las rutas de la API, con `/api/v1`.

## Paso 32 — Verificar configuración de comunicación y CORS

**Qué se hace y por qué:** CORS limita qué origen web puede llamar a Flask desde el navegador. La URL del frontend y la de API son distintas: el origen CORS se expresa sin ruta, mientras que la base de API sí termina en `/api/v1`.

1. Desde Git Bash, ejecutar:
   ```bash
   cd /c/AlojamientosEmpresa
   grep -nE 'VITE_API_URL|CORS_ALLOWED_ORIGINS' compose.yaml
   grep -E '^(VITE_API_URL|CORS_ALLOWED_ORIGINS)=' .env
   ```
2. Comprobar que `VITE_API_URL` es `http://localhost:5000/api/v1` y `CORS_ALLOWED_ORIGINS` es `http://localhost:8080`, salvo los cambios de puerto permitidos en el paso 17.
3. En `compose.yaml`, mantener ambos valores parametrizados como `${VITE_API_URL:?...}` y `${CORS_ALLOWED_ORIGINS:?...}`; no escribir URL locales fijas.
4. Validar sin mostrar las credenciales:
   ```bash
   docker compose config --quiet
   ```
5. Si se cambia `VITE_API_URL`, volver a ejecutar:
   ```bash
   docker compose build frontend
   docker compose up -d frontend
   ```

**Cómo interpretar las instrucciones y los comandos:** Los comandos `grep` permiten comparar los valores de Compose y `.env`; `docker compose config --quiet` comprueba que Compose puede resolverlos. Si cambia la URL, hay que reconstruir el frontend.

**Si no se obtiene el resultado esperado:** Si hay errores CORS, confirmar el origen exacto del navegador, incluido el puerto, sin agregar `/api/v1` a `CORS_ALLOWED_ORIGINS`.

**Resultado esperado:** la configuración de URL y CORS es coherente. **Esto aún no demuestra que la comunicación funcione**: la prueba real en el navegador se realiza en el paso 35.

## Paso 33 — Construir la imagen del frontend

**Qué se hace y por qué:** Vite compila HTML, CSS y JavaScript destinados a Nginx. La construcción puede terminar bien aun con una URL incorrecta o con avisos de vulnerabilidad; por eso ambas condiciones deben verificarse por separado.

1. Desde `/c/AlojamientosEmpresa`, ejecutar:
   ```bash
   docker compose build frontend
   ```
2. Comprobar que `npm ci` y `npm run build` terminan sin errores y que Vite genera la aplicación compilada para Nginx.
3. Si falla `npm ci`, revisar `frontend/package.json` y `frontend/package-lock.json`; no borrar el archivo lock ni actualizar dependencias automáticamente.
4. Si faltan variables de Vite, revisar `.env` y repetir la construcción.
5. Si npm avisa de vulnerabilidades de dependencias, registrar el resultado para su revisión. **Una construcción correcta no significa que la auditoría de seguridad esté aprobada.** No ejecutar `npm audit fix` sin analizar los cambios.

**Cómo interpretar las instrucciones y los comandos:** `docker compose build frontend` crea la imagen de Nginx con los archivos Vite compilados. El análisis `npm audit` examina avisos de seguridad; no forma parte de la comprobación de URL del navegador.

**Si no se obtiene el resultado esperado:** Si el build termina con avisos de npm, distinguir construcción exitosa de seguridad. Auditar y documentar los paquetes afectados antes de actualizar dependencias.

**Auditar dependencias sin instalar Node.js en Windows:** `npm audit` consulta vulnerabilidades conocidas de la versión exacta del `package-lock.json`. Ejecutar los dos comandos siguientes desde **Git Bash**. Se utiliza un contenedor temporal Node y un montaje de **solo lectura**, de modo que la auditoría no altera el repositorio:

```bash
cd /c/AlojamientosEmpresa/frontend
MSYS_NO_PATHCONV=1 docker run --rm --mount "type=bind,source=$(pwd -W),target=/codigo,readonly" -w /codigo node:22-alpine npm audit --audit-level=high
MSYS_NO_PATHCONV=1 docker run --rm --mount "type=bind,source=$(pwd -W),target=/codigo,readonly" -w /codigo node:22-alpine npm audit --omit=dev --audit-level=high
```

La primera auditoría incluye dependencias de desarrollo y de producción; la segunda excluye las de desarrollo. Documentar **ambos** resultados. `found 0 vulnerabilities` significa que npm no identificó avisos conocidos en el alcance consultado, no que el proyecto esté libre de todos los riesgos. Si aparecen alertas, identificar paquetes y revisar la corrección sugerida antes de modificar el lockfile. No ejecutar `npm audit fix --force` ni ocultar avisos. El repositorio **fuente** puede conservar dependencias antiguas incluso si el repositorio de **implementación** ya recibió una corrección posterior.

**Si npm informa vulnerabilidades corregibles:** antes de actualizar, revisar que `git status --short` no muestre cambios desconocidos y que la simulación `npm audit fix --dry-run` no proponga modificaciones mayores no deseadas. Con la revisión hecha, ejecutar `npm audit fix` sin `--force`, usando el mismo contenedor Node **con montaje de escritura**. Los siguientes comandos actúan sobre el lockfile real del frontend; no ejecutarlos si no hay cambios que corregir o si hay trabajo ajeno sin revisar:

```bash
cd /c/AlojamientosEmpresa/frontend
git status --short
MSYS_NO_PATHCONV=1 docker run --rm --mount "type=bind,source=$(pwd -W),target=/codigo" -w /codigo node:22-alpine npm audit fix --dry-run
MSYS_NO_PATHCONV=1 docker run --rm --mount "type=bind,source=$(pwd -W),target=/codigo" -w /codigo node:22-alpine npm audit fix
MSYS_NO_PATHCONV=1 docker run --rm --mount "type=bind,source=$(pwd -W),target=/codigo" -w /codigo node:22-alpine npm audit --audit-level=high
git diff --check
git diff -- package.json package-lock.json
```

`--dry-run` describe una propuesta; no demuestra que la corrección se aplicó. El segundo comando sí modifica dependencias y posiblemente `package-lock.json`. Si quedan avisos o aparecen cambios no previstos, detenerse y documentarlos. Si la auditoría queda conforme, volver a `/c/AlojamientosEmpresa`, ejecutar `docker compose build frontend`, `docker compose up -d frontend` y repetir la prueba de navegador del Paso 35. Las actualizaciones de lockfile se publican **solo si fueron revisadas y autorizadas** en el Paso 44.


**Resultado esperado:** se construye la imagen del frontend y quedan registrados los avisos de dependencias, si los hubiera.

## Paso 34 — Iniciar el contenedor del frontend

**Qué se hace y por qué:** Se crea o inicia el contenedor que sirve el frontend. Ver el servicio iniciado no basta: en el paso siguiente se verificará que Nginx entregue la página y que el navegador pueda hablar con la API.

1. Ejecutar:
   ```bash
   docker compose up -d frontend
   docker compose ps
   docker compose logs --tail 50 frontend
   ```
2. Comprobar que los servicios `db`, `api` y `frontend` aparecen iniciados; `db` debe permanecer saludable.

**Cómo interpretar las instrucciones y los comandos:** `docker compose up -d frontend` inicia el servidor Nginx; `docker compose ps` muestra todos los servicios y `docker compose logs` ayuda a detectar fallos de arranque.

**Si no se obtiene el resultado esperado:** Si el contenedor se reinicia o está detenido, revisar `docker compose logs --tail 50 frontend` antes de cambiar configuración.

**Resultado esperado:** Nginx sirve el frontend en el puerto local 8080.

## Paso 35 — Comprobar el frontend y su conexión con la API

**Qué se hace y por qué:** Una respuesta HTTP 200 de Nginx solo comprueba la página. El navegador debe demostrar que el catálogo llama efectivamente a Flask con `/api/v1` y que no hay errores de JavaScript ni de CORS.

1. En Git Bash, ejecutar:
   ```bash
   curl -I http://localhost:8080
   ```
2. Confirmar HTTP **200**. Si se cambió `FRONTEND_HOST_PORT`, utilizar el puerto definido en `.env`.
3. Abrir `http://localhost:8080` en un navegador, comprobar que aparecen los alojamientos y revisar la consola y la pestaña Red/Network.
4. Comprobar que las solicitudes del catálogo salen hacia `http://localhost:5000/api/v1/alojamientos` (o el puerto alternativo configurado) y reciben la respuesta esperada. Verificar que no existen errores JavaScript ni errores de CORS.
5. Si el navegador intenta solicitar `/alojamientos` sin `/api/v1`, corregir `VITE_API_URL` en `.env`, ejecutar:
   ```bash
   docker compose build frontend
   docker compose up -d frontend
   ```
   y repetir la comprobación en el navegador.

**Cómo interpretar las instrucciones y los comandos:** `curl -I` comprueba las cabeceras HTTP de Nginx, mientras que las herramientas Network y Console del navegador permiten verificar peticiones reales a Flask y detectar fallos de CORS o JavaScript.

**Si no se obtiene el resultado esperado:** Si Nginx devuelve 200 pero la interfaz no conecta, comprobar Network y la URL `/api/v1`; reconstruir el frontend si se corrigió la variable.

**Resultado esperado:** Nginx sirve el frontend y el catálogo consulta correctamente la API `/api/v1`.

## Paso 36 — Validar registro, inicio de sesión y perfil

**Qué se hace y por qué:** Registro, inicio de sesión, consulta de perfil y cierre de sesión verifican el recorrido real de un usuario desde la interfaz hasta Flask y MySQL. Las cuentas deben ser de prueba y sus credenciales no se publican.

1. En `http://localhost:8080` (o el puerto alternativo), abrir la vista de **Registro**.
2. Registrar una cuenta de prueba con un correo y contraseña que no se hayan utilizado en pruebas anteriores.
3. Abrir **Login**, iniciar sesión y comprobar que se puede acceder a **Perfil**.
4. Cerrar la sesión y comprobar que el frontend vuelve al estado de visitante.
5. Observar en **Network** que el registro, inicio de sesión y perfil terminan con respuestas satisfactorias (normalmente, registro HTTP 201, inicio de sesión y perfil HTTP 200). Utilizar datos de prueba únicos; no adjuntar ni publicar contraseñas, tokens, cabeceras `Authorization` ni archivos locales que contengan cuentas de prueba.
6. Si una operación falla, revisar las solicitudes en la pestaña **Network** del navegador y ejecutar:
   ```bash
   cd /c/AlojamientosEmpresa
   docker compose logs --tail 80 api
   ```

**Cómo interpretar las instrucciones y los comandos:** Los formularios del navegador generan solicitudes HTTP hacia Flask; revisar Network permite distinguir un error del frontend de un rechazo de la API. No copiar en capturas, salidas compartidas ni registros de incidencias el cuerpo de peticiones que contengan credenciales.

**Si no se obtiene el resultado esperado:** Si el formulario falla, comprobar el código HTTP y la respuesta de la solicitud afectada; no repetir registros con el mismo correo sin identificar la causa.

**Resultado esperado:** registro, inicio y cierre de sesión funcionan y las solicitudes llegan al backend.

## Paso 37 — Validar permisos y operaciones principales

**Qué se hace y por qué:** Los roles deben protegerse en el servidor, además de ocultar opciones en la interfaz. Se comprueba un usuario normal, después un administrador de prueba y operaciones representativas sin eliminar datos ajenos.

1. Iniciar sesión con una cuenta normal y comprobar que **no puede acceder a funciones exclusivas de administrador**. Además de la interfaz, comprobar que la API rechaza la solicitud administrativa (respuesta HTTP 403 si la API utiliza este código para indicar acceso prohibido): ocultar un botón no equivale a impedir el acceso en el backend.
2. Para comprobar el rol administrador, registrar primero una cuenta de prueba y promoverla con el script que incluye el repositorio. Sustituir el correo del ejemplo:
   ```bash
   cd /c/AlojamientosEmpresa
   docker compose exec api python scripts/promover_admin.py correo@ejemplo.com
   ```
3. Cerrar sesión e iniciar sesión nuevamente con esa cuenta para actualizar sus permisos.
4. Verificar en la interfaz las funciones permitidas: listar, crear o editar alojamientos, consultar comodidades y usar las funciones de administración disponibles.
5. Documentar cuáles operaciones se probaron efectivamente. Comprobar las operaciones de alta, consulta y modificación; si se prueba una eliminación (`DELETE`), hacerlo únicamente sobre registros propios de prueba y con autorización. **No afirmar cobertura de operaciones que no se ejecutaron**.
6. Si un control falla, revisar el código HTTP y la respuesta en la pestaña **Network** del navegador; inspeccionar `docker compose logs --tail 80 api`, comprobar el rol del usuario y repetir únicamente el caso afectado. No darlo por aprobado hasta que el backend aplique el permiso correcto.

**Cómo interpretar las instrucciones y los comandos:** `docker compose exec api python scripts/promover_admin.py ...` modifica el rol de **una cuenta de prueba** en la base de datos. Es una acción con efecto real; comprobar el correo y nunca aplicarla a una cuenta ajena.

**Si no se obtiene el resultado esperado:** Si la API permite una acción sin rol adecuado, detener la validación como incidencia de permisos; ocultar la opción en la interfaz no es solución.

**Resultado esperado:** las operaciones principales funcionan y los permisos de visitante, usuario y administrador se aplican correctamente.

## Paso 38 — Comprobar que los datos se conservan al reiniciar

**Qué se hace y por qué:** Reiniciar contenedores comprueba que MySQL guarda los datos en un volumen persistente; no es suficiente mirar que el volumen existe. Los datos y permisos creados deben seguir siendo consultables.

1. Manteniendo los datos de prueba creados, ejecutar:
   ```bash
   cd /c/AlojamientosEmpresa
   docker compose restart
   docker compose ps
   ```
2. Esperar a que MySQL vuelva a mostrar el estado **healthy** antes de iniciar las pruebas de la interfaz; un reinicio puede terminar antes de que todos los servicios estén listos.
3. Volver a abrir `http://localhost:8080` (o el puerto alternativo) e iniciar sesión.
4. Comprobar que siguen disponibles las cuentas y los registros que se crearon antes del reinicio.
5. Si faltan datos, verificar el volumen MySQL:
   ```bash
   docker volume ls
   ```

**Cómo interpretar las instrucciones y los comandos:** `docker compose restart` reinicia servicios sin borrar sus volúmenes; `docker compose ps` permite esperar a MySQL; `docker volume ls` ayuda a identificar los volúmenes existentes sin eliminarlos.

**Si no se obtiene el resultado esperado:** Si faltan datos tras reiniciar, revisar el volumen y los logs; no ejecutar `docker compose down --volumes`.

**Resultado esperado:** la información persiste tras reiniciar los contenedores. No usar `docker compose down --volumes`, porque eliminaría los datos del volumen.

## Paso 39 — Respaldar MySQL y comprobar una restauración independiente

**Qué se hace y por qué:** Un respaldo útil debe poder restaurarse. Se exporta MySQL a un archivo nuevo, se valida su integridad y se importa en otra base para no alterar los datos originales.

1. En Git Bash, desde la carpeta principal del proyecto, crear la carpeta local de respaldos si falta:
   ```bash
   cd /c/AlojamientosEmpresa
   mkdir -p respaldos
   ```
2. Preparar un nombre nuevo para el respaldo. **No sobrescribir archivos previos**:
   ```bash
   RESPALDO="respaldos/alojamientos_$(date +%Y%m%d_%H%M%S).sql"
   if [ -e "$RESPALDO" ]; then echo 'Nombre ocupado: elegir otro antes de continuar'; else echo "Destino libre: $RESPALDO"; fi
   ```
   Si el nombre está ocupado, asignar uno distinto a `RESPALDO` antes de continuar.
3. Ejecutar la exportación sin mostrar contraseñas. La subshell con `noclobber` **impide sobrescribir** un archivo aunque se repita accidentalmente la orden. `--no-tablespaces` evita exigir el privilegio MySQL `PROCESS`. El parámetro `< /dev/null` facilita la ejecución no interactiva en Git Bash:
   ```bash
   (
     set -o noclobber
     docker compose exec -T db sh -c 'MYSQL_PWD="$MYSQL_PASSWORD" exec mysqldump --no-tablespaces --single-transaction --set-gtid-purged=OFF -u"$MYSQL_USER" "$MYSQL_DATABASE"' < /dev/null > "$RESPALDO"
   )
   ESTADO_RESPALDO=$?
   printf 'Código de salida del respaldo: %s\n' "$ESTADO_RESPALDO"
   ```
4. Verificar el código de salida, que el archivo no está vacío, que terminó el volcado y que **no hubo errores en la terminal**. No aprobar el respaldo solo porque el comando termine en cero: `mysqldump` puede generar un archivo incompleto y mostrar errores de permisos, por ejemplo relacionados con `PROCESS`. Comprobar también la salida de errores y el marcador final.
   ```bash
   if [ "${ESTADO_RESPALDO:-1}" -eq 0 ] && test -s "$RESPALDO" && grep -q '^-- Dump completed on' "$RESPALDO"; then
     echo 'Verificaciones automáticas correctas; comprobar que no hubo errores en stderr'
   else
     echo 'Respaldo no válido: revisar salida, permisos y archivo; no restaurar'
   fi
   ```
   **Solo si todas las verificaciones son satisfactorias**, continuar al siguiente punto.
5. Crear una base de prueba nueva llamada `alojamientos_restauracion`, sin `IF NOT EXISTS`. **Si ya existe, el comando fallará: no continuar ni sobrescribir esa base.**
   ```bash
   docker compose exec -T db sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" exec mysql -u root -e "CREATE DATABASE alojamientos_restauracion;"'
   ```
6. Solo si la base se creó correctamente y el respaldo está completo, restaurar:
   ```bash
   docker compose exec -T db sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" exec mysql -u root alojamientos_restauracion' < "$RESPALDO"
   ```
7. Comprobar las tablas restauradas y compararlas con las tablas de la base principal (la cantidad de tablas depende de las migraciones de la versión utilizada):
   ```bash
   docker compose exec -T db sh -c 'MYSQL_PWD="$MYSQL_ROOT_PASSWORD" exec mysql -u root -e "SHOW TABLES FROM alojamientos_db; SHOW TABLES FROM alojamientos_restauracion;"'
   ```
   Comparar también los registros representativos (por ejemplo, usuarios y alojamientos), sin imprimir contraseñas ni otros datos personales en evidencias o salidas compartidas. La restauración no queda validada únicamente porque el comando de importación finalice sin errores.
8. Conservar el respaldo fuera de ambos repositorios; puede contener información privada. No publicarlo en GitHub ni incluirlo en las imágenes.

**Cómo interpretar las instrucciones y los comandos:** `mysqldump` exporta SQL, `--single-transaction` permite un respaldo consistente para tablas InnoDB y `--no-tablespaces` evita exigir `PROCESS`; `set -o noclobber` impide sobrescribir por redirección; el comando `mysql` importa el archivo únicamente en la base de ensayo.

**Si no se obtiene el resultado esperado:** Si el respaldo produce errores o el archivo no tiene marcador final, no restaurarlo. Si `alojamientos_restauracion` ya existe, detenerse o escoger un nombre nuevo después de comprobarlo.

**Resultado esperado:** respaldo completo y tablas restauradas en una base independiente, sin alterar la base principal.

## Paso 40 — Realizar la verificación final local

**Qué se hace y por qué:** La aceptación local reúne las verificaciones anteriores y comprueba que secretos, respaldos y configuración se mantengan separados del código publicado. También registra qué comprobaciones no se realizaron.

1. En Git Bash, desde la carpeta principal, ejecutar:
   ```bash
   cd /c/AlojamientosEmpresa
   docker compose config --quiet
   docker compose ps
   curl -fsS http://localhost:5000/health
   curl -I http://localhost:8080
   git -C backend status --short
   git -C frontend status --short
   git -C backend ls-files .env
   git -C frontend ls-files .env
   ```
2. Si cambió los puertos en el paso 17, sustituir `5000` y `8080` en los comandos `curl` por los valores de `API_HOST_PORT` y `FRONTEND_HOST_PORT` de `.env`.
3. Comprobar que MySQL aparece **healthy**, la API responde con `status: ok`, Nginx responde HTTP **200** y se puede utilizar la interfaz desde el navegador.
4. Confirmar que se aprobaron las pruebas automatizadas del paso 25, las pruebas funcionales de los pasos 36 y 37, la persistencia del paso 38 y el respaldo del paso 39.
5. Revisar `Dockerfile`, `.dockerignore`, `compose.yaml`, `.env.example`, `nginx.conf` y `.gitignore`. Ambos comandos `git ls-files .env` deben producir salida vacía. No publicar `.env`, respaldos ni credenciales. Recordar que `.dockerignore` evita copiar archivos excluidos al contexto de Docker, pero no elimina automáticamente documentación, pruebas u otros archivos que no estén excluidos de la imagen final.
6. Conservar una copia protegida de `compose.yaml` y `.env.example` en la carpeta principal del proyecto: están en `/c/AlojamientosEmpresa` (fuera de los repositorios `backend` y `frontend`) y **no se publican automáticamente al hacer push de esos repositorios**. Se necesitarán como base de la configuración para la VM en Azure.
7. Mantener los valores `http://localhost:5000` y `http://localhost:8080` únicamente para la comprobación local. Al desplegar la aplicación en Azure se configurarán las direcciones públicas HTTPS, credenciales propias del servidor y una nueva compilación del frontend. La VM Ubuntu no requiere WSL 2.

**Cómo interpretar las instrucciones y los comandos:** `docker compose config --quiet` revisa configuración; `ps` estado; `curl` salud y web; `git status` cambios y `git ls-files .env` comprueba que las claves no estén versionadas. Cada prueba cubre una condición distinta.

**Si no se obtiene el resultado esperado:** Si falla cualquiera de las pruebas integradas, identificar su paso de origen. Un HTTP 200 de Nginx no sustituye registro, permisos y persistencia.

**Resultado esperado:** backend, frontend y MySQL funcionan y están comprobados en local; la configuración se puede adaptar a la VM Ubuntu de Azure sin modificar el código de la aplicación. Este paso solo se considera aprobado después de ejecutar todas las verificaciones en el equipo donde se realiza la instalación.

**Criterio de aceptación local:** comprobar realmente las herramientas existentes y realizar solo las instalaciones necesarias. Ejecutar la auditoría de dependencias del Paso 33 en la copia local del frontend; documentar cualquier vulnerabilidad y su corrección antes de publicar. Registrar qué operaciones se ejecutaron y cuáles quedaron pendientes. Una prueba aprobada en otro equipo o en otra revisión del código no sustituye estas comprobaciones.

## Paso 41 — Autenticar GitHub y preparar los repositorios definitivos

**Qué se hace y por qué:** `origin` identifica la fuente original de lectura y `deploy` los repositorios privados donde se publicará el trabajo preparado. Autenticación, permisos y autorización del propietario son requisitos distintos.

**Repositorios del proyecto (verificar siempre el nombre exacto):**

| Uso | Backend | Frontend |
| --- | --- | --- |
| **Fuente original, solo lectura** (`origin`) | <https://github.com/oflodororni/api-alojamientos> | <https://github.com/oflodororni/frontend-alojamientos> |
| **Destino de implementación** (`deploy`) | <https://github.com/oflodororni/alojamientos-api> | <https://github.com/oflodororni/alojamientos-frontend> |

Los repositorios de destino indicados son **privados y ya tienen una rama `main`**; no crear forks ni repositorios adicionales. Las direcciones de clonación (`origin`) y de publicación (`deploy`) son distintas. Cualquier persona puede realizar la implementación local con los repositorios públicos de origen; para publicar en los destinos privados se requieren permisos de escritura y autorización expresa del propietario. No asumir que cualquier cuenta de GitHub tiene acceso. La cuenta que ejecute este procedimiento necesita permiso de escritura sobre ambos destinos. **No cambiar ni eliminar `origin`:** debe seguir apuntando a las fuentes originales. Los pasos siguientes se realizan únicamente en las copias locales.

1. En Git Bash, verificar primero GitHub CLI:
   ```bash
   gh --version
   ```
   Si el comando no existe, comprobar antes de instalarlo y, únicamente si falta, ejecutar en Windows `winget.exe install --id GitHub.cli -e`, cerrar y volver a abrir Git Bash y repetir `gh --version`. No instalar de nuevo una herramienta ya disponible.
2. Comprobar autenticación y cuenta activa:
   ```bash
   gh auth status -h github.com
   gh api user --jq .login
   ```
   Si devuelve **HTTP 401** o no hay sesión, ejecutar:
   ```bash
   gh auth login --hostname github.com --git-protocol https --web
   ```
   Completar la autenticación en el navegador, sin compartir credenciales ni tokens. Repetir `gh auth status -h github.com` y `gh api user --jq .login`. **Detenerse** si no funciona o si la cuenta no está autorizada para usar los destinos.
3. Verificar el acceso a los dos repositorios privados de destino. La cuenta debe poder consultarlos y tener permiso de escritura:
   ```bash
   gh repo view oflodororni/alojamientos-api --json nameWithOwner,isPrivate
   gh repo view oflodororni/alojamientos-frontend --json nameWithOwner,isPrivate
   gh api repos/oflodororni/alojamientos-api --jq '.permissions.push'
   gh api repos/oflodororni/alojamientos-frontend --jq '.permissions.push'
   ```
   Se esperan ambos repositorios con `isPrivate: true` y ambos permisos `push: true`. Si algún comando falla o indica `false`, **no continuar** y solicitar acceso a los destinos indicados. No sustituirlos por otros repositorios sin autorización.
4. Comprobar que el backend conserva el remoto original antes de añadir el remoto de implementación:
   ```bash
   cd /c/AlojamientosEmpresa/backend
   git remote -v
   git remote get-url origin
   ```
   `origin` debe ser `https://github.com/oflodororni/api-alojamientos.git`. Si apunta a otra dirección, detenerse para revisar su procedencia. **Si no existe `deploy`, añadirlo; si ya existe, no modificarlo automáticamente:**
   ```bash
   if git remote get-url deploy >/dev/null 2>&1; then
     git remote get-url deploy
   else
     git remote add deploy https://github.com/oflodororni/alojamientos-api.git
   fi
   git remote -v
   ```
   Confirmar que `deploy` es exactamente `https://github.com/oflodororni/alojamientos-api.git`; si no coincide, detenerse antes de seguir.
5. Comprobar el frontend del mismo modo:
   ```bash
   cd /c/AlojamientosEmpresa/frontend
   git remote -v
   git remote get-url origin
   ```
   `origin` debe ser `https://github.com/oflodororni/frontend-alojamientos.git`. **Si no existe `deploy`, añadirlo; si ya existe, comprobarlo sin sobrescribirlo:**
   ```bash
   if git remote get-url deploy >/dev/null 2>&1; then
     git remote get-url deploy
   else
     git remote add deploy https://github.com/oflodororni/alojamientos-frontend.git
   fi
   git remote -v
   ```
   `deploy` debe ser exactamente `https://github.com/oflodororni/alojamientos-frontend.git`.
6. Comprobar que se puede consultar cada destino e identificar si `main` ya existe. La rama `main` puede existir en los destinos. Antes de publicar, se debe comparar con el historial local y evitar duplicar o sobrescribir commits:
   ```bash
   git -C /c/AlojamientosEmpresa/backend ls-remote --heads deploy main
   git -C /c/AlojamientosEmpresa/frontend ls-remote --heads deploy main
   ```
   En destinos vacíos, los comandos terminan correctamente **sin mostrar una referencia**. En destinos ya publicados, una referencia `main` **es normal**: compararla con `git rev-parse HEAD`, revisar si el historial corresponde y detener la publicación si hay discrepancias no resueltas. No ejecutar `push --force`. Si aparece un error de autenticación o conexión, no continuar.

**Cómo interpretar las instrucciones y los comandos:** `gh --version` comprueba la herramienta; `gh auth status` verifica sesión; `gh api user` muestra la cuenta; `gh repo view` consulta los destinos; `git remote add deploy` agrega otra dirección sin reemplazar `origin`.

**Si no se obtiene el resultado esperado:** Si hay HTTP 401, autenticar con `gh auth login`; si la cuenta carece de permisos o el remoto es distinto, detenerse y solicitar autorización, sin crear forks.

**Resultado esperado:** GitHub CLI autenticado, acceso autorizado a los dos repositorios privados, `origin` conservado para el código fuente y `deploy` configurado para los destinos correctos. **No se ha publicado ningún cambio.**

## Paso 42 — Crear la integración continua del backend

**Qué se hace y por qué:** La integración continua del backend repetirá Pytest y una construcción Docker en GitHub cuando haya cambios o solicitudes a `main`. Así se comprueba el código en un entorno remoto independiente del equipo local.

El workflow se prepara en la copia local `backend` y se publicará exclusivamente en `oflodororni/alojamientos-api` mediante el remoto `deploy` del paso 41. El repositorio fuente `oflodororni/api-alojamientos` no se modifica.

1. En `backend`, comprobar si existe `.github/workflows/ci.yml`. Si existe, revisar su contenido antes de reemplazarlo.
2. Crear `.github/workflows/ci.yml` con el siguiente contenido:

   ```yaml
   name: CI Backend
   
   on:
     push:
       branches: [main]
     pull_request:
       branches: [main]
   
   permissions:
     contents: read
   
   jobs:
     pruebas:
       runs-on: ubuntu-latest
       steps:
         - name: Descargar codigo
           uses: actions/checkout@v4
         - name: Configurar Python
           uses: actions/setup-python@v5
           with:
             python-version: '3.11'
         - name: Instalar dependencias
           run: |
             python -m pip install --upgrade pip
             python -m pip install -r requirements.txt
         - name: Ejecutar pruebas
           run: python -m pytest -q
   
     imagen:
       runs-on: ubuntu-latest
       steps:
         - name: Descargar codigo
           uses: actions/checkout@v4
         - name: Comprobar imagen del backend
           run: docker build -t alojamientos-api:ci .
   ```

3. Comprobar que el archivo está en la carpeta correcta:
   ```bash
   cd /c/AlojamientosEmpresa/backend
   git status --short
   ```
4. Verificar también que el archivo `Dockerfile` creado durante la preparación local está en la raíz de `backend` y que no se está agregando `.env`.
5. Antes de publicar, comprobar la reproducción de las pruebas dentro de una imagen nueva, desde `backend`:
   ```bash
   docker build -t alojamientos-api:ci .
   docker run --rm -e FLASK_TESTING=true alojamientos-api:ci python -m pytest -q
   ```
   Se espera que todas las pruebas pasen. Esta verificación local **no sustituye** la ejecución posterior en GitHub Actions.

**Cómo interpretar las instrucciones y los comandos:** `actions/checkout` obtiene el commit en GitHub; `setup-python` selecciona Python; `pip` instala dependencias; `pytest` prueba Flask; `docker build` comprueba la imagen. Son dos trabajos (`pruebas` e `imagen`) distintos.

**Si no se obtiene el resultado esperado:** Si falla Pytest en la imagen nueva, corregir el problema local antes de publicar; una definición YAML correcta no equivale a un workflow exitoso.

**Resultado esperado:** el workflow está preparado para ejecutar Pytest y comprobar la construcción Docker en cada cambio a `main` o solicitud de incorporación a `main`. La ejecución real se comprobará al publicarlo.

## Paso 43 — Crear la integración continua del frontend

**Qué se hace y por qué:** La integración continua del frontend instalará dependencias con el archivo de bloqueo, compilará Vite y construirá la imagen Docker. Este workflow no despliega en Azure ni sustituye por sí solo una auditoría npm.

El workflow se prepara en la copia local `frontend` y se publicará exclusivamente en `oflodororni/alojamientos-frontend` mediante el remoto `deploy` del paso 41. El repositorio fuente `oflodororni/frontend-alojamientos` no se modifica.

1. En `frontend`, comprobar si existe `.github/workflows/ci.yml`. Si existe, revisarlo antes de reemplazarlo.
2. Crear `.github/workflows/ci.yml` con el siguiente contenido:

   ```yaml
   name: CI Frontend
   
   on:
     push:
       branches: [main]
     pull_request:
       branches: [main]
   
   permissions:
     contents: read
   
   jobs:
     construir:
       runs-on: ubuntu-latest
       steps:
         - name: Descargar codigo
           uses: actions/checkout@v4
         - name: Configurar Node.js
           uses: actions/setup-node@v4
           with:
             node-version: '22'
             cache: npm
         - name: Instalar dependencias
           run: npm ci
         - name: Compilar frontend
           env:
             VITE_API_URL: http://localhost:5000/api/v1
           run: npm run build
   
     imagen:
       runs-on: ubuntu-latest
       steps:
         - name: Descargar codigo
           uses: actions/checkout@v4
         - name: Comprobar imagen del frontend
           run: docker build --build-arg VITE_API_URL=http://localhost:5000/api/v1 -t alojamientos-frontend:ci .
   ```

3. Comprobar si existe `frontend/.gitignore`. Si falta, crearlo con estas reglas; si existe, añadir solo las reglas que falten:
   ```gitignore
   .env
   .env.*
   !.env.example
   node_modules/
   dist/
   *.log
   ```
4. Ejecutar:
   ```bash
   cd /c/AlojamientosEmpresa/frontend
   git status --short
   git check-ignore -v --no-index .env
   ```
5. Comprobar que `Dockerfile`, `nginx.conf`, `package.json` y `package-lock.json` están disponibles y que `.env` está excluido de Git.
6. Como comprobación local previa a CI, ejecutar desde `frontend`:
   ```bash
   docker build --build-arg VITE_API_URL=http://localhost:5000/api/v1 -t alojamientos-frontend:ci .
   ```
   La imagen debe construirse. Los avisos de npm no desaparecen por el hecho de construir: registrar cualquier vulnerabilidad pendiente de análisis. Esta verificación local **no sustituye** GitHub Actions.

**Cómo interpretar las instrucciones y los comandos:** `actions/setup-node` fija Node 22; `npm ci` instala exactamente el lockfile; `npm run build` genera Vite; `docker build --build-arg` reproduce la compilación en contenedor. Un workflow correcto no garantiza auditoría de dependencias.

**Si no se obtiene el resultado esperado:** Si falla el build, revisar Vite y dependencias; para cambios de seguridad, registrar el resultado de `npm audit` y recompilar antes de publicar.

**Alcance de la seguridad:** este workflow valida compilación e imagen, pero **no ejecuta automáticamente `npm audit`**. Conservar como evidencia la auditoría ejecutada en el Paso 33 y repetirla al actualizar `package-lock.json`. Un aviso de npm requiere análisis, aunque CI aparezca en verde.

**Resultado esperado:** el workflow está preparado para comprobar `npm ci`, `npm run build` y la construcción de la imagen Docker, sin publicar todavía la aplicación en Azure.

## Paso 44 — Publicar en los destinos autorizados y comprobar la CI

**Qué se hace y por qué:** La publicación final debe ser explícita, limitada a los destinos autorizados y seguida de una verificación del commit exacto que aprobó GitHub Actions. Un `push` aceptado no equivale a CI aprobada.

**Condiciones previas:** los pasos 41–43 están terminados; el usuario ha autorizado expresamente publicar en **ambos** repositorios de destino. No basta con tener permisos técnicos: si no existe esa autorización, **detenerse antes de `git push`**.

1. En Git Bash, desde la carpeta principal, revisar los cambios y la rama activa de las copias locales:
   ```bash
   cd /c/AlojamientosEmpresa
   git -C backend branch --show-current
   git -C frontend branch --show-current
   git -C backend status --short
   git -C frontend status --short
   git -C backend remote -v
   git -C frontend remote -v
   git -C backend config --get user.name
   git -C backend config --get user.email
   git -C frontend config --get user.name
   git -C frontend config --get user.email
   ```
   Si faltan nombre o correo en alguno de los dos repositorios, definir los valores correctos y configurarlos **solo en ese repositorio** mediante `git config --local`, como en el paso 8. No inventar identidades ni modificar la configuración global.
   Se espera la rama `main` en ambos proyectos, `origin` apuntando a los repositorios fuente y `deploy` a los destinos del paso 41. **No utilizar `origin` para publicar.**
2. Antes de publicar, comprobar que los destinos continúan accesibles y que no se sobrescribirá una rama remota que haya aparecido después del paso 41:
   ```bash
   gh auth status -h github.com
   git -C backend ls-remote --heads deploy main
   git -C frontend ls-remote --heads deploy main
   ```
   Si un destino está vacío, el comando no devuelve referencias; si `main` ya existe, se debe examinar su historial y confirmar que los cambios locales pueden integrarse sin sobrescribirlo. **No utilizar `--force`.**
3. En el backend, preparar **solo los archivos nuevos o modificados para Docker y CI**, sin hacer `git add .`:
   ```bash
   cd /c/AlojamientosEmpresa/backend
   git add .github/workflows/ci.yml Dockerfile .dockerignore .gitignore
   git diff --cached --check
   git diff --cached --name-only
   git status --short
   ```
   Revisar la lista antes de confirmar. No agregar `.env`, contraseñas, respaldos SQL, archivos de prueba locales ni capturas privadas. Comprobar también los demás archivos versionados con `git ls-files`: **el primer push de `main` incluye el código y el historial ya versionados del repositorio fuente**, incluso documentación y pruebas que no formen parte de la imagen Docker.
4. En el frontend, hacer la misma revisión:
   ```bash
   cd /c/AlojamientosEmpresa/frontend
   git add .github/workflows/ci.yml Dockerfile .dockerignore nginx.conf .gitignore
   git diff --cached --check
   git diff --cached --name-only
   git status --short
   ```
   Si en el Paso 33 se corrigieron vulnerabilidades npm y `package-lock.json` cambió, **revisar primero** `git diff -- package.json package-lock.json`; solo después de aprobar esos cambios, preparar también el lockfile con `git add package-lock.json`, repetir `git diff --cached --check` y verificar la lista exacta de archivos preparados. No introducir `package.json` a menos que realmente se haya modificado y revisado.
   No publicar `node_modules/`, `dist/`, `.env`, respaldos ni resultados temporales. Si un archivo privado ya estuviera versionado, **detenerse y corregirlo antes de hacer push**: `.gitignore` no elimina archivos previamente versionados ni borra secretos del historial.
5. Antes de la primera publicación, examinar también `git ls-files` y el historial heredado: el push inicial puede incluir documentación, tests y archivos compilados `.pyc` previamente versionados, aunque `.dockerignore` los excluya de la imagen. Si hay datos privados en **cualquier commit anterior**, detenerse y resolverlo con autorización; `.gitignore` no limpia historial.
6. Solicitar y registrar la **autorización explícita del usuario para publicar** en estos destinos exactos:
   - Backend: <https://github.com/oflodororni/alojamientos-api>
   - Frontend: <https://github.com/oflodororni/alojamientos-frontend>

   Solo si la cuenta tiene permisos, existe autorización expresa y el historial local permite una actualización de avance rápido (*fast-forward*), crear los commits y publicar **exclusivamente a `deploy`**:
   ```bash
   cd /c/AlojamientosEmpresa/backend
   git commit -m "Configurar Docker e integracion continua del backend"
   git push -u deploy main

   cd /c/AlojamientosEmpresa/frontend
   git commit -m "Configurar Docker e integracion continua del frontend"
   git push -u deploy main
   ```
   Si no existen cambios por confirmar, revisar `git status` y no fabricar commits vacíos. Si el push se rechaza, detenerse y revisar el remoto; no hacer push forzado. **Nunca utilizar `git push origin main`.**
7. Abrir la pestaña **Actions** en los repositorios de destino, no en las fuentes originales:
   - Backend: <https://github.com/oflodororni/alojamientos-api/actions>
   - Frontend: <https://github.com/oflodororni/alojamientos-frontend/actions>

   Si las políticas del repositorio solicitan habilitar GitHub Actions, hacerlo únicamente con autorización. También puede comprobar las ejecuciones por Git Bash:
   ```bash
   gh run list --repo oflodororni/alojamientos-api --limit 5
   gh run list --repo oflodororni/alojamientos-frontend --limit 5
   ```
8. Confirmar que las dos integraciones continuas finalizaron correctamente: en el backend, **Pytest y construcción Docker**; en el frontend, **`npm ci`, compilación Vite y construcción Docker**. Ante una ejecución fallida, revisar sus registros en Actions, corregir y repetir. Registrar los enlaces de las ejecuciones, sus estados finales y los **SHA de los commits**. Confirmar que los commits locales coinciden con `deploy/main` y con los `head_sha` de las ejecuciones de Actions:
   ```bash
   git -C /c/AlojamientosEmpresa/backend rev-parse HEAD
   git -C /c/AlojamientosEmpresa/backend ls-remote deploy refs/heads/main
   git -C /c/AlojamientosEmpresa/frontend rev-parse HEAD
   git -C /c/AlojamientosEmpresa/frontend ls-remote deploy refs/heads/main
   ```
   Utilizar `gh run view ID_DE_EJECUCION --repo PROPIETARIO/REPOSITORIO` para revisar cada ejecución real. El simple éxito de `git push` o una ejecución CI de **otro commit** no prueba esta publicación.
9. Recordar que `compose.yaml` y `.env.example` ubicados en `/c/AlojamientosEmpresa` están **fuera de ambos repositorios**, por lo que no se subirán con estos comandos. Conservarlos protegidos para adaptarlos después a un despliegue en Azure. **Esta fase configura CI; todavía no configura despliegue continuo (CD) ni publica la aplicación en Azure.**

**Cómo interpretar las instrucciones y los comandos:** `git diff --cached` revisa exactamente qué entrará en el commit; `git commit` confirma cambios locales; `git push ... deploy main` publica solo en el remoto autorizado; `gh run list/view` y los SHA comprueban el resultado de CI para ese mismo commit.

**Si no se obtiene el resultado esperado:** Si el destino ya tiene `main` y la historia no es una continuación válida, detenerse: no usar `--force`. Si GitHub Actions falla, consultar el job y el commit correcto.

**Cuando el repositorio de destino ya tiene `main`:** la publicación directa desde un clon nuevo del origen puede fallar porque `deploy/main` contiene commits que la copia local aún no tiene. No utilizar `--force`, no eliminar ramas ni modificar `origin`. Para publicar cambios posteriores se debe partir de la última versión del destino, examinar su historial y llevar únicamente los cambios revisados. Si no se tienen permisos de escritura, completar la implementación y las pruebas locales sin realizar el push. La preparación de CI puede verificarse localmente, pero solo una ejecución real en GitHub permite aprobar CI remota.

**Resultado esperado:** el código preparado queda publicado en `oflodororni/alojamientos-api` y `oflodororni/alojamientos-frontend` con autorización, sin modificar los repositorios originales. Los dos workflows de GitHub Actions tienen ejecuciones aprobadas y verificadas; no se da por aprobado este paso solo porque `git push` termine correctamente.
