From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 05 Jul 2014 17:09:10 +0000
Subject: Re: [PATCH] video: fbdev: g364fb.c: Cleaning up variable that is never used
Message-Id: <CAMuHMdUjAdLYRugmU7h2XR1x=hEKrOo6QqzbKXuaaEVF3S9amQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1404562874-19440-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1404562874-19440-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Rickard Strandqvist <rickard.strandqvist@sonymobile.com>, Jingoo Han <jg1.han@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sat, Jul 5, 2014 at 2:21 PM, Rickard Strandqvist
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

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
