From: "Pfiffer, AndrewX K" <andrewx.k.pfiffer@intel.com>
Subject: PATCH: fbdev: intelfb - workaround for 830M
Date: Thu, 6 Jan 2005 17:00:52 -0800
Message-ID: <69F69FD5FD4A9843ACBF7CE9B7830B4A02DCA461@orsmsx408>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CmiVY-0001b5-0u
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Jan 2005 17:01:40 -0800
Received: from fmr19.intel.com ([134.134.136.18] helo=orsfmr004.jf.intel.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CmiVW-0005hG-9K
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Jan 2005 17:01:39 -0800
Content-class: urn:content-classes:message
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
To: sylvain.meyer@worldonline.fr, linux-fbdev-devel@lists.sourceforge.net

This is a work around for the 830M with intelfb.  Relative to 2.6.10.
Without this patch, updates to the DSPACNTR register will be ignored.

Signed-off-by: Andrew Pfiffer <andrewx.k.pfiffer@intel.com>

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/01/06 16:14:27-08:00 andrewx.k.pfiffer@intel.com=20
#   On the 830M, the display plane needs to be enabled before writing
#   to any of the other bits in the DSPACNTR register.
#  =20
#   This patch detects the specific case, temporarily enables the plane,
#   updates the register, and then disables the plane.  It also appears
#   to require some settling time, but not an entire frame's time.
#  =20
#   Without this change, the pixel format fields in DSPACNTR won't get
#   written on the 830M.
#  =20
#=20
# drivers/video/intelfb/intelfbhw.c
#   2005/01/06 16:14:08-08:00 andrewx.k.pfiffer@intel.com +14 -0
#   If we're updating the DSPACNTR register on an 830M, temporarily
enable
#   the plane before writing the register.
#=20
diff -Nru a/drivers/video/intelfb/intelfbhw.c
b/drivers/video/intelfb/intelfbhw.c
--- a/drivers/video/intelfb/intelfbhw.c	2005-01-06 16:15:36 -08:00
+++ b/drivers/video/intelfb/intelfbhw.c	2005-01-06 16:15:36 -08:00
@@ -1207,6 +1207,20 @@
 	OUTREG(ADPA, tmp);
=20
 	/* setup display plane */
+	if (dinfo->pdev->device =3D=3D PCI_DEVICE_ID_INTEL_830M) {
+		/*
+		 *	i830M errata: the display plane must be enabled
+		 *	to allow writes to the other bits in the plane
+		 *	control register.
+		 */
+		tmp =3D INREG(DSPACNTR);
+		if ((tmp & DISPPLANE_PLANE_ENABLE) !=3D
DISPPLANE_PLANE_ENABLE) {
+			tmp |=3D DISPPLANE_PLANE_ENABLE;
+			OUTREG(DSPACNTR, tmp);
+			OUTREG(DSPACNTR,
hw->disp_a_ctrl|DISPPLANE_PLANE_ENABLE);
+			mdelay(1);
+		}
+	}
 	OUTREG(DSPACNTR, hw->disp_a_ctrl & ~DISPPLANE_PLANE_ENABLE);
 	OUTREG(DSPASTRIDE, hw->disp_a_stride);
 	OUTREG(DSPABASE, hw->disp_a_base);


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
