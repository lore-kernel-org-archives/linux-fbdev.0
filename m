From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] radeonfb lockup in .28-rc (bisected)
Date: Wed, 05 Nov 2008 08:33:14 +1100
Message-ID: <1225834394.8004.273.camel@pasglop>
References: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
	 <1225152347.8004.49.camel@pasglop> <m3k5bt2hsc.fsf@lugabout.jhcloos.org>
	 <1225662539.8004.237.camel@pasglop>
	 <871vxtthr3.fsf@burly.wgtn.ondioline.org>
	 <1225697689.8004.245.camel@pasglop>
	 <87wsfkrnn1.fsf@burly.wgtn.ondioline.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756842AbYKDViz@vger.kernel.org>
In-Reply-To: <87wsfkrnn1.fsf@burly.wgtn.ondioline.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Paul Collins <paul@burly.ondioline.org>
Cc: James Cloos <cloos@jhcloos.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>

On Tue, 2008-11-04 at 19:49 +1300, Paul Collins wrote:
> +               int width = ((image->width - 1) / 32 + 1) * 32;

Heh, it would have been easier to do

	width = (image->width | 0x1f) + 1; 

BTW. Does it always lockup or only when using this special font (without
the hack that is ?)

Cheers,
Ben.
