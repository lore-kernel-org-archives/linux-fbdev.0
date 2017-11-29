From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 29 Nov 2017 11:28:54 +0000
Subject: Re: [PATCH v2 1/4] backlight: as3711_bl: fix device-tree node lookup
Message-Id: <20171129112854.c2niizszlo4u2uq2@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171120104547.2639-1-johan@kernel.org>
 <20171120104547.2639-2-johan@kernel.org>
In-Reply-To: <20171120104547.2639-2-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Johan Hovold <johan@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, stable <stable@vger.kernel.org>, linux-fbdev@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Mon, 20 Nov 2017, Johan Hovold wrote:

> Fix child-node lookup during probe, which ended up searching the whole
> device tree depth-first starting at the parent rather than just matching
> on its children.
>=20
> To make things worse, the parent mfd node was also prematurely freed.
>=20
> Fixes: 59eb2b5e57ea ("drivers/video/backlight/as3711_bl.c: add OF support=
")
> Cc: stable <stable@vger.kernel.org>     # 3.10
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/video/backlight/as3711_bl.c | 33 +++++++++++++++++++++++--------=
--
>  1 file changed, 23 insertions(+), 10 deletions(-)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
