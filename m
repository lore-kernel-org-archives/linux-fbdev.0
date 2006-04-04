From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] video/aty/atyfb_base.c: fix an off-by-one error
Date: Tue, 4 Apr 2006 20:54:54 +0200
Message-ID: <20060404185454.GW6529@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750802AbWDDSy5@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

This patch fixes an obvious of-by-one error spotted by the Coverity 
checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-rc1-mm1-full/drivers/video/aty/atyfb_base.c.old	2006-04-04 20:20:18.000000000 +0200
+++ linux-2.6.17-rc1-mm1-full/drivers/video/aty/atyfb_base.c	2006-04-04 20:20:33.000000000 +0200
@@ -3400,7 +3400,7 @@ static int __devinit atyfb_pci_probe(str
 	struct atyfb_par *par;
 	int i, rc = -ENOMEM;
 
-	for (i = ARRAY_SIZE(aty_chips); i >= 0; i--)
+	for (i = ARRAY_SIZE(aty_chips) - 1; i >= 0; i--)
 		if (pdev->device == aty_chips[i].pci_id)
 			break;
 
