From: Sylwester Nawrocki <spnlinux@gmail.com>
Date: Sat, 27 Nov 2010 17:07:16 +0000
Subject: Re: [PATCH 3/4] S5PC110: add MIPI-DSI support for platform and machine.
Message-Id: <4CF13AC4.3060508@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1290496593-4927-1-git-send-email-inki.dae@samsung.com>
In-Reply-To: <1290496593-4927-1-git-send-email-inki.dae@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello,

On 11/23/2010 08:16 AM, Inki Dae wrote:
> clock.c
> - added dsim clock gate.
>
> dev-dsim.c
> - platform and machine specific definitions.
> Now just supports only MACHINE GONI so for other machines,
> mipi_1_1v_name and mipi_1_8v_name values should be changed to
> proper regulator name at each machine file.
>
> setup-dsim.c
> - platform specific definitions.
>
> Signed-off-by: Inki Dae<inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park<kyungmin.park@samsung.com>
> ---
>   arch/arm/mach-s5pv210/Kconfig                   |   11 ++
>   arch/arm/mach-s5pv210/Makefile                  |    2 +
>   arch/arm/mach-s5pv210/clock.c                   |    6 +
>   arch/arm/mach-s5pv210/dev-dsim.c                |  149 +++++++++++++++++++++++
>   arch/arm/mach-s5pv210/include/mach/map.h        |    4 +
>   arch/arm/mach-s5pv210/include/mach/regs-clock.h |    3 +-
>   arch/arm/mach-s5pv210/mach-goni.c               |   12 ++
>   arch/arm/mach-s5pv210/setup-dsim.c              |  144 ++++++++++++++++++++++
>   arch/arm/plat-s5p/Kconfig                       |    5 +
>   9 files changed, 335 insertions(+), 1 deletions(-)
>   create mode 100644 arch/arm/mach-s5pv210/dev-dsim.c
>   create mode 100644 arch/arm/mach-s5pv210/setup-dsim.c
>
> diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
> index 862f239..447701f 100644
> --- a/arch/arm/mach-s5pv210/Kconfig
> +++ b/arch/arm/mach-s5pv210/Kconfig
> @@ -53,6 +53,12 @@ config S5PV210_SETUP_SDHCI_GPIO
>   	help
>   	  Common setup code for SDHCI gpio.
>
> +config S5PV210_SETUP_DSIM
> +	bool
> +	depends on REGULATOR
> +	help
> +	  Common setup code for MIPI-DSIM.
> +
>   menu "S5PC110 Machines"
>
>   config MACH_AQUILA
> @@ -68,6 +74,7 @@ config MACH_AQUILA
>   	select S5P_DEV_ONENAND
>   	select S5PV210_SETUP_FB_24BPP
>   	select S5PV210_SETUP_SDHCI
> +	select S5PV210_SETUP_DSIM
>   	help
>   	  Machine support for the Samsung Aquila target based on S5PC110 SoC
>
> @@ -86,12 +93,14 @@ config MACH_GONI
>   	select S3C_DEV_I2C2
>   	select S3C_DEV_USB_HSOTG
>   	select S5P_DEV_ONENAND
> +	select S5P_DEV_DSIM
>   	select SAMSUNG_DEV_KEYPAD
>   	select S5PV210_SETUP_FB_24BPP
>   	select S5PV210_SETUP_I2C1
>   	select S5PV210_SETUP_I2C2
>   	select S5PV210_SETUP_KEYPAD
>   	select S5PV210_SETUP_SDHCI
> +	select S5PV210_SETUP_DSIM
>   	help
>   	  Machine support for Samsung GONI board
>   	  S5PC110(MCP) is one of package option of S5PV210
> @@ -107,6 +116,7 @@ config MACH_SMDKC110
>   	select S5PV210_SETUP_I2C1
>   	select S5PV210_SETUP_I2C2
>   	select S5PV210_SETUP_IDE
> +	select S5PV210_SETUP_DSIM
>   	help
>   	  Machine support for Samsung SMDKC110
>   	  S5PC110(MCP) is one of package option of S5PV210
> @@ -135,6 +145,7 @@ config MACH_SMDKV210
>   	select S5PV210_SETUP_IDE
>   	select S5PV210_SETUP_KEYPAD
>   	select S5PV210_SETUP_SDHCI
> +	select S5PV210_SETUP_DSIM
>   	help
>   	  Machine support for Samsung SMDKV210
>
> diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
> index ff1a0db..f6a6443 100644
> --- a/arch/arm/mach-s5pv210/Makefile
> +++ b/arch/arm/mach-s5pv210/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_MACH_TORBRECK)	+= mach-torbreck.o
>
>   obj-y				+= dev-audio.o
>   obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
> +obj-$(CONFIG_S5P_DEV_DSIM)	+= dev-dsim.o
>
>   obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
>   obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
> @@ -37,3 +38,4 @@ obj-$(CONFIG_S5PV210_SETUP_IDE)		+= setup-ide.o
>   obj-$(CONFIG_S5PV210_SETUP_KEYPAD)	+= setup-keypad.o
>   obj-$(CONFIG_S5PV210_SETUP_SDHCI)       += setup-sdhci.o
>   obj-$(CONFIG_S5PV210_SETUP_SDHCI_GPIO)	+= setup-sdhci-gpio.o
> +obj-$(CONFIG_S5PV210_SETUP_DSIM)	+= setup-dsim.o
> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
> index 019c3a6..9cbf244 100644
> --- a/arch/arm/mach-s5pv210/clock.c
> +++ b/arch/arm/mach-s5pv210/clock.c
> @@ -347,6 +347,12 @@ static struct clk init_clocks_disable[] = {
>   		.enable		= s5pv210_clk_ip0_ctrl,
>   		.ctrlbit	= (1<<  26),
>   	}, {
> +		.name		= "dsim",
> +		.id		= -1,
> +		.parent		=&clk_hclk_dsys.clk,
> +		.enable		= s5pv210_clk_ip1_ctrl,
> +		.ctrlbit	= (1<<2),
> +	}, {
>   		.name		= "otg",
>   		.id		= -1,
>   		.parent		=&clk_hclk_psys.clk,
> diff --git a/arch/arm/mach-s5pv210/dev-dsim.c b/arch/arm/mach-s5pv210/dev-dsim.c
> new file mode 100644
> index 0000000..3f43d72
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/dev-dsim.c
> @@ -0,0 +1,149 @@
> +/* linux/arch/arm/plat-s5pc11x/dev-dsim.c
> + *
> + * Copyright 2009 Samsung Electronics
> + *	InKi Dae<inki.dae@samsung.com>
> + *
> + * S5PC1XX series device definition for MIPI-DSIM
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> +*/
> +
> +#include<linux/kernel.h>
> +#include<linux/string.h>
> +#include<linux/platform_device.h>
> +#include<linux/regulator/consumer.h>
> +#include<linux/fb.h>
> +
> +#include<mach/map.h>
> +#include<mach/irqs.h>
> +
> +#include<plat/devs.h>
> +#include<plat/cpu.h>
> +#include<plat/fb.h>
> +
> +#include<plat/dsim.h>
> +#include<plat/mipi_ddi.h>
> +
> +static struct dsim_config dsim_info = {
> +	/* main frame fifo auto flush at VSYNC pulse */
> +	.auto_flush = false,
> +	.eot_disable = false,
> +
> +	.auto_vertical_cnt = false,
> +	.hse = false,
> +	.hfp = false,
> +	.hbp = false,
> +	.hsa = false,

Since static struct members are implicitly initialized with constant 
value 0 do you really need all that initializations to 'false'?

> +
> +	.e_no_data_lane = DSIM_DATA_LANE_2,
> +	.e_byte_clk = DSIM_PLL_OUT_DIV8,
> +
> +	/*
> +	 * =====================> +	 * |    P    |    M    |    S    |    MHz    |
> +	 * -------------------------------------------
> +	 * |    3    |   100   |    3    |    100    |
> +	 * |    3    |   100   |    2    |    200    |
> +	 * |    3    |    63   |    1    |    252    |
> +	 * |    4    |   100   |    1    |    300    |
> +	 * |    4    |   110   |    1    |    330    |
> +	 * |   12    |   350   |    1    |    350    |
> +	 * |    3    |   100   |    1    |    400    |
> +	 * |    4    |   150   |    1    |    450    |
> +	 * |    3    |   118   |    1    |    472    |
> +	 * |   12    |   250   |    0    |    500    |
> +	 * |    4    |   100   |    0    |    600    |
> +	 * |    3    |    81   |    0    |    648    |
> +	 * |    3    |    88   |    0    |    704    |
> +	 * |    3    |    90   |    0    |    720    |
> +	 * |    3    |   100   |    0    |    800    |
> +	 * |   12    |   425   |    0    |    850    |
> +	 * |    4    |   150   |    0    |    900    |
> +	 * |   12    |   475   |    0    |    950    |
> +	 * |    6    |   250   |    0    |   1000    |
> +	 * -------------------------------------------
> +	 */
> +
> +	/* 472MHz: LSI Recommended */
> +	.p = 3,
> +	.m = 118,
> +	.s = 1,
> +
> +	/* D-PHY PLL stable time spec :min = 200usec ~ max 400usec */
> +	.pll_stable_time = 400,
> +
> +	.esc_clk = 10 * 1000000,	/* escape clk : 10MHz */
> +
> +	/* stop state holding counter after bta change count 0 ~ 0xfff */
> +	.stop_holding_cnt = 0x0f,
> +	.bta_timeout = 0xff,		/* bta timeout 0 ~ 0xff */
> +	.rx_timeout = 0xffff,		/* lp rx timeout 0 ~ 0xffff */
> +
> +	.e_lane_swap = DSIM_NO_CHANGE,
> +};
> +
> +/* define ddi platform data based on MIPI-DSI. */
> +static struct mipi_ddi_platform_data mipi_ddi_pd = {
> +	.cmd_write			= s5p_dsim_wr_data,
> +	.cmd_read			= NULL,
> +	.get_dsim_frame_done		= s5p_dsim_get_frame_done_status,
> +	.clear_dsim_frame_done		= s5p_dsim_clear_frame_done,
> +	.change_dsim_transfer_mode	= s5p_dsim_change_transfer_mode,
> +	.get_fb_frame_done		= NULL,
> +	.trigger			= NULL,
No need to initialize to NULL.
> +};
> +
> +static struct dsim_lcd_config dsim_lcd_info = {
> +	.e_interface			= DSIM_COMMAND,
> +	.parameter[DSI_VIRTUAL_CH_ID]	= (unsigned int)DSIM_VIRTUAL_CH_0,
> +	.parameter[DSI_FORMAT]		= (unsigned int)DSIM_24BPP_888,
> +	.parameter[DSI_VIDEO_MODE_SEL]	= (unsigned int)DSIM_BURST,

Wouldn't it be cleaner to define struct members of relevant type and 
name in place of the array and avoid casting?

> +	.mipi_ddi_pd			= (void *)&mipi_ddi_pd,
> +};
> +
> +static struct resource s5p_dsim_resource[] = {
> +	[0] = {
> +		.start = S5PV210_PA_DSI,
> +		.end   = S5PV210_PA_DSI + S5PV210_SZ_DSI - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start = IRQ_MIPIDSI,
> +		.end   = IRQ_MIPIDSI,
> +		.flags = IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct s5p_platform_dsim dsim_platform_data = {
> +	.clk_name		= "dsim",
> +	.mipi_1_1v_name		= "vmipi_1.1v",
> +	.mipi_1_8v_name		= "vmipi_1.8v",

You could avoid passing regulator's names in here. All you need to do is 
defining regulator supplies properly (see further comments below).
Creating well known (e.g. as defined in the datasheet) regulator supply 
names in the actual driver file (s5p-dsim.c) should be enough.
The regulator API can be used to match a regulator and its consumer.

> +	.dsim_info		=&dsim_info,
> +	.dsim_lcd_info		=&dsim_lcd_info,
> +
> +	.mipi_power		= s5p_dsim_mipi_power,
> +	.part_reset		= s5p_dsim_part_reset,
> +	.init_d_phy		= s5p_dsim_init_d_phy,
> +	.get_fb_frame_done	= NULL,
> +	.trigger		= NULL,
> +
> +	.platform_rev		= 1,
> +
> +	/*
> +	 * the stable time of needing to write data on SFR
> +	 * when the mipi mode becomes LP mode.
> +	 */
> +	.delay_for_stabilization = 600,
> +};
> +
> +struct platform_device s5p_device_dsim = {
> +	.name			= "s5p-dsim",
> +	.id			= 0,
> +	.num_resources		= ARRAY_SIZE(s5p_dsim_resource),
> +	.resource		= s5p_dsim_resource,
> +	.dev			= {
> +		.platform_data = (void *)&dsim_platform_data,
> +	},
> +};
> diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
> index 861d7fe..1ad2dad 100644
> --- a/arch/arm/mach-s5pv210/include/mach/map.h
> +++ b/arch/arm/mach-s5pv210/include/mach/map.h
> @@ -69,6 +69,10 @@
>
>   #define S5PV210_PA_FB		(0xF8000000)
>
> +/* MIPI-DSI */
> +#define S5PV210_PA_DSI		(0xFA500000)
> +#define S5PV210_SZ_DSI		SZ_1M

How about removing S5PV210_SZ_DSI and directly using SZ_1M in dev-dsim.c 
? Also, 1MB is probably excessive.

> +
>   #define S5PV210_PA_FIMC0	(0xFB200000)
>   #define S5PV210_PA_FIMC1	(0xFB300000)
>   #define S5PV210_PA_FIMC2	(0xFB400000)
> diff --git a/arch/arm/mach-s5pv210/include/mach/regs-clock.h b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> index ebaabe0..c8b9366 100644
> --- a/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> +++ b/arch/arm/mach-s5pv210/include/mach/regs-clock.h
> @@ -196,7 +196,8 @@
>   #define S5P_OTHERS_USB_SIG_MASK		(1<<  16)
>
>   /* MIPI */
> -#define S5P_MIPI_DPHY_EN		(3)
> +#define S5P_MIPI_DPHY_EN		(3<<  0)
> +#define S5P_MIPI_M_RESETN		(1<<  1)
>
>   /* S5P_DAC_CONTROL */
>   #define S5P_DAC_ENABLE			(1)
> diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
> index b1dcf96..500cc1b 100644
> --- a/arch/arm/mach-s5pv210/mach-goni.c
> +++ b/arch/arm/mach-s5pv210/mach-goni.c
> @@ -269,10 +269,18 @@ static void __init goni_tsp_init(void)
>   /* MAX8998 regulators */
>   #if defined(CONFIG_REGULATOR_MAX8998) || defined(CONFIG_REGULATOR_MAX8998_MODULE)
>
> +static struct regulator_consumer_supply goni_ldo3_consumers[] = {
> +	REGULATOR_SUPPLY("vmipi_1.1v", ""),
> +};

You could just do:
	REGULATOR_SUPPLY("vmipi_1.1v", "s5p-dsim.0"),

The second argument is used to match your consumer device with the 
relevant regulator supply.

Similar could be done in other machine's board setup files and there is 
no need to pass anything in the platform data.

Then in your driver probe you might just do:

... = regulator_get(&pdev->dev, "vmipi_1.1v");

> +
>   static struct regulator_consumer_supply goni_ldo5_consumers[] = {
>   	REGULATOR_SUPPLY("vmmc", "s3c-sdhci.0"),
>   };
>
> +static struct regulator_consumer_supply goni_ldo7_consumers[] = {
> +	REGULATOR_SUPPLY("vmipi_1.8v", ""),
> +};

Ditto.

> +
>   static struct regulator_init_data goni_ldo2_data = {
>   	.constraints	= {
>   		.name		= "VALIVE_1.1V",
> @@ -294,6 +302,8 @@ static struct regulator_init_data goni_ldo3_data = {
>   		.apply_uV	= 1,
>   		.always_on	= 1,
>   	},
> +	.num_consumer_supplies = ARRAY_SIZE(goni_ldo3_consumers),
> +	.consumer_supplies = goni_ldo3_consumers,
>   };
>
>   static struct regulator_init_data goni_ldo4_data = {
> @@ -333,6 +343,8 @@ static struct regulator_init_data goni_ldo7_data = {
>   		.apply_uV	= 1,
>   		.always_on	= 1,
>   	},
> +	.num_consumer_supplies = ARRAY_SIZE(goni_ldo7_consumers),
> +	.consumer_supplies = goni_ldo7_consumers,
>   };
>
>   static struct regulator_init_data goni_ldo8_data = {
> diff --git a/arch/arm/mach-s5pv210/setup-dsim.c b/arch/arm/mach-s5pv210/setup-dsim.c
> new file mode 100644
> index 0000000..874efa0
> --- /dev/null
> +++ b/arch/arm/mach-s5pv210/setup-dsim.c
> @@ -0,0 +1,144 @@
> +/*
> + * S5PC110 MIPI-DSIM driver.
> + *
> + * Author: InKi Dae<inki.dae@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> + * MA 02111-1307 USA
> + */
> +#include<linux/kernel.h>
> +#include<linux/string.h>
> +#include<linux/io.h>
> +#include<linux/err.h>
> +#include<linux/platform_device.h>
> +#include<linux/clk.h>
> +#include<linux/regulator/consumer.h>
> +
> +#include<mach/map.h>
> +#include<mach/regs-clock.h>
> +
> +#include<plat/dsim.h>
> +#include<plat/clock.h>
> +#include<plat/regs-dsim.h>

> +
> +static int s5p_dsim_enable_d_phy(struct dsim_global *dsim, unsigned int enable)
> +{
> +	unsigned int reg;
> +
> +	WARN_ON(dsim = NULL);
> +
> +	reg = readl(S5P_MIPI_CONTROL)&  ~(1<<  0);
> +	reg |= (enable<<  0);
> +	writel(reg, S5P_MIPI_CONTROL);

You may want to use __raw_readl(), __raw_writel here instead
since the addresses used are statically remapped.

> +
> +	dev_dbg(dsim->dev, "%s : %x\n", __func__, reg);
> +
> +	return 0;
> +}
> +
> +static int s5p_dsim_enable_dsi_master(struct dsim_global *dsim,
> +	unsigned int enable)
> +{
> +	unsigned int reg;
> +
> +	WARN_ON(dsim = NULL);

Issuing a warning when "dsim" is NULL and then crashing on a dereference 
of it seems rather pointless to me. But it might be just me.

> +
> +	reg = readl(S5P_MIPI_CONTROL)&  ~(1<<  2);
> +	reg |= (enable<<  2);
> +	writel(reg, S5P_MIPI_CONTROL);
> +
> +	dev_dbg(dsim->dev, "%s : %x\n", __func__, reg);
> +
> +	return 0;
> +}
> +
> +int s5p_dsim_part_reset(struct dsim_global *dsim)
> +{
> +	WARN_ON(dsim = NULL);
> +
> +	writel(S5P_MIPI_M_RESETN, S5P_MIPI_PHY_CON0);
> +
> +	dev_dbg(dsim->dev, "%s\n", __func__);
> +
> +	return 0;
> +}
> +
> +int s5p_dsim_init_d_phy(struct dsim_global *dsim)
> +{
> +	WARN_ON(dsim = NULL);
> +
> +	/**
> +	 * DPHY and Master block must be enabled at the system initialization
> +	 * step before data access from/to DPHY begins.
> +	 */
> +	s5p_dsim_enable_d_phy(dsim, 1);
> +
> +	s5p_dsim_enable_dsi_master(dsim, 1);

It looks like two separate functions which are just changing different 
bits in the same IO register are created and then these functions are 
used only here. I think it would be worth to make it more compact. We 
should be trying try to keep the platform device helpers as lean as 
possible.

> +
> +	dev_dbg(dsim->dev, "%s\n", __func__);
> +
> +	return 0;
> +}
> +
> +int s5p_dsim_mipi_power(struct dsim_global *dsim, struct regulator *p_mipi_1_1v,
> +	struct regulator *p_mipi_1_8v, unsigned int enable)
> +{
> +	int ret = -1;
> +
> +	WARN_ON(dsim = NULL);
> +
> +	if (IS_ERR(p_mipi_1_1v) || IS_ERR(p_mipi_1_8v)) {
> +		dev_err(dsim->dev, "p_mipi_1_1v or p_mipi_1_8v is NULL.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (enable) {
> +		if (p_mipi_1_1v)
> +			ret = regulator_enable(p_mipi_1_1v);
> +
> +		if (ret<  0) {
> +			dev_err(dsim->dev,
> +				"failed to enable regulator mipi_1_1v.\n");
> +			return ret;
> +		}
> +
> +		if (p_mipi_1_8v)
> +			ret = regulator_enable(p_mipi_1_8v);
> +
> +		if (ret<  0) {
> +			dev_err(dsim->dev,
> +				"failed to enable regulator mipi_1_8v.\n");
> +			return ret;
> +		}
> +	} else {
> +		if (p_mipi_1_1v)
> +			ret = regulator_force_disable(p_mipi_1_1v);
> +		if (ret<  0) {
> +			dev_err(dsim->dev,
> +				"failed to disable regulator mipi_1_1v.\n");
> +			return ret;
> +		}
> +
> +		if (p_mipi_1_8v)
> +			ret = regulator_force_disable(p_mipi_1_8v);
> +		if (ret<  0) {
> +			dev_err(dsim->dev,
> +				"failed to disable regulator mipi_1_8v.\n");
> +			return ret;
> +		}
> +	}
> +
> +	return ret;
> +}

This function seem to be called only in the driver and it uses driver's 
(private?) data, so can you explain what is the purpose of having it in 
arch?
I suspect all the above regulator handling code could well be moved to 
the driver. Am I missing something?

> diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
> index 65dbfa8..73a34e0 100644
> --- a/arch/arm/plat-s5p/Kconfig
> +++ b/arch/arm/plat-s5p/Kconfig
> @@ -56,3 +56,8 @@ config S5P_DEV_ONENAND
>   	bool
>   	help
>   	  Compile in platform device definition for OneNAND controller
> +
> +config S5P_DEV_DSIM
> +	bool
> +	help
> +	  Compile in platform device definitions for MIPI-DSI


-- 
Regards,
Sylwester
