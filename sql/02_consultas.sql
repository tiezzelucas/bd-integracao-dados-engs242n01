-- 1. Total vendido por produto em fevereiro de 2025

SELECT
    produto_id,
    SUM(qtde_vendida) AS "Total Quantidade Vendida",
    ROUND(SUM(qtde_vendida * valor_unitario), 2) AS "Total Vendidos"
FROM venda
WHERE data_emissao >= '2025-02-01'
  AND data_emissao < '2025-03-01'
GROUP BY produto_id
ORDER BY "Total Vendidos" DESC;

-- 2. Produtos requisitados e não recebidos

SELECT
    pc.pedido_id,
    pc.produto_id,
    pc.descricao_produto,
    pc.qtde_pedida,
    COALESCE(SUM(em.qtde_recebida), 0) AS "Recebidos",
    pc.qtde_pedida -
    COALESCE(SUM(em.qtde_recebida), 0) AS "Não recebidos"

FROM pedido_compra pc
LEFT JOIN entradas_mercadoria em
    ON em.ordem_compra = pc.ordem_compra
    AND em.produto_id = pc.produto_id
GROUP BY
    pc.pedido_id,
    pc.produto_id,
    pc.descricao_produto,
    pc.qtde_pedida
HAVING pc.qtde_pedida >
       COALESCE(SUM(em.qtde_recebida), 0)
ORDER BY pc.pedido_id;
