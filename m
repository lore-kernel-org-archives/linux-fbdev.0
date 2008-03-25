From: Andres Salomon <dilinger@queued.net>
Subject: [PATCH] gxfb: two suspend/resume fixes
Date: Tue, 25 Mar 2008 11:30:34 -0400
Message-ID: <20080325113034.489d8643@ephemeral>
References: <20080311181807.454effb7@ephemeral>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JeB6K-0003ZT-EX for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Mar 2008 08:30:12 -0700
Received: from mail.queued.net ([207.210.101.209])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JeB6I-0005l1-Oo
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 25 Mar 2008 08:30:12 -0700
In-Reply-To: <20080311181807.454effb7@ephemeral>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: jordan.crouse@amd.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, adaplas@gmail.com, info-linux@geode.amd.com

Hi Andrew,

Can you please also add/merge this patch as well?  It fixes bugs in
gxfb-add-power-management-functionality.patch (currently in your tree).




Two suspend/resume fixes:
  - we weren't saving/restoring the palette correctly; I wasn't setting
    PAL_ADDRESS correctly.
  - the original GP restore code had an off-by-one bug that I happily
    reproduced in this code.  This fixes that, which fixes the RASTER_MODE
    register not getting set.

And drop an unnecessary comment.

Signed-off-by: Andres Salomon <dilinger@debian.org>
---
 drivers/video/geode/suspend_gx.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/geode/suspend_gx.c b/drivers/video/geode/suspend_gx.c
index bc1f2b9..9aff32e 100644
--- a/drivers/video/geode/suspend_gx.c
+++ b/drivers/video/geode/suspend_gx.c
@@ -39,7 +39,7 @@ static void gx_save_regs(struct gxfb_par *par)
 	memcpy(par->fp, par->vid_regs + VP_FP_START, sizeof(par->fp));
 
 	/* save the palette */
-	write_gp(par, DC_PAL_ADDRESS, 0);
+	write_dc(par, DC_PAL_ADDRESS, 0);
 	for (i = 0; i < ARRAY_SIZE(par->pal); i++)
 		par->pal[i] = read_dc(par, DC_PAL_DATA);
 }
@@ -73,10 +73,10 @@ static void gx_restore_gfx_proc(struct gxfb_par *par)
 
 	for (i = 0; i < ARRAY_SIZE(par->gp); i++) {
 		switch (i) {
-		case GP_RASTER_MODE:
 		case GP_VECTOR_MODE:
 		case GP_BLT_MODE:
 		case GP_BLT_STATUS:
+		case GP_HST_SRC:
 			/* don't restore these registers */
 			break;
 		default:
@@ -130,7 +130,7 @@ static void gx_restore_display_ctlr(struct gxfb_par *par)
 	}
 
 	/* restore the palette */
-	write_gp(par, DC_PAL_ADDRESS, 0);
+	write_dc(par, DC_PAL_ADDRESS, 0);
 	for (i = 0; i < ARRAY_SIZE(par->pal); i++)
 		write_dc(par, DC_PAL_DATA, par->pal[i]);
 }
@@ -163,7 +163,7 @@ static void gx_restore_video_proc(struct gxfb_par *par)
 		case VP_RSVD_3:
 		case VP_CRC32:
 		case VP_AWT:
-		case VP_VTM:    /* this is r/w, shouldn't we restore?  -dil */
+		case VP_VTM:
 			/* don't restore these registers */
 			break;
 		default:
-- 
1.5.3.7


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
