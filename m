From: Paul Collins <paul@burly.ondioline.org>
Subject: Re: [Linux-fbdev-devel] radeonfb lockup in .28-rc (bisected)
Date: Mon, 03 Nov 2008 20:01:52 +1300
Message-ID: <871vxtthr3.fsf@burly.wgtn.ondioline.org>
References: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
	<1225152347.8004.49.camel@pasglop>
	<m3k5bt2hsc.fsf@lugabout.jhcloos.org>
	<1225662539.8004.237.camel@pasglop>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754796AbYKCHJY@vger.kernel.org>
In-Reply-To: <1225662539.8004.237.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Mon, 03 Nov 2008 08:48:59 +1100")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: James Cloos <cloos@jhcloos.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> Now, the problem is ... My second son was just born last wed. so I'm
> pretty unavailable right now. Thus, for .29, I'm tempted to go for the
> simpler approach which is to blacklist M7's from imageblit acceleration.

I am also experiencing this problem on a PowerBook G4 with an M10.

0000:00:10.0 VGA compatible controller [0300]: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10] [1002:4e50]

Here are the fonts I'm using:

        http://ondioline.org/~paul/consolefonts/

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
