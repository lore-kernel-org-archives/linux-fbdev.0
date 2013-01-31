From: Russell King <rmk@arm.linux.org.uk>
Date: Thu, 31 Jan 2013 00:09:12 +0000
Subject: Re: BUG: circular locking dependency detected
Message-Id: <20130131000911.GB14801@flint.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130130200648.GA13298@flint.arm.linux.org.uk> <20130130215211.GA28418@flint.arm.linux.org.uk> <CAKMK7uHEggaGfLTq4c3MfY7csQSFpb=kRwdbJUQMN9Cz9K=V4A@mail.gmail.com> <20130130221946.GA14801@flint.arm.linux.org.uk> <CA+55aFyRHK3dmwQf_mdfB18dmoaRZqBG9FvHRqTs7cqBjgUs+g@mail.gmail.com>
In-Reply-To: <CA+55aFyRHK3dmwQf_mdfB18dmoaRZqBG9FvHRqTs7cqBjgUs+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>

On Thu, Jan 31, 2013 at 10:52:51AM +1100, Linus Torvalds wrote:
> On Thu, Jan 31, 2013 at 9:19 AM, Russell King <rmk@arm.linux.org.uk> wrote:
> >
> > So... what you seem to be telling me is that 3.9 is going to be a
> > release which issues lockdep complaints when the console blanks, and
> > you think that's acceptable?
> >
> > Adding Linus and Andrew so they're aware of this issue...
> 
> Oh, we're extremely aware of it. And it's not a new issue, the locking
> problem have apparently been around forever, although I'm not sure why
> the lockdep splat itself started happening only recently.

Well, the reason the splat started happening recently is because of:

commit daee779718a319ff9f83e1ba3339334ac650bb22
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Sat Sep 22 19:52:11 2012 +0200

    console: implement lockdep support for console_lock
    
    Dave Airlie recently discovered a locking bug in the fbcon layer,
    where a timer_del_sync (for the blinking cursor) deadlocks with the
    timer itself, since both (want to) hold the console_lock:
    
    https://lkml.org/lkml/2012/8/21/36

which, if I'm looking at the git history right, appears to have come
in during the last merge window?

Yes, the locking may be wrong, but we've lived with that locking for
a long time without problem.

Can we at least silence these warnings by temporarily disabling the
lockdep tracking added by the above commit for this lock, until the
fixes for this are merged during the next merge window?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
