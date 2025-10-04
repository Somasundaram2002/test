const { greet } = require('../src/greeter');

test('greets default', () => {
  expect(greet()).toBe('Hello, world');
});

test('greets by name', () => {
  expect(greet('Somu')).toBe('Hello, Somu');
});
