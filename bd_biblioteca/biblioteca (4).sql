-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-12-2024 a las 17:08:03
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `biblioteca`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `eliminar_libro` (IN `id` INT(3))   begin
	Delete from libro where id_libro = id ;
	select l.id_libro, l.nombre_libro, l.edicion, l.num_ejemplares, l.autor, e.nombre_editorial from libro l 
	left join editorial e on l.id_editorial = e.id_editorial ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_libro` (IN `id` INT(3), IN `nombre_l` VARCHAR(100), IN `numero` INT(3), IN `edi` INT(2), IN `auto` VARCHAR(100))   begin
	insert into libro (id_editorial,nombre_libro,num_ejemplares,edicion,autor) values (id,nombre_l,numero,edi,auto);
	select l.id_libro, l.nombre_libro, l.edicion, l.num_ejemplares, l.autor, e.nombre_editorial from libro l 
	left join editorial e on l.id_editorial = e.id_editorial ;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar_prestamo` (IN `fecha` DATE, IN `fechad` DATE, IN `hora` TIME, IN `libro` INT(3), IN `admin` INT(3), IN `cod` VARCHAR(10), IN `lugar` VARCHAR(50))   begin
	insert into prestamo (fecha_prestamo,fecha_devolucion,hora_prestamo,id_libro,id_admin,codigo,lugar_p) values (fecha,fechad,hora,libro,admin,cod,lugar);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `modificar_libro` (IN `titulo` VARCHAR(100), IN `ejemplar` INT(3), IN `edicion` INT(2), IN `autor` VARCHAR(100), IN `editorial` INT(3), IN `id` INT(3))   begin
	update libro set nombre_libro = titulo ,num_ejemplares= ejemplar,edicion= edicion,autor= autor,id_editorial = editorial where id_libro = id;
	select l.id_libro, l.nombre_libro, l.edicion, l.num_ejemplares, l.autor, e.nombre_editorial from libro l 
	left join editorial e on l.id_editorial = e.id_editorial ;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `id_admin` int(3) NOT NULL,
  `nombre_ad` varchar(50) NOT NULL,
  `apellido_ad` varchar(50) NOT NULL,
  `celular_ad` varchar(9) DEFAULT NULL,
  `correo_ad` varchar(50) DEFAULT NULL,
  `dni_ad` varchar(8) NOT NULL,
  `clave` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`id_admin`, `nombre_ad`, `apellido_ad`, `celular_ad`, `correo_ad`, `dni_ad`, `clave`) VALUES
(1, 'Alvaro ', 'Garcia Marquez', '773498451', 'garcialvaro@gmail.com', '88903312', '123456789'),
(2, 'Humberto', 'Anco Lopez', '989895105', 'biblioteca@gmail.com', '73841065', '987654321');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

CREATE TABLE `cliente` (
  `codigo` varchar(10) NOT NULL,
  `dni_cliente` varchar(8) NOT NULL,
  `nombre_cliente` varchar(50) NOT NULL,
  `apellido_cliente` varchar(50) NOT NULL,
  `celular_cliente` varchar(9) DEFAULT NULL,
  `tipo` varchar(50) NOT NULL,
  `escuela_p` varchar(50) NOT NULL,
  `ciclo` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`codigo`, `dni_cliente`, `nombre_cliente`, `apellido_cliente`, `celular_cliente`, `tipo`, `escuela_p`, `ciclo`) VALUES
('123456789', '72888119', 'rafael', 'viza', '944038119', 'alumno', 'EPISI', '4'),
('2018204051', '74333119', 'Luciana', 'Marquez', '888333222', 'docente', 'Derecho', ''),
('2019305521', '71888310', 'Eliana', 'Ruiz', '777668222', 'docente', 'EPISI', ''),
('2020203050', '72000510', 'Gerardo', 'Surco', '555000222', 'docente', 'Administracion', '5'),
('2021204048', '74678657', 'Joseph Antonio', 'Huaman Quina', '96646019', 'alumno', 'EPISI', '7'),
('2023204007', '75434505', 'bricel', 'salas', '111222333', 'alumno', 'EPISI', '4'),
('2023204017', '72888411', 'raul', 'fernandes', '944038117', 'docente', 'EPISI', ''),
('2023204021', '72111410', 'Adriana', 'Lopez', '998877116', 'alumno', 'Derecho', '5'),
('2023204025', '72888411', 'ramiro', 'vizcarra', '944038118', 'alumno', 'EPISI', '4'),
('2023204026', '72888410', 'rafael', 'viza escobar', '944038119', 'alumno', 'EPISI', '4'),
('2024204001', '36789465', 'Pedro', 'Castillo Sanchez', '986545876', 'docente', 'EPISI', ''),
('2024204090', '73777820', 'Luis', 'Flores ', '097564332', 'alumno', 'Ambiental', '3'),
('2233445511', '75955408', 'Victor', 'Baluarte', '778800099', 'docente', 'Ambiental', ''),
('3334455512', '72888310', 'federico', 'cruz', '993344123', 'docente', 'Ambiental', ''),
('9876543210', '7644421', 'jaime', 'urtado', '333444555', 'alumno', 'EPISI', '3');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `devolucion`
--

CREATE TABLE `devolucion` (
  `id_devolucion` int(3) NOT NULL,
  `fecha_d` date NOT NULL,
  `hora_d` time DEFAULT NULL,
  `id_prestamo` int(3) NOT NULL,
  `estado` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `devolucion`
--

INSERT INTO `devolucion` (`id_devolucion`, `fecha_d`, `hora_d`, `id_prestamo`, `estado`) VALUES
(2, '2024-12-10', '17:00:00', 50, 'atrasado'),
(3, '2024-12-06', '12:30:00', 51, 'atrasado'),
(4, '2024-12-29', '13:30:00', 52, 'pendiente'),
(5, '2024-12-25', '14:45:00', 53, 'pendiente'),
(6, '2024-12-31', '16:50:00', 54, 'pendiente'),
(7, '2024-11-28', '10:30:00', 55, 'atrasado'),
(8, '2024-11-30', '10:40:00', 56, 'atrasado'),
(9, '2024-12-26', '15:45:00', 57, 'pendiente'),
(10, '2024-10-24', NULL, 59, 'atrasado'),
(11, '2024-12-19', NULL, 60, 'pendiente'),
(14, '2024-12-28', NULL, 63, 'pendiente'),
(15, '2024-12-30', NULL, 64, 'pendiente');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `editorial`
--

CREATE TABLE `editorial` (
  `id_editorial` int(3) NOT NULL,
  `nombre_editorial` varchar(100) NOT NULL,
  `ruc` varchar(100) NOT NULL,
  `telefono` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `editorial`
--

INSERT INTO `editorial` (`id_editorial`, `nombre_editorial`, `ruc`, `telefono`) VALUES
(1, 'Editorial Alfa', '12345678901', '987654321'),
(2, 'Editorial Beta', '10987654321', '123456789'),
(3, 'Editorial Gamma', '11223344556', '987123456'),
(4, 'Editorial Buenavista', '203041139', '988119400'),
(5, 'Editorial', '332024487', '123456777');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `libro`
--

CREATE TABLE `libro` (
  `id_libro` int(3) NOT NULL,
  `id_editorial` int(3) NOT NULL,
  `nombre_libro` varchar(100) NOT NULL,
  `num_ejemplares` int(3) NOT NULL,
  `edicion` int(2) NOT NULL,
  `autor` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `libro`
--

INSERT INTO `libro` (`id_libro`, `id_editorial`, `nombre_libro`, `num_ejemplares`, `edicion`, `autor`) VALUES
(1, 1, 'Fundamentos de la Programación', 2, 7, 'Luis Joyanes Aguilar\r '),
(2, 2, 'Fundamentos de los Sistemas Operativos', 18, 6, 'Abraham Silberschatz'),
(3, 3, 'Ecuaciones DIferenciales', 8, 7, 'Dennis Zill'),
(4, 3, 'Analisis y diseño de Sistemas', 7, 5, 'Robert Newman'),
(5, 2, 'Programacion Orientada a Objetos', 0, 8, ''),
(8, 4, 'Matematica 4', 4, 7, 'Espinoza'),
(9, 4, 'Circuitos en corriente Alterna', 8, 3, 'Boylestad'),
(10, 4, 'Fisica Electrica', 14, 2, 'Dennis Zill'),
(11, 3, 'Fundamentos de la Programación', 1, 7, 'Luis Joyanes Aguilar\r '),
(12, 5, 'Base de datos', 5, 7, ''),
(13, 1, 'Robotica', 2, 6, 'Robert Newman'),
(14, 3, 'Robotica 2', 3, 7, 'Raymond Stanford'),
(18, 3, 'Metodos Numericos', 20, 7, 'Raul Mendes');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `prestamo`
--

CREATE TABLE `prestamo` (
  `id_prestamo` int(3) NOT NULL,
  `fecha_prestamo` date NOT NULL,
  `fecha_devolucion` date NOT NULL,
  `hora_prestamo` time NOT NULL,
  `id_libro` int(3) NOT NULL,
  `id_admin` int(3) NOT NULL,
  `codigo` varchar(10) NOT NULL,
  `lugar_p` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `prestamo`
--

INSERT INTO `prestamo` (`id_prestamo`, `fecha_prestamo`, `fecha_devolucion`, `hora_prestamo`, `id_libro`, `id_admin`, `codigo`, `lugar_p`) VALUES
(46, '2024-10-29', '2024-10-31', '14:54:00', 2, 1, '2021204048', 'domicilio'),
(50, '2024-12-01', '2024-12-10', '17:00:00', 2, 1, '2023204026', 'domicilio'),
(51, '2024-12-01', '2024-12-06', '12:30:00', 3, 2, '2023204026', 'domicilio'),
(52, '2024-12-26', '2024-12-29', '13:30:00', 4, 1, '2020203050', 'sala'),
(53, '2024-12-08', '2024-12-25', '14:45:00', 5, 1, '2233445511', 'sala'),
(54, '2024-12-30', '2024-12-31', '16:50:00', 5, 2, '2023204025', 'sala'),
(55, '2024-11-21', '2024-11-28', '10:30:00', 10, 1, '2023204021', 'domicilio'),
(56, '2024-11-22', '2024-11-30', '10:40:00', 8, 1, '2023204007', 'domicilio'),
(57, '2024-12-11', '2024-12-26', '15:45:00', 9, 1, '2023204021', 'domicilio'),
(59, '2024-10-19', '2024-10-24', '14:30:00', 9, 2, '2023204026', 'domicilio'),
(60, '2024-12-17', '2024-12-19', '16:30:00', 13, 2, '2023204026', 'domicilio'),
(63, '2024-12-12', '2024-12-28', '15:50:00', 9, 1, '2023204017', 'domicilio'),
(64, '2024-12-25', '2024-12-30', '15:00:00', 13, 1, '2023204007', 'domicilio');

--
-- Disparadores `prestamo`
--
DELIMITER $$
CREATE TRIGGER `actualizar_stock` AFTER INSERT ON `prestamo` FOR EACH ROW begin 
	update libro set num_ejemplares = num_ejemplares-1 where id_libro = new.id_libro;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `insertar_devolucion` AFTER INSERT ON `prestamo` FOR EACH ROW begin 
	insert into devolucion (fecha_d,id_prestamo,estado) values (new.fecha_devolucion,new.id_prestamo,'pendiente');
end
$$
DELIMITER ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indices de la tabla `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`codigo`);

--
-- Indices de la tabla `devolucion`
--
ALTER TABLE `devolucion`
  ADD PRIMARY KEY (`id_devolucion`),
  ADD KEY `devolucion_prestamo_FK` (`id_prestamo`);

--
-- Indices de la tabla `editorial`
--
ALTER TABLE `editorial`
  ADD PRIMARY KEY (`id_editorial`);

--
-- Indices de la tabla `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`id_libro`),
  ADD KEY `libro_editorial_FK` (`id_editorial`);

--
-- Indices de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD PRIMARY KEY (`id_prestamo`),
  ADD KEY `prestamo_libro_FK` (`id_libro`),
  ADD KEY `prestamo_administrador_FK` (`id_admin`),
  ADD KEY `prestamo_cliente_FK` (`codigo`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `administrador`
--
ALTER TABLE `administrador`
  MODIFY `id_admin` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `devolucion`
--
ALTER TABLE `devolucion`
  MODIFY `id_devolucion` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `editorial`
--
ALTER TABLE `editorial`
  MODIFY `id_editorial` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `libro`
--
ALTER TABLE `libro`
  MODIFY `id_libro` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `prestamo`
--
ALTER TABLE `prestamo`
  MODIFY `id_prestamo` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `devolucion`
--
ALTER TABLE `devolucion`
  ADD CONSTRAINT `devolucion_prestamo_FK` FOREIGN KEY (`id_prestamo`) REFERENCES `prestamo` (`id_prestamo`) ON DELETE CASCADE;

--
-- Filtros para la tabla `libro`
--
ALTER TABLE `libro`
  ADD CONSTRAINT `libro_editorial_FK` FOREIGN KEY (`id_editorial`) REFERENCES `editorial` (`id_editorial`);

--
-- Filtros para la tabla `prestamo`
--
ALTER TABLE `prestamo`
  ADD CONSTRAINT `prestamo_administrador_FK` FOREIGN KEY (`id_admin`) REFERENCES `administrador` (`id_admin`),
  ADD CONSTRAINT `prestamo_cliente_FK` FOREIGN KEY (`codigo`) REFERENCES `cliente` (`codigo`),
  ADD CONSTRAINT `prestamo_libro_FK` FOREIGN KEY (`id_libro`) REFERENCES `libro` (`id_libro`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
