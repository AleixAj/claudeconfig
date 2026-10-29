# Instrucciones para Claude Code

Esta carpeta **no es un proyecto que haya que modificar**. Es un pack de
configuración de Claude Code (skills, subagentes y permisos) que hay que
instalar en otro sitio.

Si el usuario te pide instalarlo, o simplemente abre una sesión aquí y
pregunta qué es esto, sigue lo de abajo. No hace falta que leas el `README.md`
antes: aquí está todo lo necesario.

**Si te han dado solo el enlace del repo y no estás dentro de esta carpeta:**
clónalo primero en una ruta corta (`git clone
https://github.com/AleixAj/claudeconfig`), entra y sigue desde aquí. No
instales nada copiando archivos sueltos desde GitHub.

**Si preguntan qué hace cada skill**, está en `SKILLS.md`: una o dos frases
por skill, agrupadas por tema, y cuáles necesitan algo instalado aparte.

## Lo único que tienes que preguntar

Pregunta al usuario **dónde** lo quiere, porque cambia el comando:

- **En un proyecto concreto** → se instala en `.claude/` de ese proyecto. Las
  skills quedan dentro del repo del proyecto y se comparten con quien lo clone.
- **Para todos sus proyectos** → se instala en `~/.claude`. Lo ve en cualquier
  carpeta, pero no se comparte con nadie.

Si no lo sabe, recomiéndale el global (`--global`): es lo que casi todo el
mundo quiere y no mete 12 MB en el repo de su proyecto.

No preguntes nada más. El resto decídelo tú con las reglas de aquí abajo.

## Cómo instalarlo

Desde la raíz de esta carpeta. En Linux, macOS o Git Bash:

```bash
bash instalar.sh --global          # para todos sus proyectos
```

```bash
cd /ruta/del/proyecto && bash /ruta/a/este/repo/instalar.sh
```

En Windows con PowerShell, si `bash` no está disponible:

```powershell
.\instalar.ps1 -Global
```

```powershell
.\instalar.ps1 -Proyecto C:\ruta\del\proyecto
```

Los dos scripts hacen exactamente lo mismo. Usa el que funcione en la shell
que tengas.

Opciones de los dos instaladores:

| bash | PowerShell | Qué hace |
|---|---|---|
| (nada) | (nada) | Instala en `.claude/` de la carpeta actual |
| `--global` | `-Global` | Instala en `~/.claude` |
| `--shopify` | `-Shopify` | Además copia `plantillas/CLAUDE.shopify.md` como `CLAUDE.md` del proyecto |
| `--forzar` | `-Forzar` | Sobrescribe skills que ya existan |

Usa `--shopify` **solo** si el proyecto de destino es un tema de Shopify.
Pregúntalo si no está claro; si no lo es, no lo pases.

## Reglas que no te salte

1. **Usa los scripts, no copies los archivos a mano.** Están probados y
   gestionan los casos de "ya existe" como toca.
2. **Nunca sobrescribas un `settings.json` que ya exista.** El script ya lo
   evita: deja los permisos del pack en `settings.pack.json` al lado. Si eso
   pasa, dile al usuario que revise ese archivo y copie a mano lo que quiera
   de `permissions.allow`, y que luego lo borre. No lo fusiones tú sin que
   te lo pida.
3. **Nunca sobrescribas un `CLAUDE.md` que ya exista** en el proyecto de
   destino. El script tampoco lo hace.
4. **No instales este `CLAUDE.md`** en ningún sitio. Es solo para ti, para
   leerlo aquí. El que se instala en proyectos es
   `plantillas/CLAUDE.shopify.md`, y solo con `--shopify`.
5. **No ejecutes `instalar-skills.sh` salvo que el usuario lo pida.** Ese baja
   las skills de sus repos originales y da versiones distintas a las de aquí;
   además 7 de las 34 no están disponibles así. Está explicado en el README.

## Después de instalar

Dile al usuario que reinicie Claude Code en la carpeta de destino y compruebe
con `/skills` que salen las 34, y con `/agents` que salen los 4
`impeccable-*`. Si instaló en un proyecto, también que acepte confiar en la
carpeta cuando se lo pregunte: sin eso no se cargan.

Avísale de que el pack trae instrucciones, no programas. Si va a trabajar con
Shopify le falta instalar aparte:

```bash
npm install -g @shopify/cli
shopify auth login
```

Y de que la skill `codebase-memory` no sirve sola: necesita el MCP
`codebase-memory-mcp`, que es un ejecutable local. Está explicado en
`CREDITOS.md`.

## Si te preguntan de dónde salen las skills

Está en `CREDITOS.md`: el repo de origen y la licencia de cada una. Varias no
declaran licencia. Si alguien pregunta por republicarlas, que lea ese archivo
antes.
