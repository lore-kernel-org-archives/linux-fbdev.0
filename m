From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 13/15] viafb: initialize 2D engine
	registers from loop
Date: Thu, 21 May 2009 04:28:51 +0800
Message-ID: <1242851333-325-13-git-send-email-HaraldWelte@viatech.com>
References: <1242851333-325-1-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-2-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-3-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-4-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-5-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-6-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-7-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-8-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-9-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-10-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-11-git-send-email-HaraldWelte@viatech.com>
	<1242851333-325-12-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <laforge@prithivi.openmoko.org>) id 1M6sjP-0006Kb-Pl
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 20:49:43 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M6sjL-0007Ga-1i
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 May 2009 20:49:43 +0000
In-Reply-To: <1242851333-325-12-git-send-email-HaraldWelte@viatech.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Harald Welte <HaraldWelte@viatech.com>

From: Harald Welte <laforge@gnumonks.org>

We don't need to unroll the register initialization routine when
initializing the 2D engine registers

Signed-off-by: Harald Welte <HaraldWelte@viatech.com>
---
 drivers/video/via/accel.c |   18 +++---------------
 1 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/video/via/accel.c b/drivers/video/via/accel.c
index c3af95f..b3a414e 100644
--- a/drivers/video/via/accel.c
+++ b/drivers/video/via/accel.c
@@ -41,23 +41,11 @@ void viafb_init_2d_engine(void)
 {
 	u32 dwVQStartAddr, dwVQEndAddr;
 	u32 dwVQLen, dwVQStartL, dwVQEndL, dwVQStartEndH;
+	int i;
 
 	/* init 2D engine regs to reset 2D engine */
-	writel(0x0, viaparinfo->io_virt + VIA_REG_GEMODE);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_SRCPOS);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_DSTPOS);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_DIMENSION);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_PATADDR);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_FGCOLOR);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_BGCOLOR);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_CLIPTL);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_CLIPBR);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_OFFSET);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_KEYCONTROL);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_SRCBASE);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_DSTBASE);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_PITCH);
-	writel(0x0, viaparinfo->io_virt + VIA_REG_MONOPAT1);
+	for (i = 0; i <= 0x40; i+= 4)
+		writel(0x0, viaparinfo->io_virt + i);
 
 	/* Init AGP and VQ regs */
 	switch (viaparinfo->chip_info->gfx_chip_name) {
-- 
1.6.2.4


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
