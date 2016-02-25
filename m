From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Feb 2016 14:04:52 +0000
Subject: Re: [PATCH 11/11] ARM: versatile: move CLCD configuration to device tree
Message-Id: <CACRpkdZd8TLdsi7_cOrqzcqWKJrfdp4Vz2sx5ozpwJXOj0fa+Q@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <3695074.sKSIyOjpjD@wuerfel>
 <CACRpkdZjfjOCFUucF1U5yVZBxSwa41GKEMv-HHQE=ymF2NZ21g@mail.gmail.com>
 <6859810.tb1t0IEONi@wuerfel> <56CC57FC.20707@ti.com>
 <CACRpkdYNaNtQQJ-tsBe5ksa4-z380ZQj-zN8ZnK0ED2kNPUwvg@mail.gmail.com>
 <56CC60C4.6040908@ti.com>
In-Reply-To: <56CC60C4.6040908@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 23, 2016 at 2:38 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

> Maybe Versatile is different. If CLCD is only used on that board, or a
> small family of boards, from one vendor, I guess it is maintainable to
> have board specific driver parts for CLCD. But if CLCD can be used by
> many vendors in many different boards, I'd steer clear of board specific
> driver code.

OK I think at this point we would say that CLCD is a legacy driver.
It is a PrimceCell (IP block) made by ARM Ltd for their reference
designs, and intended for demonstration purposes. It is used in
these:
arch/arm/mach-integrator/
arch/arm/mach-versatile/
arch/arm/mach-realview/
arch/arm/mach-vexpress/

At the last iteration of their reference designs, ARM invented a
new display driver called HDLCD, which you can find in
drivers/gpu/drm/arm in linux-next. Thus the CLCD is now legacy.

As part of signing a deal with ARM to synthesize their silicon,
vendors get copies of the IP blocks to jumpstart design work.
Sometimes they will design their own display controller, sometimes
they will take the ARM CLCD and synthesize it right off
and not innovate around it at all. That is why CLCD also
appears in:
arch/arm/configs/axm55xx_defconfig
arch/arm/configs/lpc18xx_defconfig
arch/arm/boot/dts/lpc18xx.dtsi
arch/arm/configs/lpc32xx_defconfig
arch/arm/boot/dts/lpc32xx.dtsi
arch/arm/configs/netx_defconfig
arch/arm/configs/spear3xx_defconfig

Sometimes the vendors will tweak the CLCD. St Microelectronics
did the latter, and that is why I add support for that variant as
well.

HOWEVER: the ARM Versatile is the *only* platform I have
seen of these that have plug'n'play for the display.

*All* the others
will be very happy with *ONE* display defined as panel in the
device tree, and off they go. Usually VGA. And that will look
much like arch/arm/boot/dts/vexpress-v2m.dtsi already look
like today, using "panel-dpi" to define their displays.

They and their displays may need some board-specific or SoC
specific tweaks though, just like the Nomadik. The Vexpress is
happy to be able to go without, because I guess it is hard-coded
to just use the DVI output, so no path for the signal needs to be
set up.

I add support for doing this for the Integrator and RealView in
the patch set, by grabbing a handle to the system controller
where they have a few "misc registers". However if you look at
it:

static void integrator_clcd_enable(struct clcd_fb *fb)
{
        struct fb_var_screeninfo *var = &fb->fb.var;
        u32 val;

        dev_info(&fb->dev->dev, "enable Integrator CLCD connectors\n");

        val = INTEGRATOR_CLCD_LCD_STATIC1 | INTEGRATOR_CLCD_LCD_STATIC2 |
                INTEGRATOR_CLCD_LCD0_EN | INTEGRATOR_CLCD_LCD1_EN;
        if (var->bits_per_pixel <= 8 ||
            (var->bits_per_pixel = 16 && var->green.length = 5))
                /* Pseudocolor, RGB555, BGR555 */
                val |= INTEGRATOR_CLCD_LCDMUX_VGA555;
        else if (fb->fb.var.bits_per_pixel <= 16)
                /* truecolor RGB565 */
                val |= INTEGRATOR_CLCD_LCDMUX_VGA565;
        else
                val = 0; /* no idea for this, don't trust the docs */

        regmap_update_bits(versatile_syscon_map,
                           INTEGRATOR_HDR_CTRL_OFFSET,
                           0,
                           INTEGRATOR_CLCD_MASK);
}

This is stuff that is so closely tied in to the fbdev driver that even
if it is SoC-specific (and reside in arch/arm/mach-integrator etc
today) it would be hard to argument that it should not be part
of the fbdev driver: what it does is connect the lines out of the
CLCD block to the physical VGA encode chip in different ways
depending on how the pixels were set up.

Yours,
Linus Walleij
