use coletaIGTI;

-- Contar o numero de homens e mulheres
SELECT genero, COUNT(genero)
FROM pessoa
GROUP BY genero;

-- Qual a média de idade das pessoas?
create temporary table idade
	SELECT cod_pessoa,
		   nome, 
		   genero, 
		   data_nascimento,
		   timestampdiff(YEAR, pes.data_nascimento, NOW()) AS idade
	FROM pessoa AS pes;
    
select * from idade;

select genero, avg(idade)
from idade
group by genero;

select distinct idade
from idade
order by idade desc;


-- Quantas pessoas compraram o veiculo Uno Attractive 1.0 a partir da data 12/10/2020?


select 
	pes.genero, 
    count(vve.cod_modelo) as numero_veiculos
from venda_veiculo vve
 join modelo_veiculo mve
	on vve.cod_modelo = mve.cod_modelo
 join pessoa pes
	on pes.cod_pessoa = vve.cod_pessoa
 where 
	mve.descricao_modelo = ' Uno Attractive 1.0'
	and vve.data_venda >= '2020-10-12'
group by pes.genero;


-- Número de carros vendidos por modelo?

select 
	mve.descricao_modelo, 
    count(vve.cod_modelo) as numero_vendas
from modelo_veiculo as mve
join venda_veiculo as vve
on mve.cod_modelo = vve.cod_modelo
group by mve.descricao_modelo;	

    
 -- Qual fabricante vendeu o maior número de veiculos?
 
 select 
 fab.nome_fabricante,
 count(vve.cod_modelo)
 from venda_veiculo as vve
 join modelo_veiculo as mve
 on vve.cod_modelo = mve.cod_modelo
 join fabricante as fab
 on mve.cod_fabricante = fab.cod_fabricante
 group by fab.nome_fabricante;


-- Qual fabricante vendeu o maior numero de veiculos por genero?

select 
 fab.nome_fabricante,
 pes.genero,
 count(vve.cod_modelo)
 from venda_veiculo as vve
 join modelo_veiculo as mve
 on vve.cod_modelo = mve.cod_modelo
 join fabricante as fab
 on mve.cod_fabricante = fab.cod_fabricante
 join pessoa as pes
 on vve.cod_pessoa = pes.cod_pessoa 
 group by pes.genero, fab.nome_fabricante
 order by count(vve.cod_modelo) desc;


