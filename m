From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 07/41] nvidiafb: Fix sparse warning
Date: Wed, 25 Apr 2007 14:21:56 +0800
Message-ID: <462EF384.7060309@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc5M-0000pR-CJ for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:38:44 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc5K-0002pB-Um
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:38:44 -0700
Received: by py-out-1112.google.com with SMTP id a29so116192pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:38:42 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Fix the following sparse warning:

drivers/video/nvidia/nv_setup.c:659:20: warning: dereference of noderef expression

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/nvidia/nv_setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/nvidia/nv_setup.c b/drivers/video/nvidia/nv_setup.c
index eab3e28..336ddb0 100644
--- a/drivers/video/nvidia/nv_setup.c
+++ b/drivers/video/nvidia/nv_setup.c
@@ -656,7 +656,7 @@ int NVCommonSetup(struct fb_info *info)
 	par->LVDS = 0;
 	if (par->FlatPanel && par->twoHeads) {
 		NV_WR32(par->PRAMDAC0, 0x08B0, 0x00010004);
-		if (par->PRAMDAC0[0x08b4] & 1)
+		if (NV_RD32(par->PRAMDAC0, 0x08b4) & 1)
 			par->LVDS = 1;
 		printk("nvidiafb: Panel is %s\n", par->LVDS ? "LVDS" : "TMDS");
 	}


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
