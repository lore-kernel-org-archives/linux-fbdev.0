From: Lee Jones <lee.jones@linaro.org>
Date: Mon, 28 Sep 2015 10:31:54 +0000
Subject: Re: [PATCHv3 2/3] backlight: add led-backlight driver
Message-Id: <20150928103154.GO27197@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1441976857-26548-1-git-send-email-tomi.valkeinen@ti.com>
 <1441976857-26548-3-git-send-email-tomi.valkeinen@ti.com>
 <5608F66E.8020703@ti.com>
In-Reply-To: <5608F66E.8020703@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org, linux-fbdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>

On Mon, 28 Sep 2015, Tomi Valkeinen wrote:
> > This patch adds a led-backlight driver (led_bl), which is similar to
> > pwm_bl except the driver uses a LED class driver to adjust the
> > brightness in the HW.
> >=20
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > ---
> >  drivers/video/backlight/Kconfig  |   7 ++
> >  drivers/video/backlight/Makefile |   1 +
> >  drivers/video/backlight/led_bl.c | 246 +++++++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 254 insertions(+)
> >  create mode 100644 drivers/video/backlight/led_bl.c
>=20
> Any comments on the backlight side of this series? It is very similar to
> the pwm_bl.c, so I presume the approach is acceptable?

Jingoo?

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
