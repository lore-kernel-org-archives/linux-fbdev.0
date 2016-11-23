From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Date: Wed, 23 Nov 2016 17:26:51 +0000
Subject: Re: [RFC PATCH 3/3] staging: remove fbtft
Message-Id: <60245ffa-0a64-cae0-7930-e05d92b35c09@tronnes.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1479888193-23908-1-git-send-email-tomi.valkeinen@ti.com>
 <1479888193-23908-4-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1479888193-23908-4-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Teddy Wang <teddy.wang@siliconmotion.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-kernel@vger.kernel.org


Den 23.11.2016 09:03, skrev Tomi Valkeinen:
> Since the fbdev framework is in maintenance mode and all new display
> drivers should be made with the DRM framework, remove fbtft from
> staging.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

FYI:
I'm working on a drm version of fbtft: https://github.com/notro/tinydrm
I have just picked it up after a 4 month break.

It is ready for a new review, except that I want to test how it would
perform as a drm userspace driver first (for spi that would mean adding
dma-buf support to spidev). If this performs well, then all the fbtft
drivers could move to userspace. If it doesn't, then at least (very slow)
i2c and e-ink displays could be userspace drivers.

Noralf.

> ---
>   MAINTAINERS                            |    6 -
>   drivers/staging/Kconfig                |    2 -
>   drivers/staging/Makefile               |    1 -
>   drivers/staging/fbtft/Kconfig          |  210 -----
>   drivers/staging/fbtft/Makefile         |   40 -
>   drivers/staging/fbtft/README           |   32 -
>   drivers/staging/fbtft/fb_agm1264k-fl.c |  456 ---------
>   drivers/staging/fbtft/fb_bd663474.c    |  184 ----
>   drivers/staging/fbtft/fb_hx8340bn.c    |  234 -----
>   drivers/staging/fbtft/fb_hx8347d.c     |  169 ----
>   drivers/staging/fbtft/fb_hx8353d.c     |  157 ----
>   drivers/staging/fbtft/fb_hx8357d.c     |  210 -----
>   drivers/staging/fbtft/fb_hx8357d.h     |   70 --
>   drivers/staging/fbtft/fb_ili9163.c     |  273 ------
>   drivers/staging/fbtft/fb_ili9320.c     |  278 ------
>   drivers/staging/fbtft/fb_ili9325.c     |  277 ------
>   drivers/staging/fbtft/fb_ili9340.c     |  149 ---
>   drivers/staging/fbtft/fb_ili9341.c     |  166 ----
>   drivers/staging/fbtft/fb_ili9481.c     |  112 ---
>   drivers/staging/fbtft/fb_ili9486.c     |  112 ---
>   drivers/staging/fbtft/fb_pcd8544.c     |  176 ----
>   drivers/staging/fbtft/fb_ra8875.c      |  318 -------
>   drivers/staging/fbtft/fb_s6d02a1.c     |  166 ----
>   drivers/staging/fbtft/fb_s6d1121.c     |  194 ----
>   drivers/staging/fbtft/fb_ssd1289.c     |  191 ----
>   drivers/staging/fbtft/fb_ssd1305.c     |  216 -----
>   drivers/staging/fbtft/fb_ssd1306.c     |  217 -----
>   drivers/staging/fbtft/fb_ssd1325.c     |  205 ----
>   drivers/staging/fbtft/fb_ssd1331.c     |  196 ----
>   drivers/staging/fbtft/fb_ssd1351.c     |  238 -----
>   drivers/staging/fbtft/fb_st7735r.c     |  190 ----
>   drivers/staging/fbtft/fb_st7789v.c     |  265 ------
>   drivers/staging/fbtft/fb_tinylcd.c     |  112 ---
>   drivers/staging/fbtft/fb_tls8204.c     |  169 ----
>   drivers/staging/fbtft/fb_uc1611.c      |  340 -------
>   drivers/staging/fbtft/fb_uc1701.c      |  179 ----
>   drivers/staging/fbtft/fb_upd161704.c   |  197 ----
>   drivers/staging/fbtft/fb_watterott.c   |  302 ------
>   drivers/staging/fbtft/fbtft-bus.c      |  252 -----
>   drivers/staging/fbtft/fbtft-core.c     | 1467 -------------------------=
----
>   drivers/staging/fbtft/fbtft-io.c       |  238 -----
>   drivers/staging/fbtft/fbtft-sysfs.c    |  219 -----
>   drivers/staging/fbtft/fbtft.h          |  421 ---------
>   drivers/staging/fbtft/fbtft_device.c   | 1597 -------------------------=
-------
>   drivers/staging/fbtft/flexfb.c         |  619 -------------
>   drivers/staging/fbtft/internal.h       |   25 -
>   46 files changed, 11847 deletions(-)
>   delete mode 100644 drivers/staging/fbtft/Kconfig
>   delete mode 100644 drivers/staging/fbtft/Makefile
>   delete mode 100644 drivers/staging/fbtft/README
>   delete mode 100644 drivers/staging/fbtft/fb_agm1264k-fl.c
>   delete mode 100644 drivers/staging/fbtft/fb_bd663474.c
>   delete mode 100644 drivers/staging/fbtft/fb_hx8340bn.c
>   delete mode 100644 drivers/staging/fbtft/fb_hx8347d.c
>   delete mode 100644 drivers/staging/fbtft/fb_hx8353d.c
>   delete mode 100644 drivers/staging/fbtft/fb_hx8357d.c
>   delete mode 100644 drivers/staging/fbtft/fb_hx8357d.h
>   delete mode 100644 drivers/staging/fbtft/fb_ili9163.c
>   delete mode 100644 drivers/staging/fbtft/fb_ili9320.c
>   delete mode 100644 drivers/staging/fbtft/fb_ili9325.c
>   delete mode 100644 drivers/staging/fbtft/fb_ili9340.c
>   delete mode 100644 drivers/staging/fbtft/fb_ili9341.c
>   delete mode 100644 drivers/staging/fbtft/fb_ili9481.c
>   delete mode 100644 drivers/staging/fbtft/fb_ili9486.c
>   delete mode 100644 drivers/staging/fbtft/fb_pcd8544.c
>   delete mode 100644 drivers/staging/fbtft/fb_ra8875.c
>   delete mode 100644 drivers/staging/fbtft/fb_s6d02a1.c
>   delete mode 100644 drivers/staging/fbtft/fb_s6d1121.c
>   delete mode 100644 drivers/staging/fbtft/fb_ssd1289.c
>   delete mode 100644 drivers/staging/fbtft/fb_ssd1305.c
>   delete mode 100644 drivers/staging/fbtft/fb_ssd1306.c
>   delete mode 100644 drivers/staging/fbtft/fb_ssd1325.c
>   delete mode 100644 drivers/staging/fbtft/fb_ssd1331.c
>   delete mode 100644 drivers/staging/fbtft/fb_ssd1351.c
>   delete mode 100644 drivers/staging/fbtft/fb_st7735r.c
>   delete mode 100644 drivers/staging/fbtft/fb_st7789v.c
>   delete mode 100644 drivers/staging/fbtft/fb_tinylcd.c
>   delete mode 100644 drivers/staging/fbtft/fb_tls8204.c
>   delete mode 100644 drivers/staging/fbtft/fb_uc1611.c
>   delete mode 100644 drivers/staging/fbtft/fb_uc1701.c
>   delete mode 100644 drivers/staging/fbtft/fb_upd161704.c
>   delete mode 100644 drivers/staging/fbtft/fb_watterott.c
>   delete mode 100644 drivers/staging/fbtft/fbtft-bus.c
>   delete mode 100644 drivers/staging/fbtft/fbtft-core.c
>   delete mode 100644 drivers/staging/fbtft/fbtft-io.c
>   delete mode 100644 drivers/staging/fbtft/fbtft-sysfs.c
>   delete mode 100644 drivers/staging/fbtft/fbtft.h
>   delete mode 100644 drivers/staging/fbtft/fbtft_device.c
>   delete mode 100644 drivers/staging/fbtft/flexfb.c
>   delete mode 100644 drivers/staging/fbtft/internal.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 772330b38212..466a86a3b2fc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4839,12 +4839,6 @@ S:	Supported
>   F:	Documentation/fault-injection/
>   F:	lib/fault-inject.c
>  =20
> -FBTFT Framebuffer drivers
> -M:	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> -M:	Noralf Tr=C3=B8nnes <noralf@tronnes.org>
> -S:	Maintained
> -F:	drivers/staging/fbtft/
> -
>   FCOE SUBSYSTEM (libfc, libfcoe, fcoe)
>   M:	Johannes Thumshirn <jth@kernel.org>
>   L:	fcoe-devel@open-fcoe.org
> diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
> index fcfe8fcea441..69a62eac7bbf 100644
> --- a/drivers/staging/Kconfig
> +++ b/drivers/staging/Kconfig
> @@ -86,8 +86,6 @@ source "drivers/staging/unisys/Kconfig"
>  =20
>   source "drivers/staging/clocking-wizard/Kconfig"
>  =20
> -source "drivers/staging/fbtft/Kconfig"
> -
>   source "drivers/staging/fsl-mc/Kconfig"
>  =20
>   source "drivers/staging/wilc1000/Kconfig"
> diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
> index 585eb34020a1..33a768c0942d 100644
> --- a/drivers/staging/Makefile
> +++ b/drivers/staging/Makefile
> @@ -32,7 +32,6 @@ obj-$(CONFIG_GS_FPGABOOT)	+=3D gs_fpgaboot/
>   obj-$(CONFIG_CRYPTO_SKEIN)	+=3D skein/
>   obj-$(CONFIG_UNISYSSPAR)	+=3D unisys/
>   obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+=3D clocking-wizard/
> -obj-$(CONFIG_FB_TFT)		+=3D fbtft/
>   obj-$(CONFIG_FSL_MC_BUS)	+=3D fsl-mc/
>   obj-$(CONFIG_WILC1000)		+=3D wilc1000/
>   obj-$(CONFIG_MOST)		+=3D most/
> diff --git a/drivers/staging/fbtft/Kconfig b/drivers/staging/fbtft/Kconfig
> deleted file mode 100644
> index 6f5e82464d78..000000000000
> diff --git a/drivers/staging/fbtft/Makefile b/drivers/staging/fbtft/Makef=
ile
> deleted file mode 100644
> index 2725ea9a4afc..000000000000
> diff --git a/drivers/staging/fbtft/README b/drivers/staging/fbtft/README
> deleted file mode 100644
> index ba4c74c92e4c..000000000000
> diff --git a/drivers/staging/fbtft/fb_agm1264k-fl.c b/drivers/staging/fbt=
ft/fb_agm1264k-fl.c
> deleted file mode 100644
> index 7561385761e9..000000000000
> diff --git a/drivers/staging/fbtft/fb_bd663474.c b/drivers/staging/fbtft/=
fb_bd663474.c
> deleted file mode 100644
> index 6010e6cbbd72..000000000000
> diff --git a/drivers/staging/fbtft/fb_hx8340bn.c b/drivers/staging/fbtft/=
fb_hx8340bn.c
> deleted file mode 100644
> index 9970ed74bb38..000000000000
> diff --git a/drivers/staging/fbtft/fb_hx8347d.c b/drivers/staging/fbtft/f=
b_hx8347d.c
> deleted file mode 100644
> index 450a61e3f99c..000000000000
> diff --git a/drivers/staging/fbtft/fb_hx8353d.c b/drivers/staging/fbtft/f=
b_hx8353d.c
> deleted file mode 100644
> index 72e4ff8c5553..000000000000
> diff --git a/drivers/staging/fbtft/fb_hx8357d.c b/drivers/staging/fbtft/f=
b_hx8357d.c
> deleted file mode 100644
> index 32e6efe1d0a7..000000000000
> diff --git a/drivers/staging/fbtft/fb_hx8357d.h b/drivers/staging/fbtft/f=
b_hx8357d.h
> deleted file mode 100644
> index e281921d4a97..000000000000
> diff --git a/drivers/staging/fbtft/fb_ili9163.c b/drivers/staging/fbtft/f=
b_ili9163.c
> deleted file mode 100644
> index 6b8f8b17e9a3..000000000000
> diff --git a/drivers/staging/fbtft/fb_ili9320.c b/drivers/staging/fbtft/f=
b_ili9320.c
> deleted file mode 100644
> index 278e4c7e95e5..000000000000
> diff --git a/drivers/staging/fbtft/fb_ili9325.c b/drivers/staging/fbtft/f=
b_ili9325.c
> deleted file mode 100644
> index c31e2e051d4a..000000000000
> diff --git a/drivers/staging/fbtft/fb_ili9340.c b/drivers/staging/fbtft/f=
b_ili9340.c
> deleted file mode 100644
> index 0711121c303c..000000000000
> diff --git a/drivers/staging/fbtft/fb_ili9341.c b/drivers/staging/fbtft/f=
b_ili9341.c
> deleted file mode 100644
> index ff35c8624ca3..000000000000
> diff --git a/drivers/staging/fbtft/fb_ili9481.c b/drivers/staging/fbtft/f=
b_ili9481.c
> deleted file mode 100644
> index 242adb3859bd..000000000000
> diff --git a/drivers/staging/fbtft/fb_ili9486.c b/drivers/staging/fbtft/f=
b_ili9486.c
> deleted file mode 100644
> index fa38d8885f0b..000000000000
> diff --git a/drivers/staging/fbtft/fb_pcd8544.c b/drivers/staging/fbtft/f=
b_pcd8544.c
> deleted file mode 100644
> index a4710dc067ef..000000000000
> diff --git a/drivers/staging/fbtft/fb_ra8875.c b/drivers/staging/fbtft/fb=
_ra8875.c
> deleted file mode 100644
> index 308a244972aa..000000000000
> diff --git a/drivers/staging/fbtft/fb_s6d02a1.c b/drivers/staging/fbtft/f=
b_s6d02a1.c
> deleted file mode 100644
> index 774b0ff69e6d..000000000000
> diff --git a/drivers/staging/fbtft/fb_s6d1121.c b/drivers/staging/fbtft/f=
b_s6d1121.c
> deleted file mode 100644
> index 9b1d70b218df..000000000000
> diff --git a/drivers/staging/fbtft/fb_ssd1289.c b/drivers/staging/fbtft/f=
b_ssd1289.c
> deleted file mode 100644
> index 25f9fbe1e76f..000000000000
> diff --git a/drivers/staging/fbtft/fb_ssd1305.c b/drivers/staging/fbtft/f=
b_ssd1305.c
> deleted file mode 100644
> index 4b38c3fadd60..000000000000
> diff --git a/drivers/staging/fbtft/fb_ssd1306.c b/drivers/staging/fbtft/f=
b_ssd1306.c
> deleted file mode 100644
> index 80fc57029fee..000000000000
> diff --git a/drivers/staging/fbtft/fb_ssd1325.c b/drivers/staging/fbtft/f=
b_ssd1325.c
> deleted file mode 100644
> index 15078bf2aa4b..000000000000
> diff --git a/drivers/staging/fbtft/fb_ssd1331.c b/drivers/staging/fbtft/f=
b_ssd1331.c
> deleted file mode 100644
> index 1d74ac1343a8..000000000000
> diff --git a/drivers/staging/fbtft/fb_ssd1351.c b/drivers/staging/fbtft/f=
b_ssd1351.c
> deleted file mode 100644
> index 200aa9ba98f9..000000000000
> diff --git a/drivers/staging/fbtft/fb_st7735r.c b/drivers/staging/fbtft/f=
b_st7735r.c
> deleted file mode 100644
> index 6670f2bb62ec..000000000000
> diff --git a/drivers/staging/fbtft/fb_st7789v.c b/drivers/staging/fbtft/f=
b_st7789v.c
> deleted file mode 100644
> index 085e9872c46d..000000000000
> diff --git a/drivers/staging/fbtft/fb_tinylcd.c b/drivers/staging/fbtft/f=
b_tinylcd.c
> deleted file mode 100644
> index 097e71cfef62..000000000000
> diff --git a/drivers/staging/fbtft/fb_tls8204.c b/drivers/staging/fbtft/f=
b_tls8204.c
> deleted file mode 100644
> index ea2ddacb9468..000000000000
> diff --git a/drivers/staging/fbtft/fb_uc1611.c b/drivers/staging/fbtft/fb=
_uc1611.c
> deleted file mode 100644
> index b33b73f17da4..000000000000
> diff --git a/drivers/staging/fbtft/fb_uc1701.c b/drivers/staging/fbtft/fb=
_uc1701.c
> deleted file mode 100644
> index b78045fe5393..000000000000
> diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft=
/fb_upd161704.c
> deleted file mode 100644
> index 970b8430eccf..000000000000
> diff --git a/drivers/staging/fbtft/fb_watterott.c b/drivers/staging/fbtft=
/fb_watterott.c
> deleted file mode 100644
> index a52e28a48825..000000000000
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fb=
tft-bus.c
> deleted file mode 100644
> index ec45043c0830..000000000000
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/f=
btft-core.c
> deleted file mode 100644
> index 587f68aa466c..000000000000
> diff --git a/drivers/staging/fbtft/fbtft-io.c b/drivers/staging/fbtft/fbt=
ft-io.c
> deleted file mode 100644
> index 4dcea2e0b3ae..000000000000
> diff --git a/drivers/staging/fbtft/fbtft-sysfs.c b/drivers/staging/fbtft/=
fbtft-sysfs.c
> deleted file mode 100644
> index 8d8bd12b90a1..000000000000
> diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
> deleted file mode 100644
> index 89c4b5b76ce6..000000000000
> diff --git a/drivers/staging/fbtft/fbtft_device.c b/drivers/staging/fbtft=
/fbtft_device.c
> deleted file mode 100644
> index e9211831b6a1..000000000000
> diff --git a/drivers/staging/fbtft/flexfb.c b/drivers/staging/fbtft/flexf=
b.c
> deleted file mode 100644
> index ce0d254148e4..000000000000
> diff --git a/drivers/staging/fbtft/internal.h b/drivers/staging/fbtft/int=
ernal.h
> deleted file mode 100644
> index eea0ec5ff4d3..000000000000

