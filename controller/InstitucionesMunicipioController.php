<?php 
    class InstitucionesMunicipioController{
        private $model;
      
        public function __construct()
        {
            require_once __DIR__ . "/../model/InstitucionesMunicipioModel.php";
            $this->model= new InstitucionesMunicipioModel();
        }
        public function index(){
            return ($this->model->index()) ? $this->model->index(): false;
        }
        public function search() {
            $rows = $this->model->search();
            $data = array();
            
            if ($rows) {
                foreach ($rows as $row) {
                    $data[] = array(
                        'codigo_ies_padre' => $row['codigo_ies_padre'],
                        'cod_inst' => $row['cod_inst'],
                        'nomb_inst' => $row['nomb_inst'],
                        'nomb_sector' => $row['nomb_sector'],
                        'nomb_academ' => $row['nomb_academ'],
                        'nomb_depto' => $row['nomb_depto'],
                        'nomb_munic' => $row['nomb_munic'],
                        'nomb_estado' => $row['nomb_estado'],
                        'acreditada' => $row['acreditada']
                    );
                }
            }
            
            $json = json_encode($data, JSON_UNESCAPED_UNICODE);
            
            // Generar el nombre del archivo JSON
            $filename = 'data.json';
        }

        public function cobertura($cod_depto,$cod_munic){
            return ($this->model->cobertura($cod_depto,$cod_munic)) ? $this->model->cobertura($cod_depto,$cod_munic): false;
        }

        public function reporte($cod_admon){
            return ($this->model->reporte($cod_admon)) ? $this->model->reporte($cod_admon): false;
        }

        public function show($cod_inst,$cod_munic){
            return ($this->model->show($cod_inst,$cod_munic)!=false) ? $this->model->show($cod_inst,$cod_munic) : 
            header("Location:index_inst_mun.php");
        }

        public function update($cod_inst, $cod_munic, $telefono, $direccion,$cod_estado,
        $programas_vigente,$acreditada,$fecha_acreditacion,$vigencia,$resolucion_acreditacion,
        $cod_juridica,$cod_seccional) {

            $result = $this->model->update($cod_inst, $cod_munic, $telefono, $direccion,$cod_estado,
            $programas_vigente,$acreditada,$fecha_acreditacion,$vigencia,$resolucion_acreditacion,
            $cod_juridica,$cod_seccional);
            if ($result != false) {
                return header("Location:show_inst_mun.php?cod_inst=".$cod_inst . "&cod_munic=" .$cod_munic  );
            } else {
                return header("Location: index_inst_mun.php");
            }
        }

        public function insertar($codigo_ies_padre, $nomb_inst, $cod_sector, $cod_academ, $cod_inst, 
        $cod_munic, $telefono, $cod_estado){
            $result=$this->model->insertar($codigo_ies_padre, $nomb_inst, $cod_sector, $cod_academ, $cod_inst, 
            $cod_munic, $telefono, $cod_estado);
            if($result != false){
                return header("Location:show_inst_mun.php?cod_inst=".$cod_inst . "&cod_munic=" .$cod_munic  );
            } else {
                return header("Location: index_inst_mun.php");
            }
            
        }

        public function instituciones(){
            return ($this->model->instituciones()) ? $this->model->instituciones(): false;
            }
            public function departamentos(){
            return ($this->model->departamentos()) ? $this->model->departamentos(): false;
            }

            public function departamentos_2(){
                return ($this->model->departamentos_2()) ? $this->model->departamentos_2() : false;
            }

            public function municipios(){
            return ($this->model->municipios()) ? $this->model->municipios(): false;
            }
            public function stats_p($cod_inst,$cod_depto,$cod_munic){
            return ($this->model->stats_p($cod_inst,$cod_depto,$cod_munic)) ? $this->model->stats_p($cod_inst,$cod_depto,$cod_munic): false;
            }
            
            public function nombre_and_total($cod_inst,$cod_depto){
            return ($this->model->nombre_and_total($cod_inst,$cod_depto)) ? $this->model->nombre_and_total($cod_inst,$cod_depto): false;
            }
            public function stats_d($cod_depto){
            return ($this->model->stats_d($cod_depto)) ? $this->model->stats_d($cod_depto): false;
            }
            public function stats_d_nomb($cod_depto){
            return ($this->model->stats_d_nomb($cod_depto)) ? $this->model->stats_d_nomb($cod_depto): false;
            }
            public function sum_inst($cod_depto){
            return ($this->model->sum_inst($cod_depto)) ? $this->model->sum_inst($cod_depto): false;
            }

            public function normas(){
            return ($this->model->normas()) ? $this->model->normas(): false; 
            }

            public function stats_normas(){
            return ($this->model->stats_normas()) ? $this->model->stats_normas(): false; 
            }

            public function logs_instituciones() {
            return ($this->model->logs_instituciones()) ? $this->model->logs_instituciones() : false;
            }
    }


?>