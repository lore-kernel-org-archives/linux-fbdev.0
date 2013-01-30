From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jan 2013 23:52:51 +0000
Subject: Re: BUG: circular locking dependency detected
Message-Id: <CA+55aFyRHK3dmwQf_mdfB18dmoaRZqBG9FvHRqTs7cqBjgUs+g@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130130200648.GA13298@flint.arm.linux.org.uk>
 <20130130215211.GA28418@flint.arm.linux.org.uk> <CAKMK7uHEggaGfLTq4c3MfY7csQSFpb=kRwdbJUQMN9Cz9K=V4A@mail.gmail.com>
 <20130130221946.GA14801@flint.arm.linux.org.uk>
In-Reply-To: <20130130221946.GA14801@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King <rmk@arm.linux.org.uk>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel <dri-devel@lists.freedesktop.org>, Dave Airlie <airlied@gmail.com>

On Thu, Jan 31, 2013 at 9:19 AM, Russell King <rmk@arm.linux.org.uk> wrote:
>
> So... what you seem to be telling me is that 3.9 is going to be a
> release which issues lockdep complaints when the console blanks, and
> you think that's acceptable?
>
> Adding Linus and Andrew so they're aware of this issue...

Oh, we're extremely aware of it. And it's not a new issue, the locking
problem have apparently been around forever, although I'm not sure why
the lockdep splat itself started happening only recently.

They'll make it into 3.9, it's 3.8 that won't have them. The patches
initially caused way *worse* behavior than just a lockdep splat - they
caused actual hard lockups (and that was *after* the initial series of
fixes). That got fixed (hopefully for the last case!) fairly recently,
and I'm not willing to take the scary patch-series that has had
several problem cases.

              LInus
