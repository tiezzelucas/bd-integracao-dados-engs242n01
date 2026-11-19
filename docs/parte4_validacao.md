# Parte 4: Roteiro de validação com o cliente (fevereiro/2025)

## 1. Pontos a validar
Durante a reunião de validação com o cliente, serão analisados os seguintes pontos:

* Integridade das vendas: verificar se as quantidades vendidas e os valores unitários são válidos, evitando registros nulos, zerados ou negativos.
* Cadastro de produtos: confirmar se todos os produtos registrados nas vendas estão cadastrados na respectiva filial.
* Cadastro de fornecedores: verificar se os fornecedores informados nos pedidos de compra existem na tabela de fornecedores.
* Correspondência dos recebimentos: conferir se todas as entradas de mercadorias possuem um pedido de compra correspondente.
* Conferência de quantidades: comparar as quantidades solicitadas nos pedidos de compra com as quantidades efetivamente recebidas.
* Associação de fornecedores: verificar se os produtos cadastrados nas filiais possuem fornecedores válidos associados.

## 2. Técnicas para garantir exatidão e precisão
Para garantir a confiabilidade das informações, foram utilizadas as seguintes técnicas:

* Filtros por período: utilização de intervalos de datas para limitar a análise a fevereiro de 2025.
* LEFT JOIN: identificação de registros sem correspondência entre tabelas, permitindo localizar produtos ou fornecedores não cadastrados.
* NOT EXISTS: identificação de recebimentos que não possuem pedido de compra correspondente.
* GROUP BY e SUM: agrupamento dos registros e soma das quantidades recebidas para comparar com as quantidades solicitadas.
* HAVING: filtragem dos grupos em que a quantidade recebida ultrapassa a quantidade pedida.
* COALESCE: tratamento de valores nulos durante a soma das quantidades recebidas.

As consultas foram executadas no MySQL e os resultados foram analisados individualmente, permitindo identificar inconsistências e verificar a integridade dos dados.

## 3. Consultas preparadas para a reunião
As consultas utilizadas na validação estão disponíveis no arquivo sql/04_validacao.sql.

Cada consulta verifica um aspecto específico da qualidade dos dados:

1. Vendas com quantidade ou valor inválido: identifica vendas com quantidade nula, zero ou negativa, ou valor unitário igual a zero ou negativo.
2. Vendas com produtos não cadastrados na filial: verifica se os produtos registrados nas vendas estão cadastrados na filial correspondente.
3. Pedidos de compra com fornecedor não cadastrado: verifica se o fornecedor informado em cada pedido possui cadastro correspondente na tabela fornecedor. Para isso, converte o código numérico para o formato utilizado no cadastro, como F1, F2 e assim sucessivamente.
4. Recebimentos sem pedido de compra correspondente: identifica entradas de mercadorias cuja combinação de ordem de compra, item e produto não foi encontrada na tabela pedido_compra.
5. Recebimentos em quantidade superior à pedida: compara a quantidade solicitada nos pedidos de compra com a soma das quantidades recebidas, identificando possíveis excessos.
6. Produtos com fornecedor não cadastrado: verifica se os produtos possuem um fornecedor associado e se esse fornecedor existe na tabela de cadastro.

(As consultas ficam em `sql/04_validacao.sql`. Explique aqui o que cada uma mostra.)

## Erros encontrados nos dados

Tabela: venda
Problema: Produtos vendidos não cadastrados na respectiva filial
Quantidade: 6 registros
Consulta que mostra: Consulta 2

Tabela: entradas_mercadoria
Problema: Recebimento sem pedido de compra correspondente
Quantidade: 1 registro
Consulta que mostra: Consulta 4

Tabela: pedido_compra / entradas_mercadoria
Problema: Quantidade recebida superior à quantidade pedida
Quantidade: 3 registros
Consulta que mostra: Consulta 5

Tabela: produtos_filial
Problema: Produtos com fornecedor não cadastrado ou inválido (idfornecedor = 0)
Quantidade: 22 registros
Consulta que mostra: Consulta 6
