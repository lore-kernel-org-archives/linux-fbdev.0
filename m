From: Mikulas Patocka <mpatocka@redhat.com>
Date: Wed, 17 Sep 2014 11:44:14 +0000
Subject: Re: [PATCH] framebuffer: fix screen corruption when copying
Message-Id: <alpine.LRH.2.02.1409170736370.15277@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1409161236550.3150@file01.intranet.prod.int.rdu2.redhat.com> <CAMuHMdXVwUrK1dscSAX7mFbG9nquF5mYC=xbOKmV5ZXC-T7fLA@mail.gmail.com>
In-Reply-To: <CAMuHMdXVwUrK1dscSAX7mFbG9nquF5mYC=xbOKmV5ZXC-T7fLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>



On Wed, 17 Sep 2014, Geert Uytterhoeven wrote:

> Hi Mikulas,
> 
> On Tue, Sep 16, 2014 at 6:38 PM, Mikulas Patocka <mpatocka@redhat.com> wrote:
> > The patch also removes the references to fb_memmove in the code that is
> > commented out because fb_memmove was removed from framebuffer subsystem.
> 
> I'd leave it as-is. Using plain memmove() is not correct, as it should operate
> on MMIO space, not RAM. On x86 it works with memmove(), though, but
> not on all architectures.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert

That code is disabled with #if 0. So it doesn't matter if it's incorrect 
in some specific situation.

The purpose of that disabled code is to be able to verify that the bug is 
in bitcpy_rev. I get screen corruption - so I enable that "memmove" 
statement - the screen corruption goes away - so I know that the bug is in 
bitcpy_rev.

Mikulas
