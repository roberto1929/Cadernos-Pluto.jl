### A Pluto.jl notebook ###
# v0.19.45

using Markdown
using InteractiveUtils

# ╔═╡ 709f3e2d-c0cc-4870-9937-9d13ac8fb026
using Printf, QuadGK

# ╔═╡ e9699e40-45f6-11ef-2c60-350b5e345713
md"""
# Exercícios em Julia: Campo Magnético Estacionário

Instituto Federal de Santa Catarina

Engenharia de Telecomunicações

Autor: Roberto da Silva Espindola

Este caderno contém exercícios de eletromagnetismo utilizando a linguagem de programação Julia. Ele se baseia no livro "Eletromagnetismo" de William Hayt. 

No decorrer do caderno, abordaremos os seguintes tópicos:

- Exemplo - 7.1
- Exercício - 7.1
- Exercício - 7.9


![Julia symbol](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Julia_Programming_Language_Logo.svg/512px-Julia_Programming_Language_Logo.svg.png)


"""


# ╔═╡ ba100e58-599e-41f8-b818-322d34317b58
md"""
## Exemplo 7.1

Este exemplo foi extraído do livro "Eletromagnetismo" de William H. Hayt Jr. e John A. Buck, página 202.

**Exemplo 7.1** -- Como um exemplo numérico ilustrando o uso da equação:
$$\mathbf{H} = \frac{I}{4\pi\rho} (\sin \alpha_2 - \sin \alpha_1) \mathbf{a}_\Phi,$$
vamos determinar $\mathbf{H}$ em $P_2(0.4, 0.3, 0)$ no campo de uma corrente filamentar de 8 A direcionada do infinito para a origem ao longo do eixo $x$ positivo, e depois da origem para o infinito ao longo do eixo $y$.

Vamos determinar o vetor campo magnético $\mathbf{H}$ no ponto $P_2​(0.4,0.3,0)$ causado por uma corrente filamentar de $8~A$ conforme descrito.

Em que:

- I é a corrente $(8 A)$.
-  $\rho$ é a distância perpendicular do ponto de observação até o fio corrente.
-  $\alpha_1$ e $\alpha_2$ são os ângulos limites do fio corrente em relação ao ponto de observação.

"""

# ╔═╡ 3fe5b7ef-83c6-42dd-bd1b-775e5aec65ab
let
   
# Dados fornecidos
I = 8.0  # Corrente em Amperes
x = 0.3  # Coordenada x do ponto P2 em metros
y = 0.4  # Coordenada y do ponto P2 em metros

# Ângulos para o eixo x
α_1x = deg2rad(-90.0)
α_2x = atan(y / x)  # tan⁻¹(y/x) em radianos

# Ângulos para o eixo y
α_1y = -atan(x / y)  # -tan⁻¹(x/y) em radianos
α_2y = deg2rad(90.0)

# Cálculo do campo magnético para o eixo x
H_x = (I / (4 * π * x)) * (sin(α_2x) - sin(α_1x))

# Cálculo do campo magnético para o eixo y
H_y = (I / (4 * π * y)) * (sin(α_2y) - sin(α_1y))

# Soma dos campos magnéticos
H_total = H_x + H_y

# Impressão dos resultados
@printf("Campo magnético devido ao eixo x (H_x): %.2f/π A/m\n", π * H_x) 
@printf("Campo magnético devido ao eixo y (H_y): %.2f/π A/m\n", π * H_y)
@printf("Campo magnético total (H_total): %.2f/π A/m\n", π * H_total)

# Também mostrando os valores sem a função de π
@printf("\nCampo magnético devido ao eixo x (H_x): %.2f A/m\n", H_x)
@printf("Campo magnético devido ao eixo y (H_y): %.2f A/m\n", H_y)
@printf("Campo magnético total (H_total): %.2f A/m\n", H_total)
@printf("Campo magnético total em termos de vetor unitário (a_z): -%.2f a_z A/m\n", H_total)
end

# ╔═╡ 492c8977-adb5-422c-8b5b-52ddc01a3ad2
md"""
## Exercício 7.1

**Exercício 7.1** -- a) Calcule $\mathbf{H}$ em componentes cartesianos em $P(2, 3, 4)$ se existe um filamento de corrente no eixo $z$ no qual circulam $8~\text{mA}$ na direção $\mathbf{a_z}$. b) Repita se o filamento está posicionado em $x = −1, y = 2$. c) Calcule $\mathbf{H}$ se ambos os filamentos estão presentes.

"""

# ╔═╡ d1830861-897d-4945-8021-c03608215949
md"""
**Parte a)** Para calcular o campo magnético $\mathbf{H}$ no ponto $P(2,3,4)$ devido a um filamento de corrente no eixo $z$ com corrente $\textit{I}$ = $8$ m$A$ na direção $\mathbf{a_z}$​ usamos:

$$\mathbf{H} = \frac{I}{2\pi\rho} \mathbf{a}_\phi$$
"""

# ╔═╡ e7b244ee-849c-42da-92d0-f4490d93ad20
let

# Função para calcular H devido a um filamento de corrente
function calculate_H(I, x, y, x0, y0)
    ρ = sqrt((x - x0)^2 + (y - y0)^2)
    a_phi_x = -(y - y0) / ρ
    a_phi_y = (x - x0) / ρ
    H_magnitude = I / (2 * π * ρ)
    H_x = H_magnitude * a_phi_x
    H_y = H_magnitude * a_phi_y
    return H_x, H_y
end

# Dados fornecidos
I = 8.0e-3  # Corrente em Amperes
x = 2.0  # Coordenada x do ponto P em metros
y = 3.0  # Coordenada y do ponto P em metros

# Parte (a) - Filamento no eixo z
H_x_a, H_y_a = calculate_H(I, x, y, 0.0, 0.0)

# Impressão dos resultados com conversão direta para μA/m
@printf("Parte (a): H = %.2f ax + %.2f ay μA/m\n", (H_x_a * 1e6), (H_y_a * 1e6))
end

# ╔═╡ b5aea472-be76-4edb-9cb9-a793cd730843
md"""
**Parte b)** Agora, consideramos o filamento posicionado em $x=−1$, $y=2$:

"""

# ╔═╡ 91dd5c97-a342-479a-bce2-b9272179caf2
let

# Função para calcular H devido a um filamento de corrente
function calculate_H(I, x, y, x0, y0)
    ρ = sqrt((x - x0)^2 + (y - y0)^2)
    a_phi_x = -(y - y0) / ρ
    a_phi_y = (x - x0) / ρ
    H_magnitude = I / (2 * π * ρ)
    H_x = H_magnitude * a_phi_x
    H_y = H_magnitude * a_phi_y
    return H_x, H_y
end

# Dados fornecidos
I = 8.0e-3  # Corrente em Amperes
x = 2.0  # Coordenada x do ponto P em metros
y = 3.0  # Coordenada y do ponto P em metros


# Parte (b) - Filamento em x = -1, y = 2
H_x_b, H_y_b = calculate_H(I, x, y, -1.0, 2.0)

# Impressão dos resultados com conversão direta para μA/m
@printf("Parte (b): H = %.2f ax + %.2f ay μA/m\n", (H_x_b * 1e6), (H_y_b * 1e6))
end

# ╔═╡ db378fc6-2f47-466d-a594-baf275f93e80
md"""
**Parte c)** Somamos os campos magnéticos vetorialmente:

$$\mathbf{H}_\text{total} = \mathbf{H_a} + \mathbf{H_b}$$
"""

# ╔═╡ b385265b-f092-4831-8f38-570d7ed16523
let
# Função para calcular H devido a um filamento de corrente
function calculate_H(I, x, y, x0, y0)
    ρ = sqrt((x - x0)^2 + (y - y0)^2)
    a_phi_x = -(y - y0) / ρ
    a_phi_y = (x - x0) / ρ
    H_magnitude = I / (2 * π * ρ)
    H_x = H_magnitude * a_phi_x
    H_y = H_magnitude * a_phi_y
    return H_x, H_y
end

# Dados fornecidos
I = 8.0e-3  # Corrente em Amperes
x = 2.0  # Coordenada x do ponto P em metros
y = 3.0  # Coordenada y do ponto P em metros

# Parte (a) - Filamento no eixo z
H_x_a, H_y_a = calculate_H(I, x, y, 0.0, 0.0)
# Parte (b) - Filamento em x = -1, y = 2
H_x_b, H_y_b = calculate_H(I, x, y, -1.0, 2.0)

	
H_x_total = H_x_a + H_x_b
H_y_total = H_y_a + H_y_b

# Impressão dos resultados com conversão direta para μA/m
@printf "Parte (c): H = %.2f ax + %.2f ay μA/m\n" (H_x_total * 1e6) (H_y_total * 1e6)
end

# ╔═╡ 74598c23-bfc8-45b6-92fe-19d8be7e57e7
md"""
## Exercício 7.9

**Exercício 7.9** -- Uma lâmina de corrente $\mathbf{K} = 8\mathbf{a_x}~\text{A/m}$ flui na região $−2 < y < 2$ no plano $z = 0$. Calcule $\mathbf{H}$ em $P(0, 0, 3)$.

Para calcular o campo magnético $\mathbf{H}$ no ponto $P(0, 0, 3)$ devido a uma lâmina de corrente $\mathbf{K} = 8\mathbf{a_x}~\text{A/m}$ podemos usar a seguinte expressão:

$$\mathbf{H(r)} = \frac{1}{4\pi} \int_{S} \frac{\mathbf{K} \times (\mathbf{r} - \mathbf{r}')}{|\mathbf{r} - \mathbf{r}'|^3} dS'$$

Em que:

-  $\mathbf{H(r)}$ é o vetor potencial magnético no ponto $r$.
-  $\mathbf{K}$ é a densidade de corrente superficial sobre a superfície $S$.
-  $\mathbf{r}$ e $\mathbf{r}$´ são vetores posição.
-  $dS´$ é o elemento diferencial de área sobre a superfície $S$.
"""

# ╔═╡ 2be9fb53-d309-4a5c-abfb-f0e9203e06cf
let

# Função para calcular a integral interna
function integrando_interno(x, y)
    return -24 / (x^2 + y^2 + 9)^(3/2)
end

# Função para calcular a integral externa
function integrando_externo(y)
    resultado, _ = quadgk(x -> integrando_interno(x, y), -Inf, Inf)
    return resultado
end

# Cálculo da integral externa no intervalo -2 a 2
H_y, _ = quadgk(integrando_externo, -2, 2)

# Multiplicando pelo fator constante
H_y *= 1 / (4 * π)

println("H em P(0, 0, 3) = ", round(H_y, digits = 2), " A/m na direção y")
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
# ╠═709f3e2d-c0cc-4870-9937-9d13ac8fb026
# ╟─e9699e40-45f6-11ef-2c60-350b5e345713
# ╟─ba100e58-599e-41f8-b818-322d34317b58
# ╠═3fe5b7ef-83c6-42dd-bd1b-775e5aec65ab
# ╟─492c8977-adb5-422c-8b5b-52ddc01a3ad2
# ╟─d1830861-897d-4945-8021-c03608215949
# ╠═e7b244ee-849c-42da-92d0-f4490d93ad20
# ╟─b5aea472-be76-4edb-9cb9-a793cd730843
# ╠═91dd5c97-a342-479a-bce2-b9272179caf2
# ╟─db378fc6-2f47-466d-a594-baf275f93e80
# ╠═b385265b-f092-4831-8f38-570d7ed16523
# ╟─74598c23-bfc8-45b6-92fe-19d8be7e57e7
# ╠═2be9fb53-d309-4a5c-abfb-f0e9203e06cf
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
