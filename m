From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [RFC] double buffering for atmel_lcdfb
Date: Wed, 6 Aug 2008 14:13:05 +0200
Message-ID: <20080806141305.49e883a2@hskinnemo-gx745.norway.atmel.com>
References: <200808061136.16783.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KQhtG-0001Dd-02 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 05:13:18 -0700
Received: from smtpeu1.atmel.com ([195.65.72.27] helo=bagnes.atmel.com)
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1KQhtD-00082h-Ps
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 06 Aug 2008 05:13:17 -0700
In-Reply-To: <200808061136.16783.stf_xl@wp.pl>
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
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: linux-fbdev-devel@lists.sourceforge.net

Stanislaw Gruszka <stf_xl@wp.pl> wrote:
> Below is patch I have already done. I also attached program which I used for 
> for tests - as far result are quite nice.

I sent this patch a while ago, but I forgot to send Nicolas a test
program when he asked for it :-(

Could you give it a try? If it works for you, I think we can conclude
that y-panning indeed works on AT91 so the patch can be applied.

Haavard

From c1dc155e3c1a828faa4379a1f6f6de0bb58385cc Mon Sep 17 00:00:00 2001
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Date: Sat, 23 Jun 2007 17:38:26 +0200
Subject: [PATCH] atmel_lcdfb: Set ypanstep to 1 and enable y-panning on AT91

Panning in the y-direction can be done by simply changing the DMA base
address. This code is already in place, but FBIOPAN_DISPLAY will
currently fail because ypanstep is 0.

Set ypanstep to 1 to indicate that we do support y-panning and also
set the necessary acceleration flags on AT91 (AVR32 already have
them.)

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
 drivers/video/atmel_lcdfb.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index b004036..c0a0364 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -39,7 +39,9 @@
 #endif
 
 #if defined(CONFIG_ARCH_AT91)
-#define	ATMEL_LCDFB_FBINFO_DEFAULT	FBINFO_DEFAULT
+#define	ATMEL_LCDFB_FBINFO_DEFAULT	(FBINFO_DEFAULT \
+					 | FBINFO_PARTIAL_PAN_OK \
+					 | FBINFO_HWACCEL_YPAN)
 
 static inline void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_info *sinfo,
 					struct fb_var_screeninfo *var)
@@ -177,7 +179,7 @@ static struct fb_fix_screeninfo atmel_lcdfb_fix __initdata = {
 	.type		= FB_TYPE_PACKED_PIXELS,
 	.visual		= FB_VISUAL_TRUECOLOR,
 	.xpanstep	= 0,
-	.ypanstep	= 0,
+	.ypanstep	= 1,
 	.ywrapstep	= 0,
 	.accel		= FB_ACCEL_NONE,
 };
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
