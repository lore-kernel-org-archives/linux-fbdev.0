From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Fri, 21 Feb 2014 13:54:54 +0000
Subject: Re: [PATCH v5] video: add OpenCores VGA/LCD framebuffer driver
Message-Id: <20140221135454.GA12555@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389384793-4710-1-git-send-email-stefan.kristiansson@saunalahti.fi>
In-Reply-To: <1389384793-4710-1-git-send-email-stefan.kristiansson@saunalahti.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, tomi.valkeinen@ti.com, plagnioj@jcrosoft.com

Hello,

On Fri, Jan 10, 2014 at 10:13:13PM +0200, Stefan Kristiansson wrote:
> This adds support for the VGA/LCD core available from OpenCores:
> http://opencores.org/project,vga_lcd
>=20
> The driver have been tested together with both OpenRISC and
> ARM (socfpga) processors.
>=20
> Signed-off-by: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> ---
> Changes in v2:
> - Add Microblaze as an example user and fix a typo in Xilinx Zynq
>=20
> Changes in v3:
> - Use devm_kzalloc instead of kzalloc
> - Remove superflous MODULE #ifdef
>=20
> Changes in v4:
> - Remove 'default n' in Kconfig
> - Simplify ioremap/request_mem_region by using devm_ioremap_resource
> - Remove release_mem_region
>=20
> Changes in v5:
> - Remove static structs to support multiple devices
> ---
>  drivers/video/Kconfig  |  16 ++
>  drivers/video/Makefile |   1 +
>  drivers/video/ocfb.c   | 440 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 457 insertions(+)
>  create mode 100644 drivers/video/ocfb.c
>=20
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 84b685f..8e41a1e 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -979,6 +979,22 @@ config FB_PVR2
>  	  (<file:drivers/video/pvr2fb.c>). Please see the file
>  	  <file:Documentation/fb/pvr2fb.txt>.
> =20
> +config FB_OPENCORES
> +	tristate "OpenCores VGA/LCD core 2.0 framebuffer support"
> +	depends on FB

Maybe add something like:

	depends on ARCH_SOCFPGA || ARCH_ZYNQ || MICROBLAZE || OPENRISC || COMPILE_=
TEST

(Sorry for being late with that suggestion, this attracted my attention
only during make oldconfig on v3.14-rc, so if you agree this is a good
idea you need a seperate patch :-)

Best regards
Uwe

> +	select FB_CFB_FILLRECT
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_IMAGEBLIT

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
