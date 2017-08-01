From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 01 Aug 2017 15:43:15 +0000
Subject: Re: [PATCH 1/4] fbcon: Make fbcon a built-time depency for fbdev
Message-Id: <2072598.i2ta92yxCh@amdc3058>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170706125735.28299-1-daniel.vetter@ffwll.ch>
 <20170706125735.28299-2-daniel.vetter@ffwll.ch>
 <1829417.jhVqBZyytf@amdc3058>
 <CGME20170801154317epcas2p1e0f43ea1e060a6b4c7ab0e77ae1f3bda@epcas2p1.samsung.com>
In-Reply-To: <1829417.jhVqBZyytf@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Steven Rostedt <rostedt@goodmis.org>, DRI Development <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

On Wednesday, July 12, 2017 12:40:45 PM Bartlomiej Zolnierkiewicz wrote:
> On Thursday, July 06, 2017 02:57:32 PM Daniel Vetter wrote:
> > There's a bunch of folks who're trying to make printk less
> > contended and faster, but there's a problem: printk uses the
> > console_lock, and the console lock has become the BKL for all things
> > fbdev/fbcon, which in turn pulled in half the drm subsystem under that
> > lock. That's awkward.
> > 
> > There reasons for that is probably just a historical accident:
> > 
> > - fbcon is a runtime option of fbdev, i.e. at runtime you can pick
> >   whether your fbdev driver instances are used as kernel consoles.
> >   Unfortunately this wasn't implemented with some module option, but
> >   through some module loading magic: As long as you don't load
> >   fbcon.ko, there's no fbdev console support, but loading it (in any
> >   order wrt fbdev drivers) will create console instances for all fbdev
> >   drivers.
> > 
> > - This was implemented through a notifier chain. fbcon.ko enumerates
> >   all fbdev instances at load time and also registers itself as
> >   listener in the fbdev notifier. The fbdev core tries to register new
> >   fbdev instances with fbcon using the notifier.
> > 
> > - On top of that the modifier chain is also used at runtime by the
> >   fbdev subsystem to e.g. control backlights for panels.
> > 
> > - The problem is that the notifier puts a mutex locking context
> >   between fbdev and fbcon, which mixes up the locking contexts for
> >   both the runtime usage and the register time usage to notify fbcon.
> >   And at runtime fbcon (through the fbdev core) might call into the
> >   notifier from a printk critical section while console_lock is held.
> > 
> > - This means console_lock must be an outer lock for the entire fbdev
> >   subsystem, which also means it must be acquired when registering a
> >   new framebuffer driver as the outermost lock since we might call
> >   into fbcon (through the notifier) which would result in a locking
> >   inversion if fbcon would acquire the console_lock from its notifier
> >   callback (which it needs to register the console).
> > 
> > - console_lock can be held anywhere, since printk can be called
> >   anywhere, and through the above story, plus drm/kms being an fbdev
> >   driver, we pull in a shocking amount of locking hiercharchy
> >   underneath the console_lock. Which makes cleaning up printk really
> >   hard (not even splitting console_lock into an rwsem is all that
> >   useful due to this).
> > 
> > There's various ways to address this, but the cleanest would be to
> > make fbcon a compile-time option, where fbdev directly calls the fbcon
> > register functions from register_framebuffer, or dummy static inline
> > versions if fbcon is disabled. Maybe augmented with a runtime knob to
> > disable fbcon, if that's needed (for debugging perhaps).
> > 
> > But this could break some users who rely on the magic "loading
> > fbcon.ko enables/disables fbdev framebuffers at runtime" thing, even
> > if that's unlikely. Hence we must be careful:
> > 
> > 1. Create a compile-time dependency between fbcon and fbdev in the
> > least minimal way. This is what this patch does.
> > 
> > 2. Wait at least 1 year to give possible users time to scream about
> > how we broke their setup. Unlikely, since all distros make fbcon
> > compile-in, and embedded platforms only compile stuff they know they
> > need anyway. But still.
> > 
> > 3. Convert the notifier to direct functions calls, with dummy static
> > inlines if fbcon is disabled. We'll still need the fb notifier for the
> > other uses (like backlights), but we can probably move it into the fb
> > core (atm it must be built-into vmlinux).
> > 
> > 4. Push console_lock down the call-chain, until it is down in
> > console_register again.
> > 
> > 5. Finally start to clean up and rework the printk/console locking.
> > 
> > For context of this saga see
> > 
> > commit 50e244cc793d511b86adea24972f3a7264cae114
> > Author: Alan Cox <alan@linux.intel.com>
> > Date:   Fri Jan 25 10:28:15 2013 +1000
> > 
> >     fb: rework locking to fix lock ordering on takeover
> > 
> > plus the pile of commits on top that tried to make this all work
> > without terminally upsetting lockdep. We've uncovered all this when
> > console_lock lockdep annotations where added in
> > 
> > commit daee779718a319ff9f83e1ba3339334ac650bb22
> > Author: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Date:   Sat Sep 22 19:52:11 2012 +0200
> > 
> >     console: implement lockdep support for console_lock
> > 
> > On the patch itself:
> > - Switch CONFIG_FRAMEBUFFER_CONSOLE to be a boolean, using the overall
> >   CONFIG_FB tristate to decided whether it should be a module or
> >   built-in.
> > 
> > - At first I thought I could force the build depency with just a dummy
> >   symbol that fbcon.ko exports and fb.ko uses. But that leads to a
> >   module depency cycle (it works fine when built-in).
> > 
> >   Since this tight binding is the entire goal the simplest solution is
> >   to move all the fbcon modules (and there's a bunch of optinal
> >   source-files which are each modules of their own, for no good
> >   reason) into the overall fb.ko core module. That's a bit more than
> >   what I would have liked to do in this patch, but oh well.
> > 
> > Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
> > Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Patch queued for 4.14, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

