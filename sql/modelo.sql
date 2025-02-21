CREATE DATABASE TicketingSystem;
USE TicketingSystem;

-- Tabla de Categorías de Eventos
-- Almacena las diferentes categorías de eventos, como conciertos, deportes y teatro
CREATE TABLE Categorias (
    categoria_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) UNIQUE NOT NULL
);

-- Tabla de Organizadores
-- Contiene información de los organizadores de eventos
CREATE TABLE Organizadores (
    organizador_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    tipo ENUM('Cantante', 'Banda', 'Club Deportivo', 'Compañía Teatral', 'Empresa', 'Institución') NOT NULL,
    contacto VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
);

-- Tabla de Establecimientos
-- Define los lugares donde se realizarán los eventos
CREATE TABLE Establecimientos (
    establecimiento_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    direccion TEXT NOT NULL,
    capacidad INT NOT NULL
);

-- Tabla de Usuarios (Clientes y Administradores)
-- Almacena la información de los usuarios registrados
CREATE TABLE Usuarios (
    usuario_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    tipo ENUM('Cliente', 'Admin') NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de Eventos
-- Registra los eventos programados, vinculados a organizadores y establecimientos
CREATE TABLE Eventos (
    evento_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    establecimiento_id INT NOT NULL,
    organizador_id INT NOT NULL,
    categoria_id INT NOT NULL,
    stock INT NOT NULL,
    limite_ventas INT NOT NULL, -- Límite para aprobar que se realice
    estado ENUM('Pendiente', 'Aprobado', 'Cancelado') DEFAULT 'Pendiente',
    FOREIGN KEY (establecimiento_id) REFERENCES Establecimientos(establecimiento_id),
    FOREIGN KEY (organizador_id) REFERENCES Organizadores(organizador_id),
    FOREIGN KEY (categoria_id) REFERENCES Categorias(categoria_id)
);

-- Tabla de Tipos de Asientos
-- Define los tipos de asientos disponibles en un evento
CREATE TABLE TiposAsiento (
    tipo_asiento_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(255) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    descripcion TEXT
);

-- Tabla de Asientos
-- Contiene información sobre la ubicación de los asientos dentro de un establecimiento
CREATE TABLE Asientos (
    asiento_id INT PRIMARY KEY AUTO_INCREMENT,
    establecimiento_id INT NOT NULL,
    tipo_asiento_id INT NOT NULL,
    fila VARCHAR(10) NOT NULL,
    numero INT NOT NULL,
    ubicacion VARCHAR(255) NOT NULL,
    FOREIGN KEY (establecimiento_id) REFERENCES Establecimientos(establecimiento_id),
    FOREIGN KEY (tipo_asiento_id) REFERENCES TiposAsiento(tipo_asiento_id)
);

-- Tabla de Preventa (Solo para American Express)
-- Maneja preventas exclusivas para ciertos tipos de tarjetas
CREATE TABLE Preventa (
    preventa_id INT PRIMARY KEY AUTO_INCREMENT,
    evento_id INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    tipo_tarjeta ENUM('American Express') NOT NULL,
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id)
);

-- Tabla de Cupones de Descuento
-- Registra códigos de descuento aplicables a las compras
CREATE TABLE Cupones (
    cupon_id INT PRIMARY KEY AUTO_INCREMENT,
    codigo VARCHAR(50) UNIQUE NOT NULL,
    descuento DECIMAL(5,2) NOT NULL, -- En porcentaje
    fecha_expiracion DATE NOT NULL
);

-- Tabla de Ventas de Tickets
-- Registra las compras de boletos realizadas por los usuarios
CREATE TABLE Ventas (
    venta_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    evento_id INT NOT NULL,
    cantidad INT NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cupon_id INT NULL,
    estado ENUM('Pendiente', 'Pagado', 'Cancelado') DEFAULT 'Pendiente',
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id),
    FOREIGN KEY (cupon_id) REFERENCES Cupones(cupon_id)
);

-- Tabla de Tickets Individuales
-- Asigna tickets únicos a los usuarios con un asiento específico
CREATE TABLE Tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    venta_id INT NOT NULL,
    usuario_id INT NOT NULL,
    asiento_id INT NOT NULL,
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (venta_id) REFERENCES Ventas(venta_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (asiento_id) REFERENCES Asientos(asiento_id)
);

-- Tabla de Transferencias de Tickets
-- Permite transferir tickets entre usuarios registrados
CREATE TABLE Transferencias (
    transferencia_id INT PRIMARY KEY AUTO_INCREMENT,
    ticket_id INT NOT NULL,
    usuario_original_id INT NOT NULL,
    usuario_nuevo_id INT NOT NULL,
    fecha_transferencia TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES Tickets(ticket_id),
    FOREIGN KEY (usuario_original_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (usuario_nuevo_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla de Pagos
-- Almacena los pagos realizados por los usuarios
CREATE TABLE Pagos (
    pago_id INT PRIMARY KEY AUTO_INCREMENT,
    venta_id INT NOT NULL,
    metodo_pago ENUM('Tarjeta de Crédito', 'Tarjeta de Débito', 'PayPal') NOT NULL,
    numero_tarjeta VARCHAR(16) NOT NULL,
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (venta_id) REFERENCES Ventas(venta_id)
);

-- Tabla de Evaluaciones de Eventos
-- Registra la retroalimentación de los asistentes sobre los eventos
CREATE TABLE Evaluaciones (
    evaluacion_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    evento_id INT NOT NULL,
    calificacion INT CHECK (calificacion BETWEEN 1 AND 5),
    comentario TEXT,
    fecha_evaluacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id)
);
