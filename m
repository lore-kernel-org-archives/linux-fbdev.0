From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] atyfb: Fix power management
Date: Wed, 03 Nov 2004 14:45:28 +1100
Message-ID: <1099453528.900.33.camel@gaston>
References: <1099451704.31629.28.camel@gaston>
	 <Pine.LNX.4.58.0411021946060.2187@ppc970.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPCD3-00034k-LR
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 19:53:21 -0800
Received: from gate.crashing.org ([63.228.1.57])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1CPCD2-0008N1-Vp
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 02 Nov 2004 19:53:21 -0800
In-Reply-To: <Pine.LNX.4.58.0411021946060.2187@ppc970.osdl.org>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, "Antonino A. Daplas" <adaplas@hotpop.com>

On Tue, 2004-11-02 at 19:47 -0800, Linus Torvalds wrote:
> 
> On Wed, 3 Nov 2004, Benjamin Herrenschmidt wrote:
> > 
> > The PM code in atyfb got broken in the recent update. This is just a typo though,
> > here's a fix:
> 
> Ok, this comment makes no sense. Which is it? It's certainly more than a 
> typo, you're literally changing the return value behaviour to be the 
> reverse of what it was.
> 
> Now, I think your fix is right, but your checkin comment doesn't make any 
> sense. Can you phrase that better?

Hrm... It's actually a typo/thinko when going from the "old style" pmac
notifiers to the new PCI based code, I think it may even be me doing it
a long time ago when I submitted a lot of atyfb updates to the fbdev tree.
(I wrote that PM code)

Anyway, here's a better comment:

----

The new atyfb has the return value for the Power Management routine
wrong. This prevents sleep from working on PowerBooks with mach64
video chips. This fixes it.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/drivers/video/aty/atyfb_base.c
===================================================================
--- linux-work.orig/drivers/video/aty/atyfb_base.c	2004-11-03 14:13:10.319998376 +1100
+++ linux-work/drivers/video/aty/atyfb_base.c	2004-11-03 14:13:45.491651472 +1100
@@ -2015,7 +2015,7 @@
 	}
 	mdelay(500);
 
-	return timeout ? -1 : 0;
+	return timeout ? 0 : -EIO;
 }
 
 static int atyfb_pci_suspend(struct pci_dev *pdev, u32 state)




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
