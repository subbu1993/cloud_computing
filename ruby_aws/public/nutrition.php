<?php
$connection = mysqli_connect("localhost", "root", "", "nutritioninfo");
$query = "select * from foodinfo where Name=\"".$_GET["q"]."\" ";
$result = $connection->query($query);
$row = $result->fetch_assoc();
$output = "{Carbohydrates: ".$row["Carbohydrate"]." |  Proteins: ".$row["Protein"]." |  Vitamins: ".$row["Vitamins"]." |  Fat: ".$row["Fat"]."}";
echo json_encode($output);

?>
