From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Wed, 08 Feb 2017 16:07:07 +0000
Subject: Re: [PATCH 1/8] fb: hisilicon: Add framebuffer driver for hi3660 SoC
Message-Id: <2996648.XhUWzz1aup@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170207024027epcas5p2528e797ee0c34cb60d97f0b659f4acbf@epcas5p2.samsung.com>
 <20170207023559.79455-1-cailiwei@hisilicon.com>
In-Reply-To: <20170207023559.79455-1-cailiwei@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cailiwei <cailiwei@hisilicon.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, guodong.xu@linaro.org, suzhuangluan@hisilicon.com, dengqingshan@hisilicon.com, xuhongtao8@hisilicon.com, zhengwanchun@hisilicon.com, shizongxuan@huawei.com


Hi,

I cannot merge this upstream as it was collectively
decided that there should be no new fbdev drivers
(DRM subsystem should be used instead).

[ You may consider submitting this driver to staging
  subsystem to make hardware usable by kernel while
  proper DRM driver is being developed. ]

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

On Tuesday, February 07, 2017 10:35:52 AM cailiwei wrote:
> From: Levy-Cai <cailiwei@hisilicon.com>
> 
> Add framebuffer driver for hi3660 SoC, this driver include lcd
> driver & Hdmi adv7533/adv7535 driver, support lcd display at
> 1080p@60 and hdmi display at 1080p@60.
> 
> Signed-off-by: cailiwei <cailiwei@hisilicon.com>
> ---
>  drivers/video/fbdev/Kconfig           | 11 ++++++++++
>  drivers/video/fbdev/Makefile          |  1 +
>  drivers/video/fbdev/hisi/Kconfig      |  6 +++++
>  drivers/video/fbdev/hisi/dss/Makefile | 41 +++++++++++++++++++++++++++++++++++
>  4 files changed, 59 insertions(+)
>  mode change 100644 => 100755 drivers/video/fbdev/Kconfig
>  mode change 100644 => 100755 drivers/video/fbdev/Makefile
>  create mode 100755 drivers/video/fbdev/hisi/Kconfig
>  create mode 100755 drivers/video/fbdev/hisi/dss/Makefile
> 
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> old mode 100644
> new mode 100755
> index 5d3b0db5ce0a..85c46cc75908
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2429,6 +2429,16 @@ config FB_HYPERV
>  	help
>  	  This framebuffer driver supports Microsoft Hyper-V Synthetic Video.
>  
> +config FB_HISI
> +	tristate "Hisilicon Framebuffer support"
> +	depends on FB
> +	select FB_CFB_FILLRECT
> +	select FB_CFB_COPYAREA
> +	select FB_CFB_IMAGEBLIT
> +	select REGMAP
> +	help
> +	  This framebuffer driver supports Hisilicon FB.
> +
>  config FB_SIMPLE
>  	bool "Simple framebuffer support"
>  	depends on (FB = y)
> @@ -2448,6 +2458,7 @@ config FB_SIMPLE
>  source "drivers/video/fbdev/omap/Kconfig"
>  source "drivers/video/fbdev/omap2/Kconfig"
>  source "drivers/video/fbdev/mmp/Kconfig"
> +source "drivers/video/fbdev/hisi/Kconfig"
>  
>  config FB_SH_MOBILE_MERAM
>  	tristate "SuperH Mobile MERAM read ahead support"
> diff --git a/drivers/video/fbdev/Makefile b/drivers/video/fbdev/Makefile
> old mode 100644
> new mode 100755
> index ee8c81405a7f..a10d3d2793e3
> --- a/drivers/video/fbdev/Makefile
> +++ b/drivers/video/fbdev/Makefile
> @@ -23,6 +23,7 @@ obj-$(CONFIG_FB_I740)		  += i740fb.o
>  obj-$(CONFIG_FB_MATROX)		  += matrox/
>  obj-$(CONFIG_FB_RIVA)		  += riva/
>  obj-$(CONFIG_FB_NVIDIA)		  += nvidia/
> +obj-$(CONFIG_FB_HISI)             += hisi/dss/
>  obj-$(CONFIG_FB_ATY)		  += aty/ macmodes.o
>  obj-$(CONFIG_FB_ATY128)		  += aty/ macmodes.o
>  obj-$(CONFIG_FB_RADEON)		  += aty/
> diff --git a/drivers/video/fbdev/hisi/Kconfig b/drivers/video/fbdev/hisi/Kconfig
> new file mode 100755
> index 000000000000..c30747d52a38
> --- /dev/null
> +++ b/drivers/video/fbdev/hisi/Kconfig
> @@ -0,0 +1,6 @@
> +config HISI_FB_KIRIN960
> +	tristate "HISI FB KIRIN960 Framebuffer support"
> +	depends on FB_HISI
> +
> +	help
> +	  This framebuffer driver supports KIRIN960 FB.
> diff --git a/drivers/video/fbdev/hisi/dss/Makefile b/drivers/video/fbdev/hisi/dss/Makefile
> new file mode 100755
> index 000000000000..60004880dd80
> --- /dev/null
> +++ b/drivers/video/fbdev/hisi/dss/Makefile
> @@ -0,0 +1,41 @@
> +ifeq ($(CONFIG_HISI_FB_KIRIN960),y)
> +obj-$(CONFIG_HISI_FB_KIRIN960) := hisifb.o
> +endif
> +
> +hisifb-objs := \
> +	hisi_mipi_dsi_host.o \
> +	hisi_mipi_dsi.o \
> +	hisi_dpe.o \
> +	hisi_fb_panel.o \
> +	hisi_fb_isr.o \
> +	hisi_fb_vsync.o \
> +	hisi_fb_buf_sync.o \
> +	hisi_fb_bl.o \
> +	hisi_fb_utils.o \
> +	hisi_fb.o \
> +	hisi_overlay_utils.o \
> +	hisi_block_algorithm.o \
> +	hisi_overlay_online.o \
> +	hisi_overlay_cmdlist_utils.o
> +
> +ifeq ($(CONFIG_HISI_FB_KIRIN960),y)
> +hisifb-objs += \
> +	hisi_dpe_utils_hi3660.o \
> +	hisi_overlay_utils_hi3660.o \
> +	panel/mipi_hikey_nte300nts.o \
> +	hdmi/adv75xx.o \
> +	hdmi/mipi_adi_hdmi.o
> +endif
> +
> +EXTRA_CFLAGS += -Idrivers/video/hisi/dss \
> +		-Idrivers/video/hisi/panel \
> +		-Idrivers/video/hisi \
> +		-Iinclude \
> +		-Idrivers/staging/android
> +
> +ifeq ($(CONFIG_HISI_PERIDVFS),y)
> +EXTRA_CFLAGS += -Idrivers/clk/hisi/peri_dvfs
> +endif
> +
> +clean:
> +	rm *.o .*cmd

