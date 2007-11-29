From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH] atmel_lcdfb: Validate display timings
Date: Thu, 29 Nov 2007 14:51:33 +0100
Message-ID: <1196344293-31101-1-git-send-email-hskinnemoen@atmel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ixjnz-0001OY-Bj for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 05:51:56 -0800
Received: from nat-132.atmel.no ([80.232.32.132] helo=relay.atmel.no)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ixjnw-00040J-61
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 Nov 2007 05:51:49 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Antonino A. Daplas" <adaplas@gmail.com>, Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: kernel@avr32linux.org, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

Setting a display timing parameter too high or too low may cause it to
wrap around and thus become completely wrong. Validate the timings in
atmel_lcdfb_check_var() and saturate to the highest or lowest possible
value if necessary.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/video/atmel_lcdfb.c |   20 ++++++++++++++++++++
 include/video/atmel_lcdc.h  |   14 +++++++-------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 235b618..58d49e4 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -203,6 +203,26 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
 	var->transp.offset = var->transp.length = 0;
 	var->xoffset = var->yoffset = 0;
 
+	/* Saturate vertical and horizontal timings at maximum values */
+	var->vsync_len = min_t(u32, var->vsync_len,
+			(ATMEL_LCDC_VPW >> ATMEL_LCDC_VPW_OFFSET) + 1);
+	var->upper_margin = min_t(u32, var->upper_margin,
+			ATMEL_LCDC_VBP >> ATMEL_LCDC_VBP_OFFSET);
+	var->lower_margin = min_t(u32, var->lower_margin,
+			ATMEL_LCDC_VFP);
+	var->right_margin = min_t(u32, var->right_margin,
+			(ATMEL_LCDC_HFP >> ATMEL_LCDC_HFP_OFFSET) + 1);
+	var->hsync_len = min_t(u32, var->hsync_len,
+			(ATMEL_LCDC_HPW >> ATMEL_LCDC_HPW_OFFSET) + 1);
+	var->left_margin = min_t(u32, var->left_margin,
+			ATMEL_LCDC_HBP + 1);
+
+	/* Some parameters can't be zero */
+	var->vsync_len = max_t(u32, var->vsync_len, 1);
+	var->right_margin = max_t(u32, var->right_margin, 1);
+	var->hsync_len = max_t(u32, var->hsync_len, 1);
+	var->left_margin = max_t(u32, var->left_margin, 1);
+
 	switch (var->bits_per_pixel) {
 	case 1:
 	case 2:
diff --git a/include/video/atmel_lcdc.h b/include/video/atmel_lcdc.h
index 4eea637..76095e7 100644
--- a/include/video/atmel_lcdc.h
+++ b/include/video/atmel_lcdc.h
@@ -115,20 +115,20 @@ struct atmel_lcdfb_info {
 #define		ATMEL_LCDC_MEMOR_LITTLE		(1 << 31)
 
 #define ATMEL_LCDC_TIM1		0x0808
-#define	ATMEL_LCDC_VFP		(0xff <<  0)
+#define	ATMEL_LCDC_VFP		(0xffU <<  0)
 #define	ATMEL_LCDC_VBP_OFFSET		8
-#define	ATMEL_LCDC_VBP		(0xff <<  ATMEL_LCDC_VBP_OFFSET)
+#define	ATMEL_LCDC_VBP		(0xffU <<  ATMEL_LCDC_VBP_OFFSET)
 #define	ATMEL_LCDC_VPW_OFFSET		16
-#define	ATMEL_LCDC_VPW		(0x3f << ATMEL_LCDC_VPW_OFFSET)
+#define	ATMEL_LCDC_VPW		(0x3fU << ATMEL_LCDC_VPW_OFFSET)
 #define	ATMEL_LCDC_VHDLY_OFFSET		24
-#define	ATMEL_LCDC_VHDLY	(0xf  << ATMEL_LCDC_VHDLY_OFFSET)
+#define	ATMEL_LCDC_VHDLY	(0xfU  << ATMEL_LCDC_VHDLY_OFFSET)
 
 #define ATMEL_LCDC_TIM2		0x080c
-#define	ATMEL_LCDC_HBP		(0xff  <<  0)
+#define	ATMEL_LCDC_HBP		(0xffU  <<  0)
 #define	ATMEL_LCDC_HPW_OFFSET		8
-#define	ATMEL_LCDC_HPW		(0x3f  <<  ATMEL_LCDC_HPW_OFFSET)
+#define	ATMEL_LCDC_HPW		(0x3fU  <<  ATMEL_LCDC_HPW_OFFSET)
 #define	ATMEL_LCDC_HFP_OFFSET		21
-#define	ATMEL_LCDC_HFP		(0x7ff << ATMEL_LCDC_HFP_OFFSET)
+#define	ATMEL_LCDC_HFP		(0x7ffU << ATMEL_LCDC_HFP_OFFSET)
 
 #define ATMEL_LCDC_LCDFRMCFG	0x0810
 #define	ATMEL_LCDC_LINEVAL	(0x7ff <<  0)
-- 
1.5.3.4


-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
