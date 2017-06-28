From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 28 Jun 2017 15:55:47 +0000
Subject: Re: [PATCH] fbcon: Make fbcon a built-time depency for fbdev
Message-Id: <CAKMK7uGLW84s879rst2AMPTByvfsFLcPnKMi+uGN885iutAsTw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170628103635.24651-1-daniel.vetter@ffwll.ch>
 <20170628110819.70eb0ce0@gandalf.local.home>
In-Reply-To: <20170628110819.70eb0ce0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Wed, Jun 28, 2017 at 5:08 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 28 Jun 2017 12:36:35 +0200
> Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
>> There's a bunch of folks who're trying to make printk less
>> contended and faster, but there's a problem: printk uses the
>> console_lock, and the console lock has become the BKL for all things
>> fbdev/fbcon, which in turn pulled in half the drm subsystem under that
>> lock. That's awkward.
>>
>
> I applied your patch and compiled it, and got this error while
> installing modules:
>
>   DEPMOD  4.12.0-rc5-test+
> depmod: ERROR: Found 11 modules in dependency cycles!
> depmod: ERROR: Cycle detected: fbcon -> bitblit -> softcursor -> fb -> fbcon
> depmod: ERROR: Cycle detected: softcursor -> fb -> fbcon_rotate -> fbcon_ccw -> softcursor
> depmod: ERROR: Cycle detected: fb -> fbcon_rotate -> fbcon_ccw -> fb
> depmod: ERROR: Cycle detected: softcursor -> fb -> fbcon_rotate -> fbcon_ccw -> fbcon_ud -> softcursor
> depmod: ERROR: Cycle detected: fb -> fbcon_rotate -> fbcon_ccw -> fbcon_ud -> fb
> depmod: ERROR: Cycle detected: softcursor -> fb -> fbcon_rotate -> fbcon_ccw -> fbcon_ud -> fbcon_cw -> softcursor
> depmod: ERROR: Cycle detected: fb -> fbcon_rotate -> fbcon_ccw -> fbcon_ud -> fbcon_cw -> fb
> depmod: ERROR: Cycle detected: fb -> fbcon_rotate -> fbcon_ccw -> fbcon_ud -> fbcon_cw -> fb
> depmod: ERROR: Cycle detected: fb -> fbcon_rotate -> fbcon_ccw -> fbcon_ud -> fbcon_cw -> tileblit -> fb
> depmod: ERROR: Cycle detected: fbcon -> bitblit -> softcursor -> fb -> fbcon_rotate -> fbcon_ccw -> fbcon_ud -> fbcon_cw -> tileblit -> fbdev
> depmod: ERROR: Cycle detected: fb -> fbcon_rotate -> fbcon_ccw -> fbcon_ud -> fbcon_cw -> tileblit -> fb
> /work/git/linux-trace.git/Makefile:1251: recipe for target '_modinst_post' failed
>
>
> Config attached.
>
> Oh, and I changed CONFIG_FB to be a module, which is probably where the
> error happened.

Yeah I only compile tested all the combos and didn't realize that
depmod is only run at install time. I indeed created a depency loop
here. I think the simplest solution would be to stuff all the fbcon
code into the fb.ko module, I'm trying to figure out whether that can
be done without massive code movement.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
