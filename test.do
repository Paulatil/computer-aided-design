set system mode atpg 
set fault type stuck 
add faults -all 
set pattern source -internal 
create patterns -auto 
run 
write fault testatpg.flt -replace 
save patterns testatpg.pat -replace 
report faults > testatpg.faults 
report statistics > testatpg.stats 
exit

