From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Aug 2012 17:09:40 +0000
Subject: Re: [PATCH] video/mx3fb: remove stray l from debug output
Message-Id: <CAMuHMdXPJhpMiBuc5Op+n5spSfsHrqoLZqjkLWNLeH2txnj=Pw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344843875-8174-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1344843875-8174-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Mon, Aug 13, 2012 at 9:44 AM, Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/video/mx3fb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> index c89f8a8..1dfdeb1 100644
> --- a/drivers/video/mx3fb.c
> +++ b/drivers/video/mx3fb.c
> @@ -771,7 +771,7 @@ static int __set_par(struct fb_info *fbi, bool lock)
>                 if (fbi->var.sync & FB_SYNC_SHARP_MODE)
>                         mode = IPU_PANEL_SHARP_TFT;
>
> -               dev_dbg(fbi->device, "pixclock = %ul Hz\n",
> +               dev_dbg(fbi->device, "pixclock = %u Hz\n",
>                         (u32) (PICOS2KHZ(fbi->var.pixclock) * 1000UL));

I think a better fix is to change the dyslectic "%ul" to "%lu", and
drop the cast to
u32, which was probably only added to kill the compiler warning caused by the
dyslectia issue.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
