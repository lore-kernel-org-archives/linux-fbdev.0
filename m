From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 04 May 2018 07:49:39 +0000
Subject: Re: [PATCH 3/3] video: fbdev: remove unused sh_mobile_meram driver
Message-Id: <CAMuHMdUEHosD=RyvQrBEjci1=DBH+2x9r9baX1d=0mx-sCc0qQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180427112241epcas1p423b20f397d034a444ec018f39241d82b@epcas1p4.samsung.com>
 <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
 <1524828105-26585-4-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1524828105-26585-4-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms+renesas@verge.net.au>

On Fri, Apr 27, 2018 at 1:21 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Since commit a521422ea4ae  ("ARM: shmobile: mackerel: Remove Legacy C
> board code") MERAM functionality is unused. Remove it.
>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
