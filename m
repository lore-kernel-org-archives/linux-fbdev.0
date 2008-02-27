From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 7/8] pxa: introduce register independent
	LCD connection type for pxafb
Date: Wed, 27 Feb 2008 10:38:34 +0800
Message-ID: <f17812d70802261838q6b56f15exd51ce45200c999e3@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JUCBn-0003gG-BI for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 18:38:35 -0800
Received: from wa-out-1112.google.com ([209.85.146.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JUCBm-00054s-W2
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 18:38:35 -0800
Received: by wa-out-1112.google.com with SMTP id k22so3027486waf.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 26 Feb 2008 18:38:34 -0800 (PST)
Content-Disposition: inline
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
To: linux-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

From 87d1a301ace25f80f8b1b30cabf0d0269228e22b Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Tue, 26 Feb 2008 14:03:51 +0800
Subject: [PATCH] pxa: introduce register independent LCD connection
type for pxafb

Reasons:

  1. straight forward: the name "LCD_COLOR_DSTN_16BPP" is much better
     than "LCCR0_Pas | LCCR0_Color | LCCR0_Dual"

  2. by defining LCD connection types as constants, it allows only
     valid possibilities

  3. by removing the dependency of register bits definitions, those
     can be later moved into the body of pxafb.c, instead of having
     a regs-lcd.h around

Currently, only lubbock, mainstone, zylonite and littleton have been
modified to support these types (see coming patches after this).
Other platforms are encouraged to change their way describing the
LCD controller connections.

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/video/pxafb.c            |   76 +++++++++++++++++++++++++++++++-------
 include/asm-arm/arch-pxa/pxafb.h |   44 ++++++++++++++++++++++
 2 files changed, 106 insertions(+), 14 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index b7a3304..b5c4548 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1064,13 +1064,73 @@ static int __init
pxafb_map_video_memory(struct pxafb_info *fbi)
 	return fbi->map_cpu ? 0 : -ENOMEM;
 }

+static void pxafb_decode_mode_info(struct pxafb_info *fbi,
+				   struct pxafb_mode_info *modes,
+				   unsigned int num_modes)
+{
+	unsigned int i, smemlen;
+
+	pxafb_setmode(&fbi->fb.var, &modes[0]);
+
+	for (i = 0; i < num_modes; i++) {
+		smemlen = modes[i].xres * modes[i].yres * modes[i].bpp / 8;
+		if (smemlen > fbi->fb.fix.smem_len)
+			fbi->fb.fix.smem_len = smemlen;
+	}
+}
+
+static int pxafb_decode_mach_info(struct pxafb_info *fbi,
+				  struct pxafb_mach_info *inf)
+{
+	unsigned int lcd_conn = inf->lcd_conn;
+
+	fbi->cmap_inverse	= inf->cmap_inverse;
+	fbi->cmap_static	= inf->cmap_static;
+
+	switch (lcd_conn & 0xf) {
+	case LCD_TYPE_MONO_STN:
+		fbi->lccr0 = LCCR0_CMS;
+		break;
+	case LCD_TYPE_MONO_DSTN:
+		fbi->lccr0 = LCCR0_CMS | LCCR0_SDS;
+		break;
+	case LCD_TYPE_COLOR_STN:
+		fbi->lccr0 = 0;
+		break;
+	case LCD_TYPE_COLOR_DSTN:
+		fbi->lccr0 = LCCR0_SDS;
+		break;
+	case LCD_TYPE_COLOR_TFT:
+		fbi->lccr0 = LCCR0_PAS;
+		break;
+	case LCD_TYPE_SMART_PANEL:
+		fbi->lccr0 = LCCR0_LCDT | LCCR0_PAS;
+		break;
+	default:
+		/* fall back to backward compatibility way */
+		fbi->lccr0 = inf->lccr0;
+		fbi->lccr3 = inf->lccr3;
+		fbi->lccr4 = inf->lccr4;
+		return -EINVAL;
+	}
+
+	if (lcd_conn == LCD_MONO_STN_8BPP)
+		fbi->lccr0 |= LCCR0_DPD;
+
+	fbi->lccr3 = LCCR3_Acb((inf->lcd_conn >> 10) & 0xff);
+	fbi->lccr3 |= (lcd_conn & LCD_BIAS_ACTIVE_LOW) ? LCCR3_OEP : 0;
+	fbi->lccr3 |= (lcd_conn & LCD_PCLK_EDGE_FALL)  ? LCCR3_PCP : 0;
+
+	pxafb_decode_mode_info(fbi, inf->modes, inf->num_modes);
+	return 0;
+}
+
 static struct pxafb_info * __init pxafb_init_fbinfo(struct device *dev)
 {
 	struct pxafb_info *fbi;
 	void *addr;
 	struct pxafb_mach_info *inf = dev->platform_data;
 	struct pxafb_mode_info *mode = inf->modes;
-	int i, smemlen;

 	/* Alloc the pxafb_info and pseudo_palette in one step */
 	fbi = kmalloc(sizeof(struct pxafb_info) + sizeof(u32) * 16, GFP_KERNEL);
@@ -1110,22 +1170,10 @@ static struct pxafb_info * __init
pxafb_init_fbinfo(struct device *dev)
 	addr = addr + sizeof(struct pxafb_info);
 	fbi->fb.pseudo_palette	= addr;

-	pxafb_setmode(&fbi->fb.var, mode);
-
-	fbi->cmap_inverse	= inf->cmap_inverse;
-	fbi->cmap_static	= inf->cmap_static;
-
-	fbi->lccr0		= inf->lccr0;
-	fbi->lccr3		= inf->lccr3;
-	fbi->lccr4		= inf->lccr4;
 	fbi->state		= C_STARTUP;
 	fbi->task_state		= (u_char)-1;

-	for (i = 0; i < inf->num_modes; i++) {
-		smemlen = mode[i].xres * mode[i].yres * mode[i].bpp / 8;
-		if (smemlen > fbi->fb.fix.smem_len)
-			fbi->fb.fix.smem_len = smemlen;
-	}
+	pxafb_decode_mach_info(fbi, inf);

 	init_waitqueue_head(&fbi->ctrlr_wait);
 	INIT_WORK(&fbi->task, pxafb_task);
diff --git a/include/asm-arm/arch-pxa/pxafb.h b/include/asm-arm/arch-pxa/pxafb.h
index 5cf51a5..41a6c22 100644
--- a/include/asm-arm/arch-pxa/pxafb.h
+++ b/include/asm-arm/arch-pxa/pxafb.h
@@ -16,6 +16,48 @@
 #include <asm/arch/regs-lcd.h>

 /*
+ * Supported LCD connections
+ *
+ * bits 0 - 3: for LCD panel type:
+ *
+ *   STN  - for passive matrix
+ *   DSTN - for dual scan passive matrix
+ *   TFT  - for active matrix
+ *
+ * bits 4 - 9 : for bus width
+ * bits 10-17 : for AC Bias Pin Frequency
+ * bit     18 : for output enable polarity
+ * bit     19 : for pixel clock edge
+ */
+#define LCD_CONN_TYPE(_x)	((_x) & 0x0f)
+#define LCD_CONN_WIDTH(_x)	(((_x) >> 4) & 0x1f)
+
+#define LCD_TYPE_UNKNOWN	0
+#define LCD_TYPE_MONO_STN	1
+#define LCD_TYPE_MONO_DSTN	2
+#define LCD_TYPE_COLOR_STN	3
+#define LCD_TYPE_COLOR_DSTN	4
+#define LCD_TYPE_COLOR_TFT	5
+#define LCD_TYPE_SMART_PANEL	6
+#define LCD_TYPE_MAX		7
+
+#define LCD_MONO_STN_4BPP	((4  << 4) | LCD_TYPE_MONO_STN)
+#define LCD_MONO_STN_8BPP	((8  << 4) | LCD_TYPE_MONO_STN)
+#define LCD_MONO_DSTN_8BPP	((8  << 4) | LCD_TYPE_MONO_DSTN)
+#define LCD_COLOR_STN_8BPP	((8  << 4) | LCD_TYPE_COLOR_STN)
+#define LCD_COLOR_DSTN_16BPP	((16 << 4) | LCD_TYPE_COLOR_DSTN)
+#define LCD_COLOR_TFT_16BPP	((16 << 4) | LCD_TYPE_COLOR_TFT)
+#define LCD_COLOR_TFT_18BPP	((18 << 4) | LCD_TYPE_COLOR_TFT)
+#define LCD_SMART_PANEL_16BPP	((16 << 4) | LCD_TYPE_SMART_PANEL)
+#define LCD_SMART_PANEL_18BPP	((18 << 4) | LCD_TYPE_SMART_PANEL)
+
+#define LCD_AC_BIAS_FREQ(x)	(((x) & 0xff) << 10)
+#define LCD_BIAS_ACTIVE_HIGH	(0 << 17)
+#define LCD_BIAS_ACTIVE_LOW	(1 << 17)
+#define LCD_PCLK_EDGE_RISE	(0 << 18)
+#define LCD_PCLK_EDGE_FALL	(1 << 18)
+
+/*
  * This structure describes the machine which we are running on.
  * It is set in linux/arch/arm/mach-pxa/machine_name.c and used in
the probe routine
  * of linux/drivers/video/pxafb.c
@@ -44,6 +86,8 @@ struct pxafb_mach_info {
 	struct pxafb_mode_info *modes;
 	unsigned int num_modes;

+	unsigned int	lcd_conn;
+
 	u_int		fixed_modes:1,
 			cmap_inverse:1,
 			cmap_static:1,
-- 
1.5.3.8



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
