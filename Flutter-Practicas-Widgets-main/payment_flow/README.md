# Payment Flow - práctica Flutter

Aplicación de las prácticas Payment 000-011. Se conserva la UI final en español que muestran los ejemplos de código de los PDF.

## Ejecutar

```powershell
flutter pub get
flutter run
```

En VS Code, abrir `lib/main.dart`, seleccionar el emulador Android y pulsar F5. Si estaba abierta la versión anterior, detenerla primero: cambió la dependencia de iconos y se agregaron recursos.

## Correspondencia con las prácticas

| PDF | Implementación |
| --- | --- |
| 000-002 | Proyecto Flutter, recursos exportados y 36 archivos de fuentes Montserrat. |
| 003 | StatefulWidget inicial, MaterialApp y rutas. |
| 004-005 | AppBar, tema, títulos, enum, callback, cuatro opciones y componente reutilizable `payment_type.dart`. |
| 006 | Botón SIGUIENTE centrado mediante floatingActionButton. |
| 007 | Navegación por nombre hacia detalles y regreso. |
| 008 | Form, ListView, GlobalKey, indicador de pasos e ilustración de tarjeta. |
| 009 | Decoración reutilizable, validaciones de campos obligatorios, máscara de tarjeta y FocusNode. |
| 010 | Fecha, CVV numérico de hasta tres dígitos, checkbox, validación y eliminación del historial al confirmar. |
| 011 | MyArguments, pantalla SuccessfulScreen, mujer, check verde, textos y botón final. |

## Archivos principales

- `lib/main.dart`: tema y tres rutas.
- `lib/ui/components/payment_type.dart`: enum, callback y opción de pago reutilizable.
- `lib/ui/screens/payment_method_screen.dart`: selección del método.
- `lib/ui/screens/payment_details_screen.dart`: formulario, máscaras y navegación.
- `lib/ui/screens/successful_screen.dart`: pantalla final y argumentos.
- `assets/`: ilustraciones originales exportadas. El check de progreso se tiñe gris porque el exportado verde había sustituido al gris; el check final conserva su color.
- `test/widget_test.dart`: selección, validación, máscaras, argumentos y ausencia de historial. `test/screenshots/` contiene capturas para inspección visual; no son páginas extraídas del PDF.

## Adaptaciones para el SDK instalado

- Font Awesome 11 y FaIcon: 10.x no compila con Flutter 3.47 porque IconData es final. Se mantienen los iconos equivalentes y los colores de las prácticas.
- Material 2 explícito para conservar el estilo de los ejemplos.
- Scroll en la primera y última pantalla para evitar desbordamiento en ventanas pequeñas.
- Se conserva el margen inferior de 15 entre opciones y los valores de colores, tipografías, tamaños y radios documentados.

## Alcance de la práctica

Los cuatro métodos pueden seleccionarse; solo se diseña el formulario de tarjeta, como indica el PDF 011. No existe cobro real. El checkbox cambia el estado y se pasa en MyArguments; no implementa almacenamiento permanente. Mejoras posteriores a los PDF: CONTINUAR COMPRANDO vuelve al inicio limpiando el historial y el formulario anterior. El nombre exige al menos 3 caracteres, el número de tarjeta 16 dígitos, la fecha MM/AA un mes válido y no vencido, y el CVV exactamente 3 dígitos. Son validaciones locales, no autorización bancaria. La pantalla final recibe los argumentos sin imprimir datos de tarjeta en consola.

## Verificar

```powershell
flutter analyze
flutter test
flutter build apk --debug
```

Las capturas se actualizan intencionalmente con `flutter test --update-goldens` después de revisar un cambio visual.

## BlueStacks: tamaño visual y carga gráfica

Configuración sugerida para probar manualmente en un equipo con 12 GB de RAM: Retrato, 720 x 1280 y 320 DPI. Mantener inicialmente 1536 MB, 1 núcleo, Memoria baja y 30 FPS. La densidad cambia el espacio lógico que Android presenta a Flutter; la menor resolución reduce los píxeles a renderizar. No se cambiaron los ajustes del emulador desde el proyecto. El rendimiento concreto depende del procesador y del resto de programas abiertos.
