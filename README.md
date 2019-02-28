# Fast number_to_currency

## Memory Usage

          | Memory Allocated | Memory Retained
---------- ------------------ ----------------
decimal   | 243              | 0
float     | 160              | 0
rational  | 160              | 0
integer   | 160              | 0
negative  | 160              | 0

## Benchmark

          |      user  |    system  |     total  |       real
---------- ------------ ------------ ------------ -----------
decimal   |  2.468144  |  0.005373  |  2.473517  |  (2.478588)
float     |  0.880165  |  0.000769  |  0.880934  |  (0.881837)
rational  |  0.982203  |  0.001215  |  0.983418  |  (0.984698)
integer   |  0.889479  |  0.003970  |  0.893449  |  (0.897219)
negative  |  0.934745  |  0.003466  |  0.938211  |  (0.941400)

# Active Support

## Memory Usage

          | Memory Allocated | Memory Retained
---------- ------------------ ----------------
decimal   | 3211262          | 172911
float     | 13568            | 0
rational  | 7377             | 0
integer   | 13560            | 0
negative  | 13608            | 0

## Benchmark
          |        user  |    system  |       total  |         real
---------- -------------- ------------ -------------- -------------
decimal   |  126.603537  |  0.564734  |  127.168271  |  (127.973537)
float     |  123.080714  |  0.462449  |  123.543163  |  (123.859657)
rational  |   60.432164  |  0.240037  |   60.672201  |  ( 60.807795)
integer   |  121.262164  |  0.455606  |  121.717770  |  (122.050438)
negative  |  125.489329  |  0.496485  |  125.985814  |  (126.362481)
