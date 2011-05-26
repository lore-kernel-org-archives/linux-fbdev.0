From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 May 2011 05:23:36 +0000
Subject: Re: [PATCH 00/29] Use display information in info not in var for panning
Message-Id: <BANLkTi=3Da1dgvdehJkwthK+OEmQeqXJmA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306364301-8195-1-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1306364301-8195-1-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Thu, May 26, 2011 at 00:57, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> While playing with the FBIOPAN_DISPLAY ioctl I noticed that many drivers use
> information from the ioctl argument such as the display resolution when they
> should use the current settings from the fb_info structure.

Haven't gone through all patches, but the above is correct.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
