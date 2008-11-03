From: James Cloos <cloos@jhcloos.com>
Subject: Re: [Linux-fbdev-devel] radeonfb lockup in .28-rc (bisected)
Date: Mon, 03 Nov 2008 10:33:04 -0500
Message-ID: <m33ai8akoo.fsf@lugabout.jhcloos.org>
References: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
	<1225152347.8004.49.camel@pasglop>
	<m3k5bt2hsc.fsf@lugabout.jhcloos.org>
	<1225662539.8004.237.camel@pasglop>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756144AbYKCPeY@vger.kernel.org>
In-Reply-To: <1225662539.8004.237.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Mon, 03 Nov 2008 08:48:59 +1100")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>

>>>>> "Benjamin" == Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

>> is in play.  It is probably spinning through all of the 2000000 possible
>> udelay(10) calls.  I don't think I ever gave it twenty seconds before
>> giving up.  And certainly not forty seconds, if the freeze happens after
>> setting the DST_Y_X register.

Benjamin> Well, setting DST_Y_X is what triggers the transfer. The above
Benjamin> means that the FIFO isn't emptying (ie, the engine is locked up).

I gave it another try over the weekend and let it sit for five minutes.
The reset message never appeared.

Benjamin>  - We can blacklist that chip for imageblit (it's not a huge
Benjamin> improvement on x86 anyway).

No objections here.

Benjamin>  - We can be smart, reduce the timeout above, and "detect" the
Benjamin> lockup, when it happens, reset the engine and disable the
Benjamin> acceleration that locked up.

Given Paul's report, that seems like the long term solution.

Benjamin> Now, the problem is ... My second son was just born last
Benjamin> wed. so I'm pretty unavailable right now.

Congrats!

Benjamin>  Thus, for .29, I'm tempted to go for the simpler approach
Benjamin> which is to blacklist M7's from imageblit acceleration.

Again, that is fine by me.  Otherwise I'll just leave the #if0 commit
in my compile clone.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
