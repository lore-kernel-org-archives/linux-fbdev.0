From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] radeonfb lockup in .28-rc (bisected)
Date: Mon, 03 Nov 2008 08:48:59 +1100
Message-ID: <1225662539.8004.237.camel@pasglop>
References: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
	 <1225152347.8004.49.camel@pasglop>  <m3k5bt2hsc.fsf@lugabout.jhcloos.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754968AbYKBVtg@vger.kernel.org>
In-Reply-To: <m3k5bt2hsc.fsf@lugabout.jhcloos.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: James Cloos <cloos@jhcloos.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>


>         /* X here pads width to a multiple of 32 and uses the clipper to
>          * adjust the result. Is that really necessary ? Things seem to
>          * work ok for me without that and the doco doesn't seem to imply
>          * there is such a restriction.
>          */
> 
> is relevant?

Possibly.

> Or whether the card is unhappy with the creg settings.  It does seem,
> now that I read the code, that:
> 
> void radeon_fifo_update_and_wait(struct radeonfb_info *rinfo, int entries)
> {
>         int i;
> 
>         for (i=0; i<2000000; i++) {
>                 rinfo->fifo_free = INREG(RBBM_STATUS) & 0x7f;
>                 if (rinfo->fifo_free >= entries)
>                         return;
>                 udelay(10);
>         }
>         printk(KERN_ERR "radeonfb: FIFO Timeout !\n");
>         /* XXX Todo: attempt to reset the engine */
> }
> 
> is in play.  It is probably spinning through all of the 2000000 possible
> udelay(10) calls.  I don't think I ever gave it twenty seconds before
> giving up.  And certainly not forty seconds, if the freeze happens after
> setting the DST_Y_X register.

Well, setting DST_Y_X is what triggers the transfer. The above means
that the FIFO isn't emptying (ie, the engine is locked up).

There's a few things we can do from here:

 - We can try indeed to do the alignment things though that involves
using the clipper etc... and thus complicates things significantly

 - We can also try putting a few more bubbles in the FIFO in case that's
where the problem is

 - We can blacklist that chip for imageblit (it's not a huge improvement
on x86 anyway).

 - We can be smart, reduce the timeout above, and "detect" the lockup,
when it happens, reset the engine and disable the acceleration that
locked up.

Now, the problem is ... My second son was just born last wed. so I'm
pretty unavailable right now. Thus, for .29, I'm tempted to go for the
simpler approach which is to blacklist M7's from imageblit acceleration.

Cheers,
Ben.
