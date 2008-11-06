From: Paul Collins <paul@burly.ondioline.org>
Subject: Re: [Linux-fbdev-devel] radeonfb lockup in .28-rc (bisected)
Date: Thu, 06 Nov 2008 17:49:31 +1300
Message-ID: <87od0tsbl0.fsf@burly.wgtn.ondioline.org>
References: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
	<1225152347.8004.49.camel@pasglop>
	<m3k5bt2hsc.fsf@lugabout.jhcloos.org>
	<1225662539.8004.237.camel@pasglop>
	<871vxtthr3.fsf@burly.wgtn.ondioline.org>
	<1225874361.13603.12.camel@pasglop>
	<87skq6sc0e.fsf@burly.wgtn.ondioline.org>
	<1225943357.13603.41.camel@pasglop>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755271AbYKFEtn@vger.kernel.org>
In-Reply-To: <1225943357.13603.41.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Thu, 06 Nov 2008 14:49:17 +1100")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, James Cloos <cloos@jhcloos.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Ok so I can't get it to die on my M9 (rv250) tipb here, I can try next
> week on a albook with an M10 (rv350). Just to make sure I'm doing the
> same as you, does it boot fine if you don't change the font and does it
> lockup if, after it's fully booted, you do a setfont neepalt10x20.psf ?

Yes.  It boots fine with the regular 8x16 font and locks up when I do
"setfont neepalt10x20.psf".

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
