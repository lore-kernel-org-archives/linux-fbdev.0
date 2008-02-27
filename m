From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 8/8] pxa: make
	lubbock/mainstone/zylonite/littleton to use new LCD connection type
Date: Wed, 27 Feb 2008 10:39:06 +0800
Message-ID: <f17812d70802261839k50381960t4a38e745474681c8@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JUCCL-0003m3-PG for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 18:39:09 -0800
Received: from el-out-1112.google.com ([209.85.162.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JUCCK-0000b4-7X
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 Feb 2008 18:39:09 -0800
Received: by el-out-1112.google.com with SMTP id y26so2498412ele.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 26 Feb 2008 18:39:07 -0800 (PST)
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

From 596867419b5d6cb33bbc4056c63d13e6ce1c042a Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Tue, 26 Feb 2008 15:06:08 +0800
Subject: [PATCH] pxa: make lubbock/mainstone/zylonite/littleton to use
new LCD connection type

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/littleton.c |    3 +--
 arch/arm/mach-pxa/lubbock.c   |    4 ++--
 arch/arm/mach-pxa/mainstone.c |    3 +--
 arch/arm/mach-pxa/zylonite.c  |    6 ++----
 4 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 0a4b54c..1c11948 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -287,8 +287,7 @@ static struct pxafb_mode_info tpo_tdo24mtea1_modes[] = {
 static struct pxafb_mach_info littleton_lcd_info = {
 	.modes			= tpo_tdo24mtea1_modes,
 	.num_modes		= 2,
-	.lccr0			= LCCR0_Act,
-	.lccr3			= LCCR3_HSP | LCCR3_VSP,
+	.lcd_conn		= LCD_COLOR_TFT_16BPP,
 	.pxafb_lcd_power	= littleton_lcd_power,
 };

diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index e7ae4bb..76e3670 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -360,8 +360,8 @@ static struct pxafb_mach_info sharp_lm8v31 = {
 	.num_modes	= 1,
 	.cmap_inverse	= 0,
 	.cmap_static	= 0,
-	.lccr0		= LCCR0_SDS,
-	.lccr3		= LCCR3_PCP | LCCR3_Acb(255),
+	.lcd_conn	= LCD_COLOR_DSTN_16BPP | LCD_PCLK_EDGE_FALL |
+			  LCD_AC_BIAS_FREQ(255);
 };

 #define	MMC_POLL_RATE		msecs_to_jiffies(1000)
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 345c3de..ae75218 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -354,8 +354,7 @@ static struct pxafb_mode_info toshiba_ltm035a776c_mode = {

 static struct pxafb_mach_info mainstone_pxafb_info = {
 	.num_modes      	= 1,
-	.lccr0			= LCCR0_Act,
-	.lccr3			= LCCR3_PCP,
+	.lcd_conn		= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
 };

 static int mainstone_mci_init(struct device *dev, irq_handler_t
mstone_detect_int, void *data)
diff --git a/arch/arm/mach-pxa/zylonite.c b/arch/arm/mach-pxa/zylonite.c
index afd2cbf..b6377e2 100644
--- a/arch/arm/mach-pxa/zylonite.c
+++ b/arch/arm/mach-pxa/zylonite.c
@@ -94,8 +94,7 @@ static struct pxafb_mode_info toshiba_ltm04c380k_mode = {

 static struct pxafb_mach_info zylonite_toshiba_lcd_info = {
 	.num_modes      	= 1,
-	.lccr0			= LCCR0_Act,
-	.lccr3			= LCCR3_PCP,
+	.lcd_conn		= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
 	.pxafb_backlight_power	= zylonite_backlight_power,
 };

@@ -131,8 +130,7 @@ static struct pxafb_mode_info sharp_ls037_modes[] = {
 static struct pxafb_mach_info zylonite_sharp_lcd_info = {
 	.modes			= sharp_ls037_modes,
 	.num_modes		= 2,
-	.lccr0			= LCCR0_Act,
-	.lccr3			= LCCR3_PCP | LCCR3_HSP | LCCR3_VSP,
+	.lcd_conn		= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL,
 	.pxafb_backlight_power	= zylonite_backlight_power,
 };

-- 
1.5.3.8



-- 
Cheers
- eric

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
