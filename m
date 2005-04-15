From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] drivers/video/intelfb/intelfbdrv.h
Date: Fri, 15 Apr 2005 02:48:49 +0200
Message-ID: <20050415004849.GJ20400@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMF1l-0002bg-6N
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 17:49:45 -0700
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DMF1j-0003Wo-EL
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 14 Apr 2005 17:49:45 -0700
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
Content-Type: text/plain; charset="iso-8859-1"
To: Andrew Morton <akpm@osdl.org>
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Ingo Oeser <ioe-lkml@axxeo.de>

Ingo Oeser noticed that all that intelfbdrv.h contains are prototypes=20
for static functions - and such prototypes don't belong into header=20
files.

This patch therefore removes drivers/video/intelfb/intelfbdrv.h and=20
moves the prototypes to intelfbdrv.c .

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 20 Mar 2005

 drivers/video/intelfb/intelfbdrv.c |   40 ++++++++++++++++-
 drivers/video/intelfb/intelfbdrv.h |   68 -----------------------------
 2 files changed, 39 insertions(+), 69 deletions(-)

--- linux-2.6.11-mm4-full/drivers/video/intelfb/intelfbdrv.c.old	2005-03-=
20 03:39:30.000000000 +0100
+++ linux-2.6.11-mm4-full/drivers/video/intelfb/intelfbdrv.c	2005-03-20 0=
3:44:03.000000000 +0100
@@ -135,9 +135,47 @@
 #endif
=20
 #include "intelfb.h"
-#include "intelfbdrv.h"
 #include "intelfbhw.h"
=20
+
+static void __devinit get_initial_mode(struct intelfb_info *dinfo);
+static void update_dinfo(struct intelfb_info *dinfo,
+			 struct fb_var_screeninfo *var);
+static int intelfb_get_fix(struct fb_fix_screeninfo *fix,
+			   struct fb_info *info);
+
+static int intelfb_check_var(struct fb_var_screeninfo *var,
+			     struct fb_info *info);
+static int intelfb_set_par(struct fb_info *info);
+static int intelfb_setcolreg(unsigned regno, unsigned red, unsigned gree=
n,
+			     unsigned blue, unsigned transp,
+			     struct fb_info *info);
+
+static int intelfb_blank(int blank, struct fb_info *info);
+static int intelfb_pan_display(struct fb_var_screeninfo *var,
+			       struct fb_info *info);
+
+static void intelfb_fillrect(struct fb_info *info,
+			     const struct fb_fillrect *rect);
+static void intelfb_copyarea(struct fb_info *info,
+			     const struct fb_copyarea *region);
+static void intelfb_imageblit(struct fb_info *info,
+			      const struct fb_image *image);
+static int intelfb_cursor(struct fb_info *info,
+			   struct fb_cursor *cursor);
+
+static int intelfb_sync(struct fb_info *info);
+
+static int intelfb_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long arg,
+			 struct fb_info *info);
+
+static int __devinit intelfb_pci_register(struct pci_dev *pdev,
+					  const struct pci_device_id *ent);
+static void __devexit intelfb_pci_unregister(struct pci_dev *pdev);
+static int __devinit intelfb_set_fbinfo(struct intelfb_info *dinfo);
+
+
 /*
  * Limiting the class to PCI_CLASS_DISPLAY_VGA prevents function 1 of th=
e
  * mobile chipsets from being registered.
--- linux-2.6.11-mm4-full/drivers/video/intelfb/intelfbdrv.h	2005-03-16 1=
8:55:25.000000000 +0100
+++ /dev/null	2005-03-19 22:42:59.000000000 +0100
@@ -1,68 +0,0 @@
-#ifndef _INTELFBDRV_H
-#define _INTELFBDRV_H
-
-/*
- ***********************************************************************=
*******
- * intelfb
- *
- * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G
- * integrated graphics chips.
- *
- * Copyright =A9 2004 Sylvain Meyer
- *
- * Author: Sylvain Meyer
- *
- ***********************************************************************=
*******
- *    This program is free software; you can redistribute it and/or modi=
fy
- *    it under the terms of the GNU General Public License as published =
by
- *    the Free Software Foundation; either version 2 of the License, or
- *    (at your option) any later version.
- *
- *    This program is distributed in the hope that it will be useful,
- *    but WITHOUT ANY WARRANTY; without even the implied warranty of
- *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *    GNU General Public License for more details.
- *
- *    You should have received a copy of the GNU General Public License
- *    along with this program; if not, write to the Free Software
- *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-*/
-
-static void __devinit get_initial_mode(struct intelfb_info *dinfo);
-static void update_dinfo(struct intelfb_info *dinfo,
-			 struct fb_var_screeninfo *var);
-static int intelfb_get_fix(struct fb_fix_screeninfo *fix,
-			   struct fb_info *info);
-
-static int intelfb_check_var(struct fb_var_screeninfo *var,
-			     struct fb_info *info);
-static int intelfb_set_par(struct fb_info *info);
-static int intelfb_setcolreg(unsigned regno, unsigned red, unsigned gree=
n,
-			     unsigned blue, unsigned transp,
-			     struct fb_info *info);
-
-static int intelfb_blank(int blank, struct fb_info *info);
-static int intelfb_pan_display(struct fb_var_screeninfo *var,
-			       struct fb_info *info);
-
-static void intelfb_fillrect(struct fb_info *info,
-			     const struct fb_fillrect *rect);
-static void intelfb_copyarea(struct fb_info *info,
-			     const struct fb_copyarea *region);
-static void intelfb_imageblit(struct fb_info *info,
-			      const struct fb_image *image);
-static int intelfb_cursor(struct fb_info *info,
-			   struct fb_cursor *cursor);
-
-static int intelfb_sync(struct fb_info *info);
-
-static int intelfb_ioctl(struct inode *inode, struct file *file,
-			 unsigned int cmd, unsigned long arg,
-			 struct fb_info *info);
-
-static int __devinit intelfb_pci_register(struct pci_dev *pdev,
-					  const struct pci_device_id *ent);
-static void __devexit intelfb_pci_unregister(struct pci_dev *pdev);
-static int __devinit intelfb_set_fbinfo(struct intelfb_info *dinfo);
-
-#endif



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
