From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Sep 2014 06:44:11 +0000
Subject: Re: [PATCH] framebuffer: fix screen corruption when copying
Message-Id: <CAMuHMdXVwUrK1dscSAX7mFbG9nquF5mYC=xbOKmV5ZXC-T7fLA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1409161236550.3150@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1409161236550.3150@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Mikulas,

On Tue, Sep 16, 2014 at 6:38 PM, Mikulas Patocka <mpatocka@redhat.com> wrote:
> The patch also removes the references to fb_memmove in the code that is
> commented out because fb_memmove was removed from framebuffer subsystem.

I'd leave it as-is. Using plain memmove() is not correct, as it should operate
on MMIO space, not RAM. On x86 it works with memmove(), though, but
not on all architectures.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
