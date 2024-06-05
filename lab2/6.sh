cat task.txt | awk '
 BEGIN {
	ppid = 0;
	avg = 0;
	cnt = 0;
	} {
	if ($7 == ppid) {
		print $0;
		avg = avg + $11;
		cnt = cnt + 1;
	}
	else {
	printf("Average_Sleeping_Children_of_ParentID = %d is %f\n", ppid, avg);
	ppid = $7;
	avg = $11;
	cnt = 1;
	print $0;
	}
}
END {
	printf("Average_Sleeping_Children_of_ParentID = %d is %f\n", ppid, avg/cnt) }' > 6.txt
    