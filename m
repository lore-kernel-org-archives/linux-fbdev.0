From: James Simmons <jsimmons@infradead.org>
Subject: Re: Re: fbdev cursor part 1.
Date: Sun, 22 Feb 2004 22:37:03 +0000 (GMT)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402222234120.2390-100000@phoenix.infradead.org>
References: <200402222206.15070.alex.kern@gmx.de>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Av2L1-0004ag-Dx
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 22 Feb 2004 14:44:39 -0800
Received: from phoenix.infradead.org ([213.86.99.234])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30)
	id 1Av22z-0004YM-RF
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 22 Feb 2004 14:26:02 -0800
In-Reply-To: <200402222206.15070.alex.kern@gmx.de>
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
To: Alexander Kern <alex.kern@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net


> > > Andrew, that one seem to work fine for me, been hammered for some time
> > > in the fbdev tree. It should go to -mm for a while imho so we get more
> > > broader testing, and eventually in 2.6.4
> >
> > Please do.
> Hi,
> 
> James, would you do part 2 of cursor patch? I convert here
> mach64 driver to pci_table solution, it works ok on my notebook. Base is 2.6.3 
> + fix_double_console_init + cursor_part 1, but cursor is broken. On console 
> it is invisible, in mc it looks correct.
> 
> The difference to todays aty driver in mainline is too big, and it can broke 
> old errata rich chip versions, which I'm not own. Should it be submitted as 
> aty_new? Just like a radeon driver did it?
> 
> Regards Alex
> 
> P.S. I have trouble to merge your patches from mailing-list. Have you they 
> somewhere in internet? Or send they as attachment ;-)

I plan to submit the latets mach64 driver from BK to linus as soon as the 
first part of the cursor patch goes in. It gives enough of the new 
cursor api to do a dump of all the drivers in the 2.5 fbdev tree. Could you
make your patch against the fbdev-2.5 bk tree? Try my patch 

http://phoenix.infradead.org/~jsimmons/fbdev.diff.gz

If it doesn't work I will put a new one you there.




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
