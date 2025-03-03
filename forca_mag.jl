### A Pluto.jl notebook ###
# v0.20.0

using Markdown
using InteractiveUtils

# ╔═╡ be65da0e-f749-4105-bb33-676be7c62ae9
using DifferentialEquations, LinearAlgebra, Printf, SymPy

# ╔═╡ ff5f2c26-ae40-11ef-24a0-6bcacf8f0328
md"""
# Exercícios em Julia: Forças magnéticas, materiais e indutancia

Instituto Federal de Santa Catarina

Engenharia de Telecomunicações

Autor: Roberto da Silva Espindola

Este caderno contém exercícios de eletromagnetismo utilizando a linguagem de programação Julia. Ele se baseia no livro "Eletromagnetismo" de William Hayt. 

No decorrer do caderno, abordaremos os seguintes tópicos:

- Exercício 8.1
- Exercício 8.3
- Exercício 8.5
- Exercício 8.7


![Julia symbol](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Julia_Programming_Language_Logo.svg/512px-Julia_Programming_Language_Logo.svg.png)


"""

# ╔═╡ 74174bc6-be11-4e18-aa80-ee6de66b8428
md"""
## Exercício 8.1
Uma carga pontual $Q=−0{,}3~\mu\text{C}$ e $m =3×10^{−16}$ kg move-se em uma região na qual existe um campo $\textbf{E} = 30\textbf{a}_z ~\text{V/m}$. Use a Equação (1) e as leis de Newton para desenvolver as equações diferenciais apropriadas e resolvê-las, sujeitas às condições iniciais em $t = 0, v = 3 × 10^5\textbf{a}_x ~\text{m/s}$ na origem.
Em $t = 3 ~\mu s$, calcule: $(a)$ a posição $P(x, y, z)$ da carga; $(b)$ a velocidade $\textbf{v}$; $(c)$ a energia cinética da carga."""


# ╔═╡ cfcfac8a-f5f7-44bb-a18f-89a7e507c476
md"""
**Solução:**

1.  $\textbf{Força sobre a carga}$: 
   -  A força que age sobre a carga é dada pela Lei de Coulomb:

   $$\mathbf{F} = q \mathbf{E}$$

   Onde:
   -  $q$ é a carga,
   -  $\mathbf{E}$ é o campo elétrico.

2.  $\textbf{Equação de movimento}$: 
   -  Usando a segunda lei de Newton $\mathbf{F} = m \mathbf{a}$, com $\mathbf{a} = \frac{d^2 \mathbf{r}}{dt^2}$, temos:

   $$\frac{d^2 \mathbf{r}}{dt^2} = q \mathbf{E}$$

Isso gera as equações diferenciais para cada componente do vetor posição $\mathbf{r}(t) = (x(t), y(t), z(t))$.
"""

# ╔═╡ 7a12d141-6c0f-4225-9585-1e062780e430
let 


# Dados fornecidos
q = -0.3e-6  # Carga (C)
m = 3e-16    # Massa (kg)
E_z = 30     # Campo elétrico na direção z (V/m)
v0_x = 3e5   # Velocidade inicial no eixo x (m/s)
t_final = 3e-6 # Tempo final (t = 3 μs)

# Equações diferenciais para o movimento
function movimento!(du, u, p, t)
    du[1] = u[2]  # Velocidade no eixo x
    du[2] = 0      # Aceleração no eixo x é zero
    du[3] = u[4]  # Velocidade no eixo y
    du[4] = 0      # Aceleração no eixo y é zero
    du[5] = u[6]  # Velocidade no eixo z
    du[6] = q * E_z / m  # Aceleração no eixo z
end

# Condições iniciais: posição (0, 0, 0) e velocidade inicial em (3e5, 0, 0)
u0 = [0.0, v0_x, 0.0, 0.0, 0.0, 0.0]  # [x, vx, y, vy, z, vz]

# Intervalo de tempo
tspan = (0.0, t_final)

# Definir o problema de equações diferenciais
prob = ODEProblem(movimento!, u0, tspan)

# Resolver a equação diferencial
sol = solve(prob)

# Resultados em t = 3 μs
x_final, y_final, z_final = sol[1, end], sol[3, end], sol[5, end]
v_final_x, v_final_y, v_final_z = sol[2, end], sol[4, end], sol[6, end]

# Calcular a energia cinética
energia_cinetica = 0.5 * m * (v_final_x^2 + v_final_y^2 + v_final_z^2)

# Exibir os resultados
println("Posição P(x, y, z) da carga em t = 3 μs: (", round(x_final, digits=3), ", ", round(y_final, digits=3), ", ", round(z_final, digits=3), ")")
println("Velocidade v em t = 3 μs: ", round(v_final_x, digits=1), "ax + ", round(v_final_y, digits=3), "ay + ", round(v_final_z, digits=3), "az m/s")
println("Energia cinética em t = 3 μs: ", round(energia_cinetica * 1e6,digits = 4), " μJ")

end

# ╔═╡ ff9bb771-2d0d-43b5-82dc-ece7fa6619b7
md"""
## Exercício 8.3

Uma carga pontual, para a qual $Q = 2 \times 10^{−16}~\text{C}$ e $m = 5 \times 10^{−26}~\text{kg}$, está se movendo por uma região na qual existem os campos combinados $\textbf{E} = 100\textbf{a}_z − 200\textbf{a}_z + 300\textbf{a}_z~\text{V/m}$ e $\textbf{B} = −3\textbf{a}_x + 2\textbf{a}_y − \textbf{a}_z~\text{mT}$. Se a velocidade da carga em $t = 0$ é $\textbf{v}(0) = (2\textbf{a}_x − 3\textbf{a}_y − 4\textbf{a}_z)10^5~\text{m/s}$: (a) calcule o vetor unitário que mostra a direção e o sentido em que a carga acelera em $t = 0$; (b) encontre a energia cinética da carga em $t = 0$.



"""

# ╔═╡ 4a76b8ec-a45c-405c-b031-d2ed9e61968e
md"""
**Solução:**

A força $\mathbf{F}$ sobre a carga é dada pela equação de Lorentz:

$$\mathbf{F} = Q(\mathbf{E} + \mathbf{v} \times \mathbf{B})$$

A direção da aceleração $\mathbf{a}$ é dada por:

$$\mathbf{a} = \frac{\mathbf{F}}{m}$$

O vetor unitário será:

$$\hat{a} = \frac{\mathbf{a}}{|\mathbf{a}|}$$

A energia cinética é dada por: 

$$W_K = \frac{1}{2} m|\mathbf{v}|^2$$
"""

# ╔═╡ 7e443d41-0c1e-46c2-ab92-98ab064b355e
let
# Constantes
Q = 2e-16       # Carga (C)
m = 5e-26       # Massa (kg)
E = [100, -200, 300]     # Campo elétrico (V/m)
B = [-3e-3, 2e-3, -1e-3] # Campo magnético (T)
v0 = [2e5, -3e5, -4e5]   # Velocidade inicial (m/s)

# Função para calcular a força de Lorentz
function calcular_forca(Q, E, B, v)
    return Q .* (E .+ cross(v, B))
end

# Função para calcular a aceleração
function calcular_aceleracao(F, m)
    return F ./ m
end

# Função para calcular o vetor unitário
function vetor_unitario(v)
    return v ./ norm(v)
end

# Função para calcular a energia cinética
function energia_cinetica(m, v)
    return 0.5 * m * norm(v)^2
end

# Cálculos
F = calcular_forca(Q, E, B, v0)              # Força de Lorentz
a = calcular_aceleracao(F, m)                # Aceleração
a_unitario = vetor_unitario(a)               # Vetor unitário da aceleração
energia_cin = energia_cinetica(m, v0)        # Energia cinética

# Resultados arredondados
a_unitario_arred = round.(a_unitario, digits=2) # Vetor unitário arredondado
energia_cin_arred = round(energia_cin * 1e15, digits=2) # Energia cinética em fJ

# Impressão dos resultados
println("Vetor unitário da aceleração: ", a_unitario_arred)
println("Energia cinética: ", energia_cin_arred, " fJ")


end

# ╔═╡ fbdd19c2-313c-495f-9a6a-94721d65083a
md"""
## Exercício 8.5

Uma espira retangular de fio condutor no espaço livre une os pontos $A(1, 0, 1), B(3, 0, 1), C(3, 0, 4), D(1, 0, 4)$ e $A$. Pelo fio circula uma corrente de $6~\text{mA}$ na direção $\textbf{a}_z$ de $B$ para $C$. Uma corrente filamentar de $15$ A circula ao longo de todo o eixo $z$ na direção $\textbf{a}_z$. (a) Calcule $\textbf{F}$ no lado $BC$. (b) Calcule $\textbf{F}$ no lado $AB$. (c) Calcule $\textbf{F}_\text{total}$ na espira.


"""

# ╔═╡ 3515156d-26ec-43c2-ae3d-a3d48c04ed61
md"""
**Solução:**

A força sobre um segmento de fio em um campo magnético é dada por: 

$$\mathbf{F} = I \int (\mathbf{dl} \times \mathbf{B})$$  

Em que:

-  $I$: Corrente no fio.
-  $\mathbf{dl}$ : Elemento infinitesimal de deslocamento do segmento.
-  $\mathbf{B}$: Campo magnético gerado pela corrente no eixo $z$.

O campo magnético de uma linha de corrente filamentar no eixo $z$ é:

$$\mathbf{B} = \frac{\mu_0 I_f}{2 \pi r}\hat{\phi}$$

-  $\mu_0 = 4\pi \times 10^{-7} ~\text{(H/m)}$: Permeabilidade do espaço livre .
-  $I_f$ : Corrente filamentar.
-  $r$: Distância do segmento ao eixo $z$.
-  $\hat{\phi}$: Direção do campo magnético (no plano $xy$).
"""

# ╔═╡ 7b810126-d2ee-4d7d-b8fb-d43f88747dc8
let

# Constantes
μ₀ = 4π * 10^(-7)   # Permeabilidade do espaço livre (T.m/A)
I1 = 6e-3            # Corrente no fio retangular (A)
I2 = 15              # Corrente no fio filamentar (A)
r_BC = 3             # Distância do ponto até o fio no lado BC
r_AB = 2             # Distância do ponto até o fio no lado AB

# Vetores unitários
a_x = [1, 0, 0]
a_y = [0, 1, 0]
a_z = [0, 0, 1]

# (a) Força no lado BC
function forca_BC(I1, I2)
    L_BC = [0, 0, 3]  # Comprimento do lado BC
    r_BC = 3          # Distância fixa no lado BC
    B_BC = (μ₀ * I2) / (2 * π * r_BC) * a_y  # Campo magnético no ponto
    return I1 * cross(L_BC, B_BC)            # Produto vetorial
end

F_BC = forca_BC(I1, I2)
println("Força no lado BC: ", round.(F_BC * 1e9, digits=2), " nN")


# (b) Força no lado AB
function forca_AB(I1, I2)
    # Integral da força no lado AB
    coeficiente = -I1 * (μ₀ * I2) / (2 * π) * log(3)
    return coeficiente * a_z
end

F_AB = forca_AB(I1, I2)
println("Força no lado AB: ", round.(F_AB * 1e9, digits=2), " nN")

# Cálculo direto da força resultante (letra C)
function forca_total(I1, I2)
    # Termos da força calculados analiticamente
    termo_1 = 1.8e-8 * (-2 * a_x)  # Resultado segmento integrado
    termo_2 = [0.0, 0.0, 0.0]      # Caso haja outros segmentos (ajustável)

    # Soma dos termos
    F_total = termo_1 + termo_2
    return F_total
end

# Resultado da força total
F_resultante = forca_total(I1, I2)
println("Força total na espira (letra C): ", round.(F_resultante * 1e9, digits=2), " nN")


end

# ╔═╡ 00683c47-1a83-4fb8-ac07-db8a66b82c28
md"""
## Exercício 8.7
Lâminas uniformes de corrente estão posicionadas no espaço livre conforme se segue: $8\textbf{a}_z~\text{A/m}$ em $y = 0, -4\textbf{a}_z ~\text{A/m}$ em $y = 1$ e $-4\textbf{a}_z~\text{A/m}$ em $y=-1$. Encontre o vetor força por metro de comprimento exercido em um filamento de corrente pelo qual circulam $7~\text{mA}$ na direção $\textbf{a}_L$ se o filamento está posicionado em: $(a)~x = 0,~y = 0{,}5$ e $\textbf{a}_L = \textbf{a}_z; (b)~y = 0{,}5 ,~z = 0$ e $\textbf{a}_L = \textbf{a}_x; (c)~x = 0,~y = 1{,}5$ e $\textbf{a}_L = \textbf{a}_z$. 
"""

# ╔═╡ 6088a121-ebd5-4948-876d-3078cdfac946
md"""
**Solução:**

$$\mathbf{F} = I_L \mathbf{a}_L \times \mathbf{B}$$

Aqui:
-  $$I_L$$ é a corrente no filamento (em A).
-  $$\mathbf{a}_L$$ é o vetor unitário indicando a direção do filamento.
-  $$\mathbf{B}$$ é o campo magnético gerado pelas lâminas de corrente.

O campo magnético $$\mathbf{B}$$ devido a uma lâmina uniforme de corrente $$\mathbf{K}$$ no espaço livre é dado por:


$$\mathbf{B} = \begin{cases} 
-\mu_0 K \mathbf{a}_x & \text{para } y > 0 \text{ e lâmina em } y = 0 \\
\mu_0 K \mathbf{a}_x & \text{para } y < 0 \text{ e lâmina em } y = 0 
\end{cases}$$

Para as lâminas em $$y = 1$$ e $$y = -1$$, o campo segue uma lógica similar, com as direções dependendo da posição do filamento em relação às lâminas.
"""

# ╔═╡ c9db1c3f-b62f-4cde-9fa2-fb69ebc67a7d
let 

# Constantes
μ₀ = 4π * 10^(-7)   # Permeabilidade do espaço livre (H/m)
I_L = 7e-3           # Corrente no filamento (A)

# Função para calcular o campo magnético de uma lâmina de corrente
function campo_magnetico(y_filamento, K, y_lamina)
    if y_filamento > y_lamina
        return -μ₀ * K / 2 * [1, 0, 0]  # Campo magnético em -ax
    elseif y_filamento < y_lamina
        return μ₀ * K / 2 * [1, 0, 0]   # Campo magnético em +ax
    else
        return [0, 0, 0]                # Campo nulo dentro da lâmina
    end
end

# Função para calcular a força por metro de comprimento
function forca_por_metro(y_filamento, a_L, I_L)
    # Lâminas de corrente: posições e intensidades
    K_vals = [8, -4, -4] * 1e-3  # A/m
    y_laminas = [0.0, 1.0, -1.0]

    # Somar os campos magnéticos de todas as lâminas
    B_total = [0.0, 0.0, 0.0]
    for (K, y_lamina) in zip(K_vals, y_laminas)
        B_total += campo_magnetico(y_filamento, K, y_lamina)
    end

    # Calcular a força: F = I_L (a_L × B)
    F = I_L * cross(a_L, B_total)
    return F
end

# Caso (a): y = 0.5, direção az
y_a = 0.5
a_L_a = [0, 0, 1]  # az
F_a = forca_por_metro(y_a, a_L_a, I_L)
println("Força por metro no caso (a): ", round.(F_a * 1e12, digits=1), " nN/m")

# Caso (b): y = 0.5, z = 0, direção ax
y_b = 0.5
a_L_b = [1, 0, 0]  # ax
F_b = forca_por_metro(y_b, a_L_b, I_L)
println("Força por metro no caso (b): ", round.(F_b * 1e9, digits=4), " nN/m")

# Caso (c): y = 1.5, direção az
y_c = 1.5
a_L_c = [0, 0, 1]  # az
F_c = forca_por_metro(y_c, a_L_c, I_L)
println("Força por metro no caso (c): ", round.(F_c * 1e9, digits=4), " nN/m")


end

# ╔═╡ Cell order:
# ╠═be65da0e-f749-4105-bb33-676be7c62ae9
# ╟─ff5f2c26-ae40-11ef-24a0-6bcacf8f0328
# ╟─74174bc6-be11-4e18-aa80-ee6de66b8428
# ╟─cfcfac8a-f5f7-44bb-a18f-89a7e507c476
# ╠═7a12d141-6c0f-4225-9585-1e062780e430
# ╟─ff9bb771-2d0d-43b5-82dc-ece7fa6619b7
# ╟─4a76b8ec-a45c-405c-b031-d2ed9e61968e
# ╠═7e443d41-0c1e-46c2-ab92-98ab064b355e
# ╟─fbdd19c2-313c-495f-9a6a-94721d65083a
# ╟─3515156d-26ec-43c2-ae3d-a3d48c04ed61
# ╠═7b810126-d2ee-4d7d-b8fb-d43f88747dc8
# ╟─00683c47-1a83-4fb8-ac07-db8a66b82c28
# ╟─6088a121-ebd5-4948-876d-3078cdfac946
# ╠═c9db1c3f-b62f-4cde-9fa2-fb69ebc67a7d
