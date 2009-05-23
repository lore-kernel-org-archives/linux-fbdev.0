From: Harald Welte <HaraldWelte@viatech.com>
Subject: [PATCH 12/14] viafb: initialize 2D engine
	registers from loop
Date: Sat, 23 May 2009 17:41:34 +0800
Message-ID: <1243071696-9334-12-git-send-email-HaraldWelte@viatech.com>
References: <1243071696-9334-1-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-2-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-3-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-4-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-5-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-6-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-7-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-8-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-9-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-10-git-send-email-HaraldWelte@viatech.com>
	<1243071696-9334-11-git-send-email-HaraldWelte@viatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <laforge@prithivi.openmoko.org>) id 1M7nsE-0005KF-9z
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 09:50:38 +0000
Received: from ganesha.gnumonks.org ([213.95.27.120])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M7ns6-0007tp-Qp
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 23 May 2009 09:50:38 +0000
In-Reply-To: <1243071696-9334-11-git-send-email-HaraldWelte@viatech.com>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Harald Welte <HaraldWelte@viatech.com>

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
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
