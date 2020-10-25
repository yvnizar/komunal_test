<?php

// define variable
$allNum = [];
$notSelfNum = [];

// loop between 0 to 5000
for ($i=0; $i <= 5000; $i++) { 
    $b = (string) $i;
    
    $allNum[] = $i;
    $numLen = strlen($i); // length of integer

    // print_r("INI I :" . $i . "<br>");
    // print_r("INI B :" . $b[0] . "<br>");

    switch ($numLen) {
        case 1: // case when length number is 1
            $sumNumber = $i+$b[0];
            $notSelfNum[] = $sumNumber; // sum of 1 number
            break;
        
        case 2: // case when length number is 2
            $sumNumber = $i+$b[0]+$b[1];
            $notSelfNum[] = $sumNumber; // sum of 2 number
            break;
        
        case 3: // case when length number is 3
            $sumNumber = $i+$b[0]+$b[1]+$b[2];
            $notSelfNum[] = $sumNumber; // sum of 3 number
            break;

        case 4: // case when length number is 4
            $sumNumber = $i+$b[0]+$b[1]+$b[2]+$b[3];
            $notSelfNum[] = $sumNumber; // sum of 4 number
            break;
    }

    // print_r(gettype($b) . "<br>");
}

// 
$selfNum = array_diff($allNum, $notSelfNum);

// print_r("SELF NUMBER <br>");
// print_r($selfNum);

// print_r("<br> NOT SELF NUMBER <br>");
// print_r($notSelfNum);

$sumSelfNum = 0;

foreach ($selfNum as $eachSelfNum) {
	$sumSelfNum += $eachSelfNum;
}

echo "<pre>Jumlah total (sum) semua bilangan self-number antara 0 dan 5000 adalah: <strong>" . number_format($sumSelfNum)."</strong>";

?>