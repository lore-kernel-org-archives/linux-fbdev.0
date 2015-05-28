From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 28 May 2015 07:35:24 +0000
Subject: Re: distorted text
Message-Id: <CAMuHMdUJ+EqkJ9g2PYNgyoOw+8EcemQhkQFO4+waSsYPcsV2XQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <555C660B.2080808@xsilon.com>
In-Reply-To: <555C660B.2080808@xsilon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, May 20, 2015 at 6:03 PM, Simon Vincent <simon.vincent@xsilon.com> wrote:
> I have done some testing and the display works correctly with clear text on
> Linux v4.0 but is distorted/corrupted on v4.1-rc1. (These are tagged
> releases from https://github.com/torvalds/linux).
>
> I have had a look at the changes but I can't find anything that might cause
> the problem although I don't know much about this part of Linux.
> Any ideas?

Can you please try to bisect the problem?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
