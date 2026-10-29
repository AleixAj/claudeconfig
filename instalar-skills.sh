#!/usr/bin/env bash
# Instala las skills del proyecto desde sus repos publicos.
# Uso:  bash instalar-skills.sh        (desde la raiz del repo)
# Requiere git. No requiere nada mas.
set -u

DEST=".claude/skills"
AGENTS=".claude/agents"
TMP="${TMPDIR:-/tmp}/skills-install-$$"
mkdir -p "$DEST" "$AGENTS" "$TMP"
ok=0; fail=0

# repo | ruta dentro del repo | nombre de carpeta final
LISTA="
pbakaus/impeccable|.claude/skills/impeccable|impeccable
nextlevelbuilder/ui-ux-pro-max-skill|.claude/skills/ui-ux-pro-max|ui-ux-pro-max
GoogleChrome/modern-web-guidance|skills/modern-web-guidance|modern-web-guidance
emilkowalski/skills|skills/emil-design-eng|emil-design-eng
emilkowalski/skills|skills/review-animations|review-animations
meodai/skill.color-expert|.|color-expert
blader/humanizer|.|humanizer
vercel-labs/agent-skills|skills/web-design-guidelines|web-design-guidelines
vercel-labs/agent-skills|skills/composition-patterns|vercel-composition-patterns
vercel-labs/agent-skills|skills/react-best-practices|vercel-react-best-practices
vercel-labs/agent-skills|skills/react-view-transitions|vercel-react-view-transitions
supabase-community/supabase-plugin|skills/supabase|supabase
supabase-community/supabase-plugin|skills/supabase-postgres-best-practices|supabase-postgres-best-practices
oso95/scroll-world|skills/scroll-world|scroll-world
anthropics/skills|skills/webapp-testing|webapp-testing
anthropics/claude-plugins-official|plugins/skill-creator/skills/skill-creator|skill-creator
cloudai-x/threejs-skills|skills/threejs-animation|threejs-animation
cloudai-x/threejs-skills|skills/threejs-fundamentals|threejs-fundamentals
cloudai-x/threejs-skills|skills/threejs-interaction|threejs-interaction
cloudai-x/threejs-skills|skills/threejs-lighting|threejs-lighting
cloudai-x/threejs-skills|skills/threejs-loaders|threejs-loaders
cloudai-x/threejs-skills|skills/threejs-materials|threejs-materials
cloudai-x/threejs-skills|skills/threejs-performance|threejs-performance
cloudai-x/threejs-skills|skills/threejs-postprocessing|threejs-postprocessing
cloudai-x/threejs-skills|skills/threejs-react-three-fiber|threejs-react-three-fiber
cloudai-x/threejs-skills|skills/threejs-shaders|threejs-shaders
cloudai-x/threejs-skills|skills/threejs-textures|threejs-textures
"

clonar() { # $1 = repo
  local slug; slug=$(echo "$1" | tr '/.' '__')
  if [ ! -d "$TMP/$slug" ]; then
    echo "  bajando $1 ..."
    git clone --depth 1 --quiet "https://github.com/$1" "$TMP/$slug" 2>/dev/null || return 1
  fi
  return 0
}

echo "Instalando skills en $DEST"
echo
while IFS='|' read -r repo ruta nombre; do
  [ -z "${repo:-}" ] && continue
  if ! clonar "$repo"; then
    echo "  FALLO  $nombre (no se pudo clonar $repo)"; fail=$((fail+1)); continue
  fi
  slug=$(echo "$repo" | tr '/.' '__')
  origen="$TMP/$slug/$ruta"
  if [ ! -f "$origen/SKILL.md" ]; then
    echo "  FALLO  $nombre (no existe $ruta en $repo; puede haber cambiado)"
    fail=$((fail+1)); continue
  fi
  rm -rf "$DEST/$nombre"
  cp -r "$origen" "$DEST/$nombre"
  rm -rf "$DEST/$nombre/.git"
  echo "  ok     $nombre"
  ok=$((ok+1))
done <<< "$LISTA"

# Los 4 subagentes de impeccable viven en su mismo repo
if [ -d "$TMP/pbakaus_impeccable/.claude/agents" ]; then
  cp "$TMP/pbakaus_impeccable/.claude/agents/"impeccable-*.md "$AGENTS/" 2>/dev/null \
    && echo "  ok     4 agentes impeccable-*"
fi

rm -rf "$TMP"
echo
echo "Instaladas: $ok    Fallos: $fail"
echo
echo "NO se instalan por aqui (no tienen repo publico localizable):"
echo "  brandkit, design-taste-frontend, imagegen-frontend-web,"
echo "  imagegen-frontend-mobile, scroll-craft, next-bundle-optimizer,"
echo "  codebase-memory"
echo "Esas van copiadas dentro del repo. Mira SETUP.md."
