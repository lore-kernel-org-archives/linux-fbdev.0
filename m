From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: mode setting and console locking, nvidia failure
Date: Mon, 17 May 2004 20:53:57 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040518035357.72794.qmail@web14927.mail.yahoo.com>
References: <1084851433.15183.20.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPvfx-00041P-9d
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 May 2004 20:53:57 -0700
Received: from web14927.mail.yahoo.com ([216.136.225.85])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BPvfx-0006ST-1m
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 May 2004 20:53:57 -0700
In-Reply-To: <1084851433.15183.20.camel@gaston>
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
Cc: James Simmons <jsimmons@infradead.org>, fb-devel <linux-fbdev-devel@lists.sourceforge.net>

It's your fbdev driver but taking out all console semaphore references didn't
make a difference. It was the ones in fbmem.c I though were the problem, not the
ones in the pm code.

I have this case, rmmod with printk in module remove routine causes hang. Get
rid of the printk and rmmod will succeed. 

How do you debug this?

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
