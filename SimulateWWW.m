function [pK, network] = SimulateWWW( N , numRuns )
  pK = zeros( 1, N ); % probability dist. p(k)
  %-----for loop-----%
  for i = 1:numRuns
    [network numDegree] = createNetwork( N );
    pK = pK + fraction( N, numDegree );
  end
  %-----end loop-----%    
  % compute expected value for number of nodes for a given degree
  pK = pK / numRuns;
  % probability distribution p(k)  
  pK = pK / sum( pK );    
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
% update the number of nodes for a given degree
function pK = fraction( N, numDegree )
  for i = 1:N
    pK( i ) = numel( find( i == numDegree ) );
  end 
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

function [network, numDegree] = createNetwork( N )
  network = sparse([]);
  numDegree = zeros( 1, N );
  pmf = zeros( 1, N ); 
  pmf( 1 ) = 1;
  %-----for loop-----%
  for newNode = 2:N
    receivingNode = connect( pmf ); % choose what previous node to link
    network( newNode, receivingNode ) = 1; % link the to nodes             
		[pmf numDegree] = update( pmf, numDegree, newNode, receivingNode );
  end
  %-----end loop-----%
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

% pick a node for connection w/ probability i/k
function v = connect( pmf )
  cdf = cumsum( pmf ); % cumulative density dist. of p(k)
  u = rand; 
  v = min( find( u < cdf ) ); % pick a node form cdf
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% update probability p(k) after each creation of a new node and linkage
function [pmf, numDegree] = update( pmf, numDegree, newNode, receivingNode )     
  numDegree( newNode ) = numDegree( newNode ) + 1; % (i+1)/k for new node              
  numDegree( receivingNode ) = numDegree( receivingNode ) + 1; 
  sumDegree = sum( numDegree ); % k: sum of degrees
  for i = 1:newNode
    pmf( i ) = numDegree( i ) / sumDegree; % update all i/k in p(k)
  end    
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%            