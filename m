From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Aug 2010 20:22:48 +0000
Subject: Re: [PATCH] Add new linearfb driver
Message-Id: <AANLkTin=WN6EmQno+tLo_o_iT=28h0RJW-Xjq-qFysCa@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100825141111.GI21862@riva.ucam.org>
In-Reply-To: <20100825141111.GI21862@riva.ucam.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Colin Watson <cjwatson@canonical.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Jones <pjones@redhat.com>, Matthew Garrett <mjg@redhat.com>

On Wed, Aug 25, 2010 at 16:11, Colin Watson <cjwatson@canonical.com> wrote:
> Split out linearfb from efifb so that boot loaders can program it as a
> simple linear framebuffer on non-EFI systems.  This is useful for boot
> loaders with their own graphics drivers, e.g. GRUB 2, since in some
> cases on x86 they can set up non-VESA modes and thus can't program
> vesafb.

Nice! I guess offb and a few other old drivers could use it, too.

> diff --git a/drivers/video/linearfb.c b/drivers/video/linearfb.c
> new file mode 100644
> index 0000000..c93eaac
> --- /dev/null
> +++ b/drivers/video/linearfb.c

> +int linearfb_get_info(struct platform_device *dev, struct fb_info **p_info)
> +{
> +       int err;
> +       unsigned int size_vmode;
> +       unsigned int size_remap;
> +       unsigned int size_total;
> +       int request_succeeded = 0;
> +       struct fb_info *info;
> +
> +       if (!screen_info.lfb_depth)
> +               screen_info.lfb_depth = 32;
> +       if (!screen_info.pages)
> +               screen_info.pages = 1;
> +       if (!screen_info.lfb_base) {
> +               printk(KERN_DEBUG "linearfb: invalid framebuffer address\n");
> +               return -ENODEV;
> +       }

[...]

Wouldn't it be more logical to extract this info somewhere from the
platform_device's
platform_data? Screen_info is such a legacy thing.
That way linearfb can support multiple displays as well.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
