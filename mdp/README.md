# Procesos de decición Markovianos

## El mundo cuadriculado

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

## Referencias

* [Machine Learining Supervised, Unsupervised & Reinforcement Udacity](https://www.udacity.com/course/machine-learning--ud262)
