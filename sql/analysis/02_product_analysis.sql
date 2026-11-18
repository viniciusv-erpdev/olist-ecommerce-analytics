-- ============================================
-- 2. ANÁLISE DE PRODUTOS VENDIDOS
-- ============================================

-- =============================================
-- ANÁLISE 01: CATEGORIAS QUE GERAM MAIS RECEITA
-- =============================================

-- Objetivo:
-- Identificar quais categorias de produtos
-- geram maior receita.

-- Regras de negócio:
-- Considerar apenas o preço individual de cada item.
-- Considerar apenas pedidos com status = 'delivered'.
-- Não considerar o valor do frete.

-- Consulta SQL desenvolvida abaixo.

select 
	sum(ite.price) as faturamento,
	pro.product_category_name as categoria_produto
from olist.products as pro
inner join olist.order_items as ite
	on pro.product_id = ite.product_id
inner join olist.orders as ord
	on ite.order_id = ord.order_id
where ord.order_status = 'delivered'
group by categoria_produto
order by faturamento desc;

-- ==================================================
-- ANÁLISE 02: VOLUME DE ITENS VENDIDOS POR CATEGORIA
-- ==================================================

-- Objetivo:
-- Identificar quais categorias possuem o maior
-- volume de itens vendidos.

-- Regras de negócio:
-- Considerar apenas pedidos com status = 'delivered'.
-- Contabilizar cada item vendido individualmente.

select 
	count(ite.order_id) as qntd_itens_vendidos,
	pro.product_category_name as categoria_produto
from olist.products as pro
inner join olist.order_items as ite
	on pro.product_id = ite.product_id
inner join olist.orders as ord
	on ite.order_id = ord.order_id
where ord.order_status = 'delivered'
group by categoria_produto
order by qntd_itens_vendidos desc;

-- ========================================================
-- ANÁLISE 03: CONCENTRAÇÃO DE RECEITA EM POUCAS CATEGORIAS
-- ========================================================

-- Objetivo:
-- Avaliar o grau de concentração da receita
-- entre as categorias de produtos.

-- Regras de negócio:
-- Não considerar o valor do frete.
-- Considerar apenas pedidos com status = 'delivered'.
-- Calcular a participação individual de cada categoria.
-- Calcular a participação percentual acumulada.
-- Ordenar as categorias por participação decrescente.

with 
	faturamento_bruto as (

		select 
			sum(price) as total 
		from olist.order_items as ite
		inner join olist.orders as ord
			on ite.order_id = ord.order_id
		where ord.order_status = 'delivered'

		),

	faturamento_categoria as (

		select 
			(sum(price)/(select total from faturamento_bruto)*100) as participacao_faturamento,
			pro.product_category_name as categoria
		from olist.order_items as ite
		inner join olist.products as pro
			on ite.product_id = pro.product_id
		inner join olist.orders as ord
			on ite.order_id = ord.order_id
		where ord.order_status = 'delivered'
		group by categoria
	)

select
	round(participacao_faturamento,2) as participacao_individual,
	round(
	sum(participacao_faturamento) 
	over (order by participacao_faturamento desc 
	rows between unbounded preceding and current row),2
	) as participacao_acumulada,
	categoria
from faturamento_categoria
order by participacao_faturamento desc;

-- ========================================================
-- ANÁLISE 04: VALOR MÉDIO DA CATEGORIA POR ITEM VENDIDO
-- ========================================================

-- Objetivo:
-- Descobrir quais categorias representam o maior valor médio
-- por item vendido

-- Regras de negócio:
-- Considerar apenas pedidos com status = 'delivered'

-- Consulta SQL desenvolvida abaixo.

select
	round(avg(ite.price), 2) as preco_medio_item,
	pro.product_category_name as categoria
from olist.order_items as ite
inner join olist.products as pro
	on ite.product_id = pro.product_id
inner join olist.orders as ord
	on ite.order_id = ord.order_id
where ord.order_status = 'delivered'
group by categoria
order by preco_medio_item desc;