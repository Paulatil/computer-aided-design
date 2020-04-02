set system mode fault
set pattern source external test.txt 
add faults -all 
run
write fault test1.flt -replace
exit
