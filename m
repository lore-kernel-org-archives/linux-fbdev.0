From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 05 Jul 2014 14:04:22 +0000
Subject: Re: [PATCH] video: fbdev: amifb.c: Cleaning up variable that is never used
Message-Id: <CAMuHMdWYGVt0=knBTZX04xwQHar0CohUQ5EKGvzMQ49nNRxiCw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404562393-18641-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404562393-18641-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Jingoo Han <jg1.han@samsung.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Joe Perches <joe@perches.com>, Sachin Kamat <sachin.kamat@linaro.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Jul 5, 2014 at 2:13 PM, Rickard Strandqvist
<rickard_strandqvist@spectrumdigital.se> wrote:
> From: Rickard Strandqvist <rickard.strandqvist@sonymobile.com>
>
> Variable ar assigned a value that is never used.
> I have also removed all the code that thereby serves no purpose.
>
> This was found using a static code analysis program called cppcheck
>
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/drivers/video/fbdev/amifb.c
> +++ b/drivers/video/fbdev/amifb.c
> @@ -1124,7 +1124,6 @@ static int ami_decode_var(struct fb_var_screeninfo *var, struct amifb_par *par,
>  {
>         u_short clk_shift, line_shift;
>         u_long maxfetchstop, fstrt, fsize, fconst, xres_n, yres_n;
> -       u_int htotal, vtotal;

These became unused by commit 3161986224a3faa8ccca3e665b7404d81e7ee3cf
Author: Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed Dec 13 00:35:54 2006 -0800

    [PATCH] fbdev: remove references to non-existent fbmon_valid_timings()

    Remove references to non-existent fbmon_valid_timings()

    Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
    Cc: James Simmons <jsimmons@infradead.org>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
