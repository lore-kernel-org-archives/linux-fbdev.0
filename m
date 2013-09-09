From: Alexandre Courbot <gnurou@gmail.com>
Date: Mon, 09 Sep 2013 02:36:43 +0000
Subject: Re: [BUG] simplefb not showing any output
Message-Id: <CAAVeFuLd3PB=whh0jPGDuP0OGCFxYh640owMZonn3h+3Sh7Ayg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
In-Reply-To: <CAG-2HqXhLcRX-oi4JchD=m7tZpDYyePKhWvkFU1ZZPEuqJ2JqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sat, Sep 7, 2013 at 9:25 PM, David Herrmann <dh.herrmann@gmail.com> wrote:
> From dbfb8e12166d494cd60823cbe84134d5d1a73ec8 Mon Sep 17 00:00:00 2001
> From: David Herrmann <dh.herrmann@gmail.com>
> Date: Sat, 7 Sep 2013 14:22:01 +0200
> Subject: [PATCH] devm/simplefb: introduce and use devm_ioremap_wc()
>
> We want to use devm_ioremap_nocache() or even devm_ioremap_wc() to speed
> up fbdev writes _a lot_. As devm_ioremap_wc() doesn't exist, yet,
> introduce it along the way. Note that ioremap_wc() is aliases to
> ioremap_nocache() in asm-generic/{io,iomem}.h so we can safely expect all
> architectures to either provide it or use the same alias.
>
> Reported-by: Tom Gundersen <teg@jklm.no>
> Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Tried this on SHIELD, and it dramatically increases performance.

Tested-by: Alexandre Courbot <acourbot@nvidia.com>

Alex.
