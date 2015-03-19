From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 19 Mar 2015 13:18:24 +0000
Subject: Re: [PATCHv4 07/10] fbdev: ssd1307fb: Add a module parameter to set the refresh rate
Message-Id: <20150319131824.GB4255@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="b5gNqxB1S1yM7hjW"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1426525918-12745-1-git-send-email-niederp@physik.uni-kl.de>
 <1426525918-12745-8-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1426525918-12745-8-git-send-email-niederp@physik.uni-kl.de>
To: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2015 at 06:11:55PM +0100, Thomas Niederpr=FCm wrote:
> This patch adds the module parameter "refreshrate" to set delay for the
> deferred io. The refresh rate is given in units of Hertz. The default
> refresh rate is 1 Hz. The refresh rate set through the newly introduced
> parameter applies to all instances of the driver and for now it is not
> possible to change it individually.
>=20
> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> ---
>  drivers/video/fbdev/ssd1307fb.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd130=
7fb.c
> index 6fecec8..8a8d305 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -42,6 +42,11 @@
>  #define	SSD1307FB_SET_COM_PINS_CONFIG	0xda
>  #define	SSD1307FB_SET_VCOMH		0xdb
> =20
> +#define REFRASHRATE 1
> +
> +static u_int refreshrate =3D REFRASHRATE;

s/REFRASH/REFRESH/ :)

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVCsyfAAoJEBx+YmzsjxAgrmsP/2HrJbqXssQNsFJweACWWLrc
9Mlf+BhK3OS/MnK6MNcIxX711QKjJbuRvm/PcNbeZFVYbpRUHhAlfj/8sbUuBxy5
PWfv8A/zMyEXk3+H0PYAlfcGVGqH7/Imom7vIlnlTRsdLMg1iBHcQic+yPcQqzH6
HfXNRsm/WR3DNMo6SPBFXUA/877AruBaClKtwVqaUQBCW2qQAB1k8IrJrpE2ACKU
/SoD0uftNxmg3VmivYuG7sAhBcecgIPJhbqcLQ2pn4BNlarHMhKV5jnpnZS2xol1
tH305IlX4V7P78W6teQ0U1XWaNowCwRSXha+eWSSYceRHT5uxnEb689da2LXQ/kD
mfnlmjdpzV6Xkvum8YHg1NklpUXM3Cb//AsM28TvZt8+XbZjrORGrx6D06/28SBH
pkZ1hM7ilKUE15e1ZRMh0sDWROPtrQTVuyiaX5QswdGBdRaDcxXaUrWoLTjDvLZx
rAeSh7yrwNcdzngqY9s2yaPfsZQxdghJe9EgRaIGdekup/RzhWSWazuYk9396YHm
GX1lmfKLQPQr7qcn92fCLgK7sQMMpQO53lmb+xz7qQpAMSgwfYixyV2VEuoTikDP
M+X8uUvBQCdSieaYCj/zz3vktlDCp4Sn+cNOvkVkrsRY3xzHlY8ZtD+zA4b8bId+
mlt1eqQ/F0wHex9vLUhl
=3tCX
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
