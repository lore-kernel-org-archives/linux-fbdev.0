From: Thierry Reding <thierry.reding@gmail.com>
Date: Tue, 12 Apr 2016 11:01:52 +0000
Subject: Re: [PATCH v5 01/46] pwm: rcar: make use of pwm_is_enabled()
Message-Id: <20160412110152.GG18882@ulmo.ba.sec>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="JbKQpFqZXJ2T76Sg"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-2-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1459368249-13241-2-git-send-email-boris.brezillon@free-electrons.com>
To: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Lee Jones <lee.jones@linaro.org>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, Robert Jarzmik <robert.jarzmik@free.fr>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger.kernel.org, Jean-Christophe


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 30, 2016 at 10:03:24PM +0200, Boris Brezillon wrote:
> Commit 5c31252c4a86 ("pwm: Add the pwm_is_enabled() helper") introduced a
> new function to test whether a PWM device is enabled or not without
> manipulating PWM internal fields.
> Hiding this is necessary if we want to smoothly move to the atomic PWM
> config approach without impacting PWM drivers.
> Fix this driver to use pwm_is_enabled() instead of directly accessing the
> ->flags field.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  drivers/pwm/pwm-rcar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

Thierry

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXDNWfAAoJEN0jrNd/PrOhoj8QAK4UAz8ugmWPS9xJCHiJvCsZ
cz4yyDzOQVaVTNHNEruFT+v1XMvaogalyvNxUR0z8fXpRzAj9vZyGm3VXD2CJcam
/FvxqFKAodcSy5PjYSLoD/0bpeYpAiILFhxPTkKGFaR8vRnvY8HL7BWWM8ReXly+
m+bPRy/JtAMpsFfYTgNGtXV101lkn8ZIvhJSCNwDwCWHAPN1q/c+XxikTuonrKiX
p0f9SB74YUtq7gh5HE1vfrSFs2ozDXFDBfEbgTk9vfEL2O0E2gUkVF8yyLWHGUSu
lfQB/A65nYFzn8tAqd97/RzMXeHMB9u+/FI7bwfvxK+hnRys3sxaS/5knlSe+Nzc
EAnnoG0VEibaNctVC5ACumPP5eqS9ejMVYmenKiq7TyAM/3DhI4ZISsm/NUrmkke
HhWUJs8U38hUK9pVHp94i63vQzLX9MWsAHXxXuTeCgkPgkklou+87nnPpcW3PWbq
m6Bgpqijcx1OAW4ooJMpt4vls578/yFbguAGJzdm3QbB9jKMa/w4iGbuRfYiCowL
cHLWFPSIGZrX3SXVfVNqSAHIhA1Jkaj1Ipku8+mz+SI/ai5Iitcnwe9QMBX1ttIh
lQ5RaQmxpp6U0cxZno9Tb1lI7GEmxa0MaZnU2wmgcbDYleyg1Hp0W0eVVeIKcFi+
5NcgYEiaLV56dufi0Vhm
=gjRe
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--
