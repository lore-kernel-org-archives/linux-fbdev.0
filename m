From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 25 Feb 2016 16:08:24 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <3564059.gK0TOyJAie@wuerfel>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <56CC60C4.6040908@ti.com>
 <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
In-Reply-To: <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 25 February 2016 15:04:52 Linus Walleij wrote:
> 
> I add support for doing this for the Integrator and RealView in
> the patch set, by grabbing a handle to the system controller
> where they have a few "misc registers". However if you look at
> it:
> 
> static void integrator_clcd_enable(struct clcd_fb *fb)
> {
>         struct fb_var_screeninfo *var = &fb->fb.var;
>         u32 val;
> 
>         dev_info(&fb->dev->dev, "enable Integrator CLCD connectors\n");
> 
>         val = INTEGRATOR_CLCD_LCD_STATIC1 | INTEGRATOR_CLCD_LCD_STATIC2 |
>                 INTEGRATOR_CLCD_LCD0_EN | INTEGRATOR_CLCD_LCD1_EN;
>         if (var->bits_per_pixel <= 8 ||
>             (var->bits_per_pixel = 16 && var->green.length = 5))
>                 /* Pseudocolor, RGB555, BGR555 */
>                 val |= INTEGRATOR_CLCD_LCDMUX_VGA555;
>         else if (fb->fb.var.bits_per_pixel <= 16)
>                 /* truecolor RGB565 */
>                 val |= INTEGRATOR_CLCD_LCDMUX_VGA565;
>         else
>                 val = 0; /* no idea for this, don't trust the docs */
> 
>         regmap_update_bits(versatile_syscon_map,
>                            INTEGRATOR_HDR_CTRL_OFFSET,
>                            0,
>                            INTEGRATOR_CLCD_MASK);
> }
> 
> This is stuff that is so closely tied in to the fbdev driver that even
> if it is SoC-specific (and reside in arch/arm/mach-integrator etc
> today) it would be hard to argument that it should not be part
> of the fbdev driver: what it does is connect the lines out of the
> CLCD block to the physical VGA encode chip in different ways
> depending on how the pixels were set up.

I think the nicest approach here would be to make this a layered
driver, where you have a separate platform_driver instance
that contains all the versatile specific add-ons, and this calls
into the common driver that handles everything that is not specific
to versatile.

It may not be worth investing much into a rework to get there
though, so simply putting it all into one module sounds like
a reasonable compromise.

	Arnd
