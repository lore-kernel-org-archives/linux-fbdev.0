From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 02 May 2014 15:48:36 +0000
Subject: Re: some divide by zero bugs in >fb_check_var() functions
Message-Id: <CAMuHMdVL8d8tFyep4y3_4w2pOnhjhhrob3LHzwtM1URVywcbEw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20140124223503.GA4251@elgon.mountain>
In-Reply-To: <20140124223503.GA4251@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Tue, Jan 28, 2014 at 10:28 PM, Kees Cook <keescook@chromium.org> wrote:
> Is it ever valid to have pixclock, xres_virtual, or bits_per_pixel be
> zero? Seems like it'd be trivial to check for those in fb_set_var()?

pixclock could be zero for some special fixed type of display that doesn't
have timings. Hmm, you could use 1 for that. Are there any in-tree users?

Anyway, the checker reported issues with specific drivers, not with the core,
right?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
