From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] radeonfb lockup in .28-rc (bisected)
Date: Tue, 04 Nov 2008 07:22:34 +1100
Message-ID: <1225743754.8004.260.camel@pasglop>
References: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
	 <1225152347.8004.49.camel@pasglop> <m3k5bt2hsc.fsf@lugabout.jhcloos.org>
	 <1225662539.8004.237.camel@pasglop>  <m33ai8akoo.fsf@lugabout.jhcloos.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755837AbYKCUYB@vger.kernel.org>
In-Reply-To: <m33ai8akoo.fsf@lugabout.jhcloos.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: James Cloos <cloos@jhcloos.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>

On Mon, 2008-11-03 at 10:33 -0500, James Cloos wrote:
> >>>>> "Benjamin" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> >> is in play.  It is probably spinning through all of the 2000000 possible
> >> udelay(10) calls.  I don't think I ever gave it twenty seconds before
> >> giving up.  And certainly not forty seconds, if the freeze happens after
> >> setting the DST_Y_X register.
> 
> Benjamin> Well, setting DST_Y_X is what triggers the transfer. The above
> Benjamin> means that the FIFO isn't emptying (ie, the engine is locked up).
> 
> I gave it another try over the weekend and let it sit for five minutes.
> The reset message never appeared.

Because it's probably going to lockup trying to display it :-) I need to
make that stuff a bit more robust, by disabling acceleration if the
engine locks up for example.

> Again, that is fine by me.  Otherwise I'll just leave the #if0 commit
> in my compile clone.

Allright, we'll see what I come up with, and at worst, I'll just revert
the whole thing.

Ben.
