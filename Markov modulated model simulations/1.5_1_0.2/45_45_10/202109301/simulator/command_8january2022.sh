### generates two beast datasets that evolve in different omegas, then combines the two datasets two form an xml file (type of restriction is asked)
omega1="0.2"
omega2="1"
read -p 'omega3: ' omega3 #episodic selection
###### Restrictions 1: omega1<1, omega2>1; 2: omega1<omega2; 3: omega1<omega2, omega2<1, omega3>1; 4: omega1<omega2, omega2<omega3


java -jar /Users/u0118390/Dropbox/PhD/beast_jar_files/beast.jar -seed 202109301 -overwrite camelid_omega${omega1}.xml;
java -jar /Users/u0118390/Dropbox/PhD/beast_jar_files/beast.jar -seed 202109301 -overwrite camelid_omega${omega2}.xml;
java -jar /Users/u0118390/Dropbox/PhD/beast_jar_files/beast.jar -seed 202109301 -overwrite camelid_omega${omega3}.xml;

#i=1 
#while [ $i -le 212 ]; do
#	j=$(( 4*$i ))
#	k=$(( 5*$i ))
#	awk -v var="$j" -v var1="$k" 'NR==var{a=$0}NR==FNR{next}FNR==var1{print a}1' camelid_sequences_omega${omega1}.xml camelid_sequences_omega${omega2}.xml > tmp && mv tmp camelid_sequences_omega${omega2}.xml;
#	((i++))
#done

i=1 
while [ $i -le 212 ]; do
	j=$(( 4*$i ))
	k=$(( 5*$i ))
	awk -v var="$j" -v var1="$k" 'NR==var{a=$0}NR==FNR{next}FNR==var1{print a}1' camelid_sequences_omega${omega1}.xml camelid_sequences_omega${omega2}.xml > tmp && mv tmp camelid_sequences_omega${omega2}.xml;
	((i++))
done

i=1 
while [ $i -le 212 ]; do
	j=$(( 4*$i )) #copy every fourth line
	k=$(( 4+6*($i-1) )) #we add a sequence to the computed line number
	awk -v var="$j" -v var1="$k" 'NR==var{a=$0}NR==FNR{next}FNR==var1{print a}1' camelid_sequences_omega${omega3}.xml camelid_sequences_omega${omega2}.xml > tmp && mv tmp camelid_sequences_omega${omega2}.xml;
	((i++))
done

#res1
#sed -n "1,233p" camelid_pyvolve_res1.xml > tmp2.xml; #puts the first 233 lines of the xml file in a temporary file #up to alignment
#sed -n "2,1273p" camelid_sequences_omega${omega2}.xml >> tmp2.xml; #adds the sequences to the temporary file #don't include the alignment tags
#sed "1,1081d" camelid_pyvolve_res1.xml >> tmp2.xml; #adds the last lines of the original xml to the temporary file #1081 is right befor the last alignment tag
#mv tmp2.xml ../beast_res1/camelid_beast_res1.xml #rename

#res2
sed -n "1,233p" camelid_pyvolve_res2.xml > tmp2.xml; #puts the first 233 lines of the xml file in a temporary file #up to alignment
sed -n "2,1273p" camelid_sequences_omega${omega2}.xml >> tmp2.xml; #adds the sequences to the temporary file #don't include the alignment tags
sed "1,1081d" camelid_pyvolve_res2.xml >> tmp2.xml; #adds the last lines of the original xml to the temporary file #1081 is right befor the last alignment tag
mv tmp2.xml ../beast_res2/camelid_beast_res2.xml #rename

#res3
#sed -n "1,233p" camelid_pyvolve_res3.xml > tmp2.xml; #puts the first 233 lines of the xml file in a temporary file #up to alignment
#sed -n "2,1273p" camelid_sequences_omega${omega2}.xml >> tmp2.xml; #adds the sequences to the temporary file #don't include the alignment tags
#sed "1,1081d" camelid_pyvolve_res3.xml >> tmp2.xml; #adds the last lines of the original xml to the temporary file #1081 is right befor the last alignment tag
#mv tmp2.xml ../beast_res3/camelid_beast_res3.xml #rename

#res4
sed -n "1,233p" camelid_pyvolve_res4.xml > tmp2.xml; #puts the first 233 lines of the xml file in a temporary file #up to alignment
sed -n "2,1273p" camelid_sequences_omega${omega2}.xml >> tmp2.xml; #adds the sequences to the temporary file #don't include the alignment tags
sed "1,1081d" camelid_pyvolve_res4.xml >> tmp2.xml; #adds the last lines of the original xml to the temporary file #1081 is right befor the last alignment tag
mv tmp2.xml ../beast_res4/camelid_beast_res4.xml #rename