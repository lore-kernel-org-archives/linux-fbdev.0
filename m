From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/6] intelfb: Workaround for 830M
Date: Tue, 18 Jan 2005 05:41:09 +0800
Message-ID: <200501180541.09971.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cqecj-00036o-TP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Jan 2005 13:41:21 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cqeci-0005SK-BQ
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Jan 2005 13:41:21 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 101831350401
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Jan 2005 21:41:05 +0000 (UTC)
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Andrew Pfiffer <andrewx.k.pfiffer@intel.com>, sylvain.meyer@worldonline.fr

  This is a work around for the 830M with intelfb.  Relative to 2.6.10.
  Without this patch, updates to the DSPACNTR register will be ignored.

  On the 830M, the display plane needs to be enabled before writing
  to any of the other bits in the DSPACNTR register.
  
  This patch detects the specific case, temporarily enables the plane,
  updates the register, and then disables the plane.  It also appears
  to require some settling time, but not an entire frame's time.
  
  Without this change, the pixel format fields in DSPACNTR won't get
  written on the 830M.

Signed-off-by: Andrew Pfiffer <andrewx.k.pfiffer@intel.com>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 intelfbhw.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+)

diff -Nru a/drivers/video/intelfb/intelfbhw.c b/drivers/video/intelfb/intelfbhw.c
--- a/drivers/video/intelfb/intelfbhw.c	2004-11-17 18:29:40 +08:00
+++ b/drivers/video/intelfb/intelfbhw.c	2005-01-15 08:18:07 +08:00
@@ -1207,6 +1207,22 @@
 	OUTREG(ADPA, tmp);
 
 	/* setup display plane */
+	if (dinfo->pdev->device == PCI_DEVICE_ID_INTEL_830M) {
+		/*
+		 *      i830M errata: the display plane must be enabled
+		 *      to allow writes to the other bits in the plane
+		 *      control register.
+		 */
+		tmp = INREG(DSPACNTR);
+		if ((tmp & DISPPLANE_PLANE_ENABLE) != DISPPLANE_PLANE_ENABLE) {
+			tmp |= DISPPLANE_PLANE_ENABLE;
+			OUTREG(DSPACNTR, tmp);
+			OUTREG(DSPACNTR, 
+			       hw->disp_a_ctrl|DISPPLANE_PLANE_ENABLE);
+			mdelay(1);
+              }
+	}
+
 	OUTREG(DSPACNTR, hw->disp_a_ctrl & ~DISPPLANE_PLANE_ENABLE);
 	OUTREG(DSPASTRIDE, hw->disp_a_stride);
 	OUTREG(DSPABASE, hw->disp_a_base);




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
