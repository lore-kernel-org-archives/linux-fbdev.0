From: Ryan Mallon <ryan@bluewatersys.com>
Date: Thu, 12 Aug 2010 04:34:41 +0000
Subject: Re: [PATCH] video: tegra: add tegra display controller and fb driver
Message-Id: <4C6379E1.4010500@bluewatersys.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1281568272-25871-1-git-send-email-konkers@android.com>
In-Reply-To: <1281568272-25871-1-git-send-email-konkers@android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 08/12/2010 11:11 AM, Erik Gilling wrote:
> This patch supersedes the previous framebuffer patch
> 
> Supports:
> 	* panel setup
> 	* overlays
> 	* suspend / resume
> 
> Notable ommisions:
> 	* support for anything but lvds panels
> 	* inegration with nvhost driver to sync updates with 3D
> 	* FB physical geometry is not set
> 	* lacks interface to set overlay/window x,y offset
> 
> Signed-off-by: Erik Gilling <konkers@android.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Travis Geiselbrecht <travis@palm.com>

Hi Erik,

Just a couple of notes, not really a full review.

> +++ b/drivers/video/tegra/Kconfig
> @@ -0,0 +1,15 @@
> +config TEGRA_DC
> +	tristate "Tegra Display Contoller"
> +	depends on ARCH_TEGRA
> +	help
> +	  Tegra display controller support.
> +
> +config FB_TEGRA
> +	tristate "Tegra Framebuffer driver"
> +	depends on TEGRA_DC && FB = y

How come this depends on FB=y?

> +++ b/drivers/video/tegra/dc/Makefile
> @@ -0,0 +1,2 @@
> +obj-y += dc.o
> +obj-y += rgb.o
> \ No newline at end of file

Is that meant to be there?

> +struct tegra_dc_blend tegra_dc_blend_modes[][DC_N_WINDOWS] = {
> +	{{.nokey = BLEND(NOKEY, FIX, 0xff, 0xff),
> +	  .one_win = BLEND(NOKEY, FIX, 0xff, 0xff),
> +	  .two_win_x = BLEND(NOKEY, FIX, 0x00, 0x00),
> +	  .two_win_y = BLEND(NOKEY, DEPENDANT, 0x00, 0x00),
> +	  .three_win_xy = BLEND(NOKEY, FIX, 0x00, 0x00)},
> +	 {.nokey = BLEND(NOKEY, FIX, 0xff, 0xff),
> +	  .one_win = BLEND(NOKEY, FIX, 0xff, 0xff),
> +	  .two_win_x = BLEND(NOKEY, FIX, 0xff, 0xff),
> +	  .two_win_y = BLEND(NOKEY, DEPENDANT, 0x00, 0x00),
> +	  .three_win_xy = BLEND(NOKEY, DEPENDANT, 0x00, 0x00)},
> +	 {.nokey = BLEND(NOKEY, FIX, 0xff, 0xff),
> +	  .one_win = BLEND(NOKEY, FIX, 0xff, 0xff),
> +	  .two_win_x = BLEND(NOKEY, ALPHA, 0xff, 0xff),
> +	  .two_win_y = BLEND(NOKEY, ALPHA, 0xff, 0xff),
> +	  .three_win_xy = BLEND(NOKEY, ALPHA, 0xff, 0xff)}
> +	}
> +};

Tab delimiting this would make it a bit more readable.

> +#define DUMP_REG(a) do {			\
> +	snprintf(buff, sizeof(buff), "%-32s\t%03x\t%08lx\n", \
> +		 #a, a, tegra_dc_readl(dc, a));		      \
> +	print(data, buff);				      \
> +	} while (0)
> +
> +static void _dump_regs(struct tegra_dc *dc, void *data,
> +		       void (* print)(void *data, const char *str))
> +{
> +	int i;
> +	char buff[256];
> +
> +	DUMP_REG(DC_CMD_GENERAL_INCR_SYNCPT);
> +	DUMP_REG(DC_CMD_GENERAL_INCR_SYNCPT_CNTRL);
> +	DUMP_REG(DC_CMD_GENERAL_INCR_SYNCPT_ERROR);

<snip>

The dump_regs code is very long for a debugging feature. Can it just be
replaced by a for loop which prints the offsets and values of each register?
> +
> +#undef DUMP_REG
> +
> +#ifdef DEBUG
> +static void dump_regs_print(void *data, const char *str)
> +{
> +	struct tegra_dc *dc = data;
> +	dev_dbg(&dc->pdev->dev, "%s", str);
> +}
> +
> +static void dump_regs(struct tegra_dc *dc)
> +{
> +	_dump_regs(dc, dc, dump_regs_print);
> +}
> +#else
> +
> +static void dump_regs(struct tegra_dc *dc) {}
> +
> +#endif
> +
> +#ifdef CONFIG_DEBUG_FS
> +
> +static void dbg_regs_print(void *data, const char *str)
> +{
> +	struct seq_file *s = data;
> +
> +	seq_printf(s, "%s", str);
> +}
> +
> +#undef DUMP_REG
> +
> +static int dbg_dc_show(struct seq_file *s, void *unused)
> +{
> +	struct tegra_dc *dc = s->private;
> +
> +	_dump_regs(dc, s, dbg_regs_print);
> +
> +	return 0;
> +}

This all looks a bit confusing (especially the undef stuff). Why do you
have both a debugfs interface to the registers and one which prints them
using dev_dbg?

> +static void tegra_dc_dbg_add(struct tegra_dc *dc)
> +{
> +	char name[32];
> +
> +	snprintf(name, sizeof(name), "tegra_dc%d_regs", dc->pdev->id);
> +	(void) debugfs_create_file(name, S_IRUGO, NULL, dc, &dbg_fops);

Don't cast the return value to void. Possibly print a warning if the
call fails?

> +/* does not support syncing windows on multiple dcs in one call */
> +int tegra_dc_sync_windows(struct tegra_dc_win *windows[], int n)
> +{
> +	if (n < 1 || n > DC_N_WINDOWS)
> +		return -EINVAL;

 if (n < 1 || n >= DC_N_WINDOWS) ?

> +	return wait_event_interruptible_timeout(windows[0]->dc->wq,
> +					 tegra_dc_windows_are_clean(windows, n),
> +					 HZ);
> +}
> +EXPORT_SYMBOL(tegra_dc_sync_windows);

<snip>

> +static irqreturn_t tegra_dc_irq(int irq, void *ptr)
> +{
> +	struct tegra_dc *dc = ptr;
> +	unsigned long status;
> +	unsigned long flags;
> +	unsigned long val;
> +	int i;
> +
> +

There are a few places like this with excess blank lines.

> +	tegra_dc_init(dc);
> +
> +	tegra_dc_set_blending(dc, tegra_dc_blend_modes[0]);
> +
> +	platform_set_drvdata(pdev, dc);
> +
> +	tegra_dc_dbg_add(dc);
> +
> +	dev_info(&pdev->dev, "probed\n");

dev_dbg? Also, probably don't need all those blank lines.

> +#ifdef CONFIG_PM
> +static int tegra_dc_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	struct tegra_dc *dc = platform_get_drvdata(pdev);
> +
> +	dev_info(&pdev->dev, "suspend\n");

dev_dbg?

> +	disable_irq(dc->irq);
> +	tegra_periph_reset_assert(dc->clk);
> +	clk_disable(dc->clk);
> +
> +	return 0;
> +}
> +
> +static int tegra_dc_resume(struct platform_device *pdev)
> +{
> +	struct tegra_dc *dc = platform_get_drvdata(pdev);
> +	struct tegra_dc_win *wins[DC_N_WINDOWS];
> +	int i;
> +
> +	dev_info(&pdev->dev, "resume\n");

dev_dbg?

> +extern int suspend_get(char *buffer, struct kernel_param *kp)
> +{
> +	return 0;
> +}
> +
> +int suspend;

Should be static? Have a global called suspend is likely to cause issues
somewhere.

> +module_param_call(suspend, suspend_set, suspend_get, &suspend, 0644);
> +
> +struct platform_driver tegra_dc_driver = {
> +	.driver = {
> +		.name = "tegradc",
> +		.owner = THIS_MODULE,
> +	},
> +	.probe = tegra_dc_probe,
> +	.remove = tegra_dc_remove,
> +#ifdef CONFIG_PM
> +	.suspend = tegra_dc_suspend,
> +	.resume = tegra_dc_resume,
> +#endif
> +};

Also should be static?

> +static inline unsigned long tegra_dc_readl(struct tegra_dc *dc,
> +					   unsigned long reg)
> +{
> +	return readl(dc->base + reg * 4);
> +}

Can these functions use __raw_readl/__raw_writel?

> +static void tegra_fb_fillrect(struct fb_info *info,
> +			      const struct fb_fillrect *rect)
> +{
> +	cfb_fillrect(info, rect);
> +}
> +
> +static void tegra_fb_copyarea(struct fb_info *info,
> +			      const struct fb_copyarea *region)
> +{
> +	cfb_copyarea(info, region);
> +}
> +
> +static void tegra_fb_imageblit(struct fb_info *info,
> +			       const struct fb_image *image)
> +{
> +	cfb_imageblit(info, image);
> +}

You can just set the cfb_ functions directly in the fb_ops. See below:

> +static struct fb_ops tegra_fb_ops = {
> +	.owner = THIS_MODULE,
> +	.fb_open = tegra_fb_open,
> +	.fb_release = tegra_fb_release,
> +	.fb_check_var = tegra_fb_check_var,
> +	.fb_set_par = tegra_fb_set_par,
> +	.fb_setcolreg = tegra_fb_setcolreg,
> +	.fb_pan_display = tegra_fb_pan_display,
> +	.fb_fillrect = tegra_fb_fillrect,
> +	.fb_copyarea = tegra_fb_copyarea,
> +	.fb_imageblit = tegra_fb_imageblit,

Should be:

	.fb_fillrect  = cfb_fillrect,
	.fb_copyarea  = cfb_fillarea,
	.fb_imageblit = cfb_imageblit,

Also (nitpicky) tab delimit to make it more readable.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
