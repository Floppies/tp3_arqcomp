# TP3-BIPS I
Trabajo Practico de Laboratorio Numero 3: BIPS I

## Consigna

Implementar un procesador basico para la educacion especificado en el paper "A Basic Processor for Teaching Digital Circuits and Systems Design with FPGA". En especifico, solo se tiene que implementar el BIP I, la version mas simple que no incluye las instrucciones de salto.

<img src="imagenes/ModulosUART.png" alt="Modulos UART" width="400"/>

### Funcionamiento

La transmision UART es un modo de transmision asincrono de simbolos que viajan en serie. Antes de la transmision, ambas partes de la comunicacion establecen en conjunto unos parametros que despues serviran para recupperar el sincronismo. Estos son el Baud Rate, la cantidad de bits del dato, de stop y de paridad, si existiese.

<img src="imagenes/FuncionamientoUART.png" alt="Funcionamiento UART" width="400"/>

Luego, el funcionamiento del sistema total consta de:
- Recibir 3 datos, dos operandos y un operador. El operador es de 6 bits y responde a la codificacion de operaciones del TP anterior.
- La interfaz procesa estos datos y, usando el modulo combinacional ALU, obtiene el resultado.
- Este resultado es enviado por el transmisor.

## Diseño

Se diseño un modulo TOP que incializa todos los modulos requeridos y los conecta entre si. Ademas se establece como valores de transmision por defecto, un clock de 50MHz y un Baud Rate de 9600, lo cual hace que el generador de pulsos se un contador modulo 163. Tambien se decidio que los bits de datos son 8 y que el bit de stop es uno solo. No se envian bits de paridad ni se hace correccion de errores.

<img src="imagenes/ModuloTopEsquematico.png" alt="Esquematico del Top" width="800"/>

## Implementación

Para implementar los modulos relacionados con la transmision, se tomaron los codigos del libro "FPGA Prototyping by Verilog Examples". La interfaz fue implementada de manera similar.

### Modulos UART

Ambos, receptor y transmisor, son maquinas de estados.
El receptor tiene un estado de repaso donde espera que el pulso de la señal baje, lo cual indica que se esta transmitiendo un dato. Luego pasa un estado de comienzo donde se empieza la rutina del sombremuestreo. El receptor "divide" en 16 el pulso de reloj que esta recibiendo. Cuando cuenta 7 segmentos, pasa a un estado de datos, en el cual cada vez que su cuenta llega a 16, toma el dato que recibe. Esto se debe a que, con el metodo de contar hasta 7 y despues hasta 16 por cada bit de dato, el receptor puede suponer que se encuentra a la mitad del pulso y por ende no va a hacer una lectura incorrecta.

<img src="imagenes/BlockDiagramRx.png" alt="Diagrama de Bloques del receptor" width="400"/>
<img src="imagenes/DiagramRx.png" alt="Diagrama de Flujo del receptor" width="400"/>

El transmisor tiene una logica similar nada mas que no hace el sobremuestreo. Simplemente, en cada pulso que le llega del generador del Baud Rate, envia un dato de manera serial. Ademas, cuenta de una entrada extra que le señala que tiene que comenzar la transmision.

<img src="imagenes/DiagramEstado.png" alt="Diagrama de Estados del transmisor" width="400"/>

El generador de Baud Rate no es mas que un contador de modulo 163. Es decir que toma los pulsos del clock de entrada y los cuenta, cada vez que llegue a 163, muestra un pulso en la salida.

### Modulo Interfaz

Este modulo es basicamente una maquina de 4 estados que va guardando los datos recibidos y va cambiando de estado cada vez que se recibe un dato nuevo. Una vez recibido el ultimo dato en una secuencia de: operando, operando y operacion; se da una señal al transmisor para que comience a enviar lo que se encuentra en la salida result que es el resultado que sale de la ALU. Este resultado se obtiene de inmediato en la presencia de los operandos y el operador ya que la ALU es un modulo combinacional.

<img src="imagenes/EstadosInterfaz.png" alt="Diagrama de Estados del transmisor" width="400"/>

### Aclaraciones

- Por razones de diseño, hay un ciclo de reloj en el que se esta enviando los datos y no se pueden recibir operandos.
- La señal que manda el codigo de operacion dentro de la interfaz trunca los 2 bits menos significativos.

## Testing

Se hicieron varios testbench para probar la funcionalidad de cada modulo en particular. Todos estos tienen una metodologia no automatizada y son bastante simples de entender. Luego
se realizo un testbench del sistema completo.

### Testing completo

El procedimiento es el siguiente:

- Se manda un pulso de reset para inicializar correctamente el sistema.
- Se genera toda la trama UART secuencialmente enviando 2 operandos y una operacion, mas especificamente dos 8'h01 y un 8'20 que es el codigo de la suma.
- Se instancia el modulo top dandole: la señal de entrada con la trama, la señal de reset y de clock, y, como salidas, el resultado y un cable para saber si se termino la transmision.

**Ejemplo de trama UART para enviar h01**
``` v
//DATO 1 = 8'h1
      #3250
      i_data            =   1'b1    ; //idle
      #50000
      i_data            =   1'b0    ; //Start
      #50000
      i_data            =   1'b1    ; //Data
      #50000
      i_data            =   1'b0    ;
      #50000
      i_data            =   1'b0    ;
      #50000
      i_data            =   1'b0    ;
      #50000
      i_data            =   1'b0    ;
      #50000
      i_data            =   1'b0    ;
      #50000
      i_data            =   1'b0    ;
      #50000
      i_data            =   1'b0    ;
      #50000
      i_data            =   1'b0    ;   //  Stop
```

## Analisis

### Simulación de comportamiento

La simulacion cumplen el comportamiento establecido. Se puede observar la trama UART que se estableció en el testbench y el resultado que es transmitido en serie. La señal tx_done sirve para visualizar cuando se termino la transmision.

<img src="imagenes/SimulacionComportamiento.png" alt="Simulacion del comportamiento" width="800"/>

### Simulación Post-Sintesis con tiempo

Se ve la misma salida que la simulacion anterior con la diferencia que ahora hay algunos pulsos en la señal tx_done pero no causan inconveniente en el funcionamiento requerido.

<img src="imagenes/SimulacionTiming.png" alt="Simulacion con timing" width="800"/>

### Analisis de Timing

Se establecio un archivo de constraint para poner como parametro un clock de 50MHz que era uno de los supuestos de diseño. Al hacer esto se puede observar el archivo del report de Timing. Este indica que en el tiempo de Setup, el Worst Negative Slack (la diferencia entre el clock y el delay del trayecto mas largo del circuito) da un valor positivo de aproximadamente 17ns, lo cual es algo deseado.

<img src="imagenes/AnalisisTiming.png" alt="Analisis de timing" width="800"/>

### Errores encontrados

En las primeras iteraciones, el funcionamiento con el testing de comportamiento era correcto pero, a la hora de sintetizar el circuito y simularlo, el modulo de la interfaz no se sintetizaba. Esto se debia a que los estados estaban mal descriptos y generaban latchs.

Tambien hubieron errores en la simulacion con timing ya que el clock generado era muy rapido. La solucion fue cambiar el paso de simulacion.