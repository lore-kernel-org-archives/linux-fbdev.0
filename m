From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 28 Jun 2017 11:48:32 +0000
Subject: Re: [PATCH] fbcon: Make fbcon a built-time depency for fbdev
Message-Id: <CAKMK7uHSiLPJMGoN979iE3jvLfBgRPr-fV8EuC_KPQ-q8eQ5aA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170628103635.24651-1-daniel.vetter@ffwll.ch>
 <20170628120003.6e2f1ef6@alans-desktop>
In-Reply-To: <20170628120003.6e2f1ef6@alans-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Wed, Jun 28, 2017 at 1:00 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> On Wed, 28 Jun 2017 12:36:35 +0200
> Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
>
>> There's a bunch of folks who're trying to make printk less
>> contended and faster, but there's a problem: printk uses the
>> console_lock, and the console lock has become the BKL for all things
>> fbdev/fbcon, which in turn pulled in half the drm subsystem under that
>> lock. That's awkward.
>
> Yes - very. Although if you implement your console printing method with
> sufficient cunning it shouldn't cause much latency in most cases but for
> unaccelerated fb it's really bad.
>
> It also makes it unnecessarily hard for a drm driver to accelerate
> console output.

It's worse, we've had to sprinkle early returns for oops_in_progress
and pushing anything more complex than writing to an mmap region when
in_atomic() into workers stuff all over the fbdev helpers because the
calling context of the fbdev driver callbacks is so ill defined.

There's an rfc patch series for a very minimal oops handler (since
there's no way you can make a modern kms driver oops-safe), but it
hasn't landed yet.

>> 4. Push console_lock down the call-chain, until it is down in
>> console_register again.
>
> I don't think that's actually going to work out. To fix it is going to
> need more invasive changes so that you can 'create' a console and set it
> up separately to actually 'enabling' it when you make it visible and
> start scribbling. I don't see any other way to make the changeover
> locking saner at this point without still having huge potential stalls in
> printk().

Yeah, I expect that as soon as console_lock is down in the fbcon.c
code the real hard work of designing a reasonable console locking
scheme will have to start. console.c is very old skool, with big locks
instead of refcounting to keep things alive, static arrays and other
fun things. It'll need work.

We'll probably also want to untangle the normal console usage from the
emergency printing when the kernel is keeling over, since it's a
totally different environment. That would at least help drm/kms a lot.

> Reviewed-by: Alan Cox <alan@linux.intel.com>

Thanks for reviewing.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
