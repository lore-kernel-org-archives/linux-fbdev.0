From: "Randy.Dunlap" <randy.dunlap@verizon.net>
Subject: [PATCH] intelfb: reduce stack usage
Date: Sun, 19 Dec 2004 22:42:39 -0800
Message-ID: <20041219224239.5cc1c227.randy.dunlap@verizon.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CgHKQ-0003Ki-Vl
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 19 Dec 2004 22:47:34 -0800
Received: from out005pub.verizon.net ([206.46.170.143] helo=out005.verizon.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CgHKP-0006QN-Cm
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 19 Dec 2004 22:47:34 -0800
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
Content-Type: text/plain; charset="iso-8859-1"
To: sylvain.meyer@worldonline.fr, rddunlap <rddunlap@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sf.net

Antonino A. Daplas a =E9crit:
> Using kmalloc() should be acceptable.  I'll CC the author.=20
---

Reduce stack usage in intelfb_set_par() from 2404 bytes
(on x86-32) to 12 bytes.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=3D
 drivers/video/intelfb/intelfbdrv.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff -Naurp ./drivers/video/intelfb/intelfbdrv.c~intelfb_stack ./drivers/vi=
deo/intelfb/intelfbdrv.c
--- ./drivers/video/intelfb/intelfbdrv.c~intelfb_stack	2004-12-19 15:19:41.=
277527280 -0800
+++ ./drivers/video/intelfb/intelfbdrv.c	2004-12-19 20:58:17.018065272 -0800
@@ -1234,8 +1234,7 @@ intelfb_check_var(struct fb_var_screenin
 static int
 intelfb_set_par(struct fb_info *info)
 {
-	struct intelfb_hwstate hw;
-
+	struct intelfb_hwstate *hw;
         struct intelfb_info *dinfo =3D GET_DINFO(info);
=20
 	if (FIXED_MODE(dinfo)) {
@@ -1243,6 +1242,10 @@ intelfb_set_par(struct fb_info *info)
 		return -EINVAL;
 	}
=20
+	hw =3D kmalloc(sizeof(*hw), GFP_ATOMIC);
+	if (!hw)
+		return -ENOMEM;
+
 	DBG_MSG("intelfb_set_par (%dx%d-%d)\n", info->var.xres,
 		info->var.yres, info->var.bits_per_pixel);
=20
@@ -1251,15 +1254,15 @@ intelfb_set_par(struct fb_info *info)
 	if (dinfo->accel)
 		intelfbhw_2d_stop(dinfo);
=20
-	hw =3D dinfo->save_state;
-	if (intelfbhw_mode_to_hw(dinfo, &hw, &info->var))
-		return -EINVAL;
-	if (intelfbhw_program_mode(dinfo, &hw, 0))
-		return -EINVAL;
+	memcpy(hw, &dinfo->save_state, sizeof(*hw));
+	if (intelfbhw_mode_to_hw(dinfo, hw, &info->var))
+		goto invalid_mode;
+	if (intelfbhw_program_mode(dinfo, hw, 0))
+		goto invalid_mode;
=20
 #if REGDUMP > 0
-	intelfbhw_read_hw_state(dinfo, &hw, 0);
-	intelfbhw_print_hw_state(dinfo, &hw);
+	intelfbhw_read_hw_state(dinfo, hw, 0);
+	intelfbhw_print_hw_state(dinfo, hw);
 #endif
=20
 	update_dinfo(dinfo, &info->var);
@@ -1278,7 +1281,11 @@ intelfb_set_par(struct fb_info *info)
 	} else {
 		info->flags =3D FBINFO_DEFAULT | FBINFO_HWACCEL_YPAN;
 	}
+	kfree(hw);
 	return 0;
+invalid_mode:
+	kfree(hw);
+	return -EINVAL;
 }
=20
 static int

---


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
