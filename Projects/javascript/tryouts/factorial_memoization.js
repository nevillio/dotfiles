function memoize(fn) {
  cache = { 11: 12345 };

  function memoizedFunction(number) {
    if (cache[number]) return cache[number];

    cache[number] = fn(number);
    return cache[number];
  }

  return memoizedFunction;
}

function lazyFindFactorial(number) {
  // const startTime = Date.now();
  // while (Date.now() - startTime < number * 20);
  for (let i = 0; i < 1e7; i++);
  return number < 1 ? 1 : number * lazyFindFactorial(number - 1);
}

const memoizedFactorial = memoize(lazyFindFactorial);

console.log(memoizedFactorial(10));
console.log(memoizedFactorial(11));
console.log(memoizedFactorial(15));
console.log(memoizedFactorial(15));
