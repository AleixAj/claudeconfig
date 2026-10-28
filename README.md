# claudeconfig

Mi configuración de Claude Code: 34 skills, 4 subagentes y unos permisos
base. Sirve para que cualquiera tenga la misma configuración que yo con un
comando, sin ir instalando skills una por una.

Una **skill** es un manual que Claude carga solo cuando el tema aparece
(diseño, CSS moderno, accesibilidad, Three.js...). Un **subagente** es un
Claude secundario con un trabajo concreto.

## Instalar

En el proyecto donde quieras usarlo:

```bash
git clone --depth 1 https://github.com/AleixAj/claudeconfig ~/claudeconfig
bash ~/claudeconfig/instalar.sh
```

Eso crea `.claude/skills` y `.claude/agents` en el proyecto actual.

Si lo quieres para **todos** tus proyectos a la vez:

```bash
bash ~/claudeconfig/instalar.sh --global
```

Lo instala en `~/.claude`, que Claude Code lee en cualquier carpeta.

Opciones:

| Opción | Qué hace |
|---|---|
| (ninguna) | Instala en `./.claude` del proyecto actual |
| `--global` | Instala en `~/.claude`, para todos los proyectos |
| `--shopify` | Además copia el `CLAUDE.md` con las reglas del tema Shopify |
| `--forzar` | Sobrescribe skills que ya tuvieras |

Por defecto **no sobrescribe nada**: lo que ya existe se salta y te avisa.
`settings.json` nunca se toca si ya tienes uno; te deja los permisos del pack
en `settings.pack.json` para que copies lo que quieras a mano.

Para comprobar que ha ido bien, abre `claude` y escribe `/skills`.

## Qué hay aquí

| Carpeta | Qué es |
|---|---|
| `skills/` | Las 34 skills |
| `agents/` | 4 subagentes de `impeccable` (diseño de interfaces) |
| `settings.json` | Permisos base: git, npm, y los comandos de lectura de Shopify. `shopify theme push/publish/delete` está en "preguntar siempre" a propósito |
| `plantillas/CLAUDE.shopify.md` | Reglas de proyecto para un tema de Shopify |
| `instalar.sh` | El instalador |
| `instalar-skills.sh` | Alternativa: baja 27 de las skills de sus repos originales |

Las 11 skills `threejs-*` son de 3D. No estorban (solo se cargan si sale el
tema), pero se pueden borrar si no las vas a usar.

## Alternativa: bajarlas de sus repos originales

```bash
bash instalar-skills.sh
```

Clona cada skill de su repo público. Probado: 27 skills + 4 agentes, 0 fallos.

Tiene dos límites:

1. **7 skills no tienen repo público localizable** y no se instalan así:
   `brandkit`, `design-taste-frontend`, `imagegen-frontend-web`,
   `imagegen-frontend-mobile`, `scroll-craft`, `next-bundle-optimizer` y
   `codebase-memory`. Las cuatro primeras venían de `Leonxlnx/taste-skill`,
   que las ha fusionado en una sola skill nueva.
2. **Te llega la versión de hoy, no la de este repo.** Comprobado: de las 27,
   7 ya son distintas. Si lo que quieres es tener lo mismo que yo, usa
   `instalar.sh`.

## Para el proyecto del tema Shopify

Dentro del repo del tema:

```bash
bash ~/claudeconfig/instalar.sh --shopify
```

Eso deja las skills en `.claude/` y las reglas en `CLAUDE.md`. Si no quieres
las skills dentro del repo del tema, usa `--global` y luego copia solo
`plantillas/CLAUDE.shopify.md` como `CLAUDE.md`.

## Licencias

Las skills son de terceros. Están aquí tal como las tengo instaladas, sin
modificar. En `CREDITOS.md` está de dónde sale cada una. Varias no declaran
licencia, así que **si este repo es público, replicarlas aquí es discutible**.
Lo razonable es tenerlo privado y dar acceso a quien lo necesite, o usar
`instalar-skills.sh` para que cada uno las baje de su origen.

## Si estás en Windows

Algunas skills tienen rutas internas largas y Git las rechaza por el límite
de 260 caracteres de Windows. Una vez por máquina:

```bash
git config --global core.longpaths true
```

Y clona en una ruta corta (`C:\dev\claudeconfig`, no en una carpeta a seis
niveles de profundidad). Me pasó montando esto, así que te lo ahorro.
