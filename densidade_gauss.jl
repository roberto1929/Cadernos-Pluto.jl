### A Pluto.jl notebook ###
# v0.19.45

using Markdown
using InteractiveUtils

# ╔═╡ 485ea19c-72a7-4d91-b611-dd6290698d18
using QuadGK, Printf

# ╔═╡ 8aa7c79c-45f1-11ef-1b89-e92864dbb146
md"""
# Exercícios em Julia: Densidade de Fluxo Elétrico, Lei de Gauss e Divergência

Instituto Federal de Santa Catarina

Engenharia de Telecomunicações

Autor: Roberto da Silva Espindola

Este caderno contém exercícios de eletromagnetismo utilizando a linguagem de programação Julia. Ele se baseia no livro "Eletromagnetismo" de William Hayt. 

No decorrer do caderno, abordaremos os seguintes tópicos:

- Exercício - 3.3
- Exercício - 3.5
- Exercício - 3.9


![Julia symbol](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Julia_Programming_Language_Logo.svg/512px-Julia_Programming_Language_Logo.svg.png)


"""


# ╔═╡ e7e8e5b5-e6b1-4a3b-ad6e-291523e14f05
md"""
## Exercício 1

**Exercício 3.3** -- A superfície cilíndrica $\rho$ = $8$ cm contém a densidade superficial de cargas $\rho_S = 5e^{-20|z|}$ nC/m². (a) Qual é o valor da carga total presente? (b) Qual é o fluxo elétrico que deixa a superfície $\rho$ = $8 cm, 1 cm < z < 5 cm, 30° < \phi < 90°$?

**Parte (a): Carga total presente**

A carga total Q em uma superfície é dada pela integral da densidade superficial de carga sobre a superfície:

$$Q = \iint_S \rho_S \, dS$$

Para a superfície cilíndrica:
$$dS = d\phi \, dz \, (\rho),$$
Em que:

-  $\rho$ = $0.08 m$ é o raio do cilindro.
-  $\phi$ varia de 0 a 2$\pi$.
-  $z$ varia de −∞ a ∞.
"""

# ╔═╡ e4b35523-c762-414b-b9be-79395fd60c43
let
# Definindo constantes
ρ = 0.08  # Raio do cilindro em metros
ρS = z -> 5e-20 * abs(z)  # Densidade superficial de carga em nC/m²

# Integrando sobre a superfície cilíndrica
integral_φ = 2π
integral_z = 2 * (1/20)  # Integração de e^(-20|z|) de -∞ a ∞

# Calculando a carga total
Q_total = 0.4 * integral_φ * integral_z  # Em nC
println("Carga total presente: ", round(Q_total, digits = 2), " nC")
end

# ╔═╡ 15c3a95a-1723-43f1-9a8d-3aee3e464afc
md"""

**Parte (b): Fluxo elétrico**

Para calcular o fluxo elétrico que deixa a superfície especificada, usamos a lei de Gauss:

$$\phi_E = \frac{Q_{\text{enc}}}{\epsilon_0}$$

Onde:

-  $\phi_E$: Fluxo elétrico que passa através da superfície.
-  $\epsilon_0$: Permissividade do vácuo, uma constante que relaciona as unidades do campo elétrico e a carga.
-  $Q_\text{enc}$: Carga elétrica total dentro da superfície fechada.
"""

# ╔═╡ e3558bca-2e5c-46f6-b467-31b777f2114a
let
# Limites da integração
z_min = 0.01  # 1 cm em metros
z_max = 0.05  # 5 cm em metros
φ_min = π/6  # 30 graus em radianos
φ_max = π/2  # 90 graus em radianos

# Integração numérica usando quadgk

integral_φ, _ = quadgk(x -> 1, φ_min, φ_max)
integral_z, _ = quadgk(z -> exp(-20 * z), z_min, z_max)

# Calculando a carga envolvida
Q_enc = 0.4 * integral_φ * integral_z  # Em nC

# Convertendo para pC (1 nC = 1000 pC)
Q_enc_pC = Q_enc * 1000
println("Fluxo elétrico que deixa a superfície: ", round(Q_enc_pC, digits = 2), " pC")
end

# ╔═╡ 821fc64e-c778-4aec-9385-6c37a26d8cb2
md"""
## Exercicio 2

**Exercício 3.5** -- Seja $D = 4xy\textbf{a}_x + 2(x² + z²)\textbf{a}_y + 4yz\textbf{a}_z$ $\text{C/m}^2$. Calcule as integrais de superfície para encontrar a carga total dentro do paralelepípedo retangular $0 < x < 2, 0 < y < 3, 0 < z < 5~\text{m}$.

Podemos usar a relação entre o vetor densidade de fluxo elétrico D e a densidade volumétrica de carga $\rho$v:

$$\nabla \cdot \mathbf{D} = \rho_v$$

A carga total $Q$ dentro de uma região pode ser encontrada integrando $\rho$v​ sobre o volume V:

$$Q = \iiint_V \rho_v \, dV$$
"""

# ╔═╡ 796ec9e2-519d-4fe1-bd75-af378fab59d9
let

# Definir a função do divergente de D
function divergente_D(y)
    return 8 * y
end

# Definir os limites de integração
x_min, x_max = 0, 2
y_min, y_max = 0, 3
z_min, z_max = 0, 5

# Calcular a integral tripla usando QuadGK
function calcular_carga_total()
    integral_y, _ = quadgk(divergente_D, y_min, y_max)
    integral_z, _ = quadgk(x -> 1, z_min, z_max)
    integral_x, _ = quadgk(x -> 1, x_min, x_max)
    
    return integral_y * integral_z * integral_x
end

# Calcular e imprimir a carga total
carga_total = calcular_carga_total()
println("Carga total dentro do paralelepípedo: ", carga_total * 1e9, " nC")  # Convertendo para nC

end

# ╔═╡ b9fe88ef-f24d-4b2b-a3ae-2c5f2613c16b
md"""
**Exercíci 3.9** -- Uma densidade volumétrica uniforme de cargas de $80$ μC/m³ está presente na região $8 mm < r < 10 mm.$ Seja $\rho_v = 0$ para $0 < r < 8$ mm. a) Encontre a carga total dentro da superfície esférica $r = 10$ mm. b) Encontre Dr em $r = 10$ mm. c) Se não existe carga para $r > 10$ mm, encontre $\mathbf{D_r}$ em $r = 20$ mm.

**a) Carga total dentro da superfície esférica $r=10$ mm**

A densidade volumétrica de carga $\rho_v$ é $80$ μC/m³ na região $8$ mm $< r < 10$ mm. Para encontrar a carga total, integramos $\rho_v$​ sobre o volume esférico dessa camada.

A carga total Q é dada por:

$$Q = \iiint_V \rho_v \, dV$$
"""

# ╔═╡ ac5f76ab-d51e-4821-8c2e-b4cc4f71a7e7
let

# Constantes
μC_to_C = 1e-6
mm_to_m = 1e-3

# Função para calcular a carga total
function calcular_carga_total(ρv, r1, r2)
    V = (4/3) * π * (r2^3 - r1^3)
    Q = ρv * V
    return Q
end

# Dados do problema
ρv = 80 * μC_to_C  # Densidade volumétrica de carga em C/m³
r1 = 8 * mm_to_m   # Raio interno em metros
r2 = 10 * mm_to_m  # Raio externo em metros


Q_total = calcular_carga_total(ρv, r1, r2)
@printf("Carga total dentro da superfície esférica r = 10 mm: %.2f pC\n",(Q_total * 1e12) ) 
end

# ╔═╡ b7fb8573-2314-4a0f-9780-edb2175ace36
md"""**b) $Dr$​ em $r=10$ mm**

Para $r = 10 mm$, usamos a lei de Gauss. A densidade de fluxo elétrico $Dr$​ é:

$$D_r = \frac{Q_{\text{enc}}}{4\pi r^2}$$
"""

# ╔═╡ 0e8723ba-2538-4459-b1c9-a25f659177d0
let

# Constantes
μC_to_C = 1e-6
mm_to_m = 1e-3

# Função para calcular a carga total
function calcular_carga_total(ρv, r1, r2)
    V = (4/3) * π * (r2^3 - r1^3)
    Q = ρv * V
    return Q
end

# Dados do problema
ρv = 80 * μC_to_C  # Densidade volumétrica de carga em C/m³
r1 = 8 * mm_to_m   # Raio interno em metros
r2 = 10 * mm_to_m  # Raio externo em metros


Q_total = calcular_carga_total(ρv, r1, r2)
	
# Função para calcular Dr
function calcular_Dr(Q, r)
    Dr = Q / (4 * π * r^2)
    return Dr
end

Dr_10mm = calcular_Dr(Q_total, r2)
@printf("Dr em r = 10 mm: %.2f nC/m²\n", (Dr_10mm * 1e9)) 
end

# ╔═╡ 6d54ec23-8648-4482-9bdd-5a316a8fdec5
md"""
**c) $Dr$ em $r=20$ mm**

Para $r=20 mm$, como não há carga além de $r=10 mm$, o fluxo $Dr$ diminui com $r²$:

$$D_r = \frac{Q_{\text{enc}}}{4\pi r^2}$$
"""

# ╔═╡ 26fa784a-e7db-4ba7-b37e-e6b875361b4a
let
μC_to_C = 1e-6
mm_to_m = 1e-3

# Função para calcular a carga total
function calcular_carga_total(ρv, r1, r2)
    V = (4/3) * π * (r2^3 - r1^3)
    Q = ρv * V
    return Q
end

# Dados do problema
ρv = 80 * μC_to_C  # Densidade volumétrica de carga em C/m³
r1 = 8 * mm_to_m   # Raio interno em metros
r2 = 10 * mm_to_m  # Raio externo em metros


Q_total = calcular_carga_total(ρv, r1, r2)

	
function calcular_Dr(Q, r)
	Dr = Q / (4 * π * r^2)
	return Dr
end

# Dado adicional para o cálculo em r = 20 mm
r3 = 20 * mm_to_m  # Raio para o cálculo de Dr fora da esfera em metros

Dr_20mm = calcular_Dr(Q_total, r3)
@printf "Dr em r = 20 mm: %.2f nC/m²\n" (Dr_20mm * 1e9)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
QuadGK = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"

[compat]
QuadGK = "~2.9.4"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "677e18afd43e092d7204c7097f7b988d28ce2357"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "b1c55339b7c6c350ee89f2c1604299660525b248"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.15.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "9b23c31e76e333e6fb4c1595ae6afa74966a729e"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.9.4"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"
"""

# ╔═╡ Cell order:
# ╠═485ea19c-72a7-4d91-b611-dd6290698d18
# ╟─8aa7c79c-45f1-11ef-1b89-e92864dbb146
# ╟─e7e8e5b5-e6b1-4a3b-ad6e-291523e14f05
# ╠═e4b35523-c762-414b-b9be-79395fd60c43
# ╟─15c3a95a-1723-43f1-9a8d-3aee3e464afc
# ╠═e3558bca-2e5c-46f6-b467-31b777f2114a
# ╟─821fc64e-c778-4aec-9385-6c37a26d8cb2
# ╠═796ec9e2-519d-4fe1-bd75-af378fab59d9
# ╟─b9fe88ef-f24d-4b2b-a3ae-2c5f2613c16b
# ╠═ac5f76ab-d51e-4821-8c2e-b4cc4f71a7e7
# ╟─b7fb8573-2314-4a0f-9780-edb2175ace36
# ╠═0e8723ba-2538-4459-b1c9-a25f659177d0
# ╟─6d54ec23-8648-4482-9bdd-5a316a8fdec5
# ╠═26fa784a-e7db-4ba7-b37e-e6b875361b4a
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
