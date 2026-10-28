# Instrucciones del proyecto

Tema de Shopify adaptado a partir de una plantilla. Trabajamos dos personas
sobre el mismo repo, así que lo que está aquí vale para los dos.

## Cómo quiero las respuestas

- Cortas, al grano. Sin resúmenes largos de lo que acabas de hacer.
- Lenguaje sencillo. Si usas una palabra técnica, di en una línea qué es.
- En español.
- Si algo ha salido mal o no lo has podido comprobar, dilo.

## Reglas del tema

- **No tocar nunca el tema publicado (live).** Para subir cambios se usa un
  tema de desarrollo o duplicado, y publicar lo hace una persona a mano.
- `shopify theme dev` para previsualizar en local. `shopify theme push` solo
  con permiso explícito y siempre con `--theme` apuntando al tema de pruebas.
- Antes de editar un archivo de la plantilla original, mirar si el cambio se
  puede hacer desde `config/settings_schema.json` o desde una sección nueva.
  Cuanto menos toquemos el código original, más fácil será actualizar la
  plantilla cuando salga una versión nueva.
- Secciones y bloques nuevos: archivo propio en `sections/` o `snippets/` con
  prefijo `custom-` para distinguirlos de los de la plantilla.
- CSS/JS propio en sus propios archivos (`assets/custom-*.css`), no mezclado
  dentro de los de la plantilla.
- Pasar `shopify theme check` antes de dar algo por terminado.
- Textos de cara al cliente van en los archivos de `locales/`, no escritos a
  pelo en el Liquid.

## Git

- Una rama por tarea, nombre descriptivo. Nada directo a `main`.
- Commits en español, en una línea, diciendo qué cambia.
- Avisar antes de hacer `push` o abrir un PR.
