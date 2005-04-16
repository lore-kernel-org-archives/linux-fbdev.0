From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/6] intelfb: Remove intelfbdrv.h
Date: Sat, 16 Apr 2005 13:20:33 +0800
Message-ID: <200504161320.34027.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMfrI-0002B7-Qw
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 22:28:44 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DMfrI-0004G8-6E
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 22:28:44 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 77B87152F13A
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 16 Apr 2005 05:28:30 +0000 (UTC)
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
Cc: Adrian Bunk <bunk@stusta.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

  Ingo Oeser noticed that all that intelfbdrv.h contains are prototypes
  for static functions - and such prototypes don't belong into header
  files.

  This patch therefore removes drivers/video/intelfb/intelfbdrv.h and
  moves the prototypes to intelfbdrv.c .

=46rom: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
=2D--

 b/drivers/video/intelfb/intelfbdrv.c |   38 +++++++++++++++++++
 drivers/video/intelfb/intelfbdrv.h   |   68 ------------------------------=
=2D----
 2 files changed, 37 insertions(+), 69 deletions(-)

diff -Nru a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/inte=
lfbdrv.c
=2D-- a/drivers/video/intelfb/intelfbdrv.c	2005-03-20 20:09:13 +08:00
+++ b/drivers/video/intelfb/intelfbdrv.c	2005-04-16 11:51:14 +08:00
@@ -135,8 +135,44 @@
 #endif
=20
 #include "intelfb.h"
=2D#include "intelfbdrv.h"
 #include "intelfbhw.h"
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
+static int intelfb_setcolreg(unsigned regno, unsigned red, unsigned green,
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
=20
 /*
  * Limiting the class to PCI_CLASS_DISPLAY_VGA prevents function 1 of the
diff -Nru a/drivers/video/intelfb/intelfbdrv.h b/drivers/video/intelfb/inte=
lfbdrv.h
=2D-- a/drivers/video/intelfb/intelfbdrv.h	2005-03-20 20:09:13 +08:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,68 +0,0 @@
=2D#ifndef _INTELFBDRV_H
=2D#define _INTELFBDRV_H
=2D
=2D/*
=2D ***********************************************************************=
*******
=2D * intelfb
=2D *
=2D * Linux framebuffer driver for Intel(R) 830M/845G/852GM/855GM/865G/915G
=2D * integrated graphics chips.
=2D *
=2D * Copyright =A9 2004 Sylvain Meyer
=2D *
=2D * Author: Sylvain Meyer
=2D *
=2D ***********************************************************************=
*******
=2D *    This program is free software; you can redistribute it and/or modi=
fy
=2D *    it under the terms of the GNU General Public License as published =
by
=2D *    the Free Software Foundation; either version 2 of the License, or
=2D *    (at your option) any later version.
=2D *
=2D *    This program is distributed in the hope that it will be useful,
=2D *    but WITHOUT ANY WARRANTY; without even the implied warranty of
=2D *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
=2D *    GNU General Public License for more details.
=2D *
=2D *    You should have received a copy of the GNU General Public License
=2D *    along with this program; if not, write to the Free Software
=2D *    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
=2D*/
=2D
=2Dstatic void __devinit get_initial_mode(struct intelfb_info *dinfo);
=2Dstatic void update_dinfo(struct intelfb_info *dinfo,
=2D			 struct fb_var_screeninfo *var);
=2Dstatic int intelfb_get_fix(struct fb_fix_screeninfo *fix,
=2D			   struct fb_info *info);
=2D
=2Dstatic int intelfb_check_var(struct fb_var_screeninfo *var,
=2D			     struct fb_info *info);
=2Dstatic int intelfb_set_par(struct fb_info *info);
=2Dstatic int intelfb_setcolreg(unsigned regno, unsigned red, unsigned gree=
n,
=2D			     unsigned blue, unsigned transp,
=2D			     struct fb_info *info);
=2D
=2Dstatic int intelfb_blank(int blank, struct fb_info *info);
=2Dstatic int intelfb_pan_display(struct fb_var_screeninfo *var,
=2D			       struct fb_info *info);
=2D
=2Dstatic void intelfb_fillrect(struct fb_info *info,
=2D			     const struct fb_fillrect *rect);
=2Dstatic void intelfb_copyarea(struct fb_info *info,
=2D			     const struct fb_copyarea *region);
=2Dstatic void intelfb_imageblit(struct fb_info *info,
=2D			      const struct fb_image *image);
=2Dstatic int intelfb_cursor(struct fb_info *info,
=2D			   struct fb_cursor *cursor);
=2D
=2Dstatic int intelfb_sync(struct fb_info *info);
=2D
=2Dstatic int intelfb_ioctl(struct inode *inode, struct file *file,
=2D			 unsigned int cmd, unsigned long arg,
=2D			 struct fb_info *info);
=2D
=2Dstatic int __devinit intelfb_pci_register(struct pci_dev *pdev,
=2D					  const struct pci_device_id *ent);
=2Dstatic void __devexit intelfb_pci_unregister(struct pci_dev *pdev);
=2Dstatic int __devinit intelfb_set_fbinfo(struct intelfb_info *dinfo);
=2D
=2D#endif




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
