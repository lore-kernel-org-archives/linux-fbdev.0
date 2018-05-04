From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 04 May 2018 07:44:11 +0000
Subject: Re: [PATCH 1/3] video: fbdev: sh_mobile_lcdcfb: remove unused MERAM support
Message-Id: <CAMuHMdWY_rwtG2vTy5R_P=37vk59+D+7ro+MgobPnEm1nJ_YXQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20180427112227epcas2p4ea3a93a5680d69a62f12cac627ebafbc@epcas2p4.samsung.com>
 <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com> <1524828105-26585-2-git-send-email-b.zolnierkie@samsung.com>
In-Reply-To: <1524828105-26585-2-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

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
