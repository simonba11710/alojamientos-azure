#!/usr/bin/env bash
set -euo pipefail
cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.."
compose=(sudo docker compose --env-file .env -f compose.yaml)

case "${1:-}" in
  internal|verify) ;;
  publish) compose+=(-f compose.http.yaml) ;;
  *) echo "Uso: bash infra/deploy.sh {internal|verify|publish}" >&2; exit 2 ;;
esac

if [[ "$1" == internal ]]; then
  test -f backend/requirements.txt
  test -f frontend/package-lock.json

  if [[ ! -e .env ]]; then
    if sudo docker volume inspect alojamientos_mysql_data >/dev/null 2>&1; then
      echo 'Existe el volumen MySQL. Recupera el .env original antes de continuar.' >&2
      exit 1
    fi
    python3 - <<'PY'
from pathlib import Path
from secrets import token_hex
import os

os.umask(0o077)
secrets = ("MYSQL_ROOT_PASSWORD", "MYSQL_PASSWORD", "SECRET_KEY")
lines = Path(".env.example").read_text().splitlines()
with open(".env", "x") as output:
    for line in lines:
        key, _, _ = line.partition("=")
        print(f"{key}={token_hex(32)}" if key in secrets else line, file=output)
PY
  fi

  "${compose[@]}" config --quiet
  sudo docker volume create alojamientos_mysql_data >/dev/null
  "${compose[@]}" up -d --wait --wait-timeout 180 mysql
  "${compose[@]}" build backend
  table_count=$("${compose[@]}" exec -T mysql sh -ec 'MYSQL_PWD="$MYSQL_PASSWORD" mysql -h 127.0.0.1 -u "$MYSQL_USER" -D "$MYSQL_DATABASE" -Nse "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = DATABASE()"')
  if [[ "$table_count" == 0 ]]; then
    "${compose[@]}" run --rm --no-deps backend flask --app 'app:crear_app()' db upgrade
  else
    current=$("${compose[@]}" run --rm --no-deps backend flask --app 'app:crear_app()' db current)
    if [[ "$current" != 'ebb9cbe49179 (head)' ]]; then
      echo 'La base ya contiene tablas y su revisión difiere. Revisa el esquema antes de migrar.' >&2
      exit 1
    fi
  fi
  "${compose[@]}" up -d --no-deps --wait --wait-timeout 90 backend
  "${compose[@]}" build frontend
  "${compose[@]}" up -d --no-deps frontend
elif [[ "$1" == publish ]]; then
  "${compose[@]}" config --quiet
  "${compose[@]}" up -d --no-deps frontend
fi

"${compose[@]}" ps
"${compose[@]}" exec -T mysql sh -ec 'MYSQL_PWD="$MYSQL_PASSWORD" mysql -h 127.0.0.1 -u "$MYSQL_USER" -D "$MYSQL_DATABASE" -e "SELECT VERSION(), DATABASE(), 1; SHOW TABLES;"'
"${compose[@]}" exec -T backend flask --app 'app:crear_app()' db current
"${compose[@]}" exec -T backend flask --app 'app:crear_app()' db heads
"${compose[@]}" exec -T frontend nginx -t
"${compose[@]}" exec -T frontend sh -ec '
  for path in / /health /api/v1/alojamientos; do
    wget -q -O /dev/null -T 5 "http://127.0.0.1$path"
    printf "Correcto: %s\n" "$path"
  done'
