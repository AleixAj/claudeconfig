#!/usr/bin/env bash
# Instala este pack de configuracion de Claude Code.
#
#   bash instalar.sh              -> en el proyecto actual (./.claude)
#   bash instalar.sh --global     -> para todos tus proyectos (~/.claude)
#   bash instalar.sh --shopify    -> ademas copia el CLAUDE.md del tema Shopify
#   bash instalar.sh --forzar     -> sobrescribe skills que ya tengas
#
# Por defecto NO sobrescribe nada. Lo que ya existe se salta y se avisa.
set -u

ORIGEN="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GLOBAL=0; SHOPIFY=0; FORZAR=0
for a in "$@"; do
  case "$a" in
    --global)  GLOBAL=1 ;;
    --shopify) SHOPIFY=1 ;;
    --forzar|--force) FORZAR=1 ;;
    -h|--help) sed -n '2,9p' "$0" | sed 's/^# \?//'; exit 0 ;;
    *) echo "Opcion desconocida: $a"; exit 1 ;;
  esac
done

if [ "$GLOBAL" = 1 ]; then
  BASE="$HOME/.claude"; DONDE="global (~/.claude)"
else
  BASE="$(pwd)/.claude";  DONDE="este proyecto ($(pwd)/.claude)"
fi

echo "Instalando en: $DONDE"
echo
mkdir -p "$BASE/skills" "$BASE/agents"

nuevas=0; saltadas=0
for d in "$ORIGEN"/skills/*/; do
  n=$(basename "$d")
  if [ -e "$BASE/skills/$n" ] && [ "$FORZAR" != 1 ]; then
    echo "  ya existe, se salta   $n"; saltadas=$((saltadas+1)); continue
  fi
  rm -rf "$BASE/skills/$n"
  cp -r "$d" "$BASE/skills/$n"
  nuevas=$((nuevas+1))
done
echo "  skills: $nuevas instaladas, $saltadas saltadas"

ag=0
for f in "$ORIGEN"/agents/*.md; do
  n=$(basename "$f")
  if [ -e "$BASE/agents/$n" ] && [ "$FORZAR" != 1 ]; then continue; fi
  cp "$f" "$BASE/agents/$n"; ag=$((ag+1))
done
echo "  agentes: $ag instalados"

# settings.json NUNCA se sobrescribe: puede tener tus permisos personales.
if [ -e "$BASE/settings.json" ]; then
  cp "$ORIGEN/settings.json" "$BASE/settings.pack.json"
  echo
  echo "  OJO: ya tenias settings.json, no lo he tocado."
  echo "       Los permisos del pack estan en $BASE/settings.pack.json"
  echo "       Copia a mano lo que quieras de 'permissions.allow' y borra ese archivo."
else
  cp "$ORIGEN/settings.json" "$BASE/settings.json"
  echo "  settings.json: instalado"
fi

if [ "$SHOPIFY" = 1 ]; then
  if [ "$GLOBAL" = 1 ]; then
    echo
    echo "  --shopify no tiene sentido con --global: el CLAUDE.md del tema"
    echo "  es de proyecto. Ejecutalo sin --global dentro del repo del tema."
  elif [ -e "CLAUDE.md" ]; then
    echo
    echo "  Ya hay un CLAUDE.md en este proyecto, no lo he tocado."
    echo "  La plantilla esta en $ORIGEN/plantillas/CLAUDE.shopify.md"
  else
    cp "$ORIGEN/plantillas/CLAUDE.shopify.md" "CLAUDE.md"
    echo "  CLAUDE.md del tema Shopify: copiado a $(pwd)/CLAUDE.md"
  fi
fi

echo
echo "Listo. Abre 'claude' y comprueba con /skills que estan las 34."
