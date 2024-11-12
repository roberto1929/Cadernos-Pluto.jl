### A Pluto.jl notebook ###
# v0.20.0

using Markdown
using InteractiveUtils

# ╔═╡ f62c2445-831f-4ca7-b0db-003fcd4dfbce
using Printf

# ╔═╡ 33f4d32c-5037-11ef-3c4d-2b2f6584c02c
md"""
# Exercícios em Julia: Onda Plana Uniforme

Instituto Federal de Santa Catarina

Engenharia de Telecomunicações

Autor: Roberto da Silva Espindola

Este caderno contém exercícios de eletromagnetismo utilizando a linguagem de programação Julia. Ele se baseia no livro "Eletromagnetismo" de William Hayt. 

No decorrer do caderno, abordaremos os seguintes tópicos:

- Exemplo - 11.1
- Exemplo - 11.2
- Exemplo - 11.3
- Exemplo - 11.4
- Exemplo - 11.5

![Julia symbol](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Julia_Programming_Language_Logo.svg/512px-Julia_Programming_Language_Logo.svg.png)


"""


# ╔═╡ 03e41c29-7884-4ad9-90ce-e59437175726
md"""
## Exemplo  EP 11.1
A amplitude do campo elétrico de uma onda plana uniforme propagando-se na direção $\mathbf{a_z}~ é ~ 250~\text{V/m}$. Se $\mathbf{E} = E_x\mathbf{a_x}$ e $\omega = 1{,}00~\text{Mrad/s}$, calcule: $(a)$ a frequência; $(b)$ o comprimento de onda; $(c)$ o período; $(d)$ a amplitude de $\mathbf{H}$.

**Fórmulas usadas:**

(a) Cálculo da frequência:

$f = \frac{\omega}{2\pi}$

(b) Cálculo do comprimento de Onda:

$\lambda = \frac{c}{f}$

(c) Cálculo do período

$T = \frac{1}{f}$

(d) Cálculo da Amplitude do campo magnético:

$H_0 = \frac{E_0}{Z_0}$
"""

# ╔═╡ c3392220-2396-4019-80c3-1df9242eb3f6
let

# Definir constantes
E0 = 250               # Amplitude do campo elétrico (V/m)
omega = 1.00e6         # Frequência angular (rad/s)
c = 3e8                # Velocidade da luz no vácuo (m/s)
Z0 = 377               # Impedância característica do vácuo (Ω)

# Calcular a frequência (f)
frequencia = omega / (2 * π)

# Calcular o comprimento de onda (λ)
comprimento_de_onda = c / frequencia

# Calcular o período (T)
periodo = 1 / frequencia

# Calcular a amplitude de H (H0)
amplitude_de_H = E0 / Z0

# Imprimir os resultados formatados
@printf("Frequência (f): %.2f kHz\n", frequencia / 1e3)
@printf("Comprimento de onda (λ): %.2f km\n", comprimento_de_onda / 1e3)
@printf("Período (T): %.2f μs\n", periodo / 1e-6)
@printf("Amplitude de H (H0): %.3f A/m\n", amplitude_de_H)

end

# ╔═╡ f430e20c-d173-4c0f-88bd-b95714264290
md""" ## Exemplo EP 11.2

Seja $\mathbf{H_s} = (2\enclose{phasorangle}{−40°}\mathbf{a_x} − 3\enclose{phasorangle}{20°} \mathbf{a_y})e^{−j0,07z} \text{A/m}$ para uma onda plana uniforme que se propaga no espaço livre. Calcule: $(a)~\omega$; $(b)~H_x$ em $P(1, 2, 3)$ em $t = 31~\text{ns}$; $(c)$ |$\mathbf{H}$| em $t = 0$ na origem.

**Fórmulas usadas:**

(a) Cálculo de frequência angular:

$\omega = \beta \cdot c$

(b) Cálculo de $H_x(z,t)$ em $P(1,2,3)$ no tempo $t = 31~\text{ns}$:

$H_x(z,t) = H_\text{x,amplitude} \cdot \cos(\omega t - \beta z + \theta_\text{Hx})$

(c) Cálculo de $|\mathbf{H}|$ na origem $z = 0$ e $t = 0$:

$|\mathbf{H}| = \sqrt{H_x^2 + H_y^2}$

"""

# ╔═╡ 2c7c1ff4-bd7f-4928-8ab1-9d82ec6c72cb
let 

# Definir constantes
beta = 0.07  # Constante de defasamento (rad/m)
c = 3e8  # Velocidade da luz (m/s)
t = 31e-9  # Tempo (s)
z = 3  # Posição z (m)
Hx_amplitude = 2  # Amplitude de Hx
Hy_amplitude = -3  # Amplitude de Hy
theta_Hx = -40 * (π / 180)  # Fase de Hx em radianos
theta_Hy = 20 * (π / 180)  # Fase de Hy em radianos

# (a) Calcular ω
omega = beta * c

# (b) Calcular Hx em P(1, 2, 3) em t = 31 ns
omega_t = omega * t
Hx = Hx_amplitude * cos(omega_t - beta * z + theta_Hx)
Hy = Hy_amplitude * cos(omega_t - beta * z + theta_Hy)
Hx_at_P = Hx

# (c) Calcular |H| em t = 0 na origem
Hx_origin = Hx_amplitude * cos(theta_Hx)
Hy_origin = Hy_amplitude * cos(theta_Hy)
H_magnitude_origin = sqrt(Hx_origin^2 + Hy_origin^2)

# Imprimir os resultados
@printf("(a) ω: %.2e rad/s\n", omega)
@printf("(b) Hx em P(1, 2, %g) em t = 31 ns: %.3f A/m\n", z,Hx_at_P)
@printf("(c) |H| em t = 0 na origem: %.2f A/m\n", H_magnitude_origin)

end

# ╔═╡ 7078988b-fcc9-4dc0-998f-1504b9a54095
md""" ## Exemplo EP 11.3
Uma onda plana uniforme de $9,375 \text{GHz}$ está se propagando no polietileno (ver Apêndice C). Se a amplitude da intensidade de campo elétrico é 500 V/m e considerase um material sem perdas, calcule: $(a)$ a constante de defasamento; $(b)$ o comprimento de onda no polietileno; $(c)$ a velocidade de propagação; $(d)$ a impedância intrínseca; $(e)$ a amplitude da intensidade de campo magnético.

**Fórmulas usadas:**

Do Apêndice C, sabemos que a permissividade relativa do polietileno:

![Apêndide C](https://i.imgur.com/GGOQR8i.png)

![Polietileno](https://i.imgur.com/kKdx4S6.png)

(a) Constante de defasamento:
A constante de defasamento é dada por:

$\beta = \frac{\omega}{v_p}$

Em que:

-  $\omega = 2\pi f$
-  $v_p$ é a velocidade de propagação

(b) Comprimento de onda:

O comprimento de onda no polietileno é dado por:

$\lambda = \frac{v_p}{f}$

(c) Velocidade de propagação:

A velocidade de propagação no polietileno é:

$v_p = \frac{c}{\sqrt{\epsilon_r}}$

(d) Impedância intrínseca:

A impedância intrínseca do polietileno é dada por:

$\eta = \eta_0 \sqrt{\frac{\mu_r}{\epsilon_r}}$

Para um material não magnético: $(\mu_r = 1)$

(e) Amplitude da intensidade de campo magnético:

A relação entre o campo elétrico e o campo magnético em uma onda plana é:

$H_0 = \frac{E_0}{\eta}$

"""

# ╔═╡ 802cf333-5c5f-4c16-b854-d0ece8dab3e5
let

# Definir constantes
frequencia = 9.375e9  # Frequência em Hz
E0 = 500  # Amplitude do campo elétrico em V/m
epsilon_r = 2.26  # Permissividade relativa do polietileno
c = 3e8  # Velocidade da luz no vácuo em m/s
mu_r = 1  # Permeabilidade relativa (assumindo material não magnético)
eta_0 = 377  # Impedância intrínseca do vácuo em ohms

# Calcular a velocidade de propagação vp
vp = c / sqrt(epsilon_r)

# Calcular a frequência angular ω
omega = 2 * π * frequencia

# Calcular a constante de defasamento β
beta = omega / vp

# Calcular o comprimento de onda λ
lambda = vp / frequencia

# Calcular a impedância intrínseca η
eta = eta_0 * sqrt(1 / epsilon_r)

# Calcular a amplitude da intensidade de campo magnético H0
H0 = E0 / eta

# Imprimir os resultados
@printf("(a) Constante de defasamento (β): %.2f rad/m\n", beta)
@printf("(b) Comprimento de onda (λ): %.2e m\n", lambda)
@printf("(c) Velocidade de propagação (v_p): %.2e m/s\n", vp)
@printf("(d) Impedância intrínseca (η): %.2f Ω\n", eta)
@printf("(e) Amplitude da intensidade de campo magnético (H0): %.2f A/m\n", H0)

end

# ╔═╡ 0bb86f86-a20c-443b-bb64-bd8cbcbaadbc
md""" ## Exemplo EP 11.4
Dado um material não magnético que possui $\epsilon'_r = 3,2$ e $\sigma = 1,5~\times~ 10^{-4}~\text{S/m}$, calcule valores numéricos a $3~\text{MHz}$ para: $(a)$ a tangente de perdas; $(b)$ a constante de atenuação; $(c)$ a constante de defasamento; $(d)$ a impedância intrínseca.

(a) Tangente de perdas:

$\tan(\delta) = \frac{\sigma}{\omega\epsilon_0\epsilon'_r}$

(b) Constante de atenuação:

$\alpha = \omega \sqrt{\frac{\mu \epsilon'_r }{2}} \left[
\sqrt{1 + \left(\dfrac{\sigma}{\omega \epsilon_0 \epsilon'_r}\right)^2} - 1\right]
^\frac{1}{2}$

(c) Constante de defasamento:

$\beta = \omega \sqrt{\frac{\mu \epsilon'_r }{2}} \left[
\sqrt{1 + \left(\dfrac{\sigma}{\omega \epsilon_0 \epsilon'_r}\right)^2} + 1\right]
^\frac{1}{2}$


(d) Impedância intrínseca:

$\eta = \sqrt{\frac{j\omega \mu}{\sigma + j\omega \epsilon_0 \epsilon'_r}}$

"""

# ╔═╡ 8ac744fc-80c2-4952-b337-56b052416fb3
let

# Definir constantes
epsilon_r_prime = 3.2  # Permissividade relativa
sigma = 1.5e-4  # Condutividade em S/m
frequencia = 3e6  # Frequência em Hz
epsilon_0 = 8.854e-12  # Permissividade do vácuo em F/m
mu_0 = 1.2566e-6  # Permeabilidade do vácuo em H/m
mu_r = 1  # Permeabilidade relativa

# Calcular a frequência angular ω
omega = 2 * π * frequencia

# Calcular a tangente de perdas
tan_delta = sigma / (omega * epsilon_0 * epsilon_r_prime)

# Calcular a constante de atenuação α
alpha = omega * sqrt((mu_0 * mu_r * epsilon_0 * epsilon_r_prime) / 2) * sqrt(sqrt(1 + (sigma / (omega * epsilon_0 * epsilon_r_prime))^2) - 1)

# Calcular a constante de defasamento β
beta = omega * sqrt((mu_0 * mu_r * epsilon_0 * epsilon_r_prime) / 2) * sqrt(sqrt(1 + (sigma / (omega * epsilon_0 * epsilon_r_prime))^2) + 1)

# Calcular a impedância intrínseca η
eta = sqrt((im * omega * mu_0 * mu_r) / (sigma + im * omega * epsilon_0 * epsilon_r_prime))

# Imprimir os resultados
@printf("(a) Tangente de perdas (tan(δ)): %.2f\n", tan_delta)
@printf("(b) Constante de atenuação (α): %.3f Np/m\n", alpha)
@printf("(c) Constante de defasamento (β): %.2f rad/m\n", beta)
@printf("(d) Impedância intrínseca (η): %.1f ∠%.1f° Ω\n", abs(eta), angle(eta) * 180 / π)

end

# ╔═╡ 71c52da0-84b6-4a49-8e8b-4d024637f77c
md""" ## Exemplo EP 11.5
Considere um material para o qual $\mu_r = 1, \epsilon'_r = 2,5$ e a tangente de perdas seja $0,12.$ Se esses três valores são constantes com a frequência na faixa de $0,5~\text{MHz} \leq f \leq 100~\text{MHz}$, calcule: $(a)~\sigma$ em $1$ e $75~\text{MHz};$ $(b)~\lambda$ em $1$ e $75~\text{MHz};$ $(c)~v_p$ em $1$ e $75~\text{MHz}.$


Foram usadas para este problema as seguintes relações:

(a) Tangente de perdas:

$\tan(\delta) = \frac{\sigma}{\omega\epsilon_0\epsilon'_r},$

em que: 
-  $\sigma$ é a consutividade.
-  $\omega$ é a frequência angular, $\omega = 2\pi f.$
-  $\epsilon_0$ é a permissividade do vácuo $(\epsilon_0 \approx 8,854\times 10^{−12}~ \text{F/m)}.$
-  $\epsilon'_r$ é a permissividade relativa do material.

 Cálculo da condutividade ($\sigma$):

Para $f=1 \text{MHz}~\text{e}~f=75 \text{MHz}:$

$\sigma = \tan(\delta) \cdot \omega \cdot \epsilon_0 \cdot \epsilon'_r$

(b) Comprimento de onda:

$\lambda = \frac{v_p}{f},$

em que:
-  $v_p$ é a velocidade de fase.

Cálculo do comprimento de onda:

$\lambda = \frac{v_p}{f} = \frac{c}{f \cdot \sqrt{\epsilon'_r}}$

(c) Velocidade de fase:

$v_p = \frac{c}{\sqrt{\epsilon'_r}},$

em que: 
-  $c$ é a velocidade da luz no vácuo $(c \approx 3\times 10^8~\text{m/s}.)$
-  $\epsilon'_r$ é a permissividade relativa do material.

Cálculo da velocidade de fase:

$v_p = \frac{c}{\sqrt{\epsilon'_r}}$
"""

# ╔═╡ 8409342f-971a-437b-8cfe-dcbb667e79a8
let

# Definir constantes
epsilon_r_prime = 2.5  # Permissividade relativa do material
mu_r = 1.0  # Permeabilidade relativa do material
tan_delta = 0.12  # Tangente de perdas
epsilon_0 = 8.854e-12  # Permissividade do vácuo em F/m
c = 3e8  # Velocidade da luz no vácuo em m/s

# Frequências em Hz
f1 = 1e6  # 1 MHz
f2 = 75e6  # 75 MHz

# Cálculo da condutividade σ para f1
omega1 = 2 * π * f1
sigma1 = tan_delta * omega1 * epsilon_0 * epsilon_r_prime

# Cálculo da condutividade σ para f2
omega2 = 2 * π * f2
sigma2 = tan_delta * omega2 * epsilon_0 * epsilon_r_prime

# Cálculo do comprimento de onda λ para f1
vp1 = c / sqrt(epsilon_r_prime)
lambda1 = vp1 / f1

# Cálculo do comprimento de onda λ para f2
vp2 = c / sqrt(epsilon_r_prime)
lambda2 = vp2 / f2

# Cálculo da velocidade de fase vp (que é a mesma para as duas frequências)
vp = c / sqrt(epsilon_r_prime)

# Imprimir os resultados
@printf("(a) Condutividade σ em %g MHz: %.3e S/m\n", f1/1e6,sigma1)
@printf("    Condutividade σ em %g MHz: %.3e S/m\n", f2/1e6,sigma2)
@printf("(b) Comprimento de onda λ em %g MHz: %.3e m\n", f1/1e6,lambda1)
@printf("    Comprimento de onda λ em %g MHz: %.3e m\n", f2/1e6,lambda2)
@printf("(c) Velocidade de fase v_p: %.3e m/s\n", vp)

end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "f604830d70fa58877def5710c5d1fa32dcb3f998"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"
"""

# ╔═╡ Cell order:
# ╠═f62c2445-831f-4ca7-b0db-003fcd4dfbce
# ╟─33f4d32c-5037-11ef-3c4d-2b2f6584c02c
# ╟─03e41c29-7884-4ad9-90ce-e59437175726
# ╠═c3392220-2396-4019-80c3-1df9242eb3f6
# ╟─f430e20c-d173-4c0f-88bd-b95714264290
# ╠═2c7c1ff4-bd7f-4928-8ab1-9d82ec6c72cb
# ╟─7078988b-fcc9-4dc0-998f-1504b9a54095
# ╠═802cf333-5c5f-4c16-b854-d0ece8dab3e5
# ╟─0bb86f86-a20c-443b-bb64-bd8cbcbaadbc
# ╠═8ac744fc-80c2-4952-b337-56b052416fb3
# ╟─71c52da0-84b6-4a49-8e8b-4d024637f77c
# ╠═8409342f-971a-437b-8cfe-dcbb667e79a8
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
