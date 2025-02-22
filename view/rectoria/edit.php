<!--Se valida la fecha inicial menor a la final -->

<?php
require_once "/opt/lampp/htdocs/proyecto_crud/controller/RectoriaController.php";

if (isset($_GET['cod_munic']) && isset($_GET['cod_inst']) && isset($_GET['cod_directivo']) && isset($_GET['cod_cargo'])) {
    $obj = new RectoriaController();
    $rectoria = $obj->show($_GET['cod_munic'], $_GET['cod_inst'], $_GET['cod_directivo'], $_GET['cod_cargo']);
} else {
    echo "HUBO UN ERROR :(";
    exit;
}
?>
<link rel="stylesheet" type="text/css" href="/proyecto_crud/assest/css/modificar.css">
<!--Se llama a la funcion validarFechas()-->
<div class="modal">
    <div class="modal-container">
        <form action="update.php?cod_munic=<?= $rectoria['cod_munic'] ?>&cod_cargo=<?= $rectoria['cod_cargo']?>
&cod_inst=<?= $rectoria['cod_inst'] ?>&cod_directivo=<?= $rectoria['cod_directivo']?>" method="POST"
            onsubmit="return validarFechas()">
            <h2>MODIFICANDO REGISTRO</h2>
            <div class="mb-3 row">
                <label for="staticEmail" class="col-sm-2 col-form-label">DIRECTIVO</label>
                <div class="col-sm-10">
                    <input type="text" name="nomb_directivo" readonly class="form-control-plaintext"
                        value="<?= $rectoria['nomb_directivo']?>">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="staticEmail" class="col-sm-2 col-form-label">INSTITUCION</label>
                <div class="col-sm-10">
                    <input type="text" name="nomb_inst" readonly class="form-control-plaintext"
                        value="<?= $rectoria['nomb_inst']?>">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="staticEmail" class="col-sm-2 col-form-label">CARGO</label>
                <div class="col-sm-10">
                    <input type="text" name="nomb_cargo" readonly class="form-control-plaintext"
                        value="<?= $rectoria['nomb_cargo']?>">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="staticEmail" class="col-sm-2 col-form-label">MUNICIPIO</label>
                <div class="col-sm-10">
                    <input type="text" name="nomb_munic" readonly class="form-control-plaintext"
                        value="<?= $rectoria['nomb_munic']?>">
                </div>
            </div>

            <div class="mb-3 row">
                <label for="exampleInputEmail1" class="col-sm-2 col-form-label">FECHA INICIO</label>
                <div  class="col-sm-10">
                    <input type="date" name="fecha_inicio" id="fecha_inicio" required class="form-control"
                        value="<?= $rectoria['fecha_inicio'] ?>">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="exampleInputEmail1" class="col-sm-2 col-form-label">FECHA FINAL</label>
                <div  class="col-sm-10">
                    <input type="date" name="fecha_final" id="fecha_final" required class="form-control"
                        value="<?= $rectoria['fecha_final'] ?>">
                </div>
            </div>
            <div class="mb-3 row">
                <label for="staticEmail" class="col-sm-2 col-form-label">NOMBRAMIENTO</label>
                <div class="col-sm-10">
                    <input type="text" name="nomb_nombram" readonly class="form-control-plaintext"
                        value="<?= $rectoria['nomb_nombram']?>">
                </div>
            </div>
            <div>
                <input type="submit" class="btn btn-success" value="ACTUALIZAR">
                <a class="btn btn-danger" href="index.php">CANCELAR</a>
            </div>
        </form>
    </div>
</div>


<script>
//funcion para validar que la fecha de inicio no se mayor a la final
function validarFechas() {
    var fechaInicio = new Date(document.getElementById('fecha_inicio').value);
    var fechaFinal = new Date(document.getElementById('fecha_final').value);
    var today = new Date(); // Fecha actual

    if (fechaInicio < today) {
        alert('La fecha de inicio tiene que ser mayor a la actual.');
        return false; // Evita enviar el formulario si hay un error
    } else {

        if (fechaInicio > fechaFinal) {
            alert('La fecha de inicio no puede ser mayor a la fecha final.');
            return false; // Evita enviar el formulario si hay un error
        }

        return true; // Permite enviar el formulario si no hay errores
    }
}
</script>