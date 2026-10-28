# claudeconfig

Mi configuración de Claude Code: 34 skills, 4 subagentes y unos permisos
base. Sirve para que cualquiera tenga la misma configuración que yo con un
comando, sin ir instalando skills una por una.

Una **skill** es un manual que Claude carga solo cuando el tema aparece
(diseño, CSS moderno, accesibilidad, Three.js...). Un **subagente** es un
Claude secundario con un trabajo concreto.

## La forma más fácil: que lo haga Claude

```bash
git clone https://github.com/AleixAj/claudeconfig
cd claudeconfig
claude
```

Y le dices: **"instala esto"**. En [CLAUDE.md](CLAUDE.md) están las
instrucciones para él: te preguntará dónde lo quieres y lo hará solo.

## A mano

En Linux, macOS o Git Bash:

```bash
bash instalar.sh --global                  # para todos tus proyectos
cd /ruta/del/proyecto && bash /ruta/a/claudeconfig/instalar.sh   # solo ahí
```

En Windows con PowerShell:

```powershell
.\instalar.ps1 -Global
.\instalar.ps1 -Proyecto C:\ruta\del\proyecto
```

Los dos scripts hacen lo mismo. Opciones:

| bash | PowerShell | Qué hace |
|---|---|---|
| (nada) | (nada) | Instala en `.claude/` de la carpeta actual |
| — | `-Proyecto <ruta>` | Instala en `.claude/` de esa carpeta |
| `--global` | `-Global` | Instala en `~/.claude`, para todos los proyectos |
| `--shopify` | `-Shopify` | Además copia el `CLAUDE.md` con las reglas del tema Shopify |
| `--forzar` | `-Forzar` | Sobrescribe skills que ya tuvieras |

**Global o por proyecto?** Global si lo quieres para ti en todas partes. Por
proyecto si quieres que todo el que clone ese repo tenga las mismas skills;
son 12 MB dentro del repo.

Por defecto **no sobrescribe nada**: lo que ya existe se salta y te avisa.
`settings.json` nunca se toca si ya tienes uno; te deja los permisos del pack
en `settings.pack.json` para que copies lo que quieras a mano.

Para comprobar que ha ido bien, abre `claude` y escribe `/skills`. Si lo
instalaste en un proyecto, acepta confiar en la carpeta cuando lo pregunte:
sin eso no se cargan.

## Qué hay aquí

| Archivo / carpeta | Qué es |
|---|---|
| `skills/` | Las 34 skills |
| `agents/` | 4 subagentes de `impeccable` (diseño de interfaces) |
| `settings.json` | Permisos base: git, npm, y los comandos de lectura de Shopify. `shopify theme push/publish/delete` está en "preguntar siempre" a propósito |
| `instalar.sh` / `instalar.ps1` | El instalador, en bash y en PowerShell |
| `instalar-skills.sh` | Alternativa: baja 27 de las skills de sus repos originales |
| `plantillas/CLAUDE.shopify.md` | Reglas de proyecto para un tema de Shopify |
| `CLAUDE.md` | Instrucciones para Claude Code. No se instala en ningún sitio |
| `CREDITOS.md` | De dónde sale cada skill y con qué licencia |

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

## Para un proyecto de Shopify

Dentro del repo del tema:

```bash
bash /ruta/a/claudeconfig/instalar.sh --shopify
```

Deja las skills en `.claude/` y las reglas del tema en `CLAUDE.md`. Si no
quieres las skills dentro del repo del tema, usa `--global` y copia solo
`plantillas/CLAUDE.shopify.md` como `CLAUDE.md`.

Esto trae instrucciones, no programas. Para trabajar con Shopify hace falta
aparte:

```bash
npm install -g @shopify/cli
shopify auth login
```

## Nota para Windows

Clonando en una ruta corta (`C:\dev\claudeconfig`) no hay ningún problema:
probado con un clon limpio, los 716 archivos llegan bien.

Si lo clonas muy profundo, algunas skills tienen rutas internas largas y Git
se come archivos en silencio por el límite de 260 caracteres de Windows. A mí
me pasó montando esto: perdía 423 archivos sin avisar. Se arregla con:

```bash
git config --global core.longpaths true
```

## Licencias

Las skills son de terceros. Están aquí tal como las tengo instaladas, sin
modificar. En [CREDITOS.md](CREDITOS.md) está de dónde sale cada una. Varias
no declaran licencia, así que si este repo es público, replicarlas aquí es
discutible. Lo razonable es tenerlo privado y dar acceso a quien lo necesite,
o usar `instalar-skills.sh` para que cada uno las baje de su origen.
