From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Aug 2015 08:21:04 +0000
Subject: Re: [PATCH] fbdev: remove unnecessary memset in vfb
Message-Id: <CAMuHMdW9g4h0EX_gZsXiTfaXsOTtqOqVN+SN=GtV8zNRQo_LXA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1434632512-128161-1-git-send-email-marcinch7@gmail.com>
In-Reply-To: <1434632512-128161-1-git-send-email-marcinch7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Marcin Chojnacki <marcinch7@gmail.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, Jun 18, 2015 at 3:01 PM, Marcin Chojnacki <marcinch7@gmail.com> wrote:
> In vfb_probe memory is allocated using rvmalloc which automatically
> sets the allocated memory to zero. This patch removes the second
> unnecessary memset in vfb_probe.
>
> Signed-off-by: Marcin Chojnacki <marcinch7@gmail.com>
> ---
>  drivers/video/fbdev/vfb.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
> index 70a897b..b2d38b7 100644
> --- a/drivers/video/fbdev/vfb.c
> +++ b/drivers/video/fbdev/vfb.c
> @@ -490,14 +490,6 @@ static int vfb_probe(struct platform_device *dev)
>         if (!(videomemory = rvmalloc(videomemorysize)))
>                 return retval;
>
> -       /*
> -        * VFB must clear memory to prevent kernel info
> -        * leakage into userspace
> -        * VGA-based drivers MUST NOT clear memory if
> -        * they want to be able to take over vgacon
> -        */
> -       memset(videomemory, 0, videomemorysize);
> -

As vfb also serves as a sample driver, I think it would be worthwhile to move
the comment to rvmalloc().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
