From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 May 2014 16:56:21 +0000
Subject: Re: [PATCH] offb: Fix little-endian support
Message-Id: <CAMuHMdWWMZQz90xP-KW0RysqQAf-NN_82R27=zDTOzErOC_3Pw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1400073709-15012-1-git-send-email-tiwai@suse.de>
	<5373772D.9060807@fr.ibm.com>
In-Reply-To: <5373772D.9060807@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Takashi Iwai <tiwai@suse.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, May 14, 2014 at 4:01 PM, Cedric Le Goater <clg@fr.ibm.com> wrote:
> --- linux.git.orig/drivers/video/fbmem.c
> +++ linux.git/drivers/video/fbmem.c
> @@ -252,7 +252,8 @@ static void  fb_set_logo_truepalette(str
>         blueshift  = info->var.blue.offset  - (8 - info->var.blue.length);
>
>         for ( i = 0; i < logo->clutsize; i++) {
> -               palette[i+32] = (safe_shift((clut[0] & redmask), redshift) |
> +               palette[i+32] = fb_cmap_byteswap(info,
> +                                safe_shift((clut[0] & redmask), redshift) |
>                                  safe_shift((clut[1] & greenmask), greenshift) |
>                                  safe_shift((clut[2] & bluemask), blueshift));
>                 clut += 3;
> @@ -271,7 +272,8 @@ static void fb_set_logo_directpalette(st
>         blueshift = info->var.blue.offset;
>
>         for (i = 32; i < 32 + logo->clutsize; i++)
> -               palette[i] = i << redshift | i << greenshift | i << blueshift;
> +               palette[i] = fb_cmap_byteswap(info, i << redshift |
> +                                       i << greenshift | i << blueshift);

I find it very strange you have to touch the generic code in such a way...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
