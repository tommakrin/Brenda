<?php

$diff = 0;
$sum = 0;

$cb = array();
for($i=0; $i<16; $i++){
	
	$cb[] = array(0x10,0x22,0x20,0x12,0x12,0x12,0x10,0x20,0x22,0x22,0x20,0x12,0x10,0x11,0x11,0x11);
	
}

$rb = array();
for($i=0; $i<16; $i++){
	
	$rb[] = array(0x20,0x20,0x12,0x12,0x10,0x10,0x22,0x22,0x22,0x22,0x11,0x11,0x11,0x22,0x22,0x22);
	
}

// Print CB
echo "<div style='width:350px;float:left;'>";
echo "<h1>CB</h1>";
echo "<table>";

for($j=0; $j<16; $j++){
	
	echo "<tr>";
	
	for($k=0; $k<16; $k++){
		echo "<td>".dechex($cb[$j][$k])."</td>";
		
	}
	
	echo "<tr>";
	
}
echo "</table>";
echo "</div>";

// Print RB
echo "<div style='width:320px;float:left;'>";
echo "<h1>RB</h1>";
echo "<table>";

for($j=0; $j<16; $j++){
	
	echo "<tr>";
	
	for($k=0; $k<16; $k++){
		echo "<td>".dechex($rb[$j][$k])."</td>";
		
	}
	
	echo "<tr>";
	
}


echo "</table>";
echo "</div>";


echo "<div style='width: 322px;float: right;margin-right: 249px;'>";
echo "<h1>RESULT</h1>";
echo "<table>";

for($j=0; $j<16; $j++){
	
	echo "<tr>";
	
	for($k=0; $k<16; $k++){
		$diff = abs($cb[$j][$k] - $rb[$j][$k]);
		$sum += $diff;
		echo "<td>".dechex($diff)."</td>";
		
	}
	
	echo "<tr>";
	
}
echo "</table>";
echo "</div>";

echo "<br/><span>";
echo "<B>SAD:</B>";
echo dechex($sum);
echo "</span>";
?>