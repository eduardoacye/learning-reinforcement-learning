<!-- coding: utf-8; mode: flyspell; ispell-local-dictionary: "castellano" -->

# Procesos de decisión Markovianos

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

Primero consideramos la secuencia `arriba`, `arriba`, `derecha`, `derecha`, `derecha`. En caso que las acciones se realicen correctamente se llega a la meta con una probabilidad de:

```
  P(realiza=[↑, ↑, →, →, →] ∩ elige=[↑, ↑, →, →, →])
= P([realiza=↑ ∩ elige=↑] ∩ [realiza=↑ ∩ elige=↑] ∩ [realiza=→ ∩ elige=→] ∩ [realiza=→ ∩ elige=→] ∩ [realiza=→ ∩ elige=→])
= P(realiza=↑ ∩ elige=↑)P(realiza=↑ ∩ elige=↑)P(realiza=→ ∩ elige=→)P(realiza=→ ∩ elige=→)P(realiza=→ ∩ elige=→)
= 0.8 * 0.8 * 0.8 * 0.8 * 0.8
= 0.8^5
= 0.32768
```

```
┏━━━━━┳━━━━━┳━━━━━┳━━━━━┓
┃→  .8┃→  .8┃→ .8 ┃✓f .8┃
┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
┃↑  .8┃█████┃     ┃✗ fin┃
┣━━━━━╋━━━━━╋━━━━━╋━━━━━┫
┃◯ ini┃     ┃     ┃     ┃
┗━━━━━┻━━━━━┻━━━━━┻━━━━━┛
```

Existe la posibilidad de que algunas acciones hayan resultado en movimientos no deseados y que aún así lleguemos a la meta, consideremos que al decidir las acciones se realiza alguna otra con probabilidad 0.1:
* se elige `arriba` se realiza `derecha` con probabilidad 0.1
* se elige `arriba` se realiza `derecha` con probabilidad 0.1
* se elige `derecha` se realiza `arriba` con probabilidad 0.1
* se elige `derecha` se realiza `arriba` con probabilidad 0.1
* se elige `derecha` se realiza `derecha` con probabilidad 0.8

Calculando probabilidades...

```
  P(realiza=[→, →, ↑, ↑, →] ∩ elige=[↑, ↑, →, →, →])
= P([realiza=→ ∩ elige=↑] ∩ [realiza=→ ∩ elige=↑] ∩ [realiza=↑ ∩ elige=→] ∩ [realiza=↑ ∩ elige=→] ∩ [realiza=→ ∩ elige=→])
= P(realiza=→ ∩ elige=↑)P(realiza=→ ∩ elige=↑)P(realiza=↑ ∩ elige=→)P(realiza=↑ ∩ elige=→)P(realiza=→ ∩ elige=→)
= 0.1 * 0.1 * 0.1 * 0.1 * 0.8
= 0.1^4 * 0.8
= 0.00008
```

Ya que estas son las únicas trayectorias posibles en esa cantidad de pasos y con esa elección de acciones, la probabilidad de la secuencia es la suma de las probabilidades calculadas: `0.32768 + 0.00008 = 0.32776`.

Como repaso se puede realizar un cálculo similar con la elección de acciones `derecha`, `derecha`, `arriba`, `arriba`, `derecha`, ¿Qué secuencia de elecciones es mas probable en este universo?

### Formalización del mundo cuadriculadamente estocástico

El modelo del universo descrito en la subsección anterior es un *proceso de decisión Markoviano*. Estos sistemas son utilizados en el *aprendizaje por refuerzo* como marcos para plantear problemas, y sobre ellos se desarrolla una solución.

Los procesos de decisión Markovianos son procesos estocásticos que proveen un marco matemático para modelar la toma de decisiones en situaciones donde los resultados de tomar dichas decisiones son parcialmente aleatorios y dependen de la decisión tomada.

Un proceso de decisión Markoviano se compone de:
* Un conjunto de estados `S`
  - En el ejemplo del mundo cuadriculadamente estocástico los estados pueden ser las posiciones válidas `S = {(1,1),(1,2),(1,3),(1,4),(2,1),(2,3),(2,4),(3,1),(3,2),(3,3),(3,4)}`
* Un conjunto de acciones que se pueden tomar, ya sea en general `A` o en particular para un estado `A : S -> {a1, ..., a_n}`.
  - En el ejemplo las acciones `A = {arriba, abajo, izquierda, derecha}` o `A = {↑, ↓, ←, →}`
* Un modelo, que es una función de transición `T : S ⨯ A ⨯ S` la cual calcula la probabilidad de ir a un estado `s'` estando en el estado `s` y eligiendo la acción `a`: `Pr(s' | s,a)`.
  - En el ejemplo esta función se definiría de la siguiente manera para `s=(1,1)` y `a=↑`:
    * `T((1,1), ↑, s') = { s'=(2,1) -> .8, s'=(1,2) -> .1, s'=(1,1) -> .1, de lo contrario 0 }`
    * se define de manera similar con el resto de los estados y acciones.
  - Este modelo tiene la **propiedad de Markov**, resumida como *solo el presente importa para determinar el futuro*  y tener esta propiedad implica que:
  ```
    P(S_n+1 = s_n+1 | S_0 = s_0, ..., S_n = s_n, A_0 = a_0, ..., A_n = a_n)
  = P(S_n+1 = s_n+1 | S_n = s_n, A_n = a_n)
  ```
  - Este modelo es **estacionario**, esto implica que la función de transición `P(S_n+1 = s' | S_n = s, A_n = a)` es independiente de `n`


## Referencias

* [Machine Learining Supervised, Unsupervised & Reinforcement Udacity](https://www.udacity.com/course/machine-learning--ud262)
* Hoel, Port, Stone. Introduction to Stochastic Processes
