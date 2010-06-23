From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Wed, 23 Jun 2010 20:05:47 +0000
Subject: Re: [PATCH] vt/console: try harder to print output when panicing
Message-Id: <20100623130547.296e00a7@virtuousgeek.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1277262779-19338-1-git-send-email-airlied@gmail.com>
	<20100623125605.5f56f6ba.akpm@linux-foundation.org>
In-Reply-To: <20100623125605.5f56f6ba.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Airlie <airlied@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.sf.net, linux-kernel@vger.kernel.org

On Wed, 23 Jun 2010 12:56:05 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 23 Jun 2010 13:12:59 +1000
> Dave Airlie <airlied@gmail.com> wrote:
> 
> > Jesse's initial patch commit said:
> > 
> > "At panic time (i.e. when oops_in_progress is set) we should try a bit
> > harder to update the screen and make sure output gets to the VT, since
> > some drivers are capable of flipping back to it.
> > 
> > So make sure we try to unblank and update the display if called from a
> > panic context."
> > 
> > I've enhanced this to add a flag to the vc that console layer can set
> > to indicate they want this behaviour to occur. This also adds support
> > to fbcon for that flag and adds an fb flag for drivers to indicate
> > they want to use the support. It enables this for KMS drivers.
> 
> Interesting.  Getting real oops traces from machines running X will
> make Rusty happy, and that's what we're all here for.
> 
> How well does this all work?  How reliable is it?  What's the success rate?
> 
> 
> 
> What's the downside here?  After all, not all oopses are catastrophic -
> sometimes the machine will go blurt and keep running so the user can
> take a look in the logs then perform an orderly reboot, etc.  As I
> understand it, those non-catastrophic oopses will now flip the machine
> from X and into the vt display, yes?  Can the user get it back to X
> mode?

No, we'll only flip from the panic notifier chain.  However if
oops_in_progress is set (as it is whenever bust_spinlocks(1) is called,
i.e. from panic() and oops_begin()) we'll try to print into the fbcon
buffer.  In the oops case this should still be safe since the buffer is
pinned, at least in the KMS world.

> Worse, there's also a risk that doing all this new work within the
> oopsing context will screw the machine up, so the user will be
> _deprived_ of an oops report which he otherwise would have been able to
> get from the logs.  This is particularly the case when it's the DRI
> stuff which oopsed, which is not exactly an uncommon occurrence lately ;)
> 
> Oh well, the best way to tell is to ship-it-and-see.

To avoid the oops part (which as I said should still be safe) we could
add a new panic_in_progress flag, that would make sure things were no
worse than they are currently.

-- 
Jesse Barnes, Intel Open Source Technology Center
