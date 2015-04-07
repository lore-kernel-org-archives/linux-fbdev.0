From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 07 Apr 2015 13:25:08 +0000
Subject: Re: [PATCH] fbdev: sh_mobile_lcdc: Fix destruction of uninitialized mutex
Message-Id: <5523DAB4.5060301@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lPhe14haAswflRiwOFEfeMUr03CtfSp6j"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1428065428-25473-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1428065428-25473-1-git-send-email-geert+renesas@glider.be>
To: linux-fbdev@vger.kernel.org

--lPhe14haAswflRiwOFEfeMUr03CtfSp6j
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03/04/15 15:50, Geert Uytterhoeven wrote:
> If sh_mobile_lcdc_probe() fails after the allocation of driver-private
> data, but before the initialization of all channels, a warning will be
> printed due to the destruction of an uninitialized mutex:
>=20
>     WARNING: CPU: 0 PID: 1 at kernel/locking/mutex-debug.c:116 mutex_de=
stroy+0x5c/0x7c()
>     DEBUG_LOCKS_WARN_ON(mutex_is_locked(lock))
>     ...
>     Backtrace:
>     ...
>     [<c00425b4>] (mutex_destroy) from [<c01d5858>] (sh_mobile_lcdc_remo=
ve+0x1bc/0x230)
>      r4:df6a4800 r3:00000000
>     [<c01d569c>] (sh_mobile_lcdc_remove) from [<c01d6620>] (sh_mobile_l=
cdc_probe+0xd54/0xe28)
>=20
> Move the initialization of the mutexes from sh_mobile_lcdc_channel_init=
()
> to immediately after the allocation of driver-private data to fix this.=

>=20
> Note that the interrupt number is moved to a new variable "irq", so we
> can reuse the existing variable "i" for iterating over the channels.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Thanks, queued for 4.1.

 Tomi



--lPhe14haAswflRiwOFEfeMUr03CtfSp6j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJVI9q3AAoJEPo9qoy8lh71EhYQAIPWzPBJWnEezoVnoBw/hUIf
UJWybMn3+9H5BppVLWPNao6ATtqO1f+R1ARPmCDpbX5tR9QbjugBsF0kSS0XqJDa
oVoUBqXaCq8AzDx0jm8XL20fsyHJginPq0GhEvxVHhbqMxM9WwuK67/IY2hRv1MF
EkDXQUyq47vWNJhsNyJYxoLLnDZoG2hhKjjJM+CmWovFfcODU75gVEkKKmogigQR
mXC7zAjdi6O4i7OH1YB3sm0r5WcX+souUgpdlEmeTPjeaZdQTIwg7+HPsmrkMxaR
LPsfFi0HumON3ICx3wvh85jUEHAduekTCt91ab5vDiFpZrpUbXmYOt67T8f0whGj
a9bqkMbIh7vPGH9XfZyQ4kNI2wZcrJAbpwwJDLtXZLbYYDP/Kp8gdt7ZQO5T0rMO
kxTmJzTqRnz8EBCKEtzH013io/+53DKxqT33JCdz6po3RdGVIFxG9WjRbUEqzhpg
Hme+TrIdY08jxnljWNyaYECgTNmAjRGNSlySCdUNKPeYFKSozWfeLXREzn/Jiz1L
advKO8Dm1PUtl7XLopLRilZNSOXWL/5xWBMGBea7qeN5LU9Qdgvb4XeUWWH8/82w
TNU01uhdCn7ZIMc44vCqn+1U8/L37pw7gG8P+YzfX670KhOg/gpPxw1a18Ievy71
wCu3Lx1heanUs6np2EGJ
=9RtR
-----END PGP SIGNATURE-----

--lPhe14haAswflRiwOFEfeMUr03CtfSp6j--
