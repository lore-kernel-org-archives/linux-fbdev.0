From: Colin Cross <ccross@android.com>
Date: Wed, 17 Mar 2010 00:31:28 +0000
Subject: Re: [RFC/PATCH 08/10] [ARM] tegra: Add framebuffer driver
Message-Id: <d73d4eaf1003161731h2b8032dch55baf7b49eede625@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <4344f3c71003151538r7dc30e01uc9885ca5d3f327cd@mail.gmail.com>
	<1268721688-27550-2-git-send-email-konkers@google.com>
	<1268721688-27550-3-git-send-email-konkers@google.com>
	<1268721688-27550-4-git-send-email-konkers@google.com>
	<1268721688-27550-5-git-send-email-konkers@google.com>
	<1268721688-27550-6-git-send-email-konkers@google.com>
	<1268721688-27550-7-git-send-email-konkers@google.com>
	<1268721688-27550-8-git-send-email-konkers@google.com>
	<1268721688-27550-9-git-send-email-konkers@google.com>
	<45a44e481003160057oaf4a75ax2ec6c9eee9f4a3e9@mail.gmail.com>
In-Reply-To: <45a44e481003160057oaf4a75ax2ec6c9eee9f4a3e9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

(Sorry about the HTML - resending in plain text for the linux-fbdev list)

Hi Jaya, thanks for your comments.

On Tue, Mar 16, 2010 at 12:57 AM, Jaya Kumar <jayakumar.lkml@gmail.com>wrote:

> Hi Colin, Erik,
>
> Interesting work.
>
> I'd recommend CCing linux-fbdev as well in future so that fbdev folks
> can also get a chance to review your new fbdev driver.

Will do

> +struct tegra_fb_lcd_data {
> > +       int     fb_xres;
> > +       int     fb_yres;
> > +       int     lcd_xres;
> > +       int     lcd_yres;
> > +       int     bits_per_pixel;
> > +};
>
> I'm trying to understand what's the difference between fb and lcd *res.

fb res is the resolution of the framebuffer driver as seen by userspace.
 lcd res is the resolution of the screen connected to the Tegra pins.  If
they are different, the Tegra display block can do scaling on the output.
 Generally they will be the same.  I'll add a comment to the lcd resolution.


> > +config FB_TEGRA
> > +       tristate "NVIDIA Tegra SoC display support"
> > +       depends on ARCH_TEGRA && FB = y
> > +       select FB_CFB_FILLRECT
> > +       select FB_CFB_COPYAREA
> > +       select FB_CFB_IMAGEBLIT
> > +       default FB
> > +       help
> > +         This driver supports the NVIDIA Tegra systems-on-a-chip.  This
> > +         driver can not be compiled as a module.
>
> Out of curiosity, why not?
>
Oversight, the option is tristate, so I'll remove this text.


> > +#define DEBUG 1
>
> You want to enable Debug by default for everyone?

Oops, I'll take it out


> > +struct tegra_fb_info {
> > +       struct clk *clk;
> > +       struct resource *reg_mem;
> > +       struct resource *fb_mem;
> > +       void __iomem *reg_base;
> > +       wait_queue_head_t event_wq;
> > +       unsigned int wait_condition;
> > +       int lcd_xres;
> > +       int lcd_yres;
> > +       int irq;
> > +};
>
> I think a comment about lcd_.res would help us understand what its
> used for and how it differs from fb_.res. How come it is being
> duplicated in multiple structures?

 The tegra_fb_lcd_data struct is passed in as platform_data, and used to
initialize the state in the tegra_fb_info struct.

 > +static int tegra_fb_cursor(struct fb_info *info, struct fb_cursor
> *cursor)
> > +{
> > +       return 0;
> > +}
> > +
> > +static int tegra_fb_sync(struct fb_info *info)
> > +{
> > +       return 0;
> > +}
>
> Out of curiosity, why populate these functions if they don't do anything?

They were placeholders, I'll remove them until they get implemented.


>  > +
> > +#ifdef DEBUG
> > +#define DUMP_REG(a) pr_info("%-32s\t%03x\t%08x\n", #a, a,
> tegra_fb_readl(tegra_fb, a));
>
> Could pr_debug be useful above?
>
The dump_regs function still needs to be inside the #ifdef DEBUG, but I'll
change the pr_info to pr_debug to lower the log level.


>  > +static struct fb_ops tegra_fb_ops = {
> > +       .fb_cursor = tegra_fb_cursor,
> > +       .fb_sync = tegra_fb_sync,
>
> These 2 were the empty functions from above. I'm guessing this isn't
> needed.

Removed


>  > +
> > +static int tegra_plat_remove(struct platform_device *pdev)
> > +{
> > +       struct fb_info *fb = platform_get_drvdata(pdev);
> > +       struct tegra_fb_info *tegra_fb = fb->par;
> > +       clk_disable(tegra_fb->clk);
> > +       iounmap(fb->screen_base);
> > +       release_resource(tegra_fb->fb_mem);
> > +       iounmap(tegra_fb->reg_base);
> > +       release_resource(tegra_fb->reg_mem);
> > +       framebuffer_release(fb);
> > +       return 0;
> > +}
> > +
>
> I didn't read through carefully but shouldn't there be an
> unregister_framebuffer in above? Wouldn't the above cause a free while
> the structures could still in use by fb*?
>
Good catch - unregister_framebuffer should be the first call. We generally
don't use modules much, so compiling as a module has been tested, but not
running as a module.

Thanks,
Colin
