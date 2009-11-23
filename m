From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Nov 2009 18:38:48 +0000
Subject: Re: [Linux-fbdev-devel] [PATCH 1/4] FRAMEBUFFER: Fix cfbfillrect for
Message-Id: <10f740e80911231038o6b18103fxd0206db41ed89b4e@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, Nov 23, 2009 at 17:01, Ben Dooks <ben@simtec.co.uk> wrote:
> From: Vincent Sanders <vince@simtec.co.uk>
>
> The cfbfillrect routine was incorrectly using the palette to lookup true and
> direct colours, but using indexed colours directly. This was simply the
> inversion of the sense of an 'if' statement. This patch fixes that so that
> colours other than black work properly for cfbfillrect.
>
> Signed-off-by: Vincent Sanders <vince@simtec.co.uk>
> Signed-off-by: Simtec Linux Team <linux@simtec.co.uk>
>
> ---
> drivers/video/cfbfillrect.c |    4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
> Index: b/drivers/video/cfbfillrect.c
> =================================> --- a/drivers/video/cfbfillrect.c	2009-05-10 14:11:19.000000000 +0100
> +++ b/drivers/video/cfbfillrect.c	2009-05-10 14:16:33.000000000 +0100
> @@ -289,9 +289,9 @@ void cfb_fillrect(struct fb_info *p, con
>
>  	if (p->fix.visual = FB_VISUAL_TRUECOLOR ||
>  	    p->fix.visual = FB_VISUAL_DIRECTCOLOR )
> -		fg = ((u32 *) (p->pseudo_palette))[rect->color];
> -	else
>  		fg = rect->color;
> +	else
> +		fg = ((u32 *) (p->pseudo_palette))[rect->color];

This is not correct. The pseudo palette must be used in truecolor and
directcolor mode,
as rect->color is a console palette index, not a pixel value.

Perhaps you forgot to initialize pseudo_palette in your fbdev driver?

P.S. Please send patches inline, so it's easier for us to comment on them.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
