# Origen de cada skill

Ninguna skill de este repo es mía. Están tal como las tengo instaladas.
Comparadas con sus repos de origen el 29 de octubre de 2026, fichero a
fichero (ignorando los saltos de línea, que en Windows son distintos).

Ese día actualicé siete: `impeccable` (4.3.1 a 4.8.0, con sus 4 agentes),
`humanizer` (2.8.0 a 3.1.0), `ui-ux-pro-max`, `skill-creator`,
`emil-design-eng`, `review-animations` y `vercel-react-view-transitions`.

**Única cosa modificada:** en `ui-ux-pro-max/SKILL.md` la versión nueva llama
a su buscador con `${CLAUDE_PLUGIN_ROOT}/.claude/skills/...`, que solo existe
si la instalas como plugin. Aquí se instala como skill normal, así que esa
variable queda vacía y la ruta no lleva a ninguna parte. Cambié esas 11 rutas
por `<SKILL_DIR>/scripts/search.py` y añadí una línea explicando que
`<SKILL_DIR>` es la carpeta donde está el propio SKILL.md. Nada más.

| Skill | Repo de origen | Licencia |
|---|---|---|
| impeccable (+ los 4 agentes) | [pbakaus/impeccable](https://github.com/pbakaus/impeccable) | Apache 2.0 |
| ui-ux-pro-max | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) | no declarada en la skill |
| modern-web-guidance | [GoogleChrome/modern-web-guidance](https://github.com/GoogleChrome/modern-web-guidance) | no declarada en la skill |
| emil-design-eng | [emilkowalski/skills](https://github.com/emilkowalski/skills) | no declarada |
| review-animations | [emilkowalski/skills](https://github.com/emilkowalski/skills) | no declarada |
| color-expert | [meodai/skill.color-expert](https://github.com/meodai/skill.color-expert) | ver LICENSE de la skill |
| humanizer | [blader/humanizer](https://github.com/blader/humanizer) | MIT |
| web-design-guidelines | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | no declarada |
| vercel-composition-patterns | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) (allí: `composition-patterns`) | MIT |
| vercel-react-best-practices | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) (allí: `react-best-practices`) | MIT |
| vercel-react-view-transitions | [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) (allí: `react-view-transitions`) | MIT |
| supabase | [supabase-community/supabase-plugin](https://github.com/supabase-community/supabase-plugin) | no declarada |
| supabase-postgres-best-practices | [supabase-community/supabase-plugin](https://github.com/supabase-community/supabase-plugin) | MIT |
| scroll-world | [oso95/scroll-world](https://github.com/oso95/scroll-world) | no declarada |
| webapp-testing | [anthropics/skills](https://github.com/anthropics/skills) | ver LICENSE.txt de la skill |
| skill-creator | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) | ver LICENSE.txt de la skill |
| threejs-* (11 skills) | [cloudai-x/threejs-skills](https://github.com/cloudai-x/threejs-skills) | no declarada |

## Sin origen localizado

No encontré repo público para estas. Si sabes de dónde salen, añádelo aquí.

| Skill | Qué sé |
|---|---|
| brandkit | Venía de [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill), que ha fusionado sus skills en una sola llamada `taste-skill`. Esta ya no está allí. |
| design-taste-frontend | Igual que la anterior. |
| imagegen-frontend-web | Igual. |
| imagegen-frontend-mobile | Igual. |
| scroll-craft | No encontré repo. En `oso95/scroll-world` solo está `scroll-world`, así que no viene de ahí. |
| next-bundle-optimizer | No encontré repo. No es `vercel-optimize` de `vercel-labs/agent-skills`: lo comparé el 29 de octubre de 2026 y es otra skill distinta. |
| codebase-memory | Va emparejada con el binario `codebase-memory-mcp`. Suelta no sirve de nada. |

## El MCP de memoria de código

La skill `codebase-memory` necesita el MCP `codebase-memory-mcp`, que es un
ejecutable aparte. No está aquí porque es un binario local y la ruta cambia
en cada máquina. No hace falta para nada. Si lo instalas, añade a tu
`~/.claude/.mcp.json`:

```json
{
  "mcpServers": {
    "codebase-memory-mcp": {
      "command": "RUTA/A/codebase-memory-mcp.exe"
    }
  }
}
```
