CREATE DATABASE TallerVistas;
USE TallerVistas;


CREATE TABLE Proveedores (
    V_id VARCHAR(10) PRIMARY KEY,
    Proveedor VARCHAR(50),
    Status INT,
    Ciudad VARCHAR(50)
);


CREATE TABLE Partes (
    P_id VARCHAR(10) PRIMARY KEY,
    Parte VARCHAR(50),
    Color VARCHAR(20),
    Peso DECIMAL(5,2),
    Ciudad VARCHAR(50)
);


CREATE TABLE Proyectos (
    Y_id VARCHAR(10) PRIMARY KEY,
    Proyecto VARCHAR(50),
    Ciudad VARCHAR(50)
);


CREATE TABLE VPY (
    V_id VARCHAR(10),
    P_id VARCHAR(10),
    Y_id VARCHAR(10),
    Cantidad INT,
    FOREIGN KEY (V_id) REFERENCES Proveedores(V_id),
    FOREIGN KEY (P_id) REFERENCES Partes(P_id),
    FOREIGN KEY (Y_id) REFERENCES Proyectos(Y_id)
);


INSERT INTO Proveedores (V_id, Proveedor, Status, Ciudad) VALUES 
('V1', 'Smith', 20, 'Londres'),
('V2', 'Jones', 10, 'París'),
('V3', 'Blake', 30, 'París'),
('V4', 'Clark', 20, 'Londres'),
('V5', 'Adams', 30, 'Atenas');


INSERT INTO Partes (P_id, Parte, Color, Peso, Ciudad) VALUES 
('P1', 'Tuerca', 'Rojo', 12.0, 'Londres'),
('P2', 'Perno', 'Verde', 17.0, 'París'),
('P3', 'Tornillo', 'Azul', 17.0, 'Roma'),
('P4', 'Tornillo', 'Rojo', 14.0, 'Londres'),
('P5', 'Leva', 'Azul', 12.0, 'París'),
('P6', 'Engrane', 'Rojo', 19.0, 'Londres');


INSERT INTO Proyectos (Y_id, Proyecto, Ciudad) VALUES 
('Y1', 'Clasificador', 'París'),
('Y2', 'Monitor', 'Roma'),
('Y3', 'OCR', 'Atenas'),
('Y4', 'Consola', 'Atenas'),
('Y5', 'RAID', 'Londres'),
('Y6', 'EDS', 'Oslo'),
('Y7', 'Cinta', 'Londres');


INSERT INTO VPY (V_id, P_id, Y_id, Cantidad) VALUES 
('V1', 'P1', 'Y1', 200),
('V1', 'P1', 'Y4', 700),
('V2', 'P3', 'Y2', 400),
('V2', 'P3', 'Y3', 200),
('V2', 'P3', 'Y5', 200),
('V2', 'P3', 'Y6', 500),
('V2', 'P5', 'Y2', 100),
('V2', 'P5', 'Y7', 400),
('V3', 'P4', 'Y2', 500),
('V3', 'P4', 'Y7', 300),
('V4', 'P6', 'Y3', 200),
('V4', 'P6', 'Y7', 800),
('V5', 'P2', 'Y2', 200),
('V5', 'P5', 'Y5', 500),
('V5', 'P6', 'Y7', 100),
('V5', 'P1', 'Y4', 100),
('V5', 'P4', 'Y4', 200),
('V5', 'P4', 'Y5', 800),
('V5', 'P5', 'Y4', 400);


DELIMITER //


CREATE PROCEDURE ObtenerPartesPorCiudad (IN ciudad_param VARCHAR(100))
BEGIN
    SELECT P_id, Parte, Color, Peso, Ciudad
    FROM Partes
    WHERE Ciudad = ciudad_param;
END //


CREATE PROCEDURE ObtenerProveedoresActivos ()
BEGIN
    SELECT V_id, Proveedor, Ciudad
    FROM Proveedores
    WHERE Status >= 20;
END //


DELIMITER ;


CREATE VIEW PartesPorProveedor AS
SELECT V.V_id, V.Proveedor, P.P_id, P.Parte, P.Color, P.Peso, P.Ciudad
FROM Proveedores V
JOIN Partes P ON V.Ciudad = P.Ciudad;


CREATE VIEW ProveedoresPorCiudad AS
SELECT V_id, Proveedor, Ciudad
FROM Proveedores;


CREATE VIEW ProyectosPorParte AS
SELECT P.P_id, P.Parte, Y.Y_id, Y.Proyecto, Y.Ciudad
FROM Partes P
JOIN VPY VP ON P.P_id = VP.P_id
JOIN Proyectos Y ON VP.Y_id = Y.Y_id;


CREATE VIEW CantidadPartesPorProveedorYProyecto AS
SELECT V.V_id, V.Proveedor, P.P_id, P.Parte, Y.Y_id, Y.Proyecto, VP.Cantidad
FROM VPY VP
JOIN Proveedores V ON VP.V_id = V.V_id
JOIN Partes P ON VP.P_id = P.P_id
JOIN Proyectos Y ON VP.Y_id = Y.Y_id;


CREATE VIEW PartesYProveedoresPorCiudad AS
SELECT P.P_id, P.Parte, P.Ciudad, V.Proveedor
FROM Partes P
JOIN Proveedores V ON P.Ciudad = V.Ciudad;
