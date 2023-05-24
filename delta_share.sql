-- Databricks notebook source
-- Criação do catalogo, é necessário criar o catalogo pois é com ele que podemos usar os recursos centralizados de controle de acesso, auditoria, linhagem e descoberta de dados em workspaces do Azure Databricks.
CREATE CATALOG TaxiShare;

-- COMMAND ----------

-- Criando Banco de Dados
CREATE DATABASE TaxiShare.NYCTaxis;

-- COMMAND ----------

-- Criando tabela dentro do nosso banco de dados
CREATE TABLE TaxiShare.NYCTaxis.YellowTaxiSample
USING DELTA
AS SELECT * FROM samples.nyctaxi.trips limit 100;

-- COMMAND ----------

-- Criando um compartilhamento
CREATE SHARE Taxis;

-- COMMAND ----------

-- Adicionando a tabela que criamos no compartilhamento
ALTER SHARE Taxis
ADD TABLE TaxiShare.NYCTaxis.YellowTaxiSample;

-- COMMAND ----------

-- Criando o recipiente. O recipiente é uma entidade que representa um usuário ou grupo de usuários que irão consumir os dados compartilhados
-- Para pegar as credenciais para acessar os dados compartilhados é necessário ir até a linha 12 e acessar o link de ativação.
-- Ao entrar no link de ativação aparecerá um botão para realizar o download das credenciais para acessar o Delta Share
CREATE RECIPIENT Consumidores;

-- COMMAND ----------

-- Dando acesso aos usuários do grupo (recipiente) Consumidores a darem select nos dados compartilhados
GRANT SELECT 
ON SHARE Taxis
TO RECIPIENT Consumidores;

-- COMMAND ----------

SHOW RECIPIENTS;
