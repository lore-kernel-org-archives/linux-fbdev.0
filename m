From: Michal Simek <monstr@monstr.eu>
Date: Mon, 11 Nov 2013 09:13:14 +0000
Subject: Re: [PATCH] video: add OpenCores VGA/LCD framebuffer driver
Message-Id: <52809FAA.6080107@monstr.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OLhXCKXbs0SMrE2iChrr3kaGbG1NjjIIe"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1384088894-31920-1-git-send-email-stefan.kristiansson@saunalahti.fi>
In-Reply-To: <1384088894-31920-1-git-send-email-stefan.kristiansson@saunalahti.fi>
To: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OLhXCKXbs0SMrE2iChrr3kaGbG1NjjIIe
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/10/2013 02:08 PM, Stefan Kristiansson wrote:
> This adds support for the VGA/LCD core available from OpenCores:
> http://opencores.org/project,vga_lcd
>=20
> The driver have been tested together with both OpenRISC and
> ARM (socfpga) processors.
>=20
> Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> ---
>  drivers/video/Kconfig  |  17 ++
>  drivers/video/Makefile |   1 +
>  drivers/video/ocfb.c   | 479 +++++++++++++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 497 insertions(+)
>  create mode 100644 drivers/video/ocfb.c
>=20
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 84b685f..2ea850c 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -979,6 +979,23 @@ config FB_PVR2
>  	  (<file:drivers/video/pvr2fb.c>). Please see the file
>  	  <file:Documentation/fb/pvr2fb.txt>.
> =20
> +config FB_OPENCORES
> +	tristate "OpenCores VGA/LCD core 2.0 framebuffer support"
> +	depends on FB
> +	select FB_CFB_FILLRECT
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_IMAGEBLIT
> +	default n
> +	help
> +	  This enables support for the OpenCores VGA/LCD core.
> +
> +	  The OpenCores VGA/LCD core is typically used together with
> +	  softcore CPUs (e.g. OpenRISC) or hard processor systems

I expect that here can be also Microblaze.

> +	  (e.g. Altera socfpga or Xilinx Zync) on FPGAs.

s/Zync/Zynq/

M




--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--OLhXCKXbs0SMrE2iChrr3kaGbG1NjjIIe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKAn6oACgkQykllyylKDCGxvgCfR0Uo95dUsgJR6505BAC+/WYD
m9MAoJJV5YSZD1zuePPIkH0EVtm35px3
=608F
-----END PGP SIGNATURE-----

--OLhXCKXbs0SMrE2iChrr3kaGbG1NjjIIe--
