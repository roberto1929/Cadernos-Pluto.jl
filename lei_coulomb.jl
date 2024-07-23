### A Pluto.jl notebook ###
# v0.19.45

using Markdown
using InteractiveUtils

# ╔═╡ 1e230ff0-187f-486c-b258-96f5949b162a
let

using LinearAlgebra

# Definindo constantes
ke = 8.99e9  # Constante eletrostática em N m² / C²
q = 2e-6     # Carga em Coulombs (2 μC)

# Posições
A = [4, 3, 5]
P = [8, 12, 2]

# Vetor posição r
r = P .- A
r_magnitude = norm(r)

# Campo elétrico em coordenadas cartesianas
E_cart = ke * q / r_magnitude^3 .* r

# Coordenadas cilíndricas de P
ρ = sqrt(P[1]^2 + P[2]^2)
φ = atan(P[2] / P[1])

# Componentes do campo elétrico em coordenadas cilíndricas
E_ρ = E_cart[1] * cos(φ) + E_cart[2] * sin(φ)
E_φ = -E_cart[1] * sin(φ) + E_cart[2] * cos(φ)
E_z = E_cart[3]

println("Componente Eρ: ", round(E_ρ,digits = 1), " aρ")
println("Componente Eφ: ", round(E_φ,digits = 1), " aφ ")
println("Componente Ez: ", round(E_z,digits = 1), " az")
end

# ╔═╡ bca49a28-4541-11ef-32c2-59dd318287e5
md"""
# Exercícios em Julia: Lei de Coulomb e Intensidade de Campo Elétrico

Instituto Federal de Santa Catarina

Engenharia de Telecomunicações

Autor: Roberto da Silva Espindola

Este caderno contém exercícios de eletromagnetismo utilizando a linguagem de programação Julia. Ele se baseia no livro "Eletromagnetismo" de William Hayt. 

No decorrer do caderno, abordaremos os seguintes tópicos:

- Introdução: Livro Referência
- Exercício - 2.2
- Exercício - 2.3
- Exercício - 2.7
- Exercício - 2.10


![Julia symbol](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Julia_Programming_Language_Logo.svg/512px-Julia_Programming_Language_Logo.svg.png)


"""


# ╔═╡ 4d99ee6b-455e-4eec-9715-ca26bc701ea4
md"""## Introdução: Livro referência"""

# ╔═╡ 5db60619-6f9e-439f-9c3b-0726152b08e3
html"""
<div style="display: flex; justify-content: space-between;">
    <div style="flex: 1; padding: 10px;">
<img src="https://m.media-amazon.com/images/I/71c-CDr1ISL._SL1500_.jpg" alt="Minha Imagem" width="220">
    </div>
</div>
"""

# ╔═╡ f2ac2bf0-4e01-4eee-919c-dd200f2b810a
md"""
Este conjunto de exercícios tem como objetivo aprofundar o entendimento dos conceitos apresentados no livro "Eletromagnetismo" de Hayt e Buck.
"""

# ╔═╡ 309c8172-e596-40fb-836e-fe984eac330f
md"""
## Exercício 2.2
**Exercício 2.2** -- Cargas pontuais de $1~\text{nC}$ e $-2~\text{nC}$ estão localizadas no espaço livre em $$(0, 0, 0)$$ e $$(1, 1, 1)$$, respectivamente. Determine o vetor força que age sobre cada carga.

Para resolver esse problema, vamos usar a lei de Coulomb para calcular a força entre duas cargas pontuais. A lei de Coulomb:

$$\mathbf{F} = k_e \frac{q_1 \cdot q_2}{r^2}\hat{r}$$

-  $\mathbf{F}$: é a força entre as cargas,
-  $k_e$: é a constante eletrostática (8.89 x 10⁹ N m² /C²),
- **q1** e **q2** são as magnitudes das cargas,
-  $r$ é a distância entre as cargas,
-  $\hat{r}$  é o vetor unitário na direção de r.
"""

# ╔═╡ 8f276487-971f-4ef1-ad81-9fe7cad96d9b
let
	# Constante eletrostática
	ke = 8.9875e9  # N·m²/C²
	
	# Cargas em Coulombs
	q1 = 1e-9  # 1 nC
	q2 = -2e-9  # -2 nC
	
	r1 = [0.0, 0.0, 0.0]  # posição da carga q1
	r2 = [1.0, 1.0, 1.0]  # posição da carga q2
	
	r = r2 .- r1
	
	dist = sqrt(sum(r .^ 2))
	
	# Vetor unitário na direção de r
	r_vet = r ./ dist
	
	# Força sobre q1 devido a q2
	F = ke * (q1 * q2) / dist^2 .* r_vet
	
	# Força sobre q2 devido a q1 é simplesmente a negativa da força sobre q1
	F1_on_q2 = F
	F2_on_q1 = -F
	
	println("Força sobre q1 devido a q2: ", round.(F1_on_q2, digits=20), " N")
	println("Força sobre q2 devido a q1: ", round.(F2_on_q1, digits=20), " N")
end

# ╔═╡ 805de0d7-d792-481b-bea6-5f9224ac05ad
md"""
## Exercício 2.3

**Exercício 2.3** -- Cargas pontuais de $50~\text{nC}$ cada estão posicionadas em $A(1, 0, 0), B(−1, 0, 0), C(0, 1, 0)$ e $D(0, −1, 0)$, no espaço livre. Encontre a força total na carga em A. 
A força entre duas cargas pontuais é dada por:

$$\mathbf{F} = \frac{k \cdot q_1 \cdot q_2}{r^2}$$

Em que:
- **F**: é a força entre as cargas,
- **k**: é a constante eletrostática (8.89 x 10⁹ N m² /C²),
- **q1** e **q2** são as magnitudes das cargas,
- **r** é a distância entre as cargas,
"""

# ╔═╡ dc88c290-e2f0-44fb-9ff3-9eba92b492a9
let

# Definindo constantes
ke = 8.99e9  # Constante eletrostática em N m² / C²
q = 50e-9    # Carga em Coulombs (50 nC)

# Calculando as forças
r_AB = 2.0
r_AC = sqrt(2.0)

F_AB = ke * q^2 / r_AB^2
F_AC = ke * q^2 / r_AC^2

# Componentes das forças
F_AC_x = F_AC * cos(pi/4)
F_AC_y = F_AC * sin(pi/4)

# Resultante das forças no eixo x e y
R_x = F_AB + 2 * F_AC_x
R_y = 0.0

# Calculando a resultante total
R = sqrt(R_x^2 + R_y^2)

# Convertendo para μN (micronewtons)
R_μN = R * 1e6
println("Força resultante total: ", round(R_μN, digits=1),"ax μN")
	
end

# ╔═╡ 276a3f02-3411-4eb4-ac10-320246c7748e
md"""
## Exercício 3

**Exercício 2.7** -- Uma carga pontual de $2~\mu\text{C}$ está posicionada em $A(4, 3, 5)$ no espaço livre. Encontre $\text{E}_\rho, \text{E}_\phi$ e $\text{E}_z$ em $P(8, 12, 2)$.
Dadas as coordenadas esféricas $(\rho, \phi, z)$, onde:
-  $$\rho$$ é a distância ao longo do plano xy até o ponto P,
-  $\phi$ é o ângulo azimutal no plano xy,
-  $z$ é a coordenada ao longo do eixo z,
podemos usar as seguintes fórmulas para calcular os componentes do campo elétrico:

$$E_ρ = \frac{1}{4 \pi \epsilon_0} \frac{q}{ρ^2}\cos(\phi)$$

$$E_{\phi} = - \frac{1}{4 \pi \epsilon_0} \frac{q }{\rho^2}\sin(\phi)$$

$$E_z = \frac{1}{4 \pi \epsilon_0} \frac{q }{\rho}\sin(\theta)$$

Onde:
- q é a carga pontual $(2~\mu\text{C})$,
-  $\epsilon_0$ é a permissividade do vácuo (8.85×10⁻¹² C²/N m²),
-  $\theta$ é o ângulo em relação ao eixo z.
"""

# ╔═╡ 38e56f11-1289-4289-ab0f-0aeb4884fbf2
md"""
## Exercício 4

**Exercício 2.10** -- Uma carga de $−1~\text{nC}$ está localizada na origem, no espaço livre. Qual carga deve ser inserida em $(2, 0, 0)$ para fazer com que $E_x$ seja zero em $(3, 1, 1)$?

**Constantes:**
-  $\epsilon_0$ é a permissividade do vácuo.
-  $k$ é a constante eletrostática.

**Cálculo das Distâncias:**
-  $r1$ e $r2$ são as distâncias calculadas usando a norma dos vetores posição.

**Componentes do Campo Elétrico:**
-  $E_\text{1x}$ é o componente x do campo elétrico devido à carga na origem.
-  $E_\text{2x}$ é o componente x do campo elétrico devido à carga em $(2,0,0)$.

**Resolução da Equação**
- Resolvemos a equação para **q2** garantindo que a soma dos componentes $E_x$ dos campos elétricos seja zero em $(3,1,1)$.
"""

# ╔═╡ f11e1d5a-9bb1-4fd6-9cc9-605588ff3f9a
let
# Constante de permissividade do vácuo em C^2 / (N m^2)
epsilon_0 = 8.854187817e-12
k = 1 / (4 * π * epsilon_0)

# Dados do problema
q1 = -1e-9  # carga em C (na origem)

# Distâncias
r1 = norm([3, 1, 1])  # distância da origem até P(3, 1, 1)
r2 = norm([3 - 2, 1, 1])  # distância de (2, 0, 0) até P(3, 1, 1)

# Componentes do campo elétrico
E1x = k * q1 * 3 / r1^3
E2x_q2 = k / (3 * sqrt(3))

# Resolver para q2
q2 = - E1x / E2x_q2

println("A carga que deve ser inserida em (2, 0, 0) para fazer E_x zero em (3, 1, 1) é: ", round.(q2, digits=15), " C")
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "ac1187e548c6ab173ac57d4e72da1620216bce54"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"
"""

# ╔═╡ Cell order:
# ╟─bca49a28-4541-11ef-32c2-59dd318287e5
# ╟─4d99ee6b-455e-4eec-9715-ca26bc701ea4
# ╟─5db60619-6f9e-439f-9c3b-0726152b08e3
# ╟─f2ac2bf0-4e01-4eee-919c-dd200f2b810a
# ╟─309c8172-e596-40fb-836e-fe984eac330f
# ╠═8f276487-971f-4ef1-ad81-9fe7cad96d9b
# ╟─805de0d7-d792-481b-bea6-5f9224ac05ad
# ╠═dc88c290-e2f0-44fb-9ff3-9eba92b492a9
# ╟─276a3f02-3411-4eb4-ac10-320246c7748e
# ╠═1e230ff0-187f-486c-b258-96f5949b162a
# ╟─38e56f11-1289-4289-ab0f-0aeb4884fbf2
# ╠═f11e1d5a-9bb1-4fd6-9cc9-605588ff3f9a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
