<img width="71" height="21" alt="image" src="https://github.com/user-attachments/assets/3025a4fb-9e46-48e3-9925-ec9c0a8e6b81" /># Parte 1: Documentação do processo de importação

## Ferramenta utilizada

## Ferramenta utilizada

- Banco de dados: MySQL.
- Ferramenta de gerenciamento: MySQL Workbench.
- Fonte dos dados: arquivo `base_teste.xlsx`.
- Linguagem do script de importação: Python.

## Estrutura da planilha

| Aba | Coluna | Tipo | Observação |
| :--- | :--- | :--- | :--- |
| venda | venda_id | Número inteiro | Identificador da venda |
| venda | data_emissao | Data | Data de emissão da venda |
| venda | horariomov | Hora | Horário da movimentação |
| venda | produto_id | Texto | Identificador do produto |
| venda | qtde_vendida | Número inteiro | Quantidade vendida |
| venda | valor_unitario | Número decimal | Valor unitário do produto |
| venda | filial_id | Número inteiro | Identificador da filial |
| venda | item | Número inteiro | Número do item da venda |
| venda | unidade_medida | Texto | Unidade de medida do produto |

| Aba | Coluna | Tipo | Observação |
| :--- | :--- | :--- | :--- |
| pedido_compra | descricao_produto | Texto | Descrição do produto |
| pedido_compra | ordem_compra | Número inteiro | Identificador da ordem de compra |
| pedido_compra | qtde_pedida | Número inteiro | Quantidade solicitada |
| pedido_compra | filial_id | Número inteiro | Identificador da filial |
| pedido_compra | data_entrega | Data | Data prevista para entrega |
| pedido_compra | qtde_entregue | Número inteiro | Quantidade já entregue |
| pedido_compra | preco_compra | Número decimal | Preço de compra do produto |
| pedido_compra | fornecedor_id | Número inteiro | Identificador numérico do fornecedor |

| Aba | Coluna | Tipo | Observação |
| :--- | :--- | :--- | :--- |
| entradas_mercadoria | data_entrada | Data | Data de recebimento da mercadoria |
| entradas_mercadoria | nro_nfe | Texto | Número da nota fiscal eletrônica |
| entradas_mercadoria | item | Número inteiro | Número do item recebido |
| entradas_mercadoria | produto_id | Texto | Identificador do produto |
| entradas_mercadoria | descricao_produto | Texto | Descrição do produto |
| entradas_mercadoria | ordem_compra | Número inteiro | Identificador da ordem de compra |
| entradas_mercadoria | qtde_recebida | Número inteiro | Quantidade recebida |
| entradas_mercadoria | filial_id | Número inteiro | 	Identificador da filial |
| entradas_mercadoria | custo_unitario | Número decimal | Custo unitário do produto |

| Aba | Coluna | Tipo | Observação |
| :--- | :--- | :--- | :--- |
| produtos_filial | filial_id | Número inteiro | Identificador da filial |
| produtos_filial | idproduto | Texto | Identificador do produto |
| produtos_filial | descricao | Texto | Descrição do produto |
| produtos_filial | estoque | Número inteiro | Quantidade disponível em estoque |
| produtos_filial | preco_unitario | Número decimal | Preço unitário do produto |
| produtos_filial | preco_compra | Número decimal | Preço de compra do produto |
| produtos_filial | preco_venda | Número decimal | Preço de venda do produto |
| produtos_filial | idfornecedor | Texto | Identificador do fornecedor |

| Aba | Coluna | Tipo | Observação |
| :--- | :--- | :--- | :--- |
| fornecedor | idfornecedor | Texto | Identificador do fornecedor |
| fornecedor | razao_social | Texto | Razão social do fornecedor |

## Erros encontrados no DDL e como foram corrigidos

| Tabela | Erro | Correção |
| :--- | :--- | :--- |
| produtos_filial | Chave primária referenciava uma coluna inexistente | Ajustada para utilizar filial_id e produto_id |
| produtos_filial | Nome errado | Errado: idfonecedor Correto: idfornecedor |
| fornecedor | Chave primária referenciava uma coluna inexistente | Ajustada para utilizar somente o identificador do fornecedor |
| entradas_mercadoria | Chave primária utilizava ordem_compra, coluna ausente na estrutura original | Inclusão da coluna ordem_compra |

## Erros encontrados no script de importação e como foram corrigidos

| Erro | Efeito | Correção |
| --- | --- | --- |
|  |  |  |

## Tratamentos aplicados aos dados

* Conversão de datas para o formato aceito pelo MySQL.
* Conversão de valores numéricos.
* Tratamento de campos vazios.
* Padronização de identificadores.
* Conferência dos tipos de dados.
