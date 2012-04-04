%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

function [network, fd, numDegrees] = createNetwork( N, runs );       
	network = sparse([0]);        
	p( 1 ) = 1;        
	numDegrees( 1 ) = 0; numDegrees( 2 ) = 0;      
	fd = zeros(1, N);
            
	for vertex = 2:N               	
	  numDegrees( vertex ) = 0;                	
		in = connect( p );               
		network( vertex, in ) = 1;                
		numDegrees( vertex ) = numDegrees( vertex ) + 1;               
		numDegrees( in ) = numDegrees( in ) + 1;                
		p = update( p, network, numDegrees );            	
	end
           
	for i = 1:N          
		tmp = find( i < numDegrees );           
		fd(i) = numel(tmp);       	
	end    
        
	[G xyz] = graph( N, network );
        
	gplot( G, xyz, '-O' );       
	%x = (1:1:N);       
	%tmp = sort( numDegrees );       
	%y = (rot90(tmp))';     
	%plot(x, y);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  function [G, xyz] = graph( N, network )
    G = zeros( N );
    [in out] = find( network );

    for i = 1:numel( in )
      G( in( i ), out( i ) ) = 1;
    end
    
    G = sparse( G );
    x = rand( 1, N ) * N;
    y = rand( 1, N ) * N;
    z = rand( 1, N ) * N;
    xyz = [x' y' z'];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  function probDist = update( p, network, numDegrees )     
    totalDegrees = sum(numDegrees);

    for i = 1:length( numDegrees )
      probDist( i ) = numDegrees( i ) / totalDegrees;
    end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

    function v = connect( p )
      P=cumsum( p );
      u = rand( 1 );
      v = min( find( u < P ) );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
