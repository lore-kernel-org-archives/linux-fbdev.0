From: Jon Smirl <jonsmirl@yahoo.com>
Subject: Re: Re: mode setting and console locking
Date: Sun, 16 May 2004 21:12:57 -0700 (PDT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040517041258.65569.qmail@web14930.mail.yahoo.com>
References: <1084765880.6447.21.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BPZUo-0002ZP-Cy
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 21:12:58 -0700
Received: from web14930.mail.yahoo.com ([216.136.225.159])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1BPZUo-0008R7-5A
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 May 2004 21:12:58 -0700
In-Reply-To: <1084765880.6447.21.camel@gaston>
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

--- Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> The kernel VT subsystem issue a special blank call to the console driver
> (I recently fixed issues there to catch those properly). fbcon will for
> a set mode when getting one of those going from gfx->text

I don't have fbcon loaded, I'm using vgacon. 

I'll try adding a printk on the radeonfb blank call and see if I am getting one
on VT swap.

The special blank call is probably what is failing. It's the primary card that
is transitioning from gfx->text, not the secondary radeonfb card. Telling the
secondary card it is transitioning when it really isn't will probably mess it up.

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
