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
|  |  |  |  |

## Erros encontrados no DDL e como foram corrigidos

| Tabela | Erro | Correção |
| --- | --- | --- |
|  |  |  |

## Erros encontrados no script de importação e como foram corrigidos

| Erro | Efeito | Correção |
| --- | --- | --- |
|  |  |  |

## Tratamentos aplicados aos dados

(conversão de tipos, validações, normalizações)

## Conferência final

| Tabela | Linhas na planilha | Linhas no banco |
| --- | --- | --- |
| fornecedor |  |  |
| produtos_filial |  |  |
| pedido_compra |  |  |
| entradas_mercadoria |  |  |
| venda |  |  |
