From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: mode setting and console locking, nvidia failure
Date: Mon, 17 May 2004 20:00:08 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040518030008.43467.qmail@web14925.mail.yahoo.com>
References: <Pine.LNX.4.44.0405172351550.796-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPups-00022P-FU
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 May 2004 20:00:08 -0700
Received: from web14925.mail.yahoo.com ([216.136.225.11])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BPups-0004Ks-6A
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 May 2004 20:00:08 -0700
In-Reply-To: <Pine.LNX.4.44.0405172351550.796-100000@phoenix.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

This patch didn't fix it. How does VGA routing work on the PCI bus, what gets
routed? Memory at A000 plus IO ports, just mem???

My top choice is still two enabled VGA devices. I suspect that X libvgahw is
writing to the registers and both cards are seeing the writes.

The bug has a very specific profile - a VT switch from X to console or vice
versa triggers it. But it also has the unique characteristic that if you switch
X to console to X things work ok. Same for console to X to console.

It is easy to recreate you need one PCI and one AGP card. Run without
framebuffer on the primary card. Reset the secondary card with a reset program
(you can use X to reset it). Load fbdev on secondary. Start X. fbset from an
xterm. System dies. This works for every combo of cards I own so it does not
seem to be driver specific.

--- James Simmons <jsimmons@infradead.org> wrote:
> Jon are you using a vanilla 2.6.6 kernel. If you are could you try this 
> patch.
> 
> http://phoenix.infradead.org/~jsimmons/mode.diff
> 
> It might solve your problem. It might be a cons2fb mapping issue.

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
