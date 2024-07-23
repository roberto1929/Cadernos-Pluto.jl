### A Pluto.jl notebook ###
# v0.19.45

using Markdown
using InteractiveUtils

# ╔═╡ 4e5efbf0-a709-4672-888c-8f88cd66204e
md"""
# Linguagem de programação Julia

Instituto Federal de Santa Catarina

Engenharia de Telecomunicações

Autor: Roberto da Silva Espindola

Este caderno contém uma introdução a linguagem de programação Julia. 

No decorrer do caderno, abordaremos os seguintes tópicos:

- Criação da linguagem
- Porque usar a linguagem Julia?
- Características da linguagem
- Funções da linguagem
- Criações de funções próprias

![Julia symbol](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Julia_Programming_Language_Logo.svg/512px-Julia_Programming_Language_Logo.svg.png)


"""


# ╔═╡ f9690fe6-a7d4-44ad-8bce-bb220efd4f07
md"""
## Criação da linguagem

- Desenvolvida em 2009 e publicada em 2012.
- Criada por Jeff Bezanson, Stefan Karpinski, Viral B. Shah e Alan Eldenman
- Se propuseram a criar uma linguagem que combinasse alta performance com uma sintaxe amigável e familiar para cientistas e engenheiros.
- Escrita em C, C++ e Scheme.
"""

# ╔═╡ ea10e613-6aa2-44b8-955d-513e6a43eb39
md"""
## Porque usar a linguagem Julia?

- Julia é uma das linguagens com alta produtividade e alto desempenho.
- É simples como o Python, mas roda como C.  
- Julia é fácil de aprender.
- Permite pensar de forma muito abstrata.

"""

# ╔═╡ ff486d3a-c71e-48b9-a5e6-73dac94d191d
md"""
## Características da linguagem

- Tipagem dinâmica.
- Criação de funções genéricas extensíveis.  
- Chamada de funções em C e Python.
- Suporte a símbolos matemáticos.  
- Gratuito e open source.
- Suporte a Unicode e UTF-8.
"""

# ╔═╡ e1192ada-bacd-4e69-aee8-acd48e9cf029
md"""
## Funções da Linguagem"""

# ╔═╡ db3a9a45-9922-4aa4-98b3-e7ba904cd826
md"""### Operadores aritméticos: +, -, *, /"""

# ╔═╡ eb7ff44f-fb76-45e8-a106-92ca3fedacf6
4 * 3

# ╔═╡ 6a00a05b-2fe0-42b9-8002-45febf9c05d2
35/8

# ╔═╡ 1b14e003-deb7-4889-8b70-d5f7c3910739
md""" ### Resto de divisão:"""

# ╔═╡ 720c9418-e9bd-4afd-82a4-d7f622273101
10%8

# ╔═╡ b705af4f-69f5-4d7e-bb79-a15d9ecf2499
md"""### Lógicos: ==, !=, <, >, <=, >=, &&, ||, !"""

# ╔═╡ e247c3e8-2a2e-407a-9373-739786f28d4b
a = 1; b = 2; c = 5;

# ╔═╡ 551b6c39-0d3c-4caf-9570-59b14c8f0d12
a == b

# ╔═╡ 6f216cd1-4389-4e71-ae64-f17017d72707
a != b

# ╔═╡ d686a9c3-ce97-4998-8c23-1b23db9267ca
md"""### Funções Trigonométricas:"""

# ╔═╡ 8ee8c95a-c40c-472b-afd9-c3e715ec85d3
sin(pi/4)

# ╔═╡ c8af0da4-4518-11ef-137b-8f5a7a666758
cos(pi)

# ╔═╡ 1d17f7b2-4e27-40bb-adec-718d433b128f
md"""### Matrizes:"""

# ╔═╡ d7a52af4-2637-4fe6-abfd-1a5427f39cf3
x = Array{Int64}(undef, 3,3)

# ╔═╡ 4fd88a72-6c39-4391-a262-b42d9eb29afd
m = [1 2 3;
	4 5 8;
	2 9 6;]

# ╔═╡ 75f605dd-d11f-48f5-a3b4-3483be52cc2b
size(m)

# ╔═╡ a9a97bb6-83c5-448c-815b-478f3b3470c3
length(m)

# ╔═╡ 1c5f3c1a-54ae-4171-9233-23d9db111151
sum(m)

# ╔═╡ c7785eee-083f-4de3-84e5-22c52ddb63d1
minimum(m)

# ╔═╡ bdf0f57f-2269-401b-a4fc-49a7728145bb
md"""## Criação de funções próprias"""

# ╔═╡ 4c10bcce-97be-40e9-aaa3-ebe37962ec9a
md"""### Fatorial:"""

# ╔═╡ 8bf0a767-f619-408d-be38-53917e4745d3
begin
function fatorial(n)
	if n == 0 || n == 1
		return 1
	else 
		return n * fatorial(n -1)
	end
end

numero = 5

println("O fatorial de $numero é: ", fatorial(numero))
end

# ╔═╡ 0f81e7c9-d9e7-4493-8bbb-98b5a4b1c46a
md"""### Soma dos números de 1 a 100:"""

# ╔═╡ e4698057-bdc6-4ccf-b380-55f9f554a5af
begin
function soma_1_a_100()
	soma = 0
	for i in 1:100
		soma+= i
	end
	return soma
end

println("A soma dos numeros de 1 a 100 é: ", soma_1_a_100())
end

# ╔═╡ a2ad4ebd-45f7-4701-b1ef-8c555180ed1d


# ╔═╡ Cell order:
# ╟─4e5efbf0-a709-4672-888c-8f88cd66204e
# ╟─f9690fe6-a7d4-44ad-8bce-bb220efd4f07
# ╟─ea10e613-6aa2-44b8-955d-513e6a43eb39
# ╟─ff486d3a-c71e-48b9-a5e6-73dac94d191d
# ╟─e1192ada-bacd-4e69-aee8-acd48e9cf029
# ╟─db3a9a45-9922-4aa4-98b3-e7ba904cd826
# ╠═eb7ff44f-fb76-45e8-a106-92ca3fedacf6
# ╠═6a00a05b-2fe0-42b9-8002-45febf9c05d2
# ╟─1b14e003-deb7-4889-8b70-d5f7c3910739
# ╠═720c9418-e9bd-4afd-82a4-d7f622273101
# ╟─b705af4f-69f5-4d7e-bb79-a15d9ecf2499
# ╠═e247c3e8-2a2e-407a-9373-739786f28d4b
# ╠═551b6c39-0d3c-4caf-9570-59b14c8f0d12
# ╠═6f216cd1-4389-4e71-ae64-f17017d72707
# ╟─d686a9c3-ce97-4998-8c23-1b23db9267ca
# ╠═8ee8c95a-c40c-472b-afd9-c3e715ec85d3
# ╠═c8af0da4-4518-11ef-137b-8f5a7a666758
# ╟─1d17f7b2-4e27-40bb-adec-718d433b128f
# ╠═d7a52af4-2637-4fe6-abfd-1a5427f39cf3
# ╠═4fd88a72-6c39-4391-a262-b42d9eb29afd
# ╠═75f605dd-d11f-48f5-a3b4-3483be52cc2b
# ╠═a9a97bb6-83c5-448c-815b-478f3b3470c3
# ╠═1c5f3c1a-54ae-4171-9233-23d9db111151
# ╠═c7785eee-083f-4de3-84e5-22c52ddb63d1
# ╟─bdf0f57f-2269-401b-a4fc-49a7728145bb
# ╟─4c10bcce-97be-40e9-aaa3-ebe37962ec9a
# ╠═8bf0a767-f619-408d-be38-53917e4745d3
# ╟─0f81e7c9-d9e7-4493-8bbb-98b5a4b1c46a
# ╠═e4698057-bdc6-4ccf-b380-55f9f554a5af
# ╠═a2ad4ebd-45f7-4701-b1ef-8c555180ed1d
