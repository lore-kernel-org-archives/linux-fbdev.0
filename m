From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 29 Nov 2017 11:29:13 +0000
Subject: Re: [PATCH v2 3/4] backlight: tps65217_bl: fix device-tree node lookup
Message-Id: <20171129112913.i6vf5skpkroisbbh@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171120104547.2639-1-johan@kernel.org>
 <20171120104547.2639-4-johan@kernel.org>
In-Reply-To: <20171120104547.2639-4-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Johan Hovold <johan@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>, Matthias Kaehlcke <matthias@kaehlcke.net>

On Mon, 20 Nov 2017, Johan Hovold wrote:

> Fix child-node lookup during probe, which ended up searching the whole
> device tree depth-first starting at the parent rather than just matching
> on its children.
>=20
> This would only cause trouble if the child node is missing while there
> is an unrelated node named "backlight" elsewhere in the tree.
>=20
> Fixes: eebfdc17cc6c ("backlight: Add TPS65217 WLED driver")
> Cc: stable <stable@vger.kernel.org>     # 3.7
> Cc: Matthias Kaehlcke <matthias@kaehlcke.net>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/video/backlight/tps65217_bl.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
