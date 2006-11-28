From: "Jordan Crouse" <jordan.crouse@amd.com>
Subject: [PATCH 6/6] [PATCH] gxfb: Turn on the flatpanel
	power and data
Date: Tue, 28 Nov 2006 16:15:23 -0700
Message-ID: <20061128231522.25769.75989.stgit@cosmic.amd.com>
References: <20061128230639.25769.43.stgit@cosmic.amd.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GpC4n-0004Ch-FW for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 28 Nov 2006 15:09:21 -0800
Received: from outbound-fra.frontbridge.com ([62.209.45.174]
	helo=outbound2-fra-R.bigfish.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GpC4m-0001ip-JE
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 28 Nov 2006 15:09:21 -0800
In-Reply-To: <20061128230639.25769.43.stgit@cosmic.amd.com>
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
To: linux-fbdev-devel@lists.sourceforge.net, info-linux@ldcmail.amd.com
Cc: akpm@osdl.org

From: Jordan Crouse <jordan.crouse@amd.com>

For Geode devices without a flatpanel aware BIOS, this enables the flatpanel
power and data.

Signed-off-by: Jordan Crouse <jordan.crouse@amd.com>
---

 drivers/video/geode/video_gx.c |   13 +++++++++++--
 drivers/video/geode/video_gx.h |    2 ++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/video/geode/video_gx.c b/drivers/video/geode/video_gx.c
index e6a4c70..ed6a174 100644
--- a/drivers/video/geode/video_gx.c
+++ b/drivers/video/geode/video_gx.c
@@ -220,7 +220,13 @@ gx_configure_tft(struct fb_info *info) {
 	/*  Set the dither control */
 	writel(0x70, par->vid_regs + GX_FP_DFC);
 
-	/* Turn on the device */
+	/* Enable the FP data and power (in case the BIOS didn't) */
+
+	fp = readl(par->vid_regs + GX_DCFG);
+	fp |= GX_DCFG_FP_PWR_EN | GX_DCFG_FP_DATA_EN;
+	writel(fp, par->vid_regs + GX_DCFG);
+
+	/* Unblank the panel */
 
 	fp = readl(par->vid_regs + GX_FP_PM);
 	fp |= GX_FP_PM_P;
@@ -245,9 +251,12 @@ static void gx_configure_display(struct
 	writel(misc, par->vid_regs + GX_MISC);
 
 	/* Write the display configuration */
-
 	dcfg = readl(par->vid_regs + GX_DCFG);
 
+	/* Disable hsync and vsync */
+	dcfg &= ~(GX_DCFG_VSYNC_EN | GX_DCFG_HSYNC_EN);
+	writel(dcfg, par->vid_regs + GX_DCFG);
+
 	/* Clear bits from existing mode. */
 	dcfg &= ~(GX_DCFG_CRT_SYNC_SKW_MASK
 		  | GX_DCFG_CRT_HSYNC_POL   | GX_DCFG_CRT_VSYNC_POL
diff --git a/drivers/video/geode/video_gx.h b/drivers/video/geode/video_gx.h
index 119d0ab..ce28d8f 100644
--- a/drivers/video/geode/video_gx.h
+++ b/drivers/video/geode/video_gx.h
@@ -25,6 +25,8 @@ #  define GX_DCFG_CRT_EN		0x00000001
 #  define GX_DCFG_HSYNC_EN		0x00000002
 #  define GX_DCFG_VSYNC_EN		0x00000004
 #  define GX_DCFG_DAC_BL_EN		0x00000008
+#  define GX_DCFG_FP_PWR_EN		0x00000040
+#  define GX_DCFG_FP_DATA_EN		0x00000080
 #  define GX_DCFG_CRT_HSYNC_POL		0x00000100
 #  define GX_DCFG_CRT_VSYNC_POL		0x00000200
 #  define GX_DCFG_CRT_SYNC_SKW_MASK	0x0001C000



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
