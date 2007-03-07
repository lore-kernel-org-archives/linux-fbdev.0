From: Ondrej Zajicek <santiago@crfreenet.org>
Subject: [PATCH] fix pixclock setting on Voodoo 1/2 cards
Date: Wed, 7 Mar 2007 21:45:23 +0100
Message-ID: <20070307204523.GC2142@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HP30v-0001Xv-VX for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Mar 2007 12:45:34 -0800
Received: from smtp1.kolej.mff.cuni.cz ([195.113.24.4])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HP30u-0006ZN-6V
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Mar 2007 12:45:33 -0800
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: gtoumi@laposte.net

Pixclock setting in sstfb didn't work with my Voodoo 2 card
with ICS 5342 DAC (this DAC requires two consecutive writes
to one of its registers to program pixclock - maybe first
write merged with second).

This patch fixes bug with pixclock setting. It is against 
2.6.21-rc1 .

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>

---

diff -uprN -X linux-2.6.21-rc1-not/Documentation/dontdiff linux-2.6.21-rc1-not/drivers/video/sstfb.c linux-2.6.21-rc1-fix/drivers/video/sstfb.c
--- linux-2.6.21-rc1-not/drivers/video/sstfb.c	2007-02-04 19:44:54.000000000 +0100
+++ linux-2.6.21-rc1-fix/drivers/video/sstfb.c	2007-03-07 21:03:08.000000000 +0100
@@ -257,6 +257,7 @@ static void __sst_dac_write(u8 __iomem *
 	r_dprintk("sst_dac_write(%#x, %#x)\n", reg, val);
 	reg &= 0x07;
 	__sst_write(vbase, DAC_DATA,(((u32)reg << 8)) | (u32)val);
+	__sst_wait_idle(vbase);
 }
 
 /* indexed access to ti/att dacs */


-- 
Ondrej 'SanTiago' Zajicek (email: santiago@mail.cz, jabber: santiago@njs.netlab.cz)
OpenPGP encrypted e-mails preferred (KeyID 0x11DEADC3, wwwkeys.pgp.net)
"To err is human -- to blame it on a computer is even more so."

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
