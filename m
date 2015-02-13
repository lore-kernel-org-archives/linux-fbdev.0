From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Fri, 13 Feb 2015 11:35:15 +0000
Subject: Re: [PATCH 1/2]Trivial patch: to solve indentation warnings in amba-clcd.c driver
Message-Id: <20150213113515.GW8656@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150213112125.GA25078@linuxteamdev.amer.dell.com>
In-Reply-To: <20150213112125.GA25078@linuxteamdev.amer.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Parmeshwr Prasad <parmeshwr_prasad@dell.com>
Cc: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, trivial@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Feb 13, 2015 at 06:21:33AM -0500, Parmeshwr Prasad wrote:
> @@ -288,7 +288,7 @@ static int clcdfb_set_par(struct fb_info *info)
>         struct clcd_regs regs;
> 
>         fb->fb.fix.line_length = fb->fb.var.xres_virtual *
> -                                fb->fb.var.bits_per_pixel / 8;
> +           fb->fb.var.bits_per_pixel / 8;

NAK on this one.  The code as it stood before is much clearer since
we align the expression with the start of it on the preceding line.

> @@ -345,17 +345,17 @@ clcdfb_setcolreg(unsigned int regno, unsigned int red,
> unsigned int green,
> 
>         if (regno < 16)
>                 fb->cmap[regno] = convert_bitfield(transp, &fb->fb.var.transp) |
> -                                 convert_bitfield(blue, &fb->fb.var.blue) |
> -                                 convert_bitfield(green, &fb->fb.var.green) |
> -                                 convert_bitfield(red, &fb->fb.var.red);
> +                   convert_bitfield(blue, &fb->fb.var.blue) |
> +                   convert_bitfield(green, &fb->fb.var.green) |
> +                   convert_bitfield(red, &fb->fb.var.red);

Ditto.

> @@ -612,15 +611,15 @@ static int clcdfb_of_init_tft_panel(struct clcd_fb *fb,
> u32 r0, u32 g0, u32 b0)
>                 u32 r0, g0, b0;
>                 u32 caps;
>         } panels[] = {
> -               { 0x110, 1,  7, 13, CLCD_CAP_5551 },
> -               { 0x110, 0,  8, 16, CLCD_CAP_888 },
> -               { 0x111, 4, 14, 20, CLCD_CAP_444 },
> -               { 0x111, 3, 11, 19, CLCD_CAP_444 | CLCD_CAP_5551 },
> -               { 0x111, 3, 10, 19, CLCD_CAP_444 | CLCD_CAP_5551 |
> -                                   CLCD_CAP_565 },
> -               { 0x111, 0,  8, 16, CLCD_CAP_444 | CLCD_CAP_5551 |
> -                                   CLCD_CAP_565 | CLCD_CAP_888 },
> -       };
> +               {
> +               0x110, 1, 7, 13, CLCD_CAP_5551}, {
> +               0x110, 0, 8, 16, CLCD_CAP_888}, {
> +               0x111, 4, 14, 20, CLCD_CAP_444}, {
> +               0x111, 3, 11, 19, CLCD_CAP_444 | CLCD_CAP_5551}, {
> +               0x111, 3, 10, 19, CLCD_CAP_444 | CLCD_CAP_5551 |
> +                           CLCD_CAP_565}, {
> +       0x111, 0, 8, 16, CLCD_CAP_444 | CLCD_CAP_5551 |
> +                           CLCD_CAP_565 | CLCD_CAP_888},};

The original is better than what you're proposing.

> @@ -675,7 +674,7 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
>                  * result is a valid format.
>                  */
>                 bpp = max_bandwidth / (1000 / 8)
> -                       / PICOS2KHZ(fb->panel->mode.pixclock);
> +                   / PICOS2KHZ(fb->panel->mode.pixclock);

Not quite enough indentation.

> @@ -717,7 +716,9 @@ static int clcdfb_of_vram_setup(struct clcd_fb *fb)
>                 return -ENOMEM;
> 
>         fb->fb.fix.smem_start = of_translate_address(memory,
> -                       of_get_address(memory, 0, &size, NULL));
> +                                                    of_get_address(memory, 0,
> +                                                                   &size,
> +                                                                   NULL));

Thi sis the exception to the rule - where scrunching an expression so that
it takes multiple lines because of lack of right-hand space is not on.
The former version was a lot better.

> @@ -757,9 +757,9 @@ static int clcdfb_of_dma_setup(struct clcd_fb *fb)
>                 return err;
> 
>         framesize = fb->panel->mode.xres * fb->panel->mode.yres *
> -                       fb->panel->bpp / 8;
> +           fb->panel->bpp / 8;

Similar comments as before.

> @@ -837,7 +838,8 @@ static int clcdfb_probe(struct amba_device *dev, const
> struct amba_id *id)
> 
>         fb = kzalloc(sizeof(struct clcd_fb), GFP_KERNEL);
>         if (!fb) {
> -               printk(KERN_INFO "CLCD: could not allocate new clcd_fb
> struct\n");
> +               printk(KERN_INFO
> +                      "CLCD: could not allocate new clcd_fb struct\n");

Converting this to pr_info() would be better, or even dev_err().

> @@ -891,21 +893,21 @@ static int clcdfb_remove(struct amba_device *dev)
> 
>  static struct amba_id clcdfb_id_table[] = {
>         {
> -               .id     = 0x00041110,
> -               .mask   = 0x000ffffe,
> -       },
> -       { 0, 0 },
> +        .id = 0x00041110,
> +        .mask = 0x000ffffe,
> +        },
> +       {0, 0},

The original is loads better.

>  };
> 
>  MODULE_DEVICE_TABLE(amba, clcdfb_id_table);
> 
>  static struct amba_driver clcd_driver = {
> -       .drv            = {
> -               .name   = "clcd-pl11x",
> -       },
> -       .probe          = clcdfb_probe,
> -       .remove         = clcdfb_remove,
> -       .id_table       = clcdfb_id_table,
> +       .drv = {
> +               .name = "clcd-pl11x",
> +               },

Yuck.  Again, the original is loads better.

And... your message seems to suffer total whitespace breakage - all
tabs seem to be converted to 8 spaces.  Your patch will not apply
as long as that kind of breakage exists...

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
