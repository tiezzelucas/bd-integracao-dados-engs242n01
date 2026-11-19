-- 1. Concatenar codigo e descricao dos produtos

SELECT
    produto_id,
    descricao_produto,
    CONCAT(produto_id, ' - ', descricao_produto) AS produto_completo
FROM pedido_compra
ORDER BY produto_id;

-- 2. Formatacao de datas no padrao DD/MM/AAAA Tabela: pedido_compra

SELECT
    pedido_id,
    produto_id,
    DATE_FORMAT(data_pedido, '%d/%m/%Y') AS data_pedido_formatada,
    DATE_FORMAT(data_entrega, '%d/%m/%Y') AS data_entrega_formatada
FROM pedido_compra
ORDER BY pedido_id;

-- 3. Produtos requisitado mais de 10 vezes por quantidade de unidades

SELECT
    produto_id,
    MAX(descricao_produto) AS descricao_produto,
    COUNT(*) AS total_registros,
    SUM(qtde_pedida) AS quantidade_total_pedida
FROM pedido_compra
GROUP BY produto_id
HAVING SUM(qtde_pedida) > 10
ORDER BY quantidade_total_pedida DESC;

-- 4. Trigger para associar fornecedor ao produto

DELIMITER $$

CREATE TRIGGER trg_produtos_fornecedor
BEFORE INSERT ON produtos_filial
FOR EACH ROW
BEGIN

    DECLARE v_idfornecedor VARCHAR(25) DEFAULT NULL;

    SELECT f.idfornEcedor
    INTO v_idfornecedor
    FROM pedido_compra pc
    INNER JOIN fornecedor f
        ON f.idfornEcedor = CONCAT('F', pc.fornecedor_id)
    WHERE pc.produto_id = NEW.produto_id
      AND pc.filial_id = NEW.filial_id
    ORDER BY
        pc.data_pedido DESC,
        pc.pedido_id DESC,
        pc.item DESC
    LIMIT 1;

    IF v_idfornecedor IS NOT NULL THEN
        SET NEW.idfornecedor = v_idfornecedor;
    END IF;

END$$

DELIMITER ;
