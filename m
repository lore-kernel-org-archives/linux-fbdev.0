From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 15 Mar 2015 09:32:11 +0000
Subject: Re: [PATCH] video: fbdev: sh_mobile_lcdcfb: Fix ROP3 sysfs attribute parsing
Message-Id: <CAMuHMdVSuMb237SQp4naaPCic7SqLB2hVgKBpWcvw2QOZhE4tA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426347519-2541-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1426347519-2541-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Mar 14, 2015 at 4:38 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The ROP3 attribute is expressed as an integer in the 0-255 range. Remove
> the wrong conversion to boolean when parsing it.
>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
