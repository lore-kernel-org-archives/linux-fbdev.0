From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: mode setting and console locking, nvidia failure
Date: Mon, 17 May 2004 16:26:38 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040517232638.88688.qmail@web14926.mail.yahoo.com>
References: <Pine.LNX.4.44.0405172351550.796-100000@phoenix.infradead.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPrVH-00041T-2V
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 May 2004 16:26:39 -0700
Received: from web14926.mail.yahoo.com ([216.136.225.84])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BPrVG-0007AE-HU
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 May 2004 16:26:38 -0700
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

I'll on vanilla 2.6 bk so I'll get the patch a try.

This is another theory I had but it doesn't seem to be true....

My new theory is that when I reset the secondary card it left two active VGA
devices. Then when I VT swap vgacon writes to the primary one but it is really
setting the registers to both cards. 

But I have some data against this theory.
1) I compiled vgacon out, compiled fbcon in. problem still happens
2) If it both VGAs were active, why can I switch from X to console and back to X
and still have fbset from xterm work?  The two VT switches would have caused the
primary card's VGA setting to get written into the secondary card.

After I reset the secondary card I can look at VGA bus routing using lspci and
see that VGA is still routed to my primary card and only a single VGA routing is
enabled.


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
