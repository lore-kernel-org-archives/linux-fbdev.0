From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/3] sstfb: fix pixclock setting on
	Voodoo 1/2 cards
Date: Sun, 11 Mar 2007 18:22:55 +0800
Message-ID: <45F3D87F.10805@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HQMsp-000233-EY for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Mar 2007 05:10:39 -0700
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HQMso-0002jr-1Q
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Mar 2007 05:10:39 -0700
Received: from ik-out-1112.google.com ([66.249.90.181])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1HQLBz-0006rr-A7 for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 11 Mar 2007 02:22:20 -0800
Received: by ik-out-1112.google.com with SMTP id c30so1528307ika
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 11 Mar 2007 03:22:08 -0700 (PDT)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Ondrej Zajicek <santiago@mail.cz>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Ondrej Zajicek <santiago@crfreenet.org>

Pixclock setting in sstfb didn't work with my Voodoo 2 card
with ICS 5342 DAC (this DAC requires two consecutive writes
to one of its registers to program pixclock - maybe first
write merged with second).

This patch fixes bug with pixclock setting. It is against
2.6.21-rc1 .

Signed-off-by: Ondrej Zajicek <santiago@crfreenet.org>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/sstfb.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sstfb.c b/drivers/video/sstfb.c
index 59cd1e7..62fa550 100644
--- a/drivers/video/sstfb.c
+++ b/drivers/video/sstfb.c
@@ -257,6 +257,7 @@ static void __sst_dac_write(u8 __iomem *
 	r_dprintk("sst_dac_write(%#x, %#x)\n", reg, val);
 	reg &= 0x07;
 	__sst_write(vbase, DAC_DATA,(((u32)reg << 8)) | (u32)val);
+	__sst_wait_idle(vbase);
 }
 
 /* indexed access to ti/att dacs */



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
