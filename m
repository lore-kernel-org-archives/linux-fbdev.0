From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: mode setting and console locking
Date: Sun, 16 May 2004 20:51:29 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040517035129.28227.qmail@web14928.mail.yahoo.com>
References: <20040517022938.48950.qmail@web14922.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPZA1-0000jl-Hc
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 20:51:29 -0700
Received: from web14928.mail.yahoo.com ([216.136.225.87])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BPZA1-0005Gk-7u
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 20:51:29 -0700
In-Reply-To: <20040517022938.48950.qmail@web14922.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

My current conclusion is that a VT switch to/from X is destroying the radeon's
registers.  But I don't think X is doing the destroying. My X app does not have
the radeon driver loaded and I checked /proc/maps and the radeon hardware is not
mapped to the X process. 

Some test cases....
radeonfb is always being run on the secondary device
console and X are always on the primary device

modprobe radeonfb from console
VT swap to X
fbset from xterm - fails

modprobe radeonfb from xterm
VT swap to console and back to X
fbset from xterm - works

modprobe radeonfb from console
VT swap to X and back to console
fbset from console - works

modprobe radeonfb from console
VT swap to another console
fbset from console - works

The only difference I can see is that the X term is in KD_GRAPHICS. When the VT
is swapped from a console in KD_TEXT to one in KD_GRAPHICS a signal must be sent
to radeonfb. This signal is being handled wrong and the wrong data is loaded
into the registers. But what is really wrong is that this signal shouldn't be
sent to radeonfb at all since my radeonfb is not the primary console device and
it shouldn't be touched on a VT swap.

I haven't figured out what happens in an fbdev driver on a KD_TEXT/KD_GRAPHICS
transition yet.



--- Jon Smirl <jonsmirl@yahoo.com> wrote:
> After about 100 reboots I have narrowed it down. The problem is coming from
> the
> VT switch to get to XFree, not Xfree. I have a bare fbdev loaded on a
> secondary
> device without a console attached to it. It should not be processing VT
> switches
> but it is.


=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
