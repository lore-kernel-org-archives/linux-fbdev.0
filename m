From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] radeonfb lockup in .28-rc (bisected)
Date: Mon, 03 Nov 2008 18:34:49 +1100
Message-ID: <1225697689.8004.245.camel@pasglop>
References: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
	 <1225152347.8004.49.camel@pasglop> <m3k5bt2hsc.fsf@lugabout.jhcloos.org>
	 <1225662539.8004.237.camel@pasglop>
	 <871vxtthr3.fsf@burly.wgtn.ondioline.org>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754855AbYKCHfy@vger.kernel.org>
In-Reply-To: <871vxtthr3.fsf@burly.wgtn.ondioline.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Paul Collins <paul@burly.ondioline.org>
Cc: James Cloos <cloos@jhcloos.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>

On Mon, 2008-11-03 at 20:01 +1300, Paul Collins wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> > Now, the problem is ... My second son was just born last wed. so I'm
> > pretty unavailable right now. Thus, for .29, I'm tempted to go for the
> > simpler approach which is to blacklist M7's from imageblit acceleration.
> 
> I am also experiencing this problem on a PowerBook G4 with an M10.

Interesting... I actually developed it on a PowerBook G4 with an M10 !
Maybe not the same revision though or maybe not the same fonts.

I'll have to dig a bit, I'm not sure I'll be able to do a proper
fix in time for the current -rc's so we might have to back the
patch off. We'll see what I can come up with this week, I want to
try reproducing here and experimenting if doing that alignment
& clipping helps.
 
> 0000:00:10.0 VGA compatible controller [0300]: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10] [1002:4e50]
> 
> Here are the fonts I'm using:
> 
>         http://ondioline.org/~paul/consolefonts/
> 

Thanks.

One thing you may want to try .. it will result in crap results on
screen but would help telling us if that's the cause, is to hack
radeonfb to round the image size to a multiple of 32 and see if that
stops the lockup.

Cheers,
Ben.
