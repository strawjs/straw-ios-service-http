// .stubbatti.js ( see https://github.com/kt3k/stubbatti )

port(57577);

get('/hello', 'Hello, world!');

// For the timeout tests
get('/slow1000', '1000', {delay: 1000});
get('/slow2000', '2000', {delay: 2000});
