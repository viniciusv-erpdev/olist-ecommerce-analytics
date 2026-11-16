# Olist Analytics — PostgreSQL & Excel

## Sobre o projeto

Projeto de portfólio de Análise de Dados utilizando PostgreSQL e Microsoft Excel.

O objetivo é explorar dados reais de comércio eletrônico brasileiro, desenvolver consultas SQL e apresentar indicadores de negócio em um dashboard interativo.

## Tecnologias

- PostgreSQL
- pgAdmin 4
- SQL
- Microsoft Excel
- Git e GitHub

## Fonte dos dados

**Brazilian E-Commerce Public Dataset by Olist**

Fonte: https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

A base contém aproximadamente 100 mil pedidos de comércio eletrônico brasileiro, realizados entre 2016 e 2018.

Os arquivos CSV originais não estão incluídos neste repositório. Consulte as condições de uso e atribuição da fonte.

## Como reproduzir o projeto

### 1. Pré-requisitos

- PostgreSQL instalado
- Cliente `psql`
- Git
- Arquivos CSV originais da Olist

### 2. Clonar o repositório

```bash
git clone URL_DO_REPOSITORIO
cd olist-analytics
```

### 3. Preparar os dados

Baixe a base no Kaggle e extraia os nove arquivos CSV para:

`data/raw/`

Mantenha os nomes originais dos arquivos.

### 4. Criar o banco

Utilizando uma conta administrativa do PostgreSQL, crie um usuário com LOGIN e um banco vazio chamado `olist_analytics`, pertencente a esse usuário.

O nome do usuário pode ser escolhido livremente.

### 5. Criar as tabelas

Conecte-se ao banco recém-criado e execute:

`sql/01_create_tables.sql`

### 6. Importar os dados

No terminal, a partir da pasta raiz do repositório:

```bash
psql -h localhost -U SEU_USUARIO -d olist_analytics -v ON_ERROR_STOP=1 -1 -f sql/02_import_data.psql
```

O comando solicita a senha do usuário PostgreSQL.

Execute a importação apenas uma vez em tabelas vazias.

### 7. Validar a importação

Execute o arquivo:

`sql/02_validate_import.sql`

Confira se os registros foram importados corretamente.

## Análises SQL

*Seção a ser preenchida durante o desenvolvimento.*

## Dashboard Excel

*Seção a ser preenchida durante o desenvolvimento.*

## Conclusões

*Seção a ser preenchida após a análise.*

## Autoria

Projeto independente de portfólio para demonstração de habilidades em SQL, PostgreSQL e análise de dados.

