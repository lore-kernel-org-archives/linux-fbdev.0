From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Date: Wed, 28 Jun 2017 11:00:03 +0000
Subject: Re: [PATCH] fbcon: Make fbcon a built-time depency for fbdev
Message-Id: <20170628120003.6e2f1ef6@alans-desktop>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170628103635.24651-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20170628103635.24651-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, dri-devel@lists.freedesktop.org, Daniel Vetter <daniel.vetter@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Wed, 28 Jun 2017 12:36:35 +0200
Daniel Vetter <daniel.vetter@ffwll.ch> wrote:

> There's a bunch of folks who're trying to make printk less
> contended and faster, but there's a problem: printk uses the
> console_lock, and the console lock has become the BKL for all things
> fbdev/fbcon, which in turn pulled in half the drm subsystem under that
> lock. That's awkward.

Yes - very. Although if you implement your console printing method with
sufficient cunning it shouldn't cause much latency in most cases but for
unaccelerated fb it's really bad.

It also makes it unnecessarily hard for a drm driver to accelerate
console output.

> 4. Push console_lock down the call-chain, until it is down in
> console_register again.

I don't think that's actually going to work out. To fix it is going to
need more invasive changes so that you can 'create' a console and set it
up separately to actually 'enabling' it when you make it visible and
start scribbling. I don't see any other way to make the changeover
locking saner at this point without still having huge potential stalls in
printk().

Reviewed-by: Alan Cox <alan@linux.intel.com>


Alan
