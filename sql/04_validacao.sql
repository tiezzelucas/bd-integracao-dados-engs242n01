-- 1. VENDAS COM QUANTIDADE OU VALOR INVALIDO
-- Verifica quantidade nula, zero ou negativa e valor unitario igual a zero ou negativo.

SELECT
    venda_id,
    data_emissao,
    produto_id,
    qtde_vendida,
    valor_unitario,
    filial_id
FROM venda
WHERE data_emissao >= '2025-02-01'
  AND data_emissao < '2025-03-01'
  AND (
      qtde_vendida IS NULL
      OR qtde_vendida <= 0
      OR valor_unitario <= 0
  );

-- 2. VENDAS COM PRODUTOS NAO CADASTRADOS NA FILIAL

SELECT
    v.venda_id,
    v.data_emissao,
    v.produto_id,
    v.filial_id
FROM venda v
LEFT JOIN produtos_filial pf
    ON pf.produto_id = v.produto_id
   AND pf.filial_id = v.filial_id
WHERE v.data_emissao >= '2025-02-01'
  AND v.data_emissao < '2025-03-01'
  AND pf.produto_id IS NULL;


-- 3. PEDIDOS DE COMPRA COM FORNECEDOR NAO CADASTRADO
-- Converte o codigo numerico para o formato F1, F2...

SELECT
    pc.pedido_id,
    pc.data_pedido,
    pc.fornecedor_id,
    CONCAT('F', pc.fornecedor_id) AS fornecedor_esperado
FROM pedido_compra pc
LEFT JOIN fornecedor f
    ON f.idfornEcedor = CONCAT('F', pc.fornecedor_id)
WHERE pc.data_pedido >= '2025-02-01'
  AND pc.data_pedido < '2025-03-01'
  AND f.idfornEcedor IS NULL;


-- 4. RECEBIMENTOS SEM PEDIDO DE COMPRA CORRESPONDENTE
-- Verifica ordem de compra, item e produto.

SELECT
    em.ordem_compra,
    em.data_entrada,
    em.nro_nfe,
    em.item,
    em.produto_id,
    em.qtde_recebida
FROM entradas_mercadoria em
WHERE em.data_entrada >= '2025-02-01'
  AND em.data_entrada < '2025-03-01'
  AND NOT EXISTS (
      SELECT 1
      FROM pedido_compra pc
      WHERE pc.ordem_compra = em.ordem_compra
        AND pc.item = em.item
        AND pc.produto_id = em.produto_id
  );
  
-- Foi identificado um recebimento de mercadoria referente à ordem de compra 19, nota fiscal NFE19, produto P19, sem correspondência na tabela de pedidos de compra. A inconsistência foi identificada utilizando NOT EXISTS.  
  
  SELECT
    pc.pedido_id,
    pc.ordem_compra,
    pc.item,
    pc.produto_id,
    pc.qtde_pedida,
    COALESCE(SUM(em.qtde_recebida), 0) AS total_recebido
FROM pedido_compra pc
LEFT JOIN entradas_mercadoria em
    ON em.ordem_compra = pc.ordem_compra
   AND em.item = pc.item
   AND em.produto_id = pc.produto_id
WHERE pc.data_pedido >= '2025-02-01'
  AND pc.data_pedido < '2025-03-01'
GROUP BY
    pc.pedido_id,
    pc.ordem_compra,
    pc.item,
    pc.produto_id,
    pc.qtde_pedida
HAVING COALESCE(SUM(em.qtde_recebida), 0) > pc.qtde_pedida;

-- Identificação de três pedidos de compra cujas quantidades recebidas ultrapassaram as quantidades solicitadas. Utilizando LEFT JOIN, agrupamento dos recebimentos e comparação entre a quantidade pedida e a quantidade efetivamente recebida.

-- 5. RECEBIMENTOS EM QUANTIDADE SUPERIOR A PEDIDA
-- Compara a quantidade recebida com a quantidade pedida.

SELECT
    pc.pedido_id,
    pc.ordem_compra,
    pc.item,
    pc.produto_id,
    pc.qtde_pedida,
    COALESCE(SUM(em.qtde_recebida), 0) AS total_recebido
FROM pedido_compra pc
LEFT JOIN entradas_mercadoria em
    ON em.ordem_compra = pc.ordem_compra
   AND em.item = pc.item
   AND em.produto_id = pc.produto_id
WHERE pc.data_pedido >= '2025-02-01'
  AND pc.data_pedido < '2025-03-01'
GROUP BY
    pc.pedido_id,
    pc.ordem_compra,
    pc.item,
    pc.produto_id,
    pc.qtde_pedida
HAVING COALESCE(SUM(em.qtde_recebida), 0) > pc.qtde_pedida;

-- Identificados três pedidos com recebimento superior ao solicitado, totalizando 89 unidades excedentes. Esses registros precisam ser conferidos com as notas fiscais e os pedidos de compra.

-- 6. PRODUTOS COM FORNECEDOR NAO CADASTRADO
-- Verifica se o fornecedor associado ao produto existe.

SELECT
    pf.filial_id,
    pf.produto_id,
    pf.descricao,
    pf.idfornecedor
FROM produtos_filial pf
LEFT JOIN fornecedor f
    ON f.idfornEcedor = pf.idfornecedor
WHERE pf.idfornecedor IS NULL
   OR pf.idfornecedor = '0'
   OR f.idfornEcedor IS NULL;
   
-- Identificados 22 produtos com associação inválida de fornecedor. É necessário verificar a origem desses registros e associar cada produto a um fornecedor existente, quando aplicável.

--RESULTADO-------

Nº    Verificação						                                Resultado
1	    Vendas com quantidade ou preço inválido			          Nenhum registro
2	    Vendas com produto não cadastrado na filial		        6 registros
3	    Pedidos com fornecedor não cadastrado			            Nenhum registro
4	    Recebimentos sem pedido correspondente		          	1 registro
5	    Recebimentos acima da quantidade pedida			          3 registros
6	    Produtos com fornecedor não cadastrado ou inválido	  22 registros
