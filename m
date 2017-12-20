From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Dec 2017 08:26:46 +0000
Subject: Re: [PATCH] vfb: fix video mode and line_length being set when loaded
Message-Id: <CAMuHMdXjkY=6=CDMPNFtxtjw8g52ivV-HdnKX3-mao0TPTabMw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <39a57338-18ac-c64f-1cf1-70a5f905990a@national.shitposting.agency>
In-Reply-To: <39a57338-18ac-c64f-1cf1-70a5f905990a@national.shitposting.agency>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pieter PoroCYon Sluys <pcy@national.shitposting.agency>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi Pieter,

On Wed, Dec 20, 2017 at 1:24 AM, Pieter "PoroCYon" Sluys
<pcy@national.shitposting.agency> wrote:
> Currently, when loading the vfb module, the newly created fbdev
> has a line_length of 0, and its video mode would be PSEUDOCOLOR
> regardless of color depth. (The former could be worked around by
> calling the FBIOPUT_VSCREENINFO ioctl with having the FBACTIVIATE_FORCE
> flag set.) This patch automatically sets the line_length correctly,
> and the video mode is derived from the bit depth now as well.

Thanks for your patch!
This bug was introduced in 2002, when converting the driver to the new
internal API.

Please add your "Signed-off-by", cfr.
Documentation/process/submitting-patches.rst.

> --- a/drivers/video/fbdev/vfb.c
> +++ b/drivers/video/fbdev/vfb.c
> @@ -239,8 +239,25 @@ static int vfb_check_var(struct fb_var_screeninfo *var,
>   */
>  static int vfb_set_par(struct fb_info *info)
>  {
> +       switch (info->var.bits_per_pixel) {
> +               case 1:
> +                       info->fix.visual = FB_VISUAL_MONO01;
> +                       break;
> +               case 2:
> +               case 4:

You can drop the tests for 2 and 4, as these are no longer used by the driver.

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
