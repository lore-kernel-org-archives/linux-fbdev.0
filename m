From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 2/5] pxafb: allow better platform
	configurable smart panel timing
Date: Thu, 11 Dec 2008 17:47:24 +0800
Message-ID: <f17812d70812110147m27338bbbs5f21e42d9cf94a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LAi8n-0004ys-Ks
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 09:47:29 +0000
Received: from rv-out-0708.google.com ([209.85.198.240])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LAi8k-0007Bb-6D for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 09:47:29 +0000
Received: by rv-out-0708.google.com with SMTP id f25so796219rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 11 Dec 2008 01:47:24 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net

For smart panels (LCD panel with internal framebuffer), the following
LCCR3 register bits have different meanings than the parallel one:

  LCCR3_PCP - controls the L_PCLK_WR polarity
  LCCR3_HSP - controls the L_LCLK_A0 polarity
  LCCR3_VSP - controls the L_FCLK_RD polarity

To keep minimum change to the original parallel timing, the .lcd_conn
flags and 'pxafb_mode_info.sync' are re-used to reflect this:

  LCD_PCLK_EDGE_{RISE,FALL} - configures LCCR3_PCP
  sync & FB_SYNC_{HOR,VERT}_HIGH_ACT - configures LCCR3_{HSP,VSP}

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/include/mach/pxafb.h |    4 ++++
 drivers/video/pxafb.c                  |    4 +++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/pxafb.h
b/arch/arm/mach-pxa/include/mach/pxafb.h
index cb44410..4201a88 100644
--- a/arch/arm/mach-pxa/include/mach/pxafb.h
+++ b/arch/arm/mach-pxa/include/mach/pxafb.h
@@ -95,6 +95,10 @@ struct pxafb_mode_info {
 	 *    in pxa27x and pxa3xx, initialize them to the same value or
 	 *    the larger one will be used
 	 * 3. same to {rd,wr}_pulse_width
+	 *
+	 * 4. LCD_PCLK_EDGE_{RISE,FALL} controls the L_PCLK_WR polarity
+	 * 5. sync & FB_SYNC_HOR_HIGH_ACT controls the L_LCLK_A0
+	 * 6. sync & FB_SYNC_VERT_HIGH_ACT controls the L_LCLK_RD
 	 */
 	unsigned	a0csrd_set_hld;	/* A0 and CS Setup/Hold Time before/after
L_FCLK_RD */
 	unsigned	a0cswr_set_hld;	/* A0 and CS Setup/Hold Time before/after
L_PCLK_WR */
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index e0bba02..c082547 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -760,7 +760,9 @@ static void setup_smart_timing(struct pxafb_info *fbi,
 		LCCR1_HorSnchWdth(__smart_timing(t3, lclk));

 	fbi->reg_lccr2 = LCCR2_DisHght(var->yres);
-	fbi->reg_lccr3 = LCCR3_PixClkDiv(__smart_timing(t4, lclk));
+	fbi->reg_lccr3 = fbi->lccr3 | LCCR3_PixClkDiv(__smart_timing(t4, lclk));
+	fbi->reg_lccr3 |= (var->sync & FB_SYNC_HOR_HIGH_ACT) ? LCCR3_HSP : 0;
+	fbi->reg_lccr3 |= (var->sync & FB_SYNC_VERT_HIGH_ACT) ? LCCR3_VSP : 0;

 	/* FIXME: make this configurable */
 	fbi->reg_cmdcr = 1;
-- 
1.6.0.4

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
