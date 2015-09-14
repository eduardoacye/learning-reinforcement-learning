# Procesos de decición Markovianos

## El mundo cuadriculado

### Introducción al mundo cuadriculado

Consideremos un mundo cuadriculado cuya representación gráfica es la siguiente:

```
┏━━━━━┳━━━━━┳━━━━━┳━━━━━┓
┃     ┃     ┃     ┃✓ fin┃
┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
┃     ┃█████┃     ┃✗ fin┃
┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
┃◯ ini┃     ┃     ┃     ┃
┗━━━━━┻━━━━━┻━━━━━┻━━━━━┛
```

Las etiquetas `◯ ini`, `✓ fin` y `✗ fin` denotan el inicio, fin positivo y fin negativo respectivamente.

Supongamos que estando en algún cuadro de la cuadrícula, podemos ir hacia `arriba`, `abajo`, `izquierda` o `derecha`, siendo la casilla con la marca `█████` y las fronteras de la cuadrícula *"paredes"* en las cuales si intentamos atravezar nos quedaremos en la casilla original. Siempre se comienza en el inicio, y una vez llegado al fin positivo o al fin negativo, el **universo** se reinicia y se vuelve a comenzar, por lo tanto no se puede llegar a `✓ fin`, desde `✗ fin` con la acción `arriba`.

Dado este **universo** podemos preguntarnos ¿Cuál es la secuencia mas corta de acciones para ir desde `◯ ini` hasta `✓ fin`?

Hay dos respuestas correctas a esta pregunta:

```
┏━━━━━┳━━━━━┳━━━━━┳━━━━━┓
┃  →  ┃  →  ┃  →  ┃✓ fin┃
┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
┃  ↑  ┃█████┃     ┃✗ fin┃
┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
┃◯ ini┃     ┃     ┃     ┃
┗━━━━━┻━━━━━┻━━━━━┻━━━━━┛
```

Es decir, partiendo del inicio, tomar las acciones: `arriba`, `derecha`, `derecha` y `derecha`.

y

```
┏━━━━━┳━━━━━┳━━━━━┳━━━━━┓
┃     ┃     ┃  →  ┃✓ fin┃
┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
┃     ┃█████┃  ↑  ┃✗ fin┃
┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
┃◯ ini┃  →  ┃  ↑  ┃     ┃
┗━━━━━┻━━━━━┻━━━━━┻━━━━━┛
```

Es decir, partiendo del inicio, tomar las acciones: `derecha`, `arriba`, `arriba`, `derecha`.

### El mundo cuadriculadamente estocástico

Podemos considerar una versión modificada del mundo descrito en la anterior subsección en donde tomar una acción no implica que esa acción se efectuará de manera correcta, esto complica un poco el modelo del **universo** que se presentó, sin embargo, es un paso mas cercano a nuestra realidad, debido a que hay muchos factores que pudieran causar que algo que deseamos hacer no se cumpla, la manera de incrustar esta variabilidad en los efectos de las acciones es considerando probabilidades.

Digamos que cuando decidimos realizar una acción `a`, hay una probabilidad de `0.8` de que esta acción se realizará como esperamos, además habrá una probabilidad de `0.1` de que lo que en verdad se realice sea moverse a la casilla que se encuentre a 90 grados con respecto a la dirección de la acción que se desea realizar y probabilidad `0.1` de moverse a la casilla a -90 grados con respecto a la dirección de la acción que se desea realizar. Para visualizar mejor esto considera el siguiente mundo:

```
┏━━━━━┳━━━━━┳━━━━━┳━━━━━┓
┃     ┃     ┃     ┃✓ fin┃
┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
┃     ┃█████┃0.8↑ ┃✗ fin┃
┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
┃ ini ┃0.1← ┃  ◯  ┃0.1→ ┃
┗━━━━━┻━━━━━┻━━━━━┻━━━━━┛
```

Si nos encontramos en el estado etiquetado con `◯` y deseamos ir hacia arriba, 80% de las veces nos iremos hacia la casilla de arriba, el 10% de las veces hacia la derecha y el 10% de las veces hacia la izquierda.

Considerando este nuevo modelo, nos podemos plantear una nueva pregunta, ¿Cuál es la probabilidad de seguir los pasos de la secuencia de la pregunta anterior y llegar a `✓ fin` a partir de `◯ ini`?

Se aborda el cálculo de la probabilidad de las dos secuencias encontradas:

Primero consideramos la secuencia `arriba`, `arriba`, `derecha`, `derecha`, `derecha`. En caso que las acciones se realicen correctamente se llega a la meta con una probabilidad de

$$P([u\to u] \cap [u\to u] \cap [r\to r] \cap [r\to r] \cap [r\to r]) = P([u\to u])P([u\to u])P([r\to r])P([r\to r])P([r\to r]) = 0.8\times 0.8\times 0.8\times 0.8\time 0.8 = 0.8^5 = 0.32768$$

```
┏━━━━━┳━━━━━┳━━━━━┳━━━━━┓
┃→  .8┃→  .8┃→ .8 ┃✓f .8┃
┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
┃↑  .8┃█████┃     ┃✗ fin┃
┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
┃◯ ini┃     ┃     ┃     ┃
┗━━━━━┻━━━━━┻━━━━━┻━━━━━┛
```

## Referencias

* [Machine Learining Supervised, Unsupervised & Reinforcement Udacity](https://www.udacity.com/course/machine-learning--ud262)
