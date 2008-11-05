From: Paul Collins <paul@burly.ondioline.org>
Subject: Re: [Linux-fbdev-devel] radeonfb lockup in .28-rc (bisected)
Date: Wed, 05 Nov 2008 23:28:01 +1300
Message-ID: <87skq6sc0e.fsf@burly.wgtn.ondioline.org>
References: <m31vy1k3ea.fsf@lugabout.jhcloos.org>
	<1225152347.8004.49.camel@pasglop>
	<m3k5bt2hsc.fsf@lugabout.jhcloos.org>
	<1225662539.8004.237.camel@pasglop>
	<871vxtthr3.fsf@burly.wgtn.ondioline.org>
	<1225874361.13603.12.camel@pasglop>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756385AbYKEK2V@vger.kernel.org>
In-Reply-To: <1225874361.13603.12.camel@pasglop> (Benjamin Herrenschmidt's
	message of "Wed, 05 Nov 2008 19:39:21 +1100")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, James Cloos <cloos@jhcloos.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Krzysztof Halasa <khc@pm.waw.pl>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Mon, 2008-11-03 at 20:01 +1300, Paul Collins wrote:
>> I am also experiencing this problem on a PowerBook G4 with an M10.
>>
>> 0000:00:10.0 VGA compatible controller [0300]: ATI Technologies Inc RV350 [Mobility Radeon 9600 M10] [1002:4e50]
>> 
>> Here are the fonts I'm using:
>> 
>>         http://ondioline.org/~paul/consolefonts/
>
> For some reason, that font gives me "Bad font file format". 

Odd.  I'm using setfont from Debian's kbd 1.14.1-4 to load it.

P.S. I haven't had time to play with the 32-roundup thing any further yet.

-- 
Paul Collins
Wellington, New Zealand

Dag vijandelijk luchtschip de huismeester is dood
