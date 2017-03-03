<html>
<head>
<title>FSME IP Control Unit VHDL generation Utility</title>
<style></style>
</head>
<html>
	<body>

<?php
echo "FSME IP Control Unit VHDL generation Utility</br>";
echo "Generating strip control loop code...</br></br>";

//$i represents the number of strips we have to check. For a block of 32x32 we need 32 strips.
//Since The first two strips are already hardcoded, here we will generate only code for 30 strips.

$k=81; //Start cycle

for ($i =1; $i < 32; $i++){
	
	echo "-- Start reading submemory 1. Writing only 16 pixels on submemory 3.</br>";
	echo "when ".$k." => cs_en_col_load <= '1'; cs_colcnt <= \"000000\";</br>";
	echo "when ".($k+1)." => cs_en_DIFF <= '0'; cs_en_col_load <= '0';</br>";
	echo "when ".($k+3)." => cs_en_wr_mem3 <= '1'; cs_datasel <= \"11\";</br>";
	echo "when ".($k+4)." => cs_en_wr_mem3 <= '0';</br>";	
	
	echo "-- Start reading submemory 2. Writing only 16 pixels on submemory 1.</br>";
	echo "when ".($k+17)." => cs_en_DIFF <= '1';</br>";
	echo "when ".($k+19)." => cs_en_wr_mem1 <= '1'; cs_datasel <= \"01\";</br>";
	echo "when ".($k+20)." => cs_en_wr_mem1 <= '0';</br>";
	
	echo "-- Start reading submemory 3. Writing only 16 pixels on submemory 2.</br>";
	echo "when ".($k+35)." => cs_en_wr_mem2 <= '1'; cs_datasel <= \"10\";</br>";
	echo "when ".($k+36)." => cs_en_wr_mem2 <= '0';</br>";
	
	$k = $k+47;
}

?>
	</body>
</html>