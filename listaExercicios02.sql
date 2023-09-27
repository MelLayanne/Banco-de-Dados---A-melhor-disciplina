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


DELIMITER //
-- 3. Contagem de Livros por Categoria
CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN categoriaNome VARCHAR(100), OUT total INT)
BEGIN
    SELECT COUNT(*) INTO total
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
END //
DELIMITER ;
-- Teste 
CALL sp_ContarLivrosPorCategoria('Autoajuda', @total);
SELECT @total;
