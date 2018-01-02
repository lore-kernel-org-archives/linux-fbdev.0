From: Lee Jones <lee.jones@linaro.org>
Date: Tue, 02 Jan 2018 15:38:41 +0000
Subject: Re: [PATCH v3] backlight: tdo24m: fix the spi cs between transfers
Message-Id: <20180102153841.vhzll4gcwuoemk3l@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171228082742.13415-1-robert.jarzmik@free.fr>
In-Reply-To: <20171228082742.13415-1-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On Thu, 28 Dec 2017, Robert Jarzmik wrote:

> Currently the LCD display (TD035S) on the cm-x300 platform is broken and
> remains blank.
>=20
> The TD0245S specification requires that the chipselect is toggled
> between commands sent to the panel. This was also the purpose of the
> former patch of commit f64dcac0b124 ("backlight: tdo24m: ensure chip
> select changes between transfers").
>=20
> Unfortunately, the "cs_change" field of a SPI transfer is
> misleading. Its true meaning is that for a SPI message holding multiple
> transfers, the chip select is toggled between each transfer, but for the
> last transfer it remains asserted.
>=20
> In this driver, all the SPI messages contain exactly one transfer, which
> means that each transfer is the last of its message, and as a
> consequence the chip select is never toggled.
>=20
> Actually, there was a second bug hidding the first one, hence the
> problem was not seen until v4.6. This problem was fixed by commit
> a52db659c79c ("spi: pxa2xx: Fix cs_change management") for PXA based
> boards.
>=20
> This fix makes the TD035S work again on a cm-x300 board. The same
> applies to other PXA boards, ie. corgi and tosa.
>=20
> Fixes: a52db659c79c ("spi: pxa2xx: Fix cs_change management")

Since this fixes an old kernel, I'm not going to apply it for -fixes.

> Reported-by: Andrea Adami <andrea.adami@gmail.com>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> Since v1: added 2 other panels
> Since v2: added Daniel's ack
> ---
>  drivers/video/backlight/corgi_lcd.c | 2 +-
>  drivers/video/backlight/tdo24m.c    | 2 +-
>  drivers/video/backlight/tosa_lcd.c  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Applied to -next, thanks.

--=20
Lee Jones
Linaro Services Technical Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
