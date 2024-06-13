-- ====================================================
-- Crear la base de datos
-- ====================================================
use master
go
if exists (select * from sysdatabases where name = 'DBCreditoRural')
begin
	drop database DBCreditoRural
end

create database DBCreditoRural
go
-- ====================================================
-- Crear los tipos y las tablas
-- ====================================================
/* Activar Base de datos: DBCreditoRural */
use DBCreditoRural
go
/* Crear los tipos */
exec sp_addtype TCodComunidad, "varchar(12)","NOT NULL"
go
exec sp_addtype TCodPrestatario, "varchar(8)","NOT NULL"
go
exec sp_addtype TCodOficial, "varchar(8)","NOT NULL"
go
exec sp_addtype TDocPrestamo, "varchar(12)","NOT NULL"
go
exec sp_addtype TDocCancelacion, "varchar(12)","NOT NULL"
go

/* Crear las tablas*/
-------------------------------------------------------------------
create table Comunidad
( -- lista de atributos
  CodComunidad   TCodComunidad NOT NULL,
  Nombre         varchar(40) NOT NULL,
  -- definici n de claves
  PRIMARY KEY (CodComunidad)
)
go
-------------------------------------------------------------------
create table Prestatario
( -- lista de atributos
  CodPrestatario   TCodPrestatario NOT NULL,
  Nombres          varchar(40),
  Sexo             varchar(9) check (Sexo in ('MASCULINO','FEMENINO')),
  EstadoCivil      varchar(15) check (EstadoCivil in ('SOLTERO','CASADO','DIVORCIADO','VIUDO','CONVIVIENTE')),
  DocIdentidad     varchar(15),
  CodComunidad   TCodComunidad,
  -- definicion de claves
  PRIMARY KEY (CodPrestatario),
  FOREIGN KEY (CodComunidad) REFERENCES Comunidad(CodComunidad)
)
go
-------------------------------------------------------------------
create table Oficial_Credito
( --lista de atributos
  CodOficial   TCodOficial NOT NULL,
  Nombres      varchar(40) NOT NULL,
  Email	       varchar(35),	 
  -- definicion de claves
  PRIMARY KEY (CodOficial)
 )
 go
-------------------------------------------------------------------
create table Prestamo
( -- lista de atributos
  DocPrestamo       TDocPrestamo NOT NULL,
  FechaPrestamo     datetime,
  Importe           numeric(15,2) check(Importe > 0),
  FechaVencimiento  datetime,
  CodPrestatario   TCodPrestatario NOT NULL,
  CodOficial   TCodOficial NOT NULL,
  -- definicion de claves
  PRIMARY KEY (DocPrestamo),
  FOREIGN KEY (CodPrestatario) REFERENCES Prestatario,
  FOREIGN KEY (CodOficial) REFERENCES Oficial_Credito
 )
 go
-------------------------------------------------------------------
create table Amortizacion
( -- lista de atributos
  DocCancelacion    TDocCancelacion NOT NULL,
  FechaCancelacion  datetime,
  Importe           numeric(15,2) check(Importe > 0),
  DocPrestamo       TDocPrestamo NOT NULL,
  -- definicion de claves
  PRIMARY KEY (DocCancelacion),
  FOREIGN KEY (DocPrestamo) REFERENCES Prestamo
 )
 go
 
-- ====================================================
-- Inserci n de datos de ejemplo
-- ====================================================
set dateformat dMy
go
--------------------- Tabla : Comunidad ----------------------------------
INSERT INTO Comunidad values ('C001','Comunidad de Saylla')
INSERT INTO Comunidad values ('C002','Comunidad de San Jeronimo')
INSERT INTO Comunidad values ('C003','Comunidad de San Sebastian')
INSERT INTO Comunidad values ('C004','Comunidad de Poroy')
INSERT INTO Comunidad values ('C005','Comunidad de Ccorca')
INSERT INTO Comunidad values ('C006','Comunidad de Santiago')
INSERT INTO Comunidad values ('C007','Comunidad de Espinar')
INSERT INTO Comunidad values ('C008','Comunidad de Huaccoto')

INSERT INTO Comunidad values('C010','Comunidad de Salkantay')
INSERT INTO Comunidad values ('C011','Comunidad de Cco amuro')
INSERT INTO Comunidad VALUES ('CO12','Comunidad de Santa In s')
INSERT INTO Comunidad values ('C013','Comunidad de Mamuera')
INSERT INTO Comunidad values('C014','Comunidad de Kiteni')
INSERT INTO Comunidad values('C015','Comunidad de Totora')
INSERT INTO Comunidad values ('C016','Comunidad de Calca')
INSERT INTO Comunidad values ('C017','Comunidad de Yucay')
INSERT INTO Comunidad values ('C018','Comunidad de Paruro')
INSERT INTO Comunidad values ('C019','Comunidad de Accos')

go
--------------------- Tabla : Prestatario ----------------------------------
INSERT INTO Prestatario values ('P01','Lopez Caceres Jose Antonio','Masculino','Soltero','23224556','C002')
INSERT INTO Prestatario values ('P02','Delgado Caceres Ana Maria','Femenino','Casado','23322556','C001')
INSERT INTO Prestatario values ('P03','Candia Calderon Maria','Femenino','Casado','22322556','C003')
INSERT INTO Prestatario values ('P04','Antonio Cutire Carlos','Masculino','Soltero','21244535','C004')
INSERT INTO Prestatario Values ('P05','Quispe Jimenes Jorge','Masculino','Casado','24563545','C005')
INSERT INTO Prestatario Values ('P06','Barrientos Torres Yovanna','Femenino','Soltero','22213456','C006')
INSERT INTO Prestatario values ('P07','Huaman Pariapaza Yvan','Masculino','Soltero','24244556','C007')
INSERT INTO Prestatario values ('P08','Noa Huamani Francisco','Masculino','Casado','24232556','C007')
INSERT INTO Prestatario values ('P09','Segovia Quispe Nancy','Femenino','Casado','45731551','C007')
INSERT INTO Prestatario values ('P10','Rios Campos Adams','Masculino','Soltero','44778138','C008')
INSERT INTO Prestatario values ('P11','Choquehuanca Paredes Adan','Masculino','Casado','43617275','C001')
INSERT INTO Prestatario values ('P12','Quispe Mamani Jaime','Masculino','Casado','41528712','C008')

INSERT INTO Prestatario values ('P16','Rado Rojas Julia Olimpia','Femenino','Soltero','18887424','C010')
INSERT INTO Prestatario values ('P17','Gonzales Estrada Ramon','Masculino','Casado','43557894','C010')
INSERT INTO Prestatario values ('P18','Gallegos Holgado Rufina','Femenino','Soltero','88449933','C010')
INSERT INTO Prestatario values ('P19','Ccahuana Castillo Hector Luis','Masculino','Soltero','45685295','C011')
INSERT INTO Prestatario values ('P20','Vargas Arce Lisbeth','Femenino','Casado','95135746','C011')
INSERT INTO Prestatario values ('P21','Florez Montalvo Silvia','Femenino','Casado','98712346','C011')
INSERT INTO Prestatario values ('P22','Caceres Torres Dario','Masculino','Soltero','47137719','C002')
INSERT INTO Prestatario values ('P23','Guzman Perez Eddy','Masculino','casado','47127218','C003')
INSERT INTO Prestatario values ('P24','Lopez Mamani Santiago','Masculino','Viudo','45147620','C007')
INSERT INTO Prestatario values ('P25','Meza Huamani Edgar','Masculino','Soltero','44668138','C008')
INSERT INTO Prestatario values ('P26','Castro Humpire Jose Luis','Masculino','Casado','43618275','C001')
INSERT INTO Prestatario values ('P27','Colque Rivera Felipe','Masculino','Viudo','41568712','C004')
INSERT INTO Prestatario values ('P28','Arzubialde Rosas Julio Cesar','Masculino','Soltero','23234586','C014')
INSERT INTO Prestatario values ('P29','Morales Chacon Virginia','Femenino','Casado','23364546','C014')
INSERT INTO Prestatario values ('P30','Calderon Manrrique Cristina','Femenino','Casado','22387555','C014')
INSERT INTO Prestatario values ('P31','Palomino Apaza David','Masculino','Divorciado','47012315','C015')
INSERT INTO Prestatario values ('P32','Quispe Alcantara Katherin','Femenino','Soltero','20401214','C015')
INSERT INTO Prestatario values ('P33','Chavez Bustamante Freddy','Masculino','Viudo','65141210','C015')
INSERT INTO Prestatario values ('P34','Gutierres Saldivar Basilio','Masculino','Casado','15478952','C016')
INSERT INTO Prestatario values ('P35','Flores Palomino Luis','Masculino','Viudo','23322546','C016')
INSERT INTO Prestatario values ('P36','Mendoza Oviedo Julia','Femenino','Casado','22322256','C016')
INSERT INTO Prestatario values ('P037','Alvarez Mejia Juan Carlos','Masculino','Casado','45455656','C003')
INSERT INTO Prestatario values ('P038','Sarmiento Zuniga Rosa','Femenino','Casado','55662233','C017')
INSERT INTO Prestatario values ('P039','Gonzales Rosas Veronica','Femenino','Casado','44101020','C005')
INSERT INTO Prestatario values ('P40','Cardenas Angulo Julio Cesar','Masculino','Casado','19879280','C019')
INSERT INTO Prestatario values ('P41','Alarcon Arroyo Juan','Masculino','Casado','18879280','C018')
INSERT INTO Prestatario values ('P42','Rojas Sosa Andres ','Masculino','Casado','19855280','C014')
INSERT INTO Prestatario values ('P43','Arguedas Pizarro Antonio','Masculino','SOLTERO','85296478','C018')

go

--------------------- Tabla : Oficial_Credito ----------------------------------
INSERT INTO Oficial_Credito values ('OC0001','Salas Mendez, Rolando','rolando@yahoo.es')
INSERT INTO Oficial_Credito values ('OC0002','Mamani Yauri, Matias Celestino','matias@gmail.com')
INSERT INTO Oficial_Credito Values ('OC0003','Merma Perez, Yesenea','yesenia@yahoo.es')
INSERT INTO Oficial_Credito values ('OC0004','Huachaca Avalos, Bruno','bruno@hotmail.com')
INSERT INTO Oficial_Credito values ('OC0005','Reyes Rios, Franco','franco@gmail.com')

INSERT INTO Oficial_Credito values ('OC0007','Zoila Gamarra Maria','mary@gmail.com')
INSERT INTO Oficial_Credito values ('OC0008','Huillca Cruz Americo','americo@yahoo.es')
INSERT INTO Oficial_Credito values ('OC0009','Huaman Condori Wilbert','wilbert@hotmail.es')
INSERT INTO Oficial_Credito values ('OC0010','Gutierrez Lopez Jesus','jesusito@gmail.com')
INSERT INTO Oficial_Credito values ('OC0011','Zapata Vizcarra Ubaldo','ubaldo@gmail.com')
INSERT INTO Oficial_Credito values ('OC0012','Aucca Cardenas Marcco','mar_1@hotmail.com')
INSERT INTO Oficial_Credito values ('OC0013','Ayala Huaman Jose','pepito@yahoo.es')
INSERT INTO Oficial_Credito values ('OC0014','Bazalar Mendoza Yuri','yuri@yahoo.com')
INSERT INTO Oficial_Credito values ('OC0015','Martinez Holgado Juan','juan@gmail.com')

go
--------------------- Tabla : Prestamo ----------------------------------
INSERT INTO Prestamo values ('PR10001','02/01/2004',1500.00,'02/05/2004','P01','OC0001')
INSERT INTO Prestamo values ('PR10002','10/01/2004',7500.00,'10/06/2004','P03','OC0001')
INSERT INTO Prestamo values ('PR10003','24/01/2004',3000.00,'11/08/2004','P01','OC0002')
INSERT INTO Prestamo values ('PR10004','23/03/2004',25000.00,'15/10/2004','P02','OC0002')
INSERT INTO Prestamo values ('PR10005','12/02/2005',5200.00,'08/12/2014','P03','OC0003')
INSERT INTO Prestamo values ('PR10006','07/01/2009',1000.00,'10/07/2012','P01','OC0003')
INSERT INTO Prestamo values ('PR10007','05/03/2010',7000.00,'10/07/2013','P01','OC0003')
INSERT INTO Prestamo values ('PR10008','08/08/2013',7000.00,'10/07/2014','P01','OC0003')
INSERT INTO Prestamo values ('PR10009','07/02/2008',7000.00,'10/07/2009','P01','OC0003')
INSERT INTO Prestamo values ('PR10010','01/04/2009',7000.00,'10/07/2010','P01','OC0003')
INSERT INTO Prestamo values ('PR10011','07/09/2007',7000.00,'10/07/2011','P01','OC0003')
INSERT INTO Prestamo values ('PR10012','05/06/2008',7000.00,'10/07/2013','P01','OC0003')
INSERT INTO Prestamo values ('PR10013','07/02/2012',7000.00,'10/07/2014','P01','OC0003')
INSERT INTO Prestamo values ('PR10014','09/01/2014',7000.00,'10/07/2014','P01','OC0003')
INSERT INTO Prestamo values ('PR10016','28/02/2005',3000.00,'27/06/2005','P07','OC0004')
INSERT INTO Prestamo values ('PR10017','16/04/2006',4000.00,'20/09/2006','P08','OC0004')
INSERT INTO Prestamo values ('PR10018','02/05/2007',2500.00,'05/12/2007','P08','OC0004')
INSERT INTO Prestamo values ('PR10019','18/06/2008',6000.00,'25/01/2009','P09','OC0004')
INSERT INTO Prestamo values ('PR10020','20/08/2008',3500.00,'20/12/2008','P09','OC0004')
INSERT INTO Prestamo values ('PR10021','15/06/2009',3800.00,'15/12/2009','P07','OC0004')
INSERT INTO Prestamo values ('PR10022','08/03/2010',4000.00,'18/08/2010','P07','OC0004')
INSERT INTO Prestamo values ('PR10023','24/08/2011',2600.00,'25/01/2012','P08','OC0004')
INSERT INTO Prestamo values ('PR10024','26/01/2012',2800.00,'01/08/2012','P09','OC0004')
INSERT INTO Prestamo values ('PR10025','24/07/2013',2000.00,'28/12/2013','P09','OC0004')
INSERT INTO Prestamo values ('PR10026','12/09/2005',3000.00,'20/10/2006','P10','OC0003')
INSERT INTO Prestamo values ('PR10027','21/01/2006',2000.00,'21/01/2007','P11','OC0002')
INSERT INTO Prestamo values ('PR10028','07/09/2007',1000.00,'07/09/2009','P10','OC0005')
INSERT INTO Prestamo values ('PR10029','19/12/2009',4000.00,'19/12/2010','P12','OC0001')
INSERT INTO Prestamo values ('PR10030','15/07/2008',6000.00,'15/07/2010','P12','OC0001')
INSERT INTO Prestamo values ('PR10031','02/10/2011',4000.00,'02/10/2013','P11','OC0002')
INSERT INTO Prestamo values ('PR10032','29/04/2011',5000.00,'29/04/2013','P10','OC0002')
INSERT INTO Prestamo values ('PR10033','27/04/2012',8000.00,'27/04/2013','P10','OC0005')
INSERT INTO Prestamo values ('PR10034','06/12/2012',2000.00,'06/12/2013','P11','OC0002')
INSERT INTO Prestamo values ('PR10035','17/08/2010',10000.00,'17/08/2011','P12','OC0005')

INSERT INTO Prestamo values ('PR10046','01/05/2006',1800.00,'02/06/2006','P16','OC0007')
INSERT INTO Prestamo values ('PR10047','06/07/2008',2000.00,'10/08/2008','P16','OC0007')
INSERT INTO Prestamo values ('PR10048','11/04/2009',6000.00,'11/12/2009','P16','OC0007')
INSERT INTO Prestamo values ('PR10049','07/05/2010',5000.00,'15/07/2010','P17','OC0007')
INSERT INTO Prestamo values ('PR10050','02/04/2011',15000.00,'02/08/2011','P17','OC0007')
INSERT INTO Prestamo values ('PR10051','10/03/2012',4000.00,'10/08/2012','P17','OC0007')
INSERT INTO Prestamo values ('PR10052','23/12/2012',10000.00,'23/02/2013','P18','OC0007')
INSERT INTO Prestamo values ('PR10053','24/07/2012',7000.00,'11/02/2013','P18','OC0007')
INSERT INTO Prestamo values ('PR10054','25/12/2012',3000.00,'15/01/2013','P18','OC0007')
INSERT INTO Prestamo values ('PR10055','05/05/2013',4000.00,'15/06/2013','P17','OC0007')
INSERT INTO Prestamo values ('PR10056','02/01/2006',1600.00,'02/01/2008','P19','OC0008')
INSERT INTO Prestamo values ('PR10057','10/01/2007',4700.00,'10/01/2009','P20','OC0008')
INSERT INTO Prestamo values ('PR10058','24/01/2008',3800.00,'24/01/2010','P21','OC0008')
INSERT INTO Prestamo values ('PR10059','23/03/2009',5800.00,'23/03/2011','P19','OC0008')
INSERT INTO Prestamo values ('PR10060','02/01/2010',1900.00,'02/01/2012','P20','OC0008')
INSERT INTO Prestamo values ('PR10061','10/01/2011',4550.00,'10/01/2012','P21','OC0008')
INSERT INTO Prestamo values ('PR10062','24/01/2012',3800.00,'24/09/2012','P19','OC0008')
INSERT INTO Prestamo values ('PR10063','23/03/2006',5500.00,'23/03/2009','P20','OC0008')
INSERT INTO Prestamo values ('PR10064','24/01/2007',3900.00,'24/01/2010','P21','OC0008')
INSERT INTO Prestamo values ('PR10065','23/03/2008',5400.00,'23/03/2011','P19','OC0008')
INSERT INTO Prestamo values ('PR10066','01/01/2004',1500.00,'02/04/2004','P22','OC0009')
INSERT INTO Prestamo values ('PR10067','10/03/2004',3000.00,'10/06/2004','P23','OC0009')
INSERT INTO Prestamo values ('PR10068','15/10/2005',5000.00,'15/06/2006','P24','OC0009')
INSERT INTO Prestamo values ('PR10069','20/01/2007',13000.00,'20/10/2007','P25','OC0009')
INSERT INTO Prestamo values ('PR10070','06/09/2008',6000.00,'10/02/2009','P26','OC0009')
INSERT INTO Prestamo values ('PR10071','07/03/2009',3000.00,'07/10/2009','P27','OC0009')
INSERT INTO Prestamo values ('PR10072','08/10/2009',3000.00,'10/01/2010','P28','OC0009')
INSERT INTO Prestamo values ('PR10073','03/05/2010',2000.00,'06/10/2010','P29','OC0009')
INSERT INTO Prestamo values ('PR10074','12/01/2011',5000.00,'12/06/2011','P30','OC0009')
INSERT INTO Prestamo values ('PR10075','15/05/2012',9000.00,'15/06/2013','P31','OC0009')
INSERT INTO Prestamo values ('PR10076','12/09/2005',3000.00,'20/10/2006','P25','OC0010')
INSERT INTO Prestamo values ('PR10077','21/01/2006',2000.00,'21/01/2007','P26','OC0002')
INSERT INTO Prestamo values ('PR10078','07/09/2007',1000.00,'07/09/2009','P27','OC0010')
INSERT INTO Prestamo values ('PR10079','19/12/2009',4000.00,'19/12/2010','P26','OC0001')
INSERT INTO Prestamo values ('PR10080','15/07/2008',6000.00,'15/07/2010','P01','OC0001')
INSERT INTO Prestamo values ('PR10081','02/10/2011',4000.00,'02/10/2013','P27','OC0002')
INSERT INTO Prestamo values ('PR10082','29/04/2011',5000.00,'29/04/2013','P25','OC0002')
INSERT INTO Prestamo values ('PR10083','27/04/2012',8000.00,'27/04/2013','P25','OC0010')
INSERT INTO Prestamo values ('PR10084','06/12/2012',2000.00,'06/12/2013','P26','OC0010')
INSERT INTO Prestamo values ('PR10085','17/08/2010',1000.00,'17/08/2011','P27','OC0010')
INSERT INTO Prestamo values ('PR10086','02/07/2008',2500.00,'02/10/2008','P28','OC0011')
INSERT INTO Prestamo values ('PR10087','10/05/2008',3500.00,'10/11/2008','P28','OC0011')
INSERT INTO Prestamo values ('PR10088','24/04/2008',5000.00,'11/12/2008','P28','OC0011')
INSERT INTO Prestamo values ('PR10089','23/06/2008',4000.00,'15/02/2009','P29','OC0011')
INSERT INTO Prestamo values ('PR10090','02/06/2008',3500.00,'02/10/2008','P29','OC0011')
INSERT INTO Prestamo values ('PR10091','10/07/2008',6500.00,'10/12/2008','P29','OC0011')
INSERT INTO Prestamo values ('PR10092','10/08/2008',6500.00,'10/01/2009','P30','OC0011')
INSERT INTO Prestamo values ('PR10093','24/07/2008',5000.00,'11/02/2009','P30','OC0011')
INSERT INTO Prestamo values ('PR10094','23/10/2008',7000.00,'15/10/2009','P30','OC0011')
INSERT INTO Prestamo values ('PR10095','23/03/2008',8000.00,'15/03/2009','P29','OC0011')
INSERT INTO Prestamo values ('PR10096','24/11/2005',2000.00,'24/05/2006','P31','OC0012')
INSERT INTO Prestamo values ('PR10097','15/12/2005',1000.00,'20/08/2006','P32','OC0012')
INSERT INTO Prestamo values ('PR10098','15/01/2006',5000.00,'05/12/2006','P33','OC0012')
INSERT INTO Prestamo values ('PR10099','20/02/2006',4500.00,'19/02/2007','P31','OC0012')
INSERT INTO Prestamo values ('PR10100','25/08/2006',3000.00,'24/08/2007','P33','OC0012')
INSERT INTO Prestamo values ('PR10101','30/11/2006',9000.00,'25/10/2007','P32','OC0012')
INSERT INTO Prestamo values ('PR10102','24/02/2007',1500.00,'20/06/2007','P31','OC0012')
INSERT INTO Prestamo values ('PR10103','15/05/2007',8000.00,'14/05/2008','P33','OC0012')
INSERT INTO Prestamo values ('PR10104','20/10/2007',3000.00,'19/10/2008','P32','OC0012')
INSERT INTO Prestamo values ('PR10105','15/10/2012',12000.00,'24/05/2013','P31','OC0012')
INSERT INTO Prestamo values ('PR10106','02/01/2005',1800.00,'02/05/2006','P34','OC0013')
INSERT INTO Prestamo values ('PR10107','02/05/2007',2500.00,'09/04/2012','P35','OC0013')
INSERT INTO Prestamo values ('PR10108','12/01/2005',5000.00,'10/10/2013','P34','OC0013')
INSERT INTO Prestamo values ('PR10109','16/08/2006',6000.00,'14/05/2013','P36','OC0013')
INSERT INTO Prestamo values ('PR10110','02/03/2005',8000.00,'11/03/2009','P35','OC0013')
INSERT INTO Prestamo values ('PR10111','06/07/2005',9000.00,'17/07/2012','P34','OC0013')
INSERT INTO Prestamo values ('PR10112','08/06/2009',4000.00,'15/11/2013','P36','OC0013')
INSERT INTO Prestamo values ('PR10113','07/10/2009',5000.00,'04/12/2012','P35','OC0013')
INSERT INTO Prestamo values ('PR10114','12/09/2010',2000.00,'02/05/2011','P34','OC0013')
INSERT INTO Prestamo values ('PR10115','15/08/2006',1000.00,'18/08/2007','P36','OC0013')
INSERT INTO Prestamo values ('PR10116','23/03/2005',5000.00,'15/10/2008','P01','OC0002')
INSERT INTO Prestamo values ('PR10117','23/01/2008',3000.00,'11/11/2012','P03','OC0001')
INSERT INTO Prestamo values ('PR10118','20/02/2010',2000.00,'12/12/2013','P02','OC0002')
INSERT INTO Prestamo values ('PR10119','12/05/2011',4000.00,'20/05/2013','P038','OC0014')
INSERT INTO Prestamo values ('PR10120','10/11/2011',6000.00,'25/08/2013','P039','OC0014')
INSERT INTO Prestamo values ('PR10121','15/02/2010',8000.00,'26/07/2012','P038','OC0002')
INSERT INTO Prestamo values ('PR10122','28/08/2007',3000.00,'28/05/2010','P01','OC0001')
INSERT INTO Prestamo values ('PR10123','14/09/2006',2000.00,'05/06/2009','P02','OC0014')
INSERT INTO Prestamo values ('PR10124','10/10/2010',1000.00,'03/11/2012','P039','OC0002')
INSERT INTO Prestamo values ('PR10125','05/09/2011',3000.00,'06/10/2013','P037','OC0002')
INSERT INTO Prestamo values ('PR10126','04/04/2008',10000.00,'01/12/2009','P42','OC0015')
INSERT INTO Prestamo values ('PR10127','05/03/2005',11000.00,'01/05/2006','P43','OC0015')
INSERT INTO Prestamo values ('PR10128','09/08/2006',12000.00,'01/12/2007','P41','OC0015')
INSERT INTO Prestamo values ('PR10129','08/02/2007',18000.00,'02/05/2010','P40','OC0015')
INSERT INTO Prestamo values ('PR10130','02/09/2006',15000.00,'01/12/2007','P41','OC0015')
INSERT INTO Prestamo values ('PR10131','03/07/2010',45000.00,'31/12/2011','P42','OC0015')
INSERT INTO Prestamo values ('PR10132','08/03/2011',6600.00,'01/01/2012','P40','OC0015')
INSERT INTO Prestamo values ('PR10133','06/03/2012',3600.00,'01/08/2013','P40','OC0015')
INSERT INTO Prestamo values ('PR10134','03/01/2009',18000.00,'01/05/2010','P43','OC0015')
INSERT INTO Prestamo values ('PR10135','03/01/2013',19000.00,'31/12/2013','P43','OC0015')

go
--------------------- Tabla : Amortizacion ----------------------------------
INSERT INTO Amortizacion values ('C10000','03/03/2004',500.00,'PR10001')
INSERT INTO Amortizacion values ('C10001','04/05/2004',600.00,'PR10001')
INSERT INTO Amortizacion values ('C10002','10/03/2004',1000.00,'PR10002')
INSERT INTO Amortizacion values ('C10003','02/04/2004',1500.00,'PR10004')
INSERT INTO Amortizacion values ('C10004','08/07/2005',5200.00,'PR10002')
INSERT INTO Amortizacion values ('C10006','06/04/2006',1000.00,'PR10005')
INSERT INTO Amortizacion values ('C10007','11/08/2013',1220.00,'PR10004')
INSERT INTO Amortizacion values ('C10008','12/08/2012',1500.00,'PR10004')
INSERT INTO Amortizacion values ('C10009','11/08/2013',800.00,'PR10004')
INSERT INTO Amortizacion values ('C10010','05/08/2014',2000.00,'PR10004')
INSERT INTO Amortizacion values ('C10011','11/08/2013',1000.00,'PR10004')
INSERT INTO Amortizacion values ('C10012','02/08/2015',2300.00,'PR10004')
INSERT INTO Amortizacion values ('C10013','11/08/2013',1700.00,'PR10004')
INSERT INTO Amortizacion values ('C10014','01/08/2009',800.00,'PR10004')
INSERT INTO Amortizacion values ('C10015','05/08/2010',200.00,'PR10004')
INSERT INTO Amortizacion values ('C10016','03/08/2013',500.00,'PR10004')
INSERT INTO Amortizacion values ('C10017','08/08/2011',1200.00,'PR10004')
INSERT INTO Amortizacion values ('C10018','09/08/2013',1000.00,'PR10004')
INSERT INTO Amortizacion values ('C10019','11/08/2013',1200.00,'PR10004')
INSERT INTO Amortizacion values ('C10020','11/08/2013',1300.00,'PR10004')
INSERT INTO Amortizacion values ('C10021','11/08/2013',1400.00,'PR10004')
INSERT INTO Amortizacion values ('C10022','28/02/2005',3000.00,'PR10016')
INSERT INTO Amortizacion values ('C10023','16/04/2006',4000.00,'PR10017')
INSERT INTO Amortizacion values ('C10024','02/05/2007',2000.00,'PR10018')
INSERT INTO Amortizacion values ('C10025','02/05/2007',500.00,'PR10018')
INSERT INTO Amortizacion values ('C10026','18/06/2008',3000.00,'PR10019')
INSERT INTO Amortizacion values ('C10027','18/06/2008',3000.00,'PR10019')
INSERT INTO Amortizacion values ('C10028','20/08/2008',1000.00,'PR10020')
INSERT INTO Amortizacion values ('C10029','20/08/2008',1000.00,'PR10020')
INSERT INTO Amortizacion values ('C10030','20/08/2008',500.00,'PR10020')
INSERT INTO Amortizacion values ('C10031','15/06/2009',800.00,'PR10021')
INSERT INTO Amortizacion values ('C10032','15/06/2009',2000.00,'PR10021')
INSERT INTO Amortizacion values ('C10033','15/06/2009',1000.00,'PR10021')
INSERT INTO Amortizacion values ('C10034','08/03/2010',2000.00,'PR10022')
INSERT INTO Amortizacion values ('C10035','08/03/2010',1500.00,'PR10022')
INSERT INTO Amortizacion values ('C10036','24/08/2011',1300.00,'PR10023')
INSERT INTO Amortizacion values ('C10037','24/08/2011',1000.00,'PR10023')
INSERT INTO Amortizacion values ('C10038','26/01/2012',2000.00,'PR10024')
INSERT INTO Amortizacion values ('C10040','20/10/2006',3000.00,'PR10026')
INSERT INTO Amortizacion values ('C10041','21/01/2007',2000.00,'PR10027')
INSERT INTO Amortizacion values ('C10042','14/09/2008',500.00,'PR10028')
INSERT INTO Amortizacion values ('C10043','07/09/2009',500.00,'PR10028')
INSERT INTO Amortizacion values ('C10044','15/05/2010',2000.00,'PR10029')
INSERT INTO Amortizacion values ('C10045','19/12/2010',2000.00,'PR10029')
INSERT INTO Amortizacion values ('C10046','15/12/2008',2000.00,'PR10030')
INSERT INTO Amortizacion values ('C10047','27/12/2009',2000.00,'PR10030')
INSERT INTO Amortizacion values ('C10048','15/07/2010',2000.00,'PR10030')
INSERT INTO Amortizacion values ('C10049','02/05/2012',1300.33,'PR10031')
INSERT INTO Amortizacion values ('C10050','02/03/2013',1300.33,'PR10031')
INSERT INTO Amortizacion values ('C10051','02/10/2013',1300.33,'PR10031')
INSERT INTO Amortizacion values ('C10052','29/08/2012',2000.00,'PR10032')
INSERT INTO Amortizacion values ('C10053','29/04/2013',2000.00,'PR10032')
INSERT INTO Amortizacion values ('C10054','27/04/2013',5000.00,'PR10033')
INSERT INTO Amortizacion values ('C10055','02/04/2013',1500.00,'PR10034')
INSERT INTO Amortizacion values ('C10056','17/08/2011',7500.00,'PR10035')

INSERT INTO Amortizacion values ('A10076','02/06/2006',1800.00,'PR10046')
INSERT INTO Amortizacion values ('A10077','10/08/2008',2000.00,'PR10047')
INSERT INTO Amortizacion values ('A10078','11/11/2009',3000.00,'PR10048')
INSERT INTO Amortizacion values ('A10079','11/12/2009',3000.00,'PR10048')
INSERT INTO Amortizacion values ('A10080','15/06/2010',2500.00,'PR10049')
INSERT INTO Amortizacion values ('A10081','15/07/2010',2500.00,'PR10049')
INSERT INTO Amortizacion values ('A10082','02/06/2011',5000.00,'PR10050')
INSERT INTO Amortizacion values ('A10083','02/07/2011',5000.00,'PR10050')
INSERT INTO Amortizacion values ('A10084','02/08/2011',5000.00,'PR10050')
INSERT INTO Amortizacion values ('A10085','10/06/2012',1000.00,'PR10051')
INSERT INTO Amortizacion values ('A10086','10/07/2012',2000.00,'PR10051')
INSERT INTO Amortizacion values ('A10087','10/08/2012',1000.00,'PR10051')
INSERT INTO Amortizacion values ('A10088','23/01/2013',5000.00,'PR10052')
INSERT INTO Amortizacion values ('A10089','23/02/2013',4000.00,'PR10052')
INSERT INTO Amortizacion values ('A10090','11/01/2013',2000.00,'PR10053')
INSERT INTO Amortizacion values ('A10091','11/02/2013',3000.00,'PR10053')
INSERT INTO Amortizacion values ('A10092','15/02/2013',2000.00,'PR10054')
INSERT INTO Amortizacion values ('C10094','02/01/2007',1600.00,'PR10056')
INSERT INTO Amortizacion values ('C10095','02/01/2008',4700.00,'PR10057')
INSERT INTO Amortizacion values ('C10096','02/01/2009',3000.00,'PR10058')
INSERT INTO Amortizacion values ('C10097','01/01/2010',800.00,'PR10058')
INSERT INTO Amortizacion values ('C10098','02/01/2010',5000.00,'PR10059')
INSERT INTO Amortizacion values ('C10099','01/01/2011',800.00,'PR10059')
INSERT INTO Amortizacion values ('C10100','02/03/2010',1000.00,'PR10060')
INSERT INTO Amortizacion values ('C10101','01/04/2010',500.00,'PR10060')
INSERT INTO Amortizacion values ('C10102','01/05/2010',400.00,'PR10060')
INSERT INTO Amortizacion values ('C10103','10/02/2011',4000.00,'PR10061')
INSERT INTO Amortizacion values ('C10104','01/03/2011',500.00,'PR10061')
INSERT INTO Amortizacion values ('C10105','01/04/2011',50.00,'PR10061')
INSERT INTO Amortizacion values ('C10106','24/02/2012',3000.00,'PR10062')
INSERT INTO Amortizacion values ('C10107','01/03/2012',500.00,'PR10062')
INSERT INTO Amortizacion values ('C10108','23/04/2006',5000.00,'PR10063')
INSERT INTO Amortizacion values ('C10109','01/05/2011',200.00,'PR10063')
INSERT INTO Amortizacion values ('C10110','23/05/2008',200.00,'PR10064')
INSERT INTO Amortizacion values ('C10112','02/04/2004',1500.00,'PR10066')
INSERT INTO Amortizacion values ('C10113','10/06/2004',3000.00,'PR10067')
INSERT INTO Amortizacion values ('C10114','14/12/2005',2500.00,'PR10068')
INSERT INTO Amortizacion values ('C10115','10/06/2006',2500.00,'PR10068')
INSERT INTO Amortizacion values ('C10116','20/03/2007',1500.00,'PR10069')
INSERT INTO Amortizacion values ('C10117','20/10/2007',1500.00,'PR10069')
INSERT INTO Amortizacion values ('C10118','06/10/2008',2000.00,'PR10069')
INSERT INTO Amortizacion values ('C10119','03/12/2008',2000.00,'PR10069')
INSERT INTO Amortizacion values ('C10120','10/02/2009',2000.00,'PR10069')
INSERT INTO Amortizacion values ('C10121','03/05/2009',1000.00,'PR10071')
INSERT INTO Amortizacion values ('C10122','07/07/2009',1000.00,'PR10071')
INSERT INTO Amortizacion values ('C10123','07/10/2009',1000.00,'PR10071')
INSERT INTO Amortizacion values ('C10124','05/11/2009',1500.00,'PR10072')
INSERT INTO Amortizacion values ('C10125','07/01/2010',500.00,'PR10072')
INSERT INTO Amortizacion values ('C10126','03/06/2010',500.00,'PR10073')
INSERT INTO Amortizacion values ('C10127','05/09/2010',1000.00,'PR10073')
INSERT INTO Amortizacion values ('C10128','15/03/2011',3000.00,'PR10074')
INSERT INTO Amortizacion values ('C10129','10/06/2012',1800.00,'PR10075')
INSERT INTO Amortizacion values ('C10130','20/10/2006',3000.00,'PR10076')
INSERT INTO Amortizacion values ('C10131','21/01/2007',2000.00,'PR10077')
INSERT INTO Amortizacion values ('C10132','14/09/2008',500.00,'PR10078')
INSERT INTO Amortizacion values ('C10133','07/09/2009',500.00,'PR10078')
INSERT INTO Amortizacion values ('C10134','15/05/2010',2000.00,'PR10079')
INSERT INTO Amortizacion values ('C10135','19/12/2010',2000.00,'PR10079')
INSERT INTO Amortizacion values ('C10136','15/12/2008',2000.00,'PR10080')
INSERT INTO Amortizacion values ('C10137','27/12/2009',2000.00,'PR10080')
INSERT INTO Amortizacion values ('C10138','15/07/2010',2000.00,'PR10080')
INSERT INTO Amortizacion values ('C10139','02/05/2012',1333.33,'PR10081')
INSERT INTO Amortizacion values ('C10140','02/03/2013',1333.33,'PR10081')
INSERT INTO Amortizacion values ('C10141','02/10/2013',1333.33,'PR10081')
INSERT INTO Amortizacion values ('C10142','29/08/2012',2000.00,'PR10082')
INSERT INTO Amortizacion values ('C10143','29/04/2013',2000.00,'PR10082')
INSERT INTO Amortizacion values ('C10144','27/04/2013',5000.00,'PR10083')
INSERT INTO Amortizacion values ('C10145','02/04/2013',1500.00,'PR10084')
INSERT INTO Amortizacion values ('C10148','02/10/2008',2500.00,'PR10086')
INSERT INTO Amortizacion values ('C10149','10/11/2008',3500.00,'PR10087')
INSERT INTO Amortizacion values ('C10150','11/11/2008',2000.00,'PR10088')
INSERT INTO Amortizacion values ('C10151','11/12/2008',3000.00,'PR10088')
INSERT INTO Amortizacion values ('C10152','15/01/2009',2000.00,'PR10089')
INSERT INTO Amortizacion values ('C10153','15/02/2009',2000.00,'PR10089')
INSERT INTO Amortizacion values ('C10154','03/09/2008',1000.00,'PR10090')
INSERT INTO Amortizacion values ('C10155','20/09/2008',1000.00,'PR10090')
INSERT INTO Amortizacion values ('C10156','10/10/2008',1500.00,'PR10090')
INSERT INTO Amortizacion values ('C10157','02/11/2008',2000.00,'PR10091')
INSERT INTO Amortizacion values ('C10158','18/11/2008',2000.00,'PR10091')
INSERT INTO Amortizacion values ('C10159','04/12/2008',2500.00,'PR10091')
INSERT INTO Amortizacion values ('C10160','02/12/2008',2500.00,'PR10092')
INSERT INTO Amortizacion values ('C10161','10/01/2009',2500.00,'PR10092')
INSERT INTO Amortizacion values ('C10162','11/01/2009',2000.00,'PR10093')
INSERT INTO Amortizacion values ('C10163','11/02/2009',2000.00,'PR10093')
INSERT INTO Amortizacion values ('C10164','15/10/2009',5000.00,'PR10094')
INSERT INTO Amortizacion values ('C10166','24/05/2006',2000.00,'PR10096')
INSERT INTO Amortizacion values ('C10167','20/08/2006',1000.00,'PR10097')
INSERT INTO Amortizacion values ('C10168','05/06/2006',2500.00,'PR10098')
INSERT INTO Amortizacion values ('C10169','05/12/2006',2500.00,'PR10098')
INSERT INTO Amortizacion values ('C10170','20/10/2006',2250.00,'PR10099')
INSERT INTO Amortizacion values ('C10171','19/02/2007',2250.00,'PR10099')
INSERT INTO Amortizacion values ('C10172','25/02/2007',1000.00,'PR10100')
INSERT INTO Amortizacion values ('C10173','25/06/2007',1000.00,'PR10100')
INSERT INTO Amortizacion values ('C10174','24/08/2007',1000.00,'PR10100')
INSERT INTO Amortizacion values ('C10175','24/02/2007',3000.00,'PR10101')
INSERT INTO Amortizacion values ('C10176','24/07/2007',3000.00,'PR10101')
INSERT INTO Amortizacion values ('C10177','25/10/2007',3000.00,'PR10101')
INSERT INTO Amortizacion values ('C10178','20/03/2007',500.00,'PR10102')
INSERT INTO Amortizacion values ('C10179','20/04/2007',500.00,'PR10102')
INSERT INTO Amortizacion values ('C10180','10/12/2007',3000.00,'PR10103')
INSERT INTO Amortizacion values ('C10181','10/02/2008',3000.00,'PR10103')
INSERT INTO Amortizacion values ('C10182','20/03/2008',2000.00,'PR10104')
INSERT INTO Amortizacion values ('C10184','02/05/2006',1800.00,'PR10106')
INSERT INTO Amortizacion values ('C10185','18/08/2007',2500.00,'PR10107')
INSERT INTO Amortizacion values ('C10186','02/09/2006',2500.00,'PR10108')
INSERT INTO Amortizacion values ('C10187','10/10/2006',2500.00,'PR10108')
INSERT INTO Amortizacion values ('C10188','01/02/2012',3000.00,'PR10109')
INSERT INTO Amortizacion values ('C10189','14/05/2013',3000.00,'PR10109')
INSERT INTO Amortizacion values ('C10190','10/10/2008',2000.00,'PR10110')
INSERT INTO Amortizacion values ('C10191','10/10/2009',2000.00,'PR10110')
INSERT INTO Amortizacion values ('C10192','11/03/2009',2000.00,'PR10110')
INSERT INTO Amortizacion values ('C10193','10/10/2011',3000.00,'PR10111')
INSERT INTO Amortizacion values ('C10194','10/01/2012',3000.00,'PR10111')
INSERT INTO Amortizacion values ('C10195','17/07/2012',3000.00,'PR10111')
INSERT INTO Amortizacion values ('C10196','01/01/2013',1000.00,'PR10112')
INSERT INTO Amortizacion values ('C10197','15/11/2013',2000.00,'PR10112')
INSERT INTO Amortizacion values ('C10198','05/11/2012',2000.00,'PR10113')
INSERT INTO Amortizacion values ('C10199','04/12/2012',2500.00,'PR10113')
INSERT INTO Amortizacion values ('C10200','04/12/2010',1500.00,'PR10114')
INSERT INTO Amortizacion values ('C10202','20/04/2005',5000.00,'PR10116')
INSERT INTO Amortizacion values ('C10203','23/05/2008',3000.00,'PR10117')
INSERT INTO Amortizacion values ('C10204','20/05/2010',1000.00,'PR10118')
INSERT INTO Amortizacion values ('C10205','20/02/2011',1000.00,'PR10118')
INSERT INTO Amortizacion values ('C10206','02/04/2012',2000.00,'PR10119')
INSERT INTO Amortizacion values ('C10207','02/05/2012',2000.00,'PR10119')
INSERT INTO Amortizacion values ('C10208','10/12/2011',2000.00,'PR10120')
INSERT INTO Amortizacion values ('C10209','10/12/2012',2000.00,'PR10120')
INSERT INTO Amortizacion values ('C10210','10/07/2013',2000.00,'PR10120')
INSERT INTO Amortizacion values ('C10211','10/12/2011',3000.00,'PR10121')
INSERT INTO Amortizacion values ('C10212','10/12/2011',3000.00,'PR10121')
INSERT INTO Amortizacion values ('C10213','10/06/2012',2000.00,'PR10121')
INSERT INTO Amortizacion values ('C10214','02/04/2008',1000.00,'PR10122')
INSERT INTO Amortizacion values ('C10215','02/04/2009',1000.00,'PR10122')
INSERT INTO Amortizacion values ('C10216','02/04/2007',1000.00,'PR10123')
INSERT INTO Amortizacion values ('C10217','02/04/2008',500.00,'PR10123')
INSERT INTO Amortizacion values ('C10218','02/04/2011',800.00,'PR10124')
INSERT INTO Amortizacion values ('C10220','01/10/2009',10000.00,'PR10126')
INSERT INTO Amortizacion values ('C10221','01/01/2006',11000.00,'PR10127')
INSERT INTO Amortizacion values ('C10222','01/09/2007',6000.00,'PR10128')
INSERT INTO Amortizacion values ('C10223','01/02/2007',6000.00,'PR10128')
INSERT INTO Amortizacion values ('C10224','01/11/2007',7500,'PR10129')
INSERT INTO Amortizacion values ('C10225','01/03/2008',7500,'PR10129')
INSERT INTO Amortizacion values ('C10226','01/01/2007',5000.00,'PR10130')
INSERT INTO Amortizacion values ('C10227','01/06/2007',5000.00,'PR10130')
INSERT INTO Amortizacion values ('C10228','01/09/2007',5000.00,'PR10130')
INSERT INTO Amortizacion values ('C10229','01/02/2011',15000,'PR10131')
INSERT INTO Amortizacion values ('C10230','01/05/2011',15000,'PR10131')
iNSERT INTO Amortizacion values ('C10231','01/11/2011',15000,'PR10131')
INSERT INTO Amortizacion values ('C10232','01/07/2011',4000.00,'PR10132')
INSERT INTO Amortizacion values ('C10233','01/11/2011',1000.00,'PR10132')
INSERT INTO Amortizacion values ('C10234','01/11/2012',1500.00,'PR10133')
INSERT INTO Amortizacion values ('C10235','01/05/2013',2000.00,'PR10133')
INSERT INTO Amortizacion values ('C10236','01/07/2009',3900.00,'PR10134')
INSERT INTO Amortizacion values ('C10237','01/11/2013',8000.00,'PR10135')

go
