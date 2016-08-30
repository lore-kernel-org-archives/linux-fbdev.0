From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 30 Aug 2016 08:59:53 +0000
Subject: Re: [PATCH V2] video: mxsfb: Fix framebuffer corruption on mx6sx
Message-Id: <dda1fb74-4e30-f54e-4504-63db899f0bb3@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Cq5o2EbOh3liGxA9Nc8S5EVkktHcVWQxB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20160826155335.8747-1-marex@denx.de>
In-Reply-To: <20160826155335.8747-1-marex@denx.de>
To: linux-fbdev@vger.kernel.org

--Cq5o2EbOh3liGxA9Nc8S5EVkktHcVWQxB
Content-Type: multipart/mixed; boundary="S4bAiMQSQE8u9FLjRG6HxKwQaNQokKdV0";
 protected-headers="v1"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Marek Vasut <marex@denx.de>, linux-fbdev@vger.kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>,
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Message-ID: <dda1fb74-4e30-f54e-4504-63db899f0bb3@ti.com>
Subject: Re: [PATCH V2] video: mxsfb: Fix framebuffer corruption on mx6sx
References: <20160826155335.8747-1-marex@denx.de>
In-Reply-To: <20160826155335.8747-1-marex@denx.de>

--S4bAiMQSQE8u9FLjRG6HxKwQaNQokKdV0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26/08/16 18:53, Marek Vasut wrote:
> Allocate the framebuffer memory as coherent, otherwise the framebuffer
> will suffer from artifacts when displaying scrolling text or video.
> This can be replicated on i.MX6SX (armv7), which has more complex memor=
y
> architecture compared to the i.MX23/28 (armv5).
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> ---
> V2: Switch to from dma_{alloc,free}_coherent() to dma_{alloc,free}_wc()=

>     for performance reasons, as suggested by Lucas Stach
> ---
>  drivers/video/fbdev/mxsfb.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Thanks, queued for 4.9.

 Tomi


--S4bAiMQSQE8u9FLjRG6HxKwQaNQokKdV0--

--Cq5o2EbOh3liGxA9Nc8S5EVkktHcVWQxB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxUsJAAoJEPo9qoy8lh71NKMP/3qt4arYCnKYT9YGYT+w6eVr
s8NXrztH3n+/oPYo79riwg4hJL6/sWYhwUcyWfbATUvEdrErp8YcSeyM7boavYAv
88feJUTY3Nw9FE/+mWArg4qMIIHCJ/zf300VF+E976YYADDOAxf1EjANVk4C6UWy
AEgeRaM3BBCLXuulWog7ac52Nviky9bNNQmHX8RuRjdlJPABTUKpbfItNilHh9Xu
MJYjpJx9/RMKqbzY7VVdamx1Q7oXjpFGndGsSx2q3CfXlxEACQJ2jMRJBbZe5NxG
C7HKvzhGCZUQPyzlsYNCYA2tmUepHp/nNUl9DN18H6lg8q+0PwyU4KUl9p26//ha
STlTjOK+jkzXXeV4lr2LvOFAelBIZEOjfKGSDIEN0fGLs6Kf6M6dN/PNBzUS4B07
lfHpxoVwRbvXLWrn2tfTK3HKJJzzyFooJvaoZYNKR936R4H9ctC2PtnnON7sRMb7
pqEA+0zqT+YRawONKUzX1EjT22B1HTCmND65jXFyKEOD18R1w1F2jUFjpW13XA40
EzfkYA2Wu/dpOwqb8QubRU22i1gYRX4m95jWxX0X2qEeUvaZPFAKyV0gpdu6I19R
6fVJbNSYJG9aQXo5MpfYawAsezcLZBIHukONnISRRgw1qX2SrKoojl9VW/MFw6Hu
6l0UIX/pLo/dRH0LB/QY
=U07Z
-----END PGP SIGNATURE-----

--Cq5o2EbOh3liGxA9Nc8S5EVkktHcVWQxB--
