# Qué hace cada skill

Una skill es un manual que Claude Code carga **solo cuando sale el tema**. No
consume nada mientras no se usa, así que tener muchas no ralentiza nada. No
hace falta llamarlas: Claude las activa al detectar de qué va la tarea.

Dos detalles que solo pasan con dos de ellas: `impeccable` es la única que
trae comandos propios (`/impeccable critique`, `/impeccable polish`...), y
`review-animations` es la única que **no** se activa sola: hay que pedírsela
por su nombre.

## Diseño de interfaces

| Skill | Qué hace |
|---|---|
| `impeccable` | La más grande y la que más se nota. Convierte a Claude en director de diseño: le da criterio para no hacer la típica web genérica. Tiene 24 subcomandos: `/impeccable critique` (review de UX con nota), `audit` (accesibilidad, rendimiento, responsive, con prioridades P0–P3), `bolder` / `quieter` / `typeset` / `layout` / `animate` (empujar un diseño en una dirección), `polish` / `harden` / `optimize` (el último repaso antes de publicar), `live` (tocar elementos en el navegador y escribir el cambio al código). Lleva un detector de diseño genérico con reglas fijas, que no gasta llamadas a la IA. |
| `ui-ux-pro-max` | Un catálogo de diseño consultable: 79 estilos, 192 paletas, 74 parejas de tipografías, 119 reglas de UX, 25 tipos de gráfica y 22 stacks (React, Next, Vue, Svelte, Flutter, SwiftUI, Tailwind...). Sirve para que la decisión de estilo no salga de la nada. **Necesita Python 3** para su buscador interno. |
| `design-taste-frontend` | Para landings, portfolios y rediseños. Lee el encargo, deduce la dirección de diseño y evita que salga algo con pinta de plantilla. En rediseños audita primero lo que ya hay. |
| `emil-design-eng` | El criterio de Emil Kowalski (el autor de Sonner y Vaul) sobre pulido de interfaz, componentes y animación: los detalles invisibles que hacen que algo se sienta bien. |
| `review-animations` | Revisa animaciones con la vara de medir alta. Por defecto señala problemas; que algo pase la revisión hay que ganárselo. |
| `web-design-guidelines` | Revisa el código de la interfaz contra las Web Interface Guidelines. Es la que responde a "revísame la UI" o "mira la accesibilidad". |
| `color-expert` | Color en serio: teoría, espacios (OKLCH y compañía), paletas, rampas, degradados, contraste y accesibilidad, mezcla de pigmentos, diferencias entre pantalla e imprenta, y nombres de colores. |

## Imágenes y referencias visuales

Estas tres **generan imágenes, no código**. Se usan antes de programar, para
decidir cómo va a ser algo.

| Skill | Qué hace |
|---|---|
| `imagegen-frontend-web` | Maquetas de web, una imagen por sección. Si la landing tiene 8 secciones, salen 8 imágenes. Luego se las pasas a Claude para que las convierta en código. |
| `imagegen-frontend-mobile` | Lo mismo para apps móviles: pantallas iOS y Android, normalmente dentro de un mockup de teléfono. |
| `brandkit` | Tableros de marca: propuestas de logo, paletas, tipografías y cómo se aplica la identidad. |

## Páginas con scroll

| Skill | Qué hace |
|---|---|
| `scroll-craft` | Landings donde el scroll cuenta una historia: héroes con planos independientes, movimiento contenido y una composición aparte para móvil. Comprueba el resultado en escritorio, móvil y con las animaciones desactivadas. |
| `scroll-world` | El scroll mueve un vídeo pregrabado: una cámara que vuela por un mundo en 3D y entra en cada escena sin cortes. **Necesita cuenta en Higgsfield** (de pago) para generar las escenas. |

## Web moderna y rendimiento

| Skill | Qué hace |
|---|---|
| `modern-web-guidance` | Buscador de buenas prácticas actuales de HTML, CSS y JavaScript de navegador. Existe porque las APIs web cambian rápido y la IA arrastra formas de hacer las cosas que ya están viejas. Cubre diálogos, popovers, modo oscuro, `:has()`, container queries, View Transitions, animaciones por scroll, Core Web Vitals, formularios y accesibilidad. |
| `next-bundle-optimizer` | Reduce lo que el navegador tiene que descargar y ejecutar al abrir una página de Next.js. Para arranques lentos o dependencias duplicadas. |
| `vercel-react-best-practices` | Rendimiento en React y Next.js, según el equipo de Vercel. |
| `vercel-composition-patterns` | Cómo montar componentes de React que aguanten el crecimiento, en vez de ir sumando props booleanas sin parar. |
| `vercel-react-view-transitions` | Transiciones entre páginas y animaciones de elementos compartidos con la View Transition API de React. Ya es estable desde React 19.3. |

## 3D con Three.js

Once skills, una por tema. Solo se cargan si hay 3D en la conversación, así
que si no haces 3D no estorban (y se pueden borrar).

`threejs-fundamentals` (escena, cámara, renderer, bucle de animación) ·
`threejs-materials` (materiales y PBR) · `threejs-lighting` (luces, sombras,
iluminación por entorno HDR) · `threejs-textures` (texturas, UVs, espacios de
color) · `threejs-loaders` (cargar modelos glTF, compresión Draco y KTX2) ·
`threejs-animation` (keyframes, esqueletos, mezcla de clips) ·
`threejs-interaction` (clics sobre objetos 3D, controles de cámara, arrastrar)
· `threejs-shaders` (shaders GLSL propios y TSL en WebGPU) ·
`threejs-postprocessing` (bloom, desenfoque, oclusión ambiental, grading) ·
`threejs-performance` (cuando la escena va a tirones o se come la memoria) ·
`threejs-react-three-fiber` (todo lo anterior desde React).

## Base de datos y backend

| Skill | Qué hace |
|---|---|
| `supabase` | Todo lo de Supabase: base de datos, login, Edge Functions, Realtime, Storage, el CLI, migraciones y, sobre todo, diagnosticar errores raros (sesiones, cookies, RLS, permisos). |
| `supabase-postgres-best-practices` | Postgres bien hecho, esté donde esté: diseño de tablas, tipos de columna, migraciones, políticas RLS, índices, triggers, tareas programadas, búsqueda vectorial. Y para cuando algo va lento o hay bloqueos. |

## Herramientas

| Skill | Qué hace |
|---|---|
| `webapp-testing` | Abre tu web en un navegador de verdad (Playwright) para comprobar que algo funciona, hacer capturas y leer los errores de consola. **Necesita Playwright instalado.** |
| `humanizer` | Quita la pinta de texto escrito por IA: el "no es X, es Y", los cierres de una línea, las triadas forzadas, los guiones largos por todas partes, el vocabulario de folleto. Está basada en la guía de Wikipedia sobre señales de escritura con IA. Reescribe sin cambiar lo que dice el texto. |
| `skill-creator` | Para crear tus propias skills, mejorarlas y medir si se activan cuando deben. |
| `codebase-memory` | Preguntas sobre la estructura del código: quién llama a esta función, qué depende de qué, código muerto. **Necesita el MCP `codebase-memory-mcp` aparte** (ver [CREDITOS.md](CREDITOS.md)). Sin él no hace nada. |

## Los 4 subagentes

Un subagente es un Claude secundario con un trabajo concreto y su propio
contexto. Estos cuatro son de `impeccable` y los llama ella sola: no tienes
que invocarlos.

| Agente | Qué hace |
|---|---|
| `impeccable-asset-producer` | Prepara las imágenes y recursos que el diseño necesita, sin cambiar la dirección visual ya aprobada. |
| `impeccable-documenter` | Escribe el `DESIGN.md`: el sistema de diseño deducido de lo que de verdad se ha construido, no de lo que se pretendía. |
| `impeccable-finish-reviewer` | Revisa el resultado final contra lo acordado y devuelve la lista de arreglos que importan, ordenada. |
| `impeccable-manual-edit-applier` | Aplica al código los cambios de texto que hayas hecho a mano en el navegador. |

## Lo que hace falta aparte

Casi todas son solo instrucciones y no necesitan nada. Las excepciones:

- `impeccable`: la primera vez se descarga su motor (un ejecutable) en
  `~/.impeccable/bin/`. Necesita internet ese primer rato.
- `ui-ux-pro-max`: Python 3 para su buscador.
- `webapp-testing`: Playwright.
- `scroll-world`: cuenta en Higgsfield, que es de pago.
- `codebase-memory`: el MCP `codebase-memory-mcp`, que es un binario local.
