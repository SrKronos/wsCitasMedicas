try 
	{
        $dsn = "arboledadb";
        $usuario ="dba";
        $clave = "proyecto2014";
        $conexion = odbc_connect($dsn, $usuario, $clave);
       // $sql= "select * from vmostrarcitas where reserva_desde>=".$_GET["desde"]." and reserva_hasta<=".$_GET["hasta"];
	   $sql= "select top 4 doctor,especialidad from vmostrarcitas  where tipo='*CONSULTAS' GROUP BY doctor,especialidad order by doctor ASC";
	    $result=odbc_exec($conexion,$sql)or die(exit("Error en odbc_exec"));
       //print odbc_result_all($result,"border=1");

        while($myRow = odbc_fetch_array( $result )){ 
            $rows[] = $myRow;
        }
    
        $objeto = [];
		$cita = [];

        
        foreach($rows as $row) {
                foreach($row as $key => $value) {
                    $dato = $value;
					$cita[$key] = $value;
                }
				array_push($objeto,$cita);
        }
		//print_r($objeto);
		echo json_encode($objeto);
	} 
	catch(PDOException $e) 
	{
		echo '<h1>Error al obtener citas.</h1><pre>', $e->getMessage()
				,'</pre>';
	}