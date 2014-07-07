From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 07 Jul 2014 20:43:41 +0000
Subject: Re: [PATCH] video: fbdev: core: fbmon.c: Cleaning up useless assignment of function parameter
Message-Id: <CAMuHMdV++wyFLbqmnqEBTrWdgTNKpy=r9-mYFhQGCj7kUUUhKQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404667555-14675-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404667555-14675-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, David Ung <davidu@nvidia.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Jul 6, 2014 at 7:25 PM, Rickard Strandqvist
<rickard_strandqvist@spectrumdigital.se> wrote:
> Remove assignment of function parameter, that has no effect outside the function
>
> This was found using a static code analysis program called cppcheck
>
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> ---
>  drivers/video/fbdev/core/fbmon.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
> index 5b0e313..71ec1ab 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -1481,7 +1481,6 @@ int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
>  }
>  void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
>  {
> -       specs = NULL;

I guess the intention was:

memset(specs, 0, sizeof(struct fb_monspecs));

>  }
>  void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
>  {

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
