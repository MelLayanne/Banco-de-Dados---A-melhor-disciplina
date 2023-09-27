DELIMITER //
-- 1. Lista de Autores
DROP PROCEDURE sp_ListarAutores;
CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT * FROM Autor;
END //
DELIMITER ; 
-- Teste 
CALL sp_ListarAutores();
