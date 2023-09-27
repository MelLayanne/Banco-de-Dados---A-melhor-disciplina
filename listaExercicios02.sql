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

    IF tt > 0 THEN
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


-- 9. Detalhamento da procedure sp_VerificarLivrosCategoria:
DELIMITER //
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoriaNome VARCHAR(100), OUT possuiLivros VARCHAR(3))
-- CREATE PROCEDURE: Cria uma stored procedure.
-- sp_VerificarLivrosCategoria: Nome da stored procedure que está sendo criada.
-- (IN categoriaNome VARCHAR(100), OUT possuiLivros VARCHAR(3)): Definimos os parâmetros, ela recebe um parâmetro de entrada 'IN' chamado 'categoriaNome' com varchar de no máximo de 100 caracteres e recebe um parâmetro de saída 'OUT' chamado possuiLivros com varchar de no máximo 3 caracteres.
-- O 'IN' é para especificarmos o nome da categoria, já o OUT é para enviarmos a resposta de sim ou não.

BEGIN
-- 'BEGIN' ele marca o início do código da stored procedure (o corpo dela).

    DECLARE tt INT;
	-- (DECLARE tt INT;) declara uma variável chamada 'tt' do tipo inteiro (INT), ela armazena o número total dos livros na categoria que vamos especificar para saber se há livros ou não.
    
    SELECT COUNT(*) INTO tt
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;
    -- (SELECT COUNT(*) INTO total): Conta o número de registros na tabela 'Livro' da condição que especificarmos.
    -- (FROM Livro): Seleciona a tabela Livro.
    -- (INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID): Junta a tabela 'Livro' e 'Categoria' com base na coluna 'Categoria_ID', o que relaciona os livros as suas categorias
    -- (WHERE Categoria.Nome = categoriaNome): Filtra os registros onde o nome da categoria corresponde ao valor passado como parâmetro 'categoriaNome', e o resultado da contagem fica armazenado na variável 'tt'.
    
    IF tt > 0 THEN
        SET possuilivro = 'Sim';
    ELSE
        SET possuilivro = 'Não';
    END IF;
    -- (IF total > 0 THEN): Condição- se o valor da variável 'tt' for maior que 0 o código dentro do ''THEN' será executado.
    -- (SET possuiLivros = 'Sim'): Define o valor da variável 'possuilivros' se houver livros na categoria.
    -- (ELSE): Caso contrário, se o valor de 'tt' for igual a 0, o que significa que não tem livros, será executado o código dentro do 'ELSE'.
    -- (SET possuiLivros = 'Não): Define o valor da variável 'possuilivros' como 'Não' se não houver livros na categoria.
    -- (END IF): Encerra a estrutura de condição.
   
DELIMITER ;
-- Delimitador padrão, usado antes e no final da stored procedure.

-- Teste da sp_VerificarLivrosCategoria
CALL sp_VerificarLivrosCategoria('Romance', @possuilivro);
SELECT @possuilivro; 
-- CALL: Ela chama a stored procedure. Neste caso, estamos chamando a stored procedure sp_VerificarLivrosCategoria.
-- (Romance): Valor do parâmetro 'categoriaNome' que estamos passando para a stored procedure. Estamos verificando se a categoria com o nome 'Romance' possui livros.
-- (@possuilivros): Parâmetro de saída onde a resposta da stored procedure será armazenada. Depois da execução da stored procedure, a variável '@possuilivros' conterá "Sim" ou "Não", dependendo da presença de livros na categoria 'Romance'.
-- (SELECT): É usada para selecionar e recuperar dados do banco de dados.Nesse caso a instrução SELECT exibirá o valor de '@possuilivros', que será "Sim" se a categoria 'Romance' tiver livros ou "Não" se não tiver.

DELIMITER //
-- 10. Livros e Seus Autores
CREATE PROCEDURE sp_LivrosESeusAutores()
BEGIN
    SELECT Livro.Titulo, CONCAT(Autor.Nome, ' ', Autor.Sobrenome) AS Autor
    FROM Livro
    INNER JOIN Autor_Livro ON Livro.Livro_ID = Autor_Livro.Livro_ID
    INNER JOIN Autor ON Autor_Livro.Autor_ID = Autor.Autor_ID;
END //
DELIMITER ;
-- Teste 
CALL sp_LivrosESeusAutores();


DELIMITER //
-- 4. Verificação de Livros por Categoria
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoriaNome VARCHAR(100), OUT possuiLivros VARCHAR(3))
BEGIN
    DECLARE tt INT;
    SELECT COUNT(*) INTO tt
    FROM Livro
    INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
    WHERE Categoria.Nome = categoriaNome;

    IF tt > 0 THEN
        SET possuilivro = 'Sim';
    ELSE
        SET possuilivro = 'Não';
    END IF;
END //
DELIMITER ;
-- Teste 
CALL sp_VerificarLivrosCategoria('Romance', @possuilivro);
SELECT @possuilivro;
