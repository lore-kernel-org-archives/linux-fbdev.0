From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 02 Jun 2020 12:03:38 +0000
Subject: Re: [PATCH v2 2/2] video: fbdev: amifb: add FIXMEs about {put,get}_user() failures
Message-Id: <CAMuHMdVYuk9+=3OTufOo98Dd3ijXS6JBH9RqK2v+9mwogxbnXA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200504232908eucas1p296927bc7c736ad924cefaea9a546459d@eucas1p2.samsung.com>
 <b1cf967015c5beafa475aaa30d8e21a58caff870.camel@perches.com>
 <380c0494-ed02-b2be-65b0-d385627fb894@samsung.com>
In-Reply-To: <380c0494-ed02-b2be-65b0-d385627fb894@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-m68k <linux-m68k@lists.linux-m68k.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Al Viro <viro@zeniv.linux.org.uk>

On Tue, Jun 2, 2020 at 1:52 PM Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Since we lack the hardware (or proper emulator setup) for
> testing needed changes add FIXMEs to document the issues
> (so at least they are not forgotten).
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
