USE tareas;

CREATE TABLE Base (
    id_plataforma INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Desarrolladores (
    id_desarrollador INT PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE Videojuegos (
    id_videojuego INT PRIMARY KEY,
    nombre VARCHAR(255),
    genero VARCHAR(100),
    fecha_lanzamiento DATE,
    id_plataforma INT,
    id_desarrollador INT,
    FOREIGN KEY (id_plataforma) REFERENCES Base(id_plataforma),
    FOREIGN KEY (id_desarrollador) REFERENCES Desarrolladores(id_desarrollador)
);

INSERT INTO Base (id_plataforma, nombre) VALUES
(1, 'PlayStation'),
(2, 'Xbox'),
(3, 'Nintendo Switch');

INSERT INTO Desarrolladores (id_desarrollador, nombre) VALUES
(1, 'Naughty Dog'),
(2, 'Rockstar Games'),
(3, 'Nintendo'),
(4, 'Ubisoft');

INSERT INTO Videojuegos (id_videojuego, nombre, genero, fecha_lanzamiento, id_plataforma, id_desarrollador) VALUES
(1, 'The Last of Us Part II', 'Acción y Aventura', '2020-06-19', 1, 1),
(2, 'Red Dead Redemption 2', 'Acción y Aventura', '2018-10-26', 2, 2),
(3, 'The Legend of Zelda: Breath of the Wild', 'Acción-Aventura', '2017-03-03', 3, 3);