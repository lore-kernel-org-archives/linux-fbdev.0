From: Holger Schurig <h.schurig@mn-logistik.de>
Subject: modedb always included?
Date: Tue, 23 Sep 2003 10:31:51 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200309231031.51724.h.schurig@mn-logistik.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3TAc/ssnmypiXbz"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1j4O-0005Sq-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 02:02:52 -0700
Received: from mail.iok.net ([62.249.129.22] helo=mail05.iok.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.22)
	id 1A1j4N-0005YG-Vm
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 23 Sep 2003 02:02:52 -0700
Received: from lin01.mn-logistik.de (frdb-d9b9441a.pool.mediaWays.net [217.185.68.26])
	by mail05.iok.net (8.12.8/8.12.8) with ESMTP id h8N92Cvm031938
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 11:02:14 +0200
Received: from mnz66.mn-logistik.de (mnz66.mn-logistik.de [192.168.233.66])
	by lin01.mn-logistik.de (Postfix) with ESMTP id E1AA51FF13
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 23 Sep 2003 10:31:51 +0200 (CEST)
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--Boundary-00=_3TAc/ssnmypiXbz
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all !

I'm not in this mailing list and hope that I can send to it anyway.

I'm a developer on an embedded device (PDA like). I recognized that that 
the framebuffer in Linux 2.6 always includes the EDID and modedb. There's 
no need for this on my target, because I have a digitally controlled LCD 
panel with a fixed setup (there's actually no monitor, FBAS or video 
signal anywhere).

The attached patch tries to fix this, please comment.

E.g., currently it's an automatically derived option (I know that no Intel 
SA1100 and no Intel PXA chip needs EDID and modelines), maybe it should 
be user-visible?


It's against Linus' bitkeeper tree from today.

--Boundary-00=_3TAc/ssnmypiXbz
Content-Type: text/x-diff;
  charset="us-ascii";
  name="small-nomodedb.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="small-nomodedb.patch"

=46rom Holger Schurig: some embedded devices don't drive a normal CRT, but =
an
digitally connected LCD panel. In this case, we don't need the EDID code and
no mode line database.

#
# Patch managed by http://www.mn-logistik.de/unsupported/pxa250/patcher
#

=2D-- linux-2.6/drivers/video/Kconfig~small-nomodedb
+++ linux-2.6/drivers/video/Kconfig
@@ -38,6 +38,14 @@
 	  (e.g. an accelerated X server) and that are not frame buffer
 	  device-aware may cause unexpected results. If unsure, say N.
=20
+config FB_MODES
+	bool
+	default y if FB && (!(FB_PXA || FB_SA1110))
+	---help---
+	  Some embedded devices don't drive a normal CRT, but an digitally
+	  connected LCD panel. In this case, we don't need the EDID code and
+	  no mode line database.
+
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
 	depends on FB && (AMIGA || PCI) && BROKEN
=2D-- linux-2.6/drivers/video/Makefile~small-nomodedb
+++ linux-2.6/drivers/video/Makefile
@@ -7,7 +7,8 @@
 obj-$(CONFIG_VT)		  +=3D console/
 obj-$(CONFIG_LOGO)		  +=3D logo/
=20
=2Dobj-$(CONFIG_FB)                  +=3D fbmem.o fbmon.o fbcmap.o modedb.o=
 softcursor.o
+obj-$(CONFIG_FB)                  +=3D fbmem.o fbcmap.o softcursor.o
+obj-$(CONFIG_FB_MODES)              +=3D fbmon.o modedb.o
 # Only include macmodes.o if we have FB support and are PPC
 ifeq ($(CONFIG_FB),y)
 obj-$(CONFIG_PPC)                 +=3D macmodes.o
=2D-- linux-2.6/drivers/video/fbmem.c~small-nomodedb
+++ linux-2.6/drivers/video/fbmem.c
@@ -389,7 +389,9 @@
 #define NUM_FB_DRIVERS	(sizeof(fb_drivers)/sizeof(*fb_drivers))
 #define FBPIXMAPSIZE	8192
=20
+#ifdef CONFIG_FB_MODES
 extern const char *global_mode_option;
+#endif
=20
 static initcall_t pref_init_funcs[FB_MAX];
 static int num_pref_init_funcs __initdata =3D 0;
@@ -1370,7 +1372,9 @@
 	 * If we get here no fb was specified.
 	 * We consider the argument to be a global video mode option.
 	 */
+#ifdef CONFIG_FB_MODES
 	global_mode_option =3D options;
+#endif
 	return 0;
 }
=20

--Boundary-00=_3TAc/ssnmypiXbz--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
