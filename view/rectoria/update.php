<?php
require_once "/opt/lampp/htdocs/proyecto_crud/controller/RectoriaController.php";
$obj = new RectoriaController();
$obj->update($_POST['fecha_inicio'], $_POST['fecha_final'], $_GET['cod_directivo'], $_GET['cod_inst'],
$_GET['cod_munic'], $_GET['cod_cargo']);
?>

