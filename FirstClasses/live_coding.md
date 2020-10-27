# Live coding

Tasks taken from [here](http://aperiodic.net/phil/scala/s-99/) and slightly modified.

## Determine whether a given integer number is odd.

### Example:

```erlang
> is_odd(7).
true
```


## P31 (**) Determine whether a given integer number is prime.

### Example:

```erlang
> is_prime(7).
true
```

## P32 (**) Determine the greatest common divisor of two positive integer numbers.
Use Euclid's algorithm.

### Example:

```erlang
> gcd(36, 63).
9
```
See tips in other languages [here](https://github.com/aleklisi/School-of-Erlang/blob/master/SecondClasses/gcd/README.md)

## P33 (*) Determine whether two positive integer numbers are coprime.
Two numbers are coprime if their greatest common divisor equals 1.

### Example:

```erlang
>are_coprime(64, 35).
true
```

## P14 (*) Duplicate the elements of a list.

### Example:

```erlang
> duplicate([a, b, c, c, d])
[a, a, b, b, c, c, c, c, d, d]
```

## P39 (*) A list of prime numbers.
Given a range of integers by its lower and upper limit, construct a list of all prime numbers in that range.

### Example:

```erlang
> list_primesin_range(7, 31).
[7, 11, 13, 17, 19, 23, 29, 31]
```

## P10 (*) Run-length encoding of a list.
Implement the so-called run-length encoding data compression method. Consecutive duplicates of elements are encoded as tuples {N, E} where N is the number of duplicates of element E.

### Example:

```erlang
> encode(['a, a, a, a, b, c, c, a, a, d, e, e, e, e]).
[{a, 4}, {b, 1}, {c, 2}, {a, 2}, {d, 1}, {e, 4}]
```

## P11 (*) Modified run-length encoding.
Modify the result of problem P10 in such a way that if an element has no duplicates it is simply copied into the result list. Only elements with duplicates are transferred as {N, E} terms.

### Example:

```erlang
> encode_modified([a, a, a, a, b, c, c, a, a, d, e, e, e, e]).
[{a, 4}, b, {c, 2}, {a, 2}, d, {e, 4}]
```

## P12 (**) Decode a run-length encoded list.
Given a run-length code list generated as specified in problem P10, construct its uncompressed version.

### Example:

```erlang
> decode([{a, 4}, {b, 1}, {c, 2}, {a, 2}, {d, 1}, {e, 4}])
[a, a, a, a, b, c, c, a, a, d, e, e, e, e]
```
