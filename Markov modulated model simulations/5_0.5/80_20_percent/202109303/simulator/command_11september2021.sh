### generates two beast datasets that evolve in different omegas, then combines the two datasets two form an xml file (type of restriction is asked)
read -p 'omega1: ' omega1
read -p 'omega2: ' omega2
read -p 'restriction: ' restriction
###### Restrictions 1: omega1<1, omega2>1; 2: omega1<omega2; 3: omega1<omega2, omega2<1, omega3>1; 4: omega1<omega2, omega2<omega3


java -jar /Users/u0118390/Dropbox/PhD/beast_jar_files/beast.jar -seed 202109303 -overwrite camelid_80_omega${omega1}.xml;
java -jar /Users/u0118390/Dropbox/PhD/beast_jar_files/beast.jar -seed 202109303 -overwrite camelid_20_omega${omega2}.xml;

i=1 
while [ $i -le 212 ]; do
	j=$(( 4*$i ))
	k=$(( 5*$i ))
	awk -v var="$j" -v var1="$k" 'NR==var{a=$0}NR==FNR{next}FNR==var1{print a}1' camelid_sequences_omega${omega1}.xml camelid_sequences_omega${omega2}.xml > tmp && mv tmp camelid_sequences_omega${omega2}.xml;
	((i++))
done


sed -n "1,233p" camelid_pyvolve_res${restriction}.xml > tmp2.xml; #puts the first 233 lines of the xml file in a temporary file #up to alignment
sed -n "2,1061p" camelid_sequences_omega${omega2}.xml >> tmp2.xml; #adds the sequences to the temporary file #don't include the alignment tags
sed "1,1081d" camelid_pyvolve_res${restriction}.xml >> tmp2.xml; #adds the last lines of the original xml to the temporary file #1081 is right befor the last alignment tag
mv tmp2.xml ../beast_res${restriction}/camelid_beast_res${restriction}.xml #rename