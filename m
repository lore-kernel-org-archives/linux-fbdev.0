From: Dennis Munsie <dmunsie@cecropia.com>
Subject: [PATCH 2.6.17-rc-mm3] intelfb 9xx stride alignment
Date: Thu, 25 May 2006 17:26:27 -0400
Message-ID: <27E98AF9-CFFA-4E1F-B6CA-DD4CA1D895BA@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0 (Apple Message framework v750)
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FjNLT-0005Uz-Dy
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 14:26:15 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FjNLT-0006Zo-ED
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 14:26:15 -0700
Received: from mail1.sea5.speakeasy.net ([69.17.117.3])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1FjNLS-0006wO-2j
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 25 May 2006 14:26:15 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; delsp="yes"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Eric Hustvedt <ehustvedt@cecropia.com>, Dave Airlie <airlied@skynet.ie>, Sylvain Meyer <sylvain.meyer@worldonline.fr>

Hi all,

Quick patch to correct the stride alignment on the 9xx chipsets.   
This allows modes like 1366x768 to be displayed correctly.

regards,
dennis

---

From: Dennis Munsie <dmunsie@cecropia.com>

intelfb -- uses stride alignment of 64 on the 9xx chipsets.

Signed-off-by: Dennis Munsie <dmunsie@cecropia.com>

---

drivers/video/intelfb/intelfb.h    |    1 +
drivers/video/intelfb/intelfbdrv.c |    5 ++++-
drivers/video/intelfb/intelfbhw.c  |    6 ++++--
3 files changed, 9 insertions(+), 3 deletions(-)

diff -Naurp -X linux-2.6.17-rc4-945-fix/Documentation/dontdiff  
linux-2.6.17-rc4-945-fix/drivers/video/intelfb/intelfb.h linux-2.6.17- 
rc4-9xx-stride/drivers/video/intelfb/intelfb.h
--- linux-2.6.17-rc4-945-fix/drivers/video/intelfb/intelfb.h	 
2006-05-25 15:50:24.000000000 -0500
+++ linux-2.6.17-rc4-9xx-stride/drivers/video/intelfb/intelfb.h	 
2006-05-25 15:55:09.000000000 -0500
@@ -59,6 +59,7 @@
#define INTEL_REG_SIZE			0x80000
#define STRIDE_ALIGNMENT		16
+#define STRIDE_ALIGNMENT_I9XX	64
#define PALETTE_8_ENTRIES		256
diff -Naurp -X linux-2.6.17-rc4-945-fix/Documentation/dontdiff  
linux-2.6.17-rc4-945-fix/drivers/video/intelfb/intelfbdrv.c  
linux-2.6.17-rc4-9xx-stride/drivers/video/intelfb/intelfbdrv.c
--- linux-2.6.17-rc4-945-fix/drivers/video/intelfb/intelfbdrv.c	 
2006-05-25 15:50:24.000000000 -0500
+++ linux-2.6.17-rc4-9xx-stride/drivers/video/intelfb/intelfbdrv.c	 
2006-05-25 15:54:03.000000000 -0500
@@ -1171,7 +1171,10 @@ update_dinfo(struct intelfb_info *dinfo,
	}
	/* Make sure the line length is a aligned correctly. */
-	dinfo->pitch = ROUND_UP_TO(dinfo->pitch, STRIDE_ALIGNMENT);
+	if (IS_I9XX(dinfo))
+		dinfo->pitch = ROUND_UP_TO(dinfo->pitch, STRIDE_ALIGNMENT_I9XX);
+	else
+		dinfo->pitch = ROUND_UP_TO(dinfo->pitch, STRIDE_ALIGNMENT);
	if (FIXED_MODE(dinfo))
		dinfo->pitch = dinfo->initial_pitch;
diff -Naurp -X linux-2.6.17-rc4-945-fix/Documentation/dontdiff  
linux-2.6.17-rc4-945-fix/drivers/video/intelfb/intelfbhw.c  
linux-2.6.17-rc4-9xx-stride/drivers/video/intelfb/intelfbhw.c
--- linux-2.6.17-rc4-945-fix/drivers/video/intelfb/intelfbhw.c	 
2006-05-25 15:50:24.000000000 -0500
+++ linux-2.6.17-rc4-9xx-stride/drivers/video/intelfb/intelfbhw.c	 
2006-05-25 16:13:28.000000000 -0500
@@ -1025,6 +1025,7 @@ intelfbhw_mode_to_hw(struct intelfb_info
	u32 vsync_start, vsync_end, vblank_start, vblank_end, vtotal, vactive;
	u32 vsync_pol, hsync_pol;
	u32 *vs, *vb, *vt, *hs, *hb, *ht, *ss, *pipe_conf;
+	u32 stride_alignment;
	DBG_MSG("intelfbhw_mode_to_hw\n");
@@ -1236,9 +1237,10 @@ intelfbhw_mode_to_hw(struct intelfb_info
	hw->disp_a_base += dinfo->fb.offset << 12;
	/* Check stride alignment. */
-	if (hw->disp_a_stride % STRIDE_ALIGNMENT != 0) {
+	stride_alignment = IS_I9XX(dinfo) ? STRIDE_ALIGNMENT_I9XX :  
STRIDE_ALIGNMENT;
+	if (hw->disp_a_stride % stride_alignment != 0) {
		WRN_MSG("display stride %d has bad alignment %d\n",
-			hw->disp_a_stride, STRIDE_ALIGNMENT);
+			hw->disp_a_stride, stride_alignment);
		return 1;
	}




-------------------------------------------------------
All the advantages of Linux Managed Hosting--Without the Cost and Risk!
Fully trained technicians. The highest number of Red Hat certifications in
the hosting industry. Fanatical Support. Click to learn more
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=107521&bid=248729&dat=121642
