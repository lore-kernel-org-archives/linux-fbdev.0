From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: mode setting and console locking, nvidia failure
Date: Sun, 16 May 2004 22:03:15 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040517050315.90926.qmail@web14926.mail.yahoo.com>
References: <20040517045145.3255.qmail@web14921.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPaHT-0007Nl-Hw
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 22:03:15 -0700
Received: from web14926.mail.yahoo.com ([216.136.225.84])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BPaHT-0008Ct-Cc
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 22:03:15 -0700
In-Reply-To: <20040517045145.3255.qmail@web14921.mail.yahoo.com>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

There is nothing wrong with fbset on rivafb. It's the same problem I'm having
with radeonfb. Swaping between text->gfx on the primary monitor mess up the chip
registers of the secondary card. In this case the PLL reads zero after the VT
swap and that causes the divide by zero.

This has got to be some problem in fb since I am sure my X does not have an
Nvidia driver loaded.

Now I'm really going to bed.

--- Jon Smirl <jonsmirl@yahoo.com> wrote:
> I'll debug this more in the morning. I tried swapping a Geforce2 for my Radeon
> just to see if I got the same failure. I can't tell since every mode I tried
> setting on the Geforce2 faults the drivers.


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
