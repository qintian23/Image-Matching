file = dir( '*.mat');
nFile = size(file, 1);
for k=1:nFile
    fnMat = file(k).name;
    disp( ['Processing ', fnMat] );
    fnLink = strrep(fnMat,'.mat','.syn');
	load( fnMat );
	
	%open link file
	fpLink = fopen( fnLink, 'wt' );
	fprintf( fpLink, 'Model=%d\n', size(x1,1) );
	for i=1:size(x1,1)
        fprintf( fpLink, '%d\t%25.20f\t%25.20f\n', i-1, x1(i, 1), x1(i, 2) );
	end;
	
	fprintf( fpLink, 'Deform=%d\n', size(y2a,1) );
	for i=1:size(y2a,1)
        fprintf( fpLink, '%d\t%25.20f\t%25.20f\n', i-1, y2a(i, 1), y2a(i, 2) );
	end;
	
    	fprintf( fpLink, 'Truth=%d\n', size(y2,1) );
	for i=1:size(y2,1)
        fprintf( fpLink, '%d\t%25.20f\t%25.20f\n', i-1, y2(i, 1), y2(i, 2) );
	end;
    
    m = min( size(x1, 1), size(y2, 1) );
	fprintf( fpLink, 'Match=%d\n', m );
	for i=1:m
        fprintf( fpLink, '%d\t%d\n', i-1, i-1);
	end;
	
	fclose( fpLink );
end;