From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [RFC 2.6.26-rc9 4/5] am200epd: convert to
 shared fb and use gpio api
Date: Thu, 31 Jul 2008 17:46:42 +0200
Message-ID: <20080731174642.a55e1e39.krzysztof.h1@poczta.fm>
References: <1217422269-11093-1-git-send-email-jayakumar.lkml@gmail.com>
	<1217422269-11093-5-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOaHY-00052F-Cc for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 08:41:36 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOaHT-0007HB-6q
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 08:41:36 -0700
In-Reply-To: <1217422269-11093-5-git-send-email-jayakumar.lkml@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

On Wed, 30 Jul 2008 08:51:08 -0400
Jaya Kumar <jayakumar.lkml@gmail.com> wrote:

> The original am200epd driver was designed with bad assumptions. It
> manipulated GPSR/GPLR registers directly. It relied on direct access to the
> pxa LCDC registers which have since conflicted with commit
> ce4fb7b892a6d6c6a0f87366b26fd834d2923dd7 . This patch moves it into mach-pxa
> and overhauls it to use pxafb's fb. It now uses the generic GPIO api.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> ---
>  arch/arm/mach-pxa/Kconfig    |    3 +
>  arch/arm/mach-pxa/Makefile   |    1 +
>  arch/arm/mach-pxa/am200epd.c |  323 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/video/Kconfig        |   13 --
>  drivers/video/Makefile       |    1 -
>  drivers/video/am200epd.c     |  295 --------------------------------------
>  6 files changed, 327 insertions(+), 309 deletions(-)
>  create mode 100644 arch/arm/mach-pxa/am200epd.c
>  delete mode 100644 drivers/video/am200epd.c
> 
> diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
> index 3e28521..945014e 100644
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -243,6 +243,9 @@ config PCM990_DISPLAY_NONE
>  
>  endchoice
>  
> +config MACH_AM200EPD
> +	depends on MACH_GUMSTIX_F
> +	bool "Enable AM200EPD board support"
>  
>  config PXA_EZX
>  	bool "Motorola EZX Platform"
> diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
> index 5220a5c..618fe96 100644
> --- a/arch/arm/mach-pxa/Makefile
> +++ b/arch/arm/mach-pxa/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_CPU_PXA320)	+= pxa320.o
>  
>  # Specific board support
>  obj-$(CONFIG_ARCH_GUMSTIX)	+= gumstix.o
> +obj-$(CONFIG_MACH_AM200EPD)	+= am200epd.o
>  obj-$(CONFIG_ARCH_LUBBOCK)	+= lubbock.o
>  obj-$(CONFIG_MACH_LOGICPD_PXA270) += lpd270.o
>  obj-$(CONFIG_MACH_MAINSTONE)	+= mainstone.o
> diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
> new file mode 100644
> index 0000000..f5bb902
> --- /dev/null
> +++ b/arch/arm/mach-pxa/am200epd.c
> @@ -0,0 +1,323 @@
> +/*
> + * am200epd.c -- Platform device for AM200 EPD kit
> + *
> + * Copyright (C) 2008, Jaya Kumar
> + *
> + * This file is subject to the terms and conditions of the GNU General Public
> + * License. See the file COPYING in the main directory of this archive for
> + * more details.
> + *
> + * Layout is based on skeletonfb.c by James Simmons and Geert Uytterhoeven.
> + *
> + * This work was made possible by help and equipment support from E-Ink
> + * Corporation. http://support.eink.com/community
> + *
> + * This driver is written to be used with the Metronome display controller.
> + * on the AM200 EPD prototype kit/development kit with an E-Ink 800x600
> + * Vizplex EPD on a Gumstix board using the Lyre interface board.
> + *
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/string.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/fb.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/irq.h>
> +#include <linux/gpio.h>
> +
> +#include <asm/arch/pxafb.h>
> +
> +#include <video/metronomefb.h>
> +
> +#include "generic.h"
> +#include "devices.h"
> +
> +static unsigned int panel_type = 6;
> +static struct platform_device *am200_device;
> +static struct metronome_board am200_board;
> +
> +static struct pxafb_mode_info am200_fb_mode_9inch7 = {
> +	.pixclock	= 40000,
> +	.xres		= 1200/2,
> +	.yres		= 842,
> +	.bpp		= 16,
> +	.hsync_len	= 2,
> +	.left_margin	= 2,
> +	.right_margin	= 2,
> +	.vsync_len	= 1,
> +	.upper_margin	= 2,
> +	.lower_margin	= 25,
> +	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +};
> +
> +static struct pxafb_mode_info am200_fb_mode_8inch = {
> +	.pixclock	= 40000,
> +	.xres		= 1088/2,
> +	.yres		= 791,
> +	.bpp		= 16,
> +	.hsync_len	= 28,
> +	.left_margin	= 8,
> +	.right_margin	= 30,
> +	.vsync_len	= 8,
> +	.upper_margin	= 10,
> +	.lower_margin	= 8,
> +	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +};
> +
> +static struct pxafb_mode_info am200_fb_mode_6inch = {
> +	.pixclock	= 40189,
> +	.xres		= 832/2,
> +	.yres		= 622,
> +	.bpp		= 16,
> +	.hsync_len	= 28,
> +	.left_margin	= 34,
> +	.right_margin	= 34,
> +	.vsync_len	= 25,
> +	.upper_margin	= 0,
> +	.lower_margin	= 2,
> +	.sync		= FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
> +};
> +
> +static struct pxafb_mach_info am200_fb_info = {
> +	.modes		= &am200_fb_mode_6inch,
> +	.num_modes	= 1,
> +	.lcd_conn	= LCD_TYPE_COLOR_TFT | LCD_PCLK_EDGE_FALL |
> +			  LCD_AC_BIAS_FREQ(24),
> +};
> +
> +/* register offsets for gpio control */
> +#define LED_GPIO_PIN 51
> +#define STDBY_GPIO_PIN 48
> +#define RST_GPIO_PIN 49
> +#define RDY_GPIO_PIN 32
> +#define ERR_GPIO_PIN 17
> +#define PCBPWR_GPIO_PIN 16
> +static int gpios[] = { LED_GPIO_PIN , STDBY_GPIO_PIN , RST_GPIO_PIN,
> +			RDY_GPIO_PIN, ERR_GPIO_PIN, PCBPWR_GPIO_PIN };
> +static char *gpio_names[] = { "LED" , "STDBY" , "RST", "RDY", "ERR", "PCBPWR" };
> +
> +static int am200_init_gpio_regs(struct metronomefb_par *par)
> +{
> +	int i;
> +	int err;
> +
> +	for (i = 0; i < ARRAY_SIZE(gpios); i++) {
> +		err = gpio_request(gpios[i], gpio_names[i]);
> +		if (err) {
> +			dev_err(&am200_device->dev, "failed requesting "
> +				"gpio %s, err=%d\n", gpio_names[i], err);
> +			goto err_req_gpio;
> +		}
> +	}
> +
> +	gpio_direction_output(LED_GPIO_PIN, 0);
> +	gpio_direction_output(STDBY_GPIO_PIN, 0);
> +	gpio_direction_output(RST_GPIO_PIN, 0);
> +
> +	gpio_direction_input(RDY_GPIO_PIN);
> +	gpio_direction_input(ERR_GPIO_PIN);
> +
> +	gpio_direction_output(PCBPWR_GPIO_PIN, 0);
> +
> +	return 0;
> +
> +err_req_gpio:
> +	while (i > 0)
> +		gpio_free(gpios[i--]);
> +
> +	return err;
> +}
> +
> +static void am200_cleanup(struct metronomefb_par *par)
> +{
> +	int i;
> +
> +	free_irq(IRQ_GPIO(RDY_GPIO_PIN), par->info);
> +
> +	for (i = 0; i < ARRAY_SIZE(gpios); i++)
> +		gpio_free(gpios[i]);
> +}
> +
> +static char __iomem *am200_metromem;
> +static dma_addr_t am200_metromem_dma;

IMO, these variables should be part of metronomefb or am200_device platform data.
The former is better. Use the data pointer in the function below to pass the metronomefb
pointer.

> +static int am200_preshare_video_mem(char __iomem *video_mem, dma_addr_t dma,
> +					struct module *fbmaster, void *data)
> +{
> +
> +	/* try to refcount the caller since we are the consumer after this */
> +	if (!try_module_get(fbmaster))
> +		return -ENODEV;
> +
> +	dev_dbg(&am200_device->dev, "mod_get %p\n", fbmaster);
> +	am200_board.fbmaster = fbmaster;
> +	am200_metromem = video_mem;
> +	am200_metromem_dma = dma;
> +
> +	return 0;
> +}
> +
> +static void am200_unshare_video_mem(void *data)
> +{
> +	struct metronomefb_par *par = data;
> +
> +	dev_dbg(&am200_device->dev, "ENTER %s\n", __func__);
> +	par->metromem = NULL;
> +	par->metromem_dma = 0;
> +	dev_dbg(&am200_device->dev, "mod_put %p\n", am200_board.fbmaster);
> +	module_put(am200_board.fbmaster);
> +}
> +
> +/* this gets called as part of our init. these steps must be done now so
> + * that we can use set_pxa_fb_info */
> +static void __init am200_presetup_fb(void)
> +{
> +	int fw;
> +	int wfm_size;
> +	int padding_size;
> +
> +	switch (panel_type) {
> +	case 6:
> +		am200_fb_info.modes = &am200_fb_mode_6inch;
> +		break;
> +	case 8:
> +		am200_fb_info.modes = &am200_fb_mode_8inch;
> +		break;
> +	case 97:
> +		am200_fb_info.modes = &am200_fb_mode_9inch7;
> +		break;
> +	default:
> +		dev_err(&am200_device->dev, "invalid panel_type selection,"
> +						" setting to 6\n");
> +		am200_fb_info.modes = &am200_fb_mode_6inch;
> +		break;
> +	}
> +
> +	fw = am200_fb_info.modes->xres;
> +	wfm_size = ((16*1024 + 2 + fw - 1) / fw) * fw;
> +	padding_size = PAGE_SIZE + (4 * fw);
> +	am200_fb_info.extra_video_mem = fw + wfm_size + padding_size;
> +	am200_fb_info.share_video_mem = am200_preshare_video_mem;
> +	am200_fb_info.unshare_video_mem = NULL;
> +
> +	set_pxa_fb_info(&am200_fb_info);
> +
> +}
> +
> +/* this gets called by metronomefb as part of its init, in our case, we
> + * have already completed initial framebuffer init in presetup_fb so we
> + * can just assign the parameters for completeness */
> +static int am200_setup_fb(struct metronomefb_par *par)
> +{
> +
> +	am200_fb_info.extra_video_mem = par->extra_size;
> +	am200_fb_info.extra_data = (void *) par;
> +	am200_fb_info.unshare_video_mem = am200_unshare_video_mem;
> +
> +	par->metromem = (unsigned char __force *) am200_metromem;
> +	par->metromem_dma = am200_metromem_dma;
> +
> +	return 0;
> +}
> +
> +static int am200_get_panel_type(void)
> +{
> +	return panel_type;
> +}
> +
> +static irqreturn_t am200_handle_irq(int irq, void *dev_id)
> +{

You may pass metronomefb_par* here to avoid one reference.

> +	struct fb_info *info = dev_id;
> +	struct metronomefb_par *par = info->par;
> +
> +	wake_up_interruptible(&par->waitq);
> +	return IRQ_HANDLED;
> +}
> +
> +static int am200_setup_irq(struct fb_info *info)
> +{
> +	int ret;
> +
> +	ret = request_irq(IRQ_GPIO(RDY_GPIO_PIN), am200_handle_irq,
> +				IRQF_DISABLED|IRQF_TRIGGER_FALLING,
> +				"AM200", info);
> +	if (ret)
> +		dev_err(&am200_device->dev, "request_irq failed: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void am200_set_rst(struct metronomefb_par *par, int state)
> +{
> +	gpio_set_value(RST_GPIO_PIN, state);
> +}
> +
> +static void am200_set_stdby(struct metronomefb_par *par, int state)
> +{
> +	gpio_set_value(STDBY_GPIO_PIN, state);
> +}
> +
> +static int am200_wait_event(struct metronomefb_par *par)
> +{
> +	return wait_event_timeout(par->waitq, gpio_get_value(RDY_GPIO_PIN), HZ);
> +}
> +
> +static int am200_wait_event_intr(struct metronomefb_par *par)
> +{
> +	int ret;
> +
> +	ret = wait_event_interruptible_timeout(par->waitq,
> +					gpio_get_value(RDY_GPIO_PIN), HZ);
> +	return ret;
> +}

You may drop the ret variable here.

> +
> +static struct metronome_board am200_board = {
> +	.owner			= THIS_MODULE,
> +	.setup_irq		= am200_setup_irq,
> +	.setup_io		= am200_init_gpio_regs,
> +	.setup_fb		= am200_setup_fb,
> +	.set_rst		= am200_set_rst,
> +	.set_stdby		= am200_set_stdby,
> +	.met_wait_event		= am200_wait_event,
> +	.met_wait_event_intr	= am200_wait_event_intr,
> +	.get_panel_type		= am200_get_panel_type,
> +	.cleanup		= am200_cleanup,
> +};
> +
> +static int __init am200_init(void)
> +{
> +	int ret;
> +
> +	/* request our platform independent driver */
> +	request_module("metronomefb");
> +
> +	am200_device = platform_device_alloc("metronomefb", -1);

The second parameter is instance id. Probably 0 is better here.

> +	if (!am200_device)
> +		return -ENOMEM;
> +
> +	platform_device_add_data(am200_device, &am200_board,
> +					sizeof(am200_board));
> +
> +	/* this _add binds metronomefb to am200. metronomefb refcounts am200 */
> +	ret = platform_device_add(am200_device);
> +
> +	if (ret)
> +		platform_device_put(am200_device);
> +
> +	am200_presetup_fb();

Should the am200 be set up in case of error?

> +
> +	return ret;
> +}
> +
> +module_param(panel_type, uint, 0);
> +MODULE_PARM_DESC(panel_type, "Select the panel type: 6, 8, 97");
> +
> +module_init(am200_init);
> +
> +MODULE_DESCRIPTION("board driver for am200 metronome epd kit");
> +MODULE_AUTHOR("Jaya Kumar");
> +MODULE_LICENSE("GPL");

Regards,
Krzysztof


----------------------------------------------------------------------
Od puzzla do przepisu! Zagraj i wygraj!
Kliknij >>> http://link.interia.pl/f1eb2


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
