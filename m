From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 29 Nov 2017 11:29:24 +0000
Subject: Re: [PATCH v2 4/4] backlight: as3711_bl: fix device-tree node leaks
Message-Id: <20171129112924.g3gbr57kjkqojkjg@dell>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20171120104547.2639-1-johan@kernel.org>
 <20171120104547.2639-5-johan@kernel.org>
In-Reply-To: <20171120104547.2639-5-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Johan Hovold <johan@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Mon, 20 Nov 2017, Johan Hovold wrote:

> Two framebuffer device-node names were looked up during probe, but were
> only used as flags to indicate the presence of two framebuffer device.
>=20
> Drop the unused framebuffer name along with a likewise unused device
> pointer from the driver data, and update the platform data to pass in
> booleans instead of the framebuffer strings. This allows us do drop the
> node references acquired during probe, which would otherwise leak.
>=20
> Note that there are no other in-kernel users of the modified
> platform-data fields.
>=20
> Fixes: 59eb2b5e57ea ("drivers/video/backlight/as3711_bl.c: add OF support=
")
> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/video/backlight/as3711_bl.c | 12 ++++++------
>  include/linux/mfd/as3711.h          |  4 ++--
>  2 files changed, 8 insertions(+), 8 deletions(-)

Applied, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
