From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 23 May 2014 12:31:44 +0000
Subject: Re: [PATCH v2 1/3] video: clps711x: Add new Cirrus Logic CLPS711X framebuffer driver
Message-Id: <537F3FB0.6010909@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="30kVSUWwgeESieVw5XNsG1tM9VHSerCW0"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1397285583-15187-1-git-send-email-shc_work@mail.ru>
To: linux-fbdev@vger.kernel.org

--30kVSUWwgeESieVw5XNsG1tM9VHSerCW0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/04/14 09:53, Alexander Shiyan wrote:
> This adds support for the framebuffer available in the Cirrus
> Logic CLPS711X CPUs.
> FB features:
> - 1-2-4 bits per pixel.
> - Programmable panel size to a maximum of 1024x256 at 4 bps.
> - Relocatible Frame Buffer (SRAM or SDRAM).
> - Programmable refresh rates.
> - 16 gray scale values.
> This new driver supports usage with devicetree and as a general
> change it removes last user of <mach/hardware.h> for CLPS711X targets,
> so this subarch will fully prepared to switch to multiplatform.
> The driver have been tested with custom board equipped Cirrus Logic
> EP7312 in DT and non-DT mode.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/video/fbdev/clps711x-fb.c | 456 ++++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 456 insertions(+)
>  create mode 100644 drivers/video/fbdev/clps711x-fb.c

<snip>

> +
> +static int clps711x_fb_get_mode_dt(struct platform_device *pdev)
> +{
> +	struct device_node *disp, *np =3D pdev->dev.of_node;
> +	struct fb_info *info =3D platform_get_drvdata(pdev);
> +	struct clps711x_fb_info *cfb =3D info->par;
> +	int ret;
> +
> +	cfb->syscon =3D
> +		syscon_regmap_lookup_by_compatible("cirrus,clps711x-syscon1");
> +	if (IS_ERR(cfb->syscon))
> +		return PTR_ERR(cfb->syscon);

Hmm, what's the syscon stuff about? Looks like it's required, but the DT
documentation patch doesn't mention it at all.

 Tomi



--30kVSUWwgeESieVw5XNsG1tM9VHSerCW0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfz+wAAoJEPo9qoy8lh71GiYP/AzV+99mo/twMghVngcSayi4
bvHxFjwmQo1IOVJjGjbWq2cQ8KMTxj98mPVbmQD4Ns7tSHtfFvg6rw6VhadCF6lb
l7Axb2p05xLEk6cNc0mKN37kwCGVSu9s66K1RLoO7BBTy0qfTKMnrqn8Jo4h6a0l
oAOPOoHI5K1Zs5pYIGNqSmhPzmmPfonQ0w7H2VkpD8/q8AmY/70Zua2plwQhCtlZ
gRdWKcDdAMdbKxR+P2BLqYy0psdR+84xNKEroxfd9uMIbuocL8/gQRC7D/uEEY7S
DSWMJHmznO9lPno3/Nr1dc+h2wVVPfmGx3NQMLY3S2OotYaKvtjQk4CRG5lc9cVN
YWvcKin/nny9UGu19cFvOwbYj8t3Qbw6hjxvEK80jBGNk4S6Gz/STLBeD2lQEntN
iX8PQ51M+ZHvE7VPXtOIiMzg0NULi+YFW1cOJKhH0JohGbB0ihzCs61G7Qqmr3du
n4XTclzB/TXTp6vdDJK15JnjgxN6y18bIE9JfhngZ4Np/0iD0MtSUgCuKcqRzW4V
WvABDQsVEqs1Eb1roTrMIoRdKVIoJHA0stU0XkTQK4siht3wjAgoKauYafzoT7Sl
2cwDomznw4y8ken5rIk2zaTnd/5TGpdOpe03/dYFTRLRKCvaZB3NYgIrB5ewOCff
zgCgUfelTFn/RM+dUOgx
=t+rA
-----END PGP SIGNATURE-----

--30kVSUWwgeESieVw5XNsG1tM9VHSerCW0--
