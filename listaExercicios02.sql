DELIMITER //
-- 1. Lista de Autores
CREATE PROCEDURE sp_ListarAutores()
BEGIN
    SELECT * FROM Autor;
END //
DELIMITER ; 
-- Teste 
CALL sp_ListarAutores();


DELIMITER //
-- 2. Livros por Categoria
CREATE PROCEDURE sp_LivrosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    SELECT Livro.Titulo
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
END //
DELIMITER ;
-- Teste 
CALL sp_LivrosPorCategoria('Ciência');
