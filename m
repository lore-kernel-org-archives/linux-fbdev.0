From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: Re: fbdev cursor part 1.
Date: Sun, 22 Feb 2004 22:06:15 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200402222206.15070.alex.kern@gmx.de>
References: <Pine.LNX.4.44.0402162341190.21833-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Av0vA-0003yu-MJ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 22 Feb 2004 13:13:52 -0800
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1Av0dE-0000mV-Nv
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 22 Feb 2004 12:55:20 -0800
In-Reply-To: <Pine.LNX.4.44.0402162341190.21833-100000@phoenix.infradead.org>
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@infradead.org>

Am Dienstag, 17. Februar 2004 00:41 schrieb James Simmons:
> > Andrew, that one seem to work fine for me, been hammered for some time
> > in the fbdev tree. It should go to -mm for a while imho so we get more
> > broader testing, and eventually in 2.6.4
>
> Please do.
Hi,

James, would you do part 2 of cursor patch? I convert here
mach64 driver to pci_table solution, it works ok on my notebook. Base is 2.6.3 
+ fix_double_console_init + cursor_part 1, but cursor is broken. On console 
it is invisible, in mc it looks correct.

The difference to todays aty driver in mainline is too big, and it can broke 
old errata rich chip versions, which I'm not own. Should it be submitted as 
aty_new? Just like a radeon driver did it?

Regards Alex

P.S. I have trouble to merge your patches from mailing-list. Have you they 
somewhere in internet? Or send they as attachment ;-)


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
