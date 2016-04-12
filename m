From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 12 Apr 2016 14:16:13 +0000
Subject: Re: [PATCH v5 03/46] backlight: lm3630a_bl: stop messing with the pwm->period field
Message-Id: <20160412141613.GI8094@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1459368249-13241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459368249-13241-4-git-send-email-boris.brezillon@free-electrons.com>
 <20160412110809.GI18882@ulmo.ba.sec>
In-Reply-To: <20160412110809.GI18882@ulmo.ba.sec>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Milo Kim <milo.kim@ti.com>, Kamil Debski <k.debski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, linux-doc@vger.kernel.org, David Airlie <airlied@linux.ie>, Mike Turquette <mturquette@baylibre.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Daniel Vetter <daniel.vetter@intel.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-clk@vger.kernel.org, linux-leds@vger.kernel.org, Boris Brezillon <boris.brezillon@free-electrons.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>, Jonathan Corbet <corbet@lwn.net>, lm-sensors@lm-sensors.org, linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-input@vger.kernel.

On Tue, 12 Apr 2016, Thierry Reding wrote:

> On Wed, Mar 30, 2016 at 10:03:26PM +0200, Boris Brezillon wrote:
> > pwm->period field is not supposed to be changed by PWM users. The only
> > ones authorized to change it are the PWM core and PWM drivers.
> >=20
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/video/backlight/lm3630a_bl.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> Applied, thanks.

Applied?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
