-- ========================================
-- 1. DESEMPENHO COMERCIAL
-- ========================================

-- ==========================================
-- ANÁLISE 01: EVOLUÇÃO MENSAL DO FATURAMENTO
-- ==========================================

-- Objetivo:
-- Investigar a evolução mensal do valor
-- dos produtos vendidos.

-- Regras de negócio:
-- Considerar apenas pedidos entregues.
-- Considerar o valor dos pagamentos, 
-- incluindo o frete.
-- Agrupar pela data de realização da compra.

-- Consulta SQL desenvolvida abaixo.

select 
    sum(payment_value) as valor_venda,
	date_trunc('month', ord.order_purchase_timestamp)::date as mes
from olist.order_payments as pay
inner join olist.orders as ord
	on pay.order_id = ord.order_id
where ord.order_status = 'delivered'
group by mes
order by mes asc;

-- ====================================================
-- ANÁLISE 02: MESES COM MAIOR E MENOR VOLUME DE VENDAS
-- ====================================================

-- Objetivo:
-- Investigar quais foram os meses com maior e
-- menor volume de vendas.

-- Regras de nogócio:
-- Considerar apenas pedidos entregues.
-- Medir o volume de vendas pela quantidade de pedidos.
-- Retornar todos os meses em caso de empate

-- Consulta SQL desenvolvida abaixo.

with 
	max_min_order as (

	select 
		count(order_id) as vendas,
		date_trunc('month', order_purchase_timestamp)::date as mes
	from olist.orders
	where order_status = 'delivered'
	group by mes
	
	)

select 
	*,
	'máximo de vendas' as classificacao
from max_min_order
where vendas = (select max(vendas) from max_min_order)

union all

select 
	*,
	'mínimo de vendas' as classificacao
from max_min_order
where vendas = (select min(vendas) from max_min_order);

-- ====================================================
-- ANÁLISE 03: ESTADOS COM O MAIOR NÚMERO DE VENDAS
-- ====================================================

-- Objetivo:
-- Investigar quais estados concentram
-- o maior número de vendas.

-- Regras de negócio:
-- Considerar apenas pedidos entregues.
-- Considerar a localização do cliente.
-- Medir o volume de vendas pela quantidade de pedidos.

-- Consulta SQL desenvolvida abaixo.

select
	count(ord.order_id) as vendas,
	cus.customer_state as estado
from olist.orders as ord
inner join olist.customers as cus
	on ord.customer_id = cus.customer_id
where ord.order_status = 'delivered'
group by estado
order by vendas desc;

-- =========================================================
-- ANÁLISE 04: RELAÇÃO ENTRE FATURAMENTO E NÚMERO DE PEDIDOS
-- =========================================================

-- Objetivo:
-- Investigar se o crescimento do faturamento 
-- acompanha o número de pedidos

-- Consulta SQL desenvolvida abaixo.

-- Regras de negócio:
-- Considerar apenas pedidos com status 'delivered'
-- Considerar que um único pedido pode possuir múltiplos
-- pagamentos.

select
	sum(pay.payment_value) as faturamento,
	count(distinct ord.order_id) as pedidos,
	date_trunc('month', ord.order_purchase_timestamp)::date as mes
from olist.order_payments as pay
inner join olist.orders as ord
	on pay.order_id = ord.order_id
where ord.order_status = 'delivered'
group by mes
order by mes desc;