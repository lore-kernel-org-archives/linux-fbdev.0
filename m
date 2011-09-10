From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 10 Sep 2011 09:18:57 +0000
Subject: Re: [PATCH] logo: Change regular 224-color tux logo to something more
Message-Id: <CAMuHMdXv3Rfn-T6=14tya82a_W4WLReSkNW8Y7ChevwvcdcSvA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110910085546.GV23283@sweaglesw.org>
In-Reply-To: <20110910085546.GV23283@sweaglesw.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: djwong@djwong.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, josh@joshtriplett.org, Linux Fbdev development list <linux-fbdev@vger.kernel.org>

On Sat, Sep 10, 2011 at 10:55,  <djwong@djwong.org> wrote:
> For Linux 3.1, I thought we could change the 224-color framebuffer logo to
> something more apropos given the version number.  As the patch is quite large,
> I'm only inlining the changelog. 8)
>
> See http://djwong.org/docs/31-tuxlogo.patch for too-large-for-lkml patch,
> http://djwong.org/docs/31-tuxlogo.png  for a PNG logo, or

Nice try!

> http://djwong.org/docs/31-tuxlogo-screen.png for a screenshot.

How come the text is corrupting the logo during scrolling?

> Singed-off-by: Darrick J. Wong <djwong@djwong.org>
> ---
>
>  drivers/video/logo/logo_linux_clut224.ppm |39322 ++++++++++++++++++++++++++++-
>  1 files changed, 37720 insertions(+), 1602 deletions(-)

This really needs to go through linux-fbdev (CCed).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
