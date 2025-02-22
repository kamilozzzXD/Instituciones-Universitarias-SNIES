/*1*/
CREATE TABLE naturaleza_juridica(
	cod_juridica varchar(5),
	nomb_juridica varchar(50)
);

ALTER TABLE naturaleza_juridica ADD CONSTRAINT pk_cod_juridica PRIMARY KEY(cod_juridica);


/*2*/
CREATE TABLE seccional(
	cod_seccional varchar(5),
	nomb_seccional varchar(50)
);
ALTER TABLE seccional ADD CONSTRAINT pk_cod_seccional PRIMARY KEY(cod_seccional);



/*3*/
CREATE TABLE acto_admon(
	cod_admon varchar(5),
	nomb_admon varchar(50)
);
ALTER TABLE acto_admon ADD CONSTRAINT pk_cod_admon PRIMARY KEY(cod_admon);

/*4*/
CREATE TABLE norma_creacion(
	cod_norma varchar(5),
	nomb_norma varchar(50)
);
ALTER TABLE norma_creacion ADD CONSTRAINT pk_cod_norma PRIMARY KEY(cod_norma);


/*5*/
CREATE TABLE estado(
	cod_estado varchar(5),
	nomb_estado varchar(50)
);
ALTER TABLE estado ADD CONSTRAINT pk_cod_estado PRIMARY KEY(cod_estado);


/*6*/
CREATE TABLE departamento(
	cod_depto varchar(5),
	nomb_depto varchar(100)
);
ALTER TABLE departamento ADD CONSTRAINT pk_cod_depto PRIMARY KEY(cod_depto);


/*7*/
CREATE TABLE municipio(
	cod_munic varchar(5),
	nomb_munic varchar(50),
	cod_depto varchar(5)
	
);
ALTER TABLE municipio ADD CONSTRAINT pk_cod_munic PRIMARY KEY(cod_munic);
ALTER TABLE municipio ADD CONSTRAINT fk_cod_depto FOREIGN KEY(cod_depto) REFERENCES departamento(cod_depto) ON DELETE RESTRICT ON UPDATE RESTRICT;


/*8*/
CREATE TABLE sectores(
	cod_sector varchar(5),
	nomb_sector varchar(50)
);
ALTER TABLE sectores ADD CONSTRAINT pk_cod_sector PRIMARY KEY(cod_sector);


/*9*/
CREATE TABLE caracter_academico(
	cod_academ varchar(5),
	nomb_academ varchar(50)
);
ALTER TABLE caracter_academico ADD CONSTRAINT pk_cod_academ PRIMARY KEY(cod_academ);


/*10*/
CREATE TABLE instituciones(
	codigo_ies_padre varchar(5),
	nomb_inst varchar(100),
	cod_sector varchar(5),
	cod_academ varchar(5)

);
ALTER TABLE instituciones ADD CONSTRAINT pk_cod_inst PRIMARY KEY(codigo_ies_padre);
ALTER TABLE instituciones ADD CONSTRAINT fk_cod_sector FOREIGN KEY(cod_sector) REFERENCES sectores(cod_sector) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE instituciones ADD CONSTRAINT fk_cod_academ FOREIGN KEY(cod_academ) REFERENCES caracter_academico(cod_academ) ON DELETE RESTRICT ON UPDATE RESTRICT;

/*11*/
CREATE TABLE inst_por_municipio(
	direccion varchar(100),
	telefono varchar(10),
	norma varchar(50),
	fecha_creacion DATE,
	programas_vigente int ,
	acreditada varchar(2),
	fecha_acreditacion DATE,
	resolucion_acreditacion varchar(20),
	vigencia int CHECK(vigencia>0),
	nit varchar(50),
	pagina_web varchar(200),

	cod_inst varchar(5),
	cod_munic varchar(5),	

	codigo_ies_padre varchar(5),
	cod_juridica varchar(5),
	cod_seccional varchar(5),	
	cod_admon varchar(5),
	cod_norma varchar(5),
	cod_estado varchar(5)
);

ALTER TABLE inst_por_municipio ADD CONSTRAINT pk_cod_inst_munic PRIMARY KEY(cod_inst,cod_munic);


ALTER TABLE inst_por_municipio ADD CONSTRAINT fk_cod_juridica FOREIGN KEY(cod_juridica) REFERENCES naturaleza_juridica(cod_juridica) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE inst_por_municipio ADD CONSTRAINT fk_cod_seccional FOREIGN KEY(cod_seccional) REFERENCES seccional(cod_seccional) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE inst_por_municipio ADD CONSTRAINT fk_cod_admon FOREIGN KEY(cod_admon) REFERENCES acto_admon(cod_admon) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE inst_por_municipio ADD CONSTRAINT fk_cod_norma FOREIGN KEY(cod_norma) REFERENCES norma_creacion(cod_norma) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE inst_por_municipio ADD CONSTRAINT fk_cod_estado FOREIGN KEY(cod_estado) REFERENCES estado(cod_estado) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE inst_por_municipio ADD CONSTRAINT fk_codigo_ies_padre FOREIGN KEY(codigo_ies_padre) REFERENCES instituciones(codigo_ies_padre) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE inst_por_municipio ADD CONSTRAINT fk_cod_munic FOREIGN KEY(cod_munic) REFERENCES municipio(cod_munic) ON DELETE RESTRICT ON UPDATE RESTRICT;;


/*12*/
CREATE TABLE cargos(
	cod_cargo varchar(5),
	nomb_cargo varchar(50)
);
ALTER TABLE cargos ADD CONSTRAINT pk_cod_cargos PRIMARY KEY(cod_cargo);


/*13*/
CREATE TABLE acto_nombramiento(
	cod_nombram varchar(5),
	nomb_nombram varchar(100)
);
ALTER TABLE acto_nombramiento ADD CONSTRAINT pk_cod_nombram PRIMARY KEY(cod_nombram);


/*14*/
CREATE TABLE directivos(
	cod_directivo varchar(5),
	nomb_directivo varchar(50),
	apell_directivo varchar(50)
);
ALTER TABLE directivos ADD CONSTRAINT pk_cod_directivo PRIMARY KEY(cod_directivo);


/*15*/
CREATE TABLE rectoria(
	
	fecha_inicio DATE,
	fecha_final DATE,

	
	cod_directivo varchar(5),
	cod_inst varchar(5),
	cod_munic varchar(5),

	cod_cargo varchar(5),
	cod_nombram varchar(5)
);


ALTER TABLE rectoria ADD CONSTRAINT pk_cod_rectoria PRIMARY KEY(cod_munic,cod_inst,cod_directivo,cod_cargo);
ALTER TABLE rectoria ADD CONSTRAINT fk_cod_cargo FOREIGN KEY(cod_cargo) REFERENCES cargos(cod_cargo) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE rectoria ADD CONSTRAINT fk_cod_nombram FOREIGN KEY(cod_nombram) REFERENCES acto_nombramiento(cod_nombram) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE rectoria ADD CONSTRAINT fk_cod_directivo FOREIGN KEY(cod_directivo) REFERENCES directivos(cod_directivo) ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE rectoria ADD CONSTRAINT fk_cod_inst_cod_munic FOREIGN KEY(cod_inst,cod_munic) REFERENCES inst_por_municipio(cod_inst,cod_munic) ON DELETE RESTRICT ON UPDATE CASCADE;




COPY naturaleza_juridica(cod_juridica,nomb_juridica) FROM '/tmp/naturaleza_juridica.csv' DELIMITER ',' CSV HEADER;
COPY seccional(cod_seccional,nomb_seccional) FROM '/tmp/seccional.csv' DELIMITER ',' CSV HEADER;
COPY acto_admon(cod_admon,nomb_admon) FROM '/tmp/acto_admon.csv' DELIMITER ',' CSV HEADER;
COPY norma_creacion(cod_norma,nomb_norma) FROM '/tmp/norma_creacion.csv' DELIMITER ',' CSV HEADER;
COPY estado(cod_estado,nomb_estado) FROM '/tmp/estado.csv' DELIMITER ',' CSV HEADER;
COPY departamento(cod_depto,nomb_depto) FROM '/tmp/departamento.csv' DELIMITER ',' CSV HEADER;
COPY municipio(cod_munic,nomb_munic,cod_depto) FROM '/tmp/municipio.csv' DELIMITER ',' CSV HEADER;
COPY sectores(cod_sector,nomb_sector) FROM '/tmp/sectores.csv' DELIMITER ',' CSV HEADER;
COPY caracter_academico(cod_academ,nomb_academ) FROM '/tmp/caracter_academico.csv' DELIMITER ',' CSV HEADER;
COPY instituciones(codigo_ies_padre,nomb_inst,cod_sector,cod_academ) FROM '/tmp/instituciones.csv' DELIMITER ',' CSV HEADER;
COPY inst_por_municipio(direccion,telefono,norma,fecha_creacion,
programas_vigente,acreditada,fecha_acreditacion,resolucion_acreditacion,vigencia,nit,
pagina_web,cod_inst,cod_munic,codigo_ies_padre,cod_juridica,cod_seccional,cod_admon,cod_norma,cod_estado
) FROM '/tmp/inst_por_municipio.csv' DELIMITER ',' CSV HEADER;
COPY cargos(cod_cargo,nomb_cargo) FROM '/tmp/cargos.csv' DELIMITER ',' CSV HEADER;
COPY acto_nombramiento(cod_nombram,nomb_nombram) FROM '/tmp/acto_nombramiento.csv' DELIMITER ',' CSV HEADER;
COPY directivos(cod_directivo,nomb_directivo,apell_directivo) FROM '/tmp/directivos.csv' DELIMITER ',' CSV HEADER;
COPY rectoria(fecha_inicio,fecha_final,cod_directivo,cod_inst,cod_munic,cod_cargo,cod_nombram
) FROM '/tmp/rectoria.csv' DELIMITER ',' CSV HEADER;




/*Trigger Rectoria Update*/
CREATE TABLE rectoria_auditoria_mod(

	nomb_directivo_completo varchar(100),
    nomb_inst varchar(100),
    nomb_cargo varchar(50),
    nomb_munic varchar(50),
    fecha_inicio DATE,
	fecha_final DATE,

    operacion text,
    changed_on TIMESTAMP(0) NOT NULL,
    user_id varchar(30) NOT NULL
);



CREATE OR REPLACE FUNCTION logs_rectoria_mod() returns trigger as 
$$
declare

rec record;

    log_nomb_directivo_completo varchar(100);
    log_nomb_inst varchar(100);
    log_nomb_cargo varchar(50);
    log_nomb_munic varchar(50);

begin 


        for rec in (SELECT r.cod_directivo as cod_directivo, CONCAT(d.nomb_directivo, ' ', d.apell_directivo) AS nomb_directivo, 
        r.cod_inst as cod_inst,  i.nomb_inst as nomb_inst, r.cod_cargo as cod_cargo, c.nomb_cargo as nomb_cargo,  r.cod_munic as cod_munic, m.nomb_munic as nomb_munic
        FROM rectoria r
        JOIN directivos d ON d.cod_directivo = r.cod_directivo
        JOIN instituciones i ON i.codigo_ies_padre = (SELECT codigo_ies_padre FROM inst_por_municipio WHERE cod_inst = r.cod_inst)
        JOIN cargos c ON c.cod_cargo = r.cod_cargo
        JOIN acto_nombramiento a ON a.cod_nombram = r.cod_nombram
        JOIN municipio m ON m.cod_munic = r.cod_munic)
        loop

            if rec.cod_directivo = NEW.cod_directivo and rec.cod_inst = NEW.cod_inst and rec.cod_cargo = NEW.cod_cargo and rec.cod_munic = NEW.cod_munic then
                log_nomb_directivo_completo = rec.nomb_directivo;
                log_nomb_inst = rec.nomb_inst;
                log_nomb_cargo = rec.nomb_cargo;
                log_nomb_munic = rec.nomb_munic;

            end if;

        end loop;

        if TG_OP = 'UPDATE' then
                INSERT INTO rectoria_auditoria_mod(nomb_directivo_completo, nomb_inst, nomb_cargo, nomb_munic, fecha_inicio, fecha_final, operacion, changed_on, user_id)
                VALUES (log_nomb_directivo_completo, log_nomb_inst, log_nomb_cargo, log_nomb_munic, OLD.fecha_inicio, OLD.fecha_final, TG_OP, current_timestamp, current_user);
        end if;

        RETURN NEW;


end;
$$
language plpgsql;


CREATE OR REPLACE TRIGGER TG_rectoria 
before update on rectoria
FOR EACH ROW EXECUTE PROCEDURE logs_rectoria_mod();



/*Trigger Instituciones Insert*/



CREATE TABLE inst_auditoria_in(
	codigo_ies_padre varchar(5),
	nomb_inst varchar(100),

    operacion text,
    changed_on TIMESTAMP(0) NOT NULL,
    user_id varchar(30) NOT NULL

);

CREATE TABLE inst_municipio_auditoria_in(
	codigo_ies_padre varchar(5),
    cod_inst varchar(5),
    telefono varchar(10)
);




CREATE OR REPLACE FUNCTION logs_inst_in() returns trigger as 
$$

begin 
        if TG_OP = 'INSERT' then
                INSERT INTO inst_auditoria_in(codigo_ies_padre, nomb_inst, operacion, changed_on, user_id)
                VALUES (NEW.codigo_ies_padre, NEW.nomb_inst, TG_OP, current_timestamp, current_user);
        end if;

        RETURN NEW;

end;
$$
language plpgsql;


CREATE OR REPLACE FUNCTION logs_inst_munic_in() returns trigger as 
$$

begin 
        if TG_OP = 'INSERT' then
                INSERT INTO inst_municipio_auditoria_in(codigo_ies_padre, cod_inst, telefono)
                VALUES (NEW.codigo_ies_padre, NEW.cod_inst, NEW.telefono);
        end if;

        RETURN NEW;

end;
$$
language plpgsql;


CREATE TRIGGER TG_INST 
before insert on instituciones
FOR EACH ROW EXECUTE PROCEDURE logs_inst_in();



CREATE TRIGGER TG_INST_MUNIC
before insert on inst_por_municipio
FOR EACH ROW EXECUTE PROCEDURE logs_inst_munic_in();






