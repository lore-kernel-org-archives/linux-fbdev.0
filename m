From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 29 Nov 2017 11:29:03 +0000
Subject: Re: [PATCH v2 2/4] backlight: max8925_bl: fix device-tree node lookup
Message-Id: <20171129112903.wpyalxs4mnghiobk@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171120104547.2639-1-johan@kernel.org>
 <20171120104547.2639-3-johan@kernel.org>
In-Reply-To: <20171120104547.2639-3-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Johan Hovold <johan@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Qing Xu <qingx@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

On Mon, 20 Nov 2017, Johan Hovold wrote:

> Fix child-node lookup during probe, which ended up searching the whole
> device tree depth-first starting at the parent rather than just matching
> on its children.
>=20
> To make things worse, the parent mfd node was also prematurely freed,
> while the child backlight node was leaked.
>=20
> Fixes: 47ec340cb8e2 ("mfd: max8925: Support dt for backlight")
> Cc: stable <stable@vger.kernel.org>     # 3.9
> Cc: Qing Xu <qingx@marvell.com>
> Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/video/backlight/max8925_bl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
