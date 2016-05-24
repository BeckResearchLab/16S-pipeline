BEGIN {
	s = -1;
	if (table == "")
		table = "sequences";
	if (create_table == 1)
		printf("DROP TABLE IF EXISTS %s; CREATE TABLE %s ( otu VARCHAR(32) PRIMARY KEY, sequence LONGTEXT );", table, table);
}

/^>/ {
	++s;
	otu[s] = $1; 
	sub(">", "", otu[s]);
	sequence[s] = "";
}
{
	if (substr($1, 1, 1) != ">")
		sequence[s] = sequence[s] $1;
}
END {
	for (i = 0; i <= s; ++i) { 
		printf("INSERT INTO %s (otu, sequence) VALUES (\"%s\", \"%s\");\n", table, otu[i], sequence[i]);
	}
} 
