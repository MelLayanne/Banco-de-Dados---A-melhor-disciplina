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

DELIMITER //
-- 4. Verificação de Livros por Categoria
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoriaNome VARCHAR(100), OUT possuiLivros VARCHAR(3))
BEGIN
    DECLARE tt INT;
    SELECT COUNT(*) INTO tt
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;

    IF total > 0 THEN
        SET possuilivro = 'Sim';
    ELSE
        SET possuilivro = 'Não';
    END IF;
END //
DELIMITER ;
-- Teste 
CALL sp_VerificarLivrosCategoria('Romance', @possuilivro);
SELECT @possuilivro;


DELIMITER //
-- 5. Lista de Livros por Ano
CREATE PROCEDURE sp_LivrosAteAno(IN anoPublicacao INT)
BEGIN
    SELECT Titulo
    FROM Livro
    WHERE Ano_Publicacao <= anoPublicacao;
END //
DELIMITER ;
-- Teste 
CALL sp_LivrosAteAno(2007);
