From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: Usage of readb() and friends...
Date: Tue, 2 Mar 2004 23:36:53 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0403022334560.19874-100000@phoenix.infradead.org>
References: <1078267813.21578.201.camel@gaston>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AyJeD-0005Qm-W6
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 15:50:01 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1AyJRd-0006qz-7r
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Mar 2004 15:37:01 -0800
In-Reply-To: <1078267813.21578.201.camel@gaston>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kars de Jong <jongk@linux-m68k.org>, Richard Zidlicky <rz@linux-m68k.org>, Russell King <rmk@arm.linux.org.uk>, Linux/m68k kernel mailing list <linux-m68k@lists.linux-m68k.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>


> > On Tue, 2 Mar 2004, Kars de Jong wrote:
> > > Which reminds me: drivers/video/fbmem.c at least seems to treat the
> > > return value of ioremap() as a virtual address, since it calls
> > > copy_{to,from}_user on it directly...
> > 
> > You're right. And the trouble there is that you can't easily find out which
> > ioremap() variant was used...
> 
> And... it's illegal to call copy_to/from_user on the return of
> ioremap anyway. Not only for semantic reasons, but also for practical
> reasons, for example, ioremap returns non cacheable space on PPC,
> and copy_to/from_user uses "cache hints" to speed up the copy.

Ug. More reason to replace the code with imageblit calls. The new fb_write 
code for some reson tho scrambles the console screen and then scrolls the 
screen below where I'm writing. I haven't figured out way yet.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
