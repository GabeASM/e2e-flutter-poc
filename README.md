# Pruebas E2E Flutter
El presente proyecto es la parte visual de la aplicación para crear mensajes encriptados y desencriptarlos. Este proyecto se conecta con la aplicación backend por lo que para su correcto funcionamiento es necesario que el backend se encuentre en ejecución.

La idea de la aplicación es poder enviar mensajes encriptados a varias personas de manera sencilla desde el teléfono. 


## SetUp
**IMPORTANTE: Es importante haber ejecutado los contenedores  backend de la aplicación usando la instrucción indicada en el README de ese proyecto.**

La aplicación puede ser ejecutada desde la interfaz gráfica que Flutter puede renderizar utilizando las ventanas del sistema operativo que se encuentre. También puede ser ejecutado utilizando un teléfono.

## Ejecución de las pruebas E2E

Para ejecutar las pruebas E2E, usar el archivo de [test](integration_test/app_test.dart).   
*Si están en VSCode pueden utilizar la extensión de Flutter para ejecutar la prueba desde el archivo.*




# Pruebas End-to-End (E2E)

## ¿Qué son las pruebas E2E?

Las pruebas **End-to-End (E2E)** son un tipo de prueba de software que valida el funcionamiento completo de una aplicación simulando escenarios reales desde la perspectiva del usuario final. En lugar de probar componentes individuales, las pruebas E2E verifican que todas las partes de la aplicación trabajen juntas correctamente, desde la interfaz de usuario hasta los servicios backend y la base de datos.

Estas pruebas simulan la interacción del usuario con la aplicación para verificar que la funcionalidad global esté libre de errores y garantice una buena experiencia de usuario.

## Diferencias con otros tipos de pruebas

1. **Pruebas unitarias**: Las pruebas unitarias se enfocan en pequeñas piezas del código, como funciones o métodos, sin considerar la interacción con otros componentes.
   
2. **Pruebas de integración**: Las pruebas de integración validan la interacción entre varios componentes del sistema, pero no simulan el flujo completo de la aplicación.

3. **Pruebas de UI**: Las pruebas de interfaz de usuario se centran en verificar que los elementos visuales, como botones, formularios y menús, funcionen correctamente. Sin embargo, no cubren todo el flujo de trabajo del sistema.

### Comparación:

| Tipo de Prueba    | Alcance                  | Objetivo                                         |
|-------------------|--------------------------|--------------------------------------------------|
| **Unitarias**     | Partes individuales       | Verificar que funciones o componentes aislados funcionan correctamente |
| **Integración**   | Módulos o componentes     | Validar que los componentes del sistema interactúen correctamente |
| **E2E**           | Todo el sistema           | Simular la interacción completa del usuario, asegurando el correcto funcionamiento desde la UI hasta el backend |

## ¿Por qué son importantes las pruebas E2E?

Las pruebas E2E en el frontend son críticas porque garantizan que la aplicación funcione como los usuarios lo esperan, validando la interfaz gráfica, los flujos de trabajo y la interacción con el backend. Detectan errores que pueden pasar desapercibidos en pruebas más unitarias o de integración, pero que afectarían directamente al usuario final.

### Beneficios de las pruebas E2E en el frontend:

- **Simulan la experiencia del usuario**: Al simular interacciones reales, las pruebas E2E aseguran que la aplicación responda correctamente a los usuarios.
- **Verifican flujos completos**: A diferencia de las pruebas unitarias, las E2E prueban flujos completos desde el inicio hasta el fin, asegurando que todo el sistema funcione de manera cohesiva.
- **Previenen errores de regresión**: Ayudan a detectar problemas en la UI o en la integración con el backend tras actualizaciones o cambios en el código.

## ¿Por qué realizar pruebas E2E en el frontend?

Realizar pruebas E2E en el frontend es esencial para asegurarse de que la interfaz de usuario funcione como se espera y que los usuarios puedan interactuar sin problemas con la aplicación. Estas pruebas ayudan a validar que los eventos de la UI, como clics en botones, formularios, o navegaciones, se realicen correctamente y generen los resultados esperados.

### Razones para realizar pruebas E2E en el frontend:

1. **Validación de la interfaz de usuario**: Las pruebas E2E garantizan que la interfaz de usuario funcione según lo previsto, permitiendo que los usuarios realicen acciones clave, como hacer login, completar formularios, o navegar entre páginas, sin problemas.
   
2. **Interacción con el backend**: Las aplicaciones frontend suelen depender del backend para obtener y enviar datos. Las pruebas E2E aseguran que la comunicación entre la UI y el backend ocurra sin problemas, validando la correcta visualización de datos y respuestas del servidor.

3. **Simulación de flujos completos de usuario**: Estos tests simulan cómo un usuario interactuaría con la aplicación, probando casos como la creación de cuentas, flujos de compra o navegación por secciones, asegurando que no haya interrupciones en la experiencia del usuario.

4. **Prevención de errores de regresión visual**: Cambios en el código, actualizaciones de librerías o nuevas funcionalidades pueden romper la UI. Las pruebas E2E detectan estos errores antes de que lleguen a producción, evitando que el usuario final se vea afectado.
