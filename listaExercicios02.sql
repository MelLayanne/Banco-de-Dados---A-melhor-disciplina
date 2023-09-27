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


DELIMITER //
-- 6. Extração de Títulos por Categoria
CREATE PROCEDURE sp_TitulosPorCategoria(IN categoriaNome VARCHAR(100))
BEGIN
    SELECT Livro.Titulo
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
END //
DELIMITER ;
-- Teste 
CALL sp_TitulosPorCategoria('Romance');


DELIMITER //
-- 7. Adição de Livro com Tratamento de Erros
CREATE PROCEDURE sp_AdicionarLivro (IN novoTitulo VARCHAR(255), IN editoraID INT, IN anoPublicacao INT, IN numPaginas INT, IN categoriaID INT, OUT mensagem VARCHAR(255))
BEGIN
    DECLARE tituloExistente INT;
    SELECT COUNT(*) INTO tituloExistente FROM Livro WHERE Titulo = novoTitulo;
    IF tituloExistente > 0 THEN
        SET mensagem = 'Erro: Título já existe.';
    ELSE
	    INSERT INTO Livro (Titulo, Editora_ID, Ano_Publicacao, Numero_Paginas, Categoria_ID)
        VALUES (novoTitulo, editoraID, anoPublicacao, numPaginas, categoriaID);
        SET mensagem = 'Livro adicionado.';
    END IF;
END //
DELIMITER ;
-- Teste 
CALL sp_AdicionarLivro('A freira', 2, 2023, 320, 1, @mensagem);
SELECT @mensagem;


DELIMITER //
-- 8. Autor Mais Antigo
DROP PROCEDURE sp_Autorantigo;
CREATE PROCEDURE sp_Autorantigo(OUT autorNome VARCHAR(255))
BEGIN
    SELECT CONCAT(Nome, ' ', Sobrenome) INTO autorNome
    FROM Autor
    WHERE Data_Nascimento = (SELECT MIN(Data_Nascimento) FROM Autor);
    END //
DELIMITER ;
-- Teste 
CALL sp_Autorantigo(@autormaisvelho);
SELECT @autormaisvelho;
