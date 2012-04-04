N = input('Enter number of nodes to created: ');
numRuns = input('Enter the number of runs: ');

[pK network] = simulateWWW( N, numRuns );
x = find( pK );
y = pK(find(pK));
grid on
subplot(2,2,1)
plot( x, y, 'o', 'MarkerSize', 4);
xlabel('k'), ylabel('p(d > k)')
title('Figure (a)')
subplot(2,2,2)
plot( x, y);
xlabel('k'), ylabel('p(d > k)')
title('Figure (b)')
subplot(2,2,3)
plot( log(x), log(y), 'o', 'MarkerSize', 4);
xlabel('log k'), ylabel('log p(d > k)')
title('Figure (c)')
subplot(2,2,4)
plot( log(x), log(y));
xlabel('log k'), ylabel('log p(d > k)')
title('Figure (d)')
slabel=['    degree    ' 'p(d > k)    '];
disp(slabel)
out = [find(pK)' pK(find(pK))'];
disp(out)